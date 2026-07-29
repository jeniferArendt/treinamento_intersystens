Class Prova.Data.Candidato Extends %Persistent
{

Parameter SISTEMA = "Desafio InterSystems";

Parameter TABELA = "Cadastro de candidatos";

Parameter TITULO = "Candidatos";

Parameter SITUACAO = 1;

Property Nome As %String;

Property Idade As %Integer;

Property Sexo As %String;

Property CodigoCandidato As %Integer;

Relationship Avaliacoes As Prova.Data.Avaliacao [ Cardinality = many, Inverse = Candidato ];

Relationship CandidatoCursos As Prova.Data.CandidatoCurso [ Cardinality = many, Inverse = Candidato ];

/// 6 - Consulta o candidato e suas avaliacoes pelo CodigoCandidato aplicando regras de aprovacao
ClassMethod ConsultaCandidato(pCodigoCandidato As %Integer) As %Status
{
	set tSC = $$$OK
	try {
		set sql = "SELECT c.Nome, a.NomeDisciplina, a.Tipo, a.Nota"
			_ " FROM Prova_Data.Candidato c"
			_ " JOIN Prova_Data.Avaliacao a ON a.Candidato = c.ID"
			_ " WHERE c.CodigoCandidato = ?"
			_ " ORDER BY a.NomeDisciplina"

		set rs = ##class(%SQL.Statement).%ExecDirect(, sql, pCodigoCandidato)

		if rs.%SQLCODE < 0 {
			set tSC = $$$ERROR($$$GeneralError, rs.%Message)
			quit
		}

		set nomeCandidato = ""
		set count = 0
		write !,"=== Consulta de Candidato ==="

		while rs.%Next() {
			if nomeCandidato = "" {
				set nomeCandidato = rs.%Get("Nome")
				write !,"Candidato: ", nomeCandidato
				write !,"----------------------------------------------"
			}
			set tipo       = rs.%Get("Tipo")
			set nota       = rs.%Get("Nota")
			set disciplina = rs.%Get("NomeDisciplina")

			if tipo = "Teorica" {
				set resultado = $select(nota >= 6: "APROVADO", 1: "REPROVADO")
			} else {
				set resultado = $select(nota >= 7: "APROVADO", 1: "REPROVADO")
			}

			write !,"  Disciplina: ", disciplina
			write !,"  Tipo      : ", tipo
			write !,"  Nota      : ", nota
			write !,"  Resultado : ", resultado
			write !,"----------------------------------------------"
			set count = count + 1
		}

		if count = 0 {
			write !,"Candidato com codigo ", pCodigoCandidato, " nao encontrado."
		}
	} catch ex {
		set tSC = ex.AsStatus()
	}
	quit tSC
}

/// 7 - Percorre as avaliacoes do proprio objeto e retorna disciplinas e resultados
Method VerificaAprovacao() As %String
{
	set resultado = ""
	set count     = ..Avaliacoes.Count()

	for i=1:1:count {
		set av = ..Avaliacoes.GetAt(i)

		if av.Tipo = "Teorica" {
			set res = $select(av.Nota >= 6: "APROVADO", 1: "REPROVADO")
		} else {
			set res = $select(av.Nota >= 7: "APROVADO", 1: "REPROVADO")
		}

		set resultado = resultado _ av.NomeDisciplina _ ": " _ res _ $char(10)
	}

	quit resultado
}

/// 8 - Exibe quantidade de caracteres sem espacos e nome com espacos trocados por |
ClassMethod AnalisaNome(pNome As %String) As %Status
{
	set semEspacos    = $translate(pNome, " ", "")
	set qtdCaracteres = $length(semEspacos)
	set nomeFormatado = $translate(pNome, " ", "|")

	write !,"=== Analise do Nome ==="
	write !,"Nome informado    : ", pNome
	write !,"Qtd de caracteres : ", qtdCaracteres, " (sem espacos)"
	write !,"Nome formatado    : ", nomeFormatado

	quit $$$OK
}

/// 9 - Recebe data no formato europeu DD/MM/AAAA e exibe conversoes de calendario
ClassMethod AnalisaDataNascimento(pData As %String) As %Status
{
	set tSC = $$$OK
	try {
		set dia = $piece(pData, "/", 1)
		set mes = $piece(pData, "/", 2)
		set ano = $piece(pData, "/", 3)

		set dataISO    = ano _ "-" _ mes _ "-" _ dia
		set horologDate = $zdateh(dataISO, 3)

		set dataIslamica = $zdate(horologDate, 18)

		set mesIslam = +$piece(dataIslamica, "/", 2)

		set meses = $listbuild(
			"Muharram", "Safar", "Rabi al-Awwal", "Rabi al-Thani",
			"Jumada al-Ula", "Jumada al-Akhira", "Rajab", "Shaban",
			"Ramadan", "Shawwal", "Dhu al-Qidah", "Dhu al-Hijjah")

		set nomeMesIslam = $list(meses, mesIslam)

		write !,"=== Analise da Data de Nascimento ==="
		write !,"Data informada (europeu) : ", pData
		write !,"Data em $Horolog         : ", horologDate
		write !,"Data islamica (tipo 18)  : ", dataIslamica
		write !,"Mes islamico             : ", nomeMesIslam
	} catch ex {
		set tSC = ex.AsStatus()
	}
	quit tSC
}

/// 10 - Retorna dados do candidato e suas avaliacoes em formato JSON pelo ID
ClassMethod BuscarCandidatoPorIdJSON(pId As %String) As %DynamicObject
{
	#dim candidato As Prova.Data.Candidato = $$$NULLOREF
	#dim json      As %DynamicObject       = $$$NULLOREF
	try {
		set candidato = ##class(Prova.Data.Candidato).%OpenId(pId)
		if '$isObject(candidato) {
			quit
		}

		set json                  = {}
		set json.ID               = pId
		set json.Nome             = candidato.Nome
		set json.Idade            = candidato.Idade
		set json.Sexo             = candidato.Sexo
		set json.CodigoCandidato  = candidato.CodigoCandidato

		set avaliacoes = []
		set count      = candidato.Avaliacoes.Count()
		for i=1:1:count {
			set av              = candidato.Avaliacoes.GetAt(i)
			set itemAv          = {}
			set itemAv.NomeDisciplina = av.NomeDisciplina
			set itemAv.Tipo     = av.Tipo
			set itemAv.Nota     = av.Nota

			if av.Tipo = "Teorica" {
				set itemAv.Resultado = $select(av.Nota >= 6: "APROVADO", 1: "REPROVADO")
			} else {
				set itemAv.Resultado = $select(av.Nota >= 7: "APROVADO", 1: "REPROVADO")
			}

			do avaliacoes.%Push(itemAv)
		}

		set json.Avaliacoes = avaliacoes
	} catch ex {
		set json = $$$NULLOREF
	}
	quit json
}

/// 11 - Retorna lista paginada de candidatos com avaliacoes em JSON (keyset pagination)
ClassMethod ConsultaCandidatoPaginacaoJSON(pNomeCandidato As %String, pLastId As %String, pPageSize As %Integer, pSexo As %String) As %DynamicObject
{
	#dim json As %DynamicObject = $$$NULLOREF
	try {
		set itens         = []
		set proximoLastId = pLastId

		set sql = "SELECT TOP ? ID, Nome, Idade, Sexo, CodigoCandidato"
			_ " FROM Prova_Data.Candidato"
			_ " WHERE ID > ?"
			_ " AND (? = '' OR Nome LIKE ?)"
			_ " AND (? = '' OR Sexo = ?)"
			_ " ORDER BY ID"

		set rs = ##class(%SQL.Statement).%ExecDirect(, sql,
			pPageSize, pLastId,
			pNomeCandidato, "%" _ pNomeCandidato _ "%",
			pSexo, pSexo)

		if rs.%SQLCODE < 0 {
			quit
		}

		set total = 0
		while rs.%Next() {
			set idCand = rs.%Get("ID")

			set item                 = {}
			set item.ID              = idCand
			set item.Nome            = rs.%Get("Nome")
			set item.Idade           = rs.%Get("Idade")
			set item.Sexo            = rs.%Get("Sexo")
			set item.CodigoCandidato = rs.%Get("CodigoCandidato")

			set avaliacoes = []
			set sqlAv = "SELECT NomeDisciplina, Tipo, Nota"
				_ " FROM Prova_Data.Avaliacao"
				_ " WHERE Candidato = ?"
				_ " ORDER BY NomeDisciplina"
			set rsAv = ##class(%SQL.Statement).%ExecDirect(, sqlAv, idCand)
			while rsAv.%Next() {
				set tipo   = rsAv.%Get("Tipo")
				set nota   = rsAv.%Get("Nota")
				set itemAv = {}
				set itemAv.NomeDisciplina = rsAv.%Get("NomeDisciplina")
				set itemAv.Tipo      = tipo
				set itemAv.Nota      = nota
				set itemAv.Resultado = $select(
					tipo = "Teorica": $select(nota >= 6: "APROVADO", 1: "REPROVADO"),
					1:               $select(nota >= 7: "APROVADO", 1: "REPROVADO"))
				do avaliacoes.%Push(itemAv)
			}
			set item.Avaliacoes = avaliacoes

			do itens.%Push(item)
			set proximoLastId = idCand
			set total         = total + 1
		}

		set json                = {}
		set json.Itens          = itens
		set json.Total          = total
		set json.ProximoLastId  = $select(total = pPageSize: proximoLastId, 1: "")
	} catch ex {
		set json = $$$NULLOREF
	}
	quit json
}

/// 12 - Ciclo completo de log: cria entrada, atualiza status e finaliza com sucesso
ClassMethod CriarLogMensagem() As %Status
{
	set tSC = $$$OK
	try {
		set log = ##class(Treinamento.Data.LogMensagem).CriarEntrada("CriarLogMensagem", "Prova.Data.Candidato")
		if '$isObject(log) {
			set tSC = $$$ERROR($$$GeneralError, "Falha ao criar entrada de log")
			quit
		}
		set idLog = log.%Id()
		write !,"Log criado com sucesso - ID: ", idLog
		write !,"  Servico : Prova.Data.Candidato"
		write !,"  Sistema : Desafio InterSystems"
		write !,"  Inicio  : ", log.Inicio
		write !,"  Status  : ", log.Status

		set log.StatusProcesso = "Processo realizado com sucesso!"
		set tSC = log.%Save()
		write !,"Status atualizado: ", log.StatusProcesso

		set tSC = ##class(Treinamento.Data.LogMensagem).Finalizar(idLog, "Processo realizado com sucesso!", "1")
		if tSC {
			write !,"Log finalizado com status: 1 (sucesso)"
		}
	} catch ex {
		set tSC = ex.AsStatus()
	}
	quit tSC
}

/// 13 - Exibe registros de log filtrados por Status, DataInicio e DataFim
ClassMethod ConsultaLog(pStatus As %String, pDataInicio As %TimeStamp, pDataFim As %TimeStamp) As %Status
{
	quit ##class(Treinamento.Data.LogMensagem).ConsultaLog(pStatus, pDataInicio, pDataFim)
}

/// 14 - Retorna logs paginados em JSON filtrados por Status, LastId, PageSize e DataFim
ClassMethod ConsultaLogPaginacaoJSON(pStatus As %String, pLastId As %String, pPageSize As %Integer, pDataFim As %TimeStamp) As %DynamicObject
{
	quit ##class(Treinamento.VO.LogMensagem).ConsultaLogPaginacaoJSON(pStatus, pLastId, pPageSize, pDataFim)
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
<DataLocation>^Prova.Data.CandidatoD</DataLocation>
<DefaultData>CandidatoDefaultData</DefaultData>
<IdLocation>^Prova.Data.CandidatoD</IdLocation>
<IndexLocation>^Prova.Data.CandidatoI</IndexLocation>
<StreamLocation>^Prova.Data.CandidatoS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
