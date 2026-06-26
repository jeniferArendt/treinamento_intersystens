Class Prova.Candidato Extends %Persistent
{

Parameter AUTOR;

Parameter SISTEMA = "Desafio InterSystems";

Parameter TABELA = "Candidatos do processo seletivo";

Parameter TITULO = "Candidato";

Parameter SITUACAO = 1;

Property Nome As %String(MAXLEN = 100) [ Required ];

Property Idade As %Integer(MAXVAL = 150, MINVAL = 0);

Property Sexo As %String(MAXLEN = 20);

Property CodigoCandidato As %Integer;

Relationship Avaliacoes As Prova.Data.Avaliacao [ Cardinality = many, Inverse = Candidato ];

Relationship Cursos As Prova.Data.CandidatoCurso [ Cardinality = many, Inverse = Candidato ];

Index CodigoCandidatoIndex On CodigoCandidato;

/// Consulta candidato por CodigoCandidato e exibe resultados com aprovação/reprovação
ClassMethod ConsultaCandidato(CodigoCandidato As %Integer)
{
    set sql = "SELECT ID, Nome FROM Prova_Data.Candidato WHERE CodigoCandidato = ?"
    set rs = ##class(%SQL.Statement).%New()
    do rs.%Prepare(sql)
    set result = rs.%Execute(CodigoCandidato)

    if 'result.%Next() {
        write "Candidato não encontrado para código: ", CodigoCandidato, !
        quit
    }

    write "Candidato: ", result.%Get("Nome"), !
    write "-------------------------------------------", !

    set candidatoId = result.%Get("ID")
    set sqlAval = "SELECT NomeDisciplina, Tipo, Nota FROM Prova_Data.Avaliacao WHERE Candidato = ?"
    set rsAval = ##class(%SQL.Statement).%New()
    do rsAval.%Prepare(sqlAval)
    set resAval = rsAval.%Execute(candidatoId)

    while resAval.%Next() {
        set tipo = resAval.%Get("Tipo")
        set nota = resAval.%Get("Nota")
        if (tipo = "Teorica") {
            set res = $Select(nota >= 6: "APROVADO", 1: "REPROVADO")
        } else {
            set res = $Select(nota >= 7: "APROVADO", 1: "REPROVADO")
        }
        write resAval.%Get("NomeDisciplina"), " - ", res, !
    }
}

/// Percorre as avaliações do próprio candidato e retorna string com resultados
Method VerificaAprovacao() As %String
{
    set resultado = ""
    set sql = "SELECT NomeDisciplina, Tipo, Nota FROM Prova_Data.Avaliacao WHERE Candidato = ?"
    set rs = ##class(%SQL.Statement).%New()
    do rs.%Prepare(sql)
    set result = rs.%Execute(..%Id())

    while result.%Next() {
        set tipo = result.%Get("Tipo")
        set nota = result.%Get("Nota")
        if (tipo = "Teorica") {
            set res = $Select(nota >= 6: "APROVADO", 1: "REPROVADO")
        } else {
            set res = $Select(nota >= 7: "APROVADO", 1: "REPROVADO")
        }
        set resultado = resultado _ result.%Get("NomeDisciplina") _ ": " _ res _ $Char(10)
    }

    quit resultado
}

/// Exibe quantidade de caracteres (sem espaços) e nome com espaços substituídos por |
ClassMethod AnalisaNome(Nome As %String)
{
    set semEspaco = $Translate(Nome, " ", "")
    write "Quantidade de caracteres (sem espaços): ", $Length(semEspaco), !
    write "Nome com | no lugar dos espaços: ", $Translate(Nome, " ", "|"), !
}

/// Converte data de nascimento DD/MM/AAAA para $Horolog, calendário islâmico e nome do mês
ClassMethod AnalisaDataNascimento(DataNascimento As %String)
{
    set horolog = $ZDateH(DataNascimento, 4)
    write "Data em $Horolog: ", horolog, !

    set islamicDate = $ZDate(horolog, 18)
    write "Data Islâmica (tabular): ", islamicDate, !

    set islamicMonthNum = +$Piece(islamicDate, "/", 2)
    set monthNames = $ListBuild(
        "Muharram", "Safar", "Rabi ul-Awwal", "Rabi ul-Akhir",
        "Jumada ul-Ula", "Jumada ul-Akhira", "Rajab", "Sha'ban",
        "Ramadan", "Shawwal", "Dhul-Qada", "Dhul-Hijja")
    write "Mês Islâmico: ", $ListGet(monthNames, islamicMonthNum), !
}

/// Retorna dados do candidato e avaliações em formato %DynamicObject JSON
ClassMethod BuscarCandidatoPorIdJSON(ID As %Integer) As %DynamicObject
{
    set candidato = ##class(Prova.Candidato).%OpenId(ID)
    if '$IsObject(candidato) quit $$$NULLOREF

    set json = {}
    set json.ID = candidato.%Id()
    set json.Nome = candidato.Nome
    set json.Idade = candidato.Idade
    set json.Sexo = candidato.Sexo
    set json.CodigoCandidato = candidato.CodigoCandidato

    set avaliacoes = []
    set sql = "SELECT NomeDisciplina, Tipo, Nota FROM Prova_Data.Avaliacao WHERE Candidato = ?"
    set rs = ##class(%SQL.Statement).%New()
    do rs.%Prepare(sql)
    set result = rs.%Execute(ID)

    while result.%Next() {
        set aval = {}
        set tipo = result.%Get("Tipo")
        set nota = result.%Get("Nota")
        set aval.NomeDisciplina = result.%Get("NomeDisciplina")
        set aval.Tipo = tipo
        set aval.Nota = nota
        set aval.Resultado = $Select(
            tipo = "Teorica": $Select(nota >= 6: "APROVADO", 1: "REPROVADO"),
            1: $Select(nota >= 7: "APROVADO", 1: "REPROVADO"))
        do avaliacoes.%Push(aval)
    }
    set json.Avaliacoes = avaliacoes

    quit json
}

/// Consulta paginada via cursor LastId; filtra por NomeCandidato (prefixo), Sexo e PageSize
ClassMethod ConsultaCandidatoPaginacaoJSON(NomeCandidato As %String = "", LastId As %Integer = 0, PageSize As %Integer = 10, Sexo As %String = "") As %DynamicObject
{
    set result = {}
    set lista = []
    set total = 0
    set proximoLastId = 0

    set sql = "SELECT TOP ? ID FROM Prova_Data.Candidato "_
              "WHERE ID > ? "_
              "AND (? = '' OR Nome %STARTSWITH ?) "_
              "AND (? = '' OR Sexo = ?) "_
              "ORDER BY ID"

    set rs = ##class(%SQL.Statement).%New()
    do rs.%Prepare(sql)
    set rset = rs.%Execute(PageSize, LastId, NomeCandidato, NomeCandidato, Sexo, Sexo)

    while rset.%Next() {
        set candidatoId = rset.%Get("ID")
        set candidatoJson = ##class(Prova.Candidato).BuscarCandidatoPorIdJSON(candidatoId)
        if $IsObject(candidatoJson) {
            do lista.%Push(candidatoJson)
            set total = total + 1
            set proximoLastId = candidatoId
        }
    }

    set result.Lista = lista
    set result.Total = total
    set result.ProximoLastId = proximoLastId

    quit result
}

Storage Default
{
<Data name="CandidatoDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Nome</Value>
</Value>
<Value name="3">
<Value>Idade</Value>
</Value>
<Value name="4">
<Value>Sexo</Value>
</Value>
<Value name="5">
<Value>CodigoCandidato</Value>
</Value>
</Data>
<DataLocation>^Prova.CandidatoD</DataLocation>
<DefaultData>CandidatoDefaultData</DefaultData>
<IdLocation>^Prova.CandidatoD</IdLocation>
<IndexLocation>^Prova.CandidatoI</IndexLocation>
<StreamLocation>^Prova.CandidatoS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
