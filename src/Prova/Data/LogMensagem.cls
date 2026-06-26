Class Prova.Data.LogMensagem Extends %Persistent
{

Parameter SISTEMA = "Desafio InterSystems";

Parameter TABELA = "Log de execução da aplicação";

Parameter TITULO = "Log de Mensagem";

Parameter SITUACAO = 1;

Property Servico As %String(MAXLEN = 100);

Property Sistema As %String(MAXLEN = 100);

Property Status As %String(MAXLEN = 50);

Property HorarioExecucao As %TimeStamp;

Property DataExecucao As %Date(FORMAT = 4);

Property Mensagem As %String(MAXLEN = 500);

/// Ciclo completo: cria, atualiza e finaliza um registro de log
ClassMethod CriarLogMensagem(Servico As %String, Sistema As %String) As %Status
{
    set log = ##class(Prova.Data.LogMensagem).%New()
    set log.Servico = Servico
    set log.Sistema = Sistema
    set log.Status = "Iniciado"
    set log.HorarioExecucao = $ZDateTime($Horolog, 3, 1)
    set log.DataExecucao = +$Horolog
    set log.Mensagem = "Processando..."
    set sc = log.%Save()
    if $System.Status.IsError(sc) quit sc
    write "Log criado - ID: ", log.%Id(), " | Status: ", log.Status, !

    set log.Status = "Processando"
    set log.Mensagem = "Processo realizado com sucesso!"
    set sc = log.%Save()
    if $System.Status.IsError(sc) quit sc
    write "Status atualizado: ", log.Mensagem, !

    set log.Status = "1"
    set sc = log.%Save()
    if $System.Status.IsError(sc) quit sc
    write "Log finalizado com status: ", log.Status, !

    quit $$$OK
}

/// Exibe logs filtrados por status e período (DD/MM/AAAA)
ClassMethod ConsultaLog(Status As %String = "", DataInicio As %String = "", DataFim As %String = "")
{
    set dtInicio = $Select(DataInicio '= "": $ZDateH(DataInicio, 4), 1: 0)
    set dtFim = $Select(DataFim '= "": $ZDateH(DataFim, 4), 1: 99999999)

    set sql = "SELECT ID, Servico, Sistema, Status, HorarioExecucao, Mensagem "_
              "FROM Prova_Data.LogMensagem "_
              "WHERE (? = '' OR Status = ?) "_
              "AND DataExecucao >= ? "_
              "AND DataExecucao <= ? "_
              "ORDER BY ID"

    set rs = ##class(%SQL.Statement).%New()
    do rs.%Prepare(sql)
    set result = rs.%Execute(Status, Status, dtInicio, dtFim)

    write "ID | Servico | Sistema | Status | Horario | Mensagem", !
    write "------------------------------------------------------------", !

    while result.%Next() {
        write result.%Get("ID"), " | "
        write result.%Get("Servico"), " | "
        write result.%Get("Sistema"), " | "
        write result.%Get("Status"), " | "
        write result.%Get("HorarioExecucao"), " | "
        write result.%Get("Mensagem"), !
    }
}

/// Retorna logs paginados em formato JSON com cursor LastId
ClassMethod ConsultaLogPaginacaoJSON(Status As %String = "", LastId As %Integer = 0, PageSize As %Integer = 10, DataFim As %String = "") As %DynamicObject
{
    set result = {}
    set lista = []
    set total = 0
    set proximoLastId = 0

    set dtFim = $Select(DataFim '= "": $ZDateH(DataFim, 4), 1: 99999999)

    set sql = "SELECT TOP ? ID, Servico, Sistema, Status, HorarioExecucao, Mensagem "_
              "FROM Prova_Data.LogMensagem "_
              "WHERE ID > ? "_
              "AND (? = '' OR Status = ?) "_
              "AND DataExecucao <= ? "_
              "ORDER BY ID"

    set rs = ##class(%SQL.Statement).%New()
    do rs.%Prepare(sql)
    set rset = rs.%Execute(PageSize, LastId, Status, Status, dtFim)

    while rset.%Next() {
        set logJson = {}
        set logJson.ID = rset.%Get("ID")
        set logJson.Servico = rset.%Get("Servico")
        set logJson.Sistema = rset.%Get("Sistema")
        set logJson.Status = rset.%Get("Status")
        set logJson.HorarioExecucao = rset.%Get("HorarioExecucao")
        set logJson.Mensagem = rset.%Get("Mensagem")
        do lista.%Push(logJson)
        set total = total + 1
        set proximoLastId = rset.%Get("ID")
    }

    set result.Lista = lista
    set result.Total = total
    set result.ProximoLastId = proximoLastId

    quit result
}

Storage Default
{
<Data name="LogMensagemDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Servico</Value>
</Value>
<Value name="3">
<Value>Sistema</Value>
</Value>
<Value name="4">
<Value>Status</Value>
</Value>
<Value name="5">
<Value>HorarioExecucao</Value>
</Value>
<Value name="6">
<Value>DataExecucao</Value>
</Value>
<Value name="7">
<Value>Mensagem</Value>
</Value>
</Data>
<DataLocation>^Prova.Data.LogMensagemD</DataLocation>
<DefaultData>LogMensagemDefaultData</DefaultData>
<IdLocation>^Prova.Data.LogMensagemD</IdLocation>
<IndexLocation>^Prova.Data.LogMensagemI</IndexLocation>
<StreamLocation>^Prova.Data.LogMensagemS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
