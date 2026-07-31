Class Ecommerce.BO.Operation Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Parameter INVOCATION = "Queue";

XData MessageMap
{
<MapItems>
<MapItem MessageType="Ecommerce.BO.Msg.Request">
<Method>RecupDadosCredito</Method>
</MapItem>
</MapItems>
}

Method RecupDadosCredito(pRequest As Ecommerce.BO.Msg.Request, Output pResponse As Ecommerce.BO.Msg.Response) As %Status
{
	set tSC = $$$OK
	set pResponse = ##class(Ecommerce.BO.Msg.Response).%New()

	try
	{
		if (pRequest.CodigoCliente = "") {
			set tSC = $$$ERROR($$$GeneralError, "CodigoCliente é obrigatório")
			quit
		}
		if (pRequest.Indicador = "") {
			set tSC = $$$ERROR($$$GeneralError, "Indicador é obrigatório")
			quit
		}

		$$$TRACE("Iniciando Metodo BO RecupDadosCredito")

		set tSQL = "select Cliente.Nome, Score.TipoAvaliacao, Score.Indicador, Score.Score"
			_ " from Ecommerce_Data.Cliente as Cliente"
			_ " inner join Ecommerce_Data.ScoreCredito as Score on Score.CodigoCliente = Cliente.CodigoCliente"
			_ " where Cliente.CodigoCliente = ? and Score.Indicador = ?"

		set tSC = ..Adapter.ExecuteQuery(.tRS, tSQL, pRequest.CodigoCliente, pRequest.Indicador)
		quit:$$$ISERR(tSC)

		if 'tRS.%Next() {
			set tSC = $$$ERROR($$$GeneralError, "Nenhum indicador '"_pRequest.Indicador_"' encontrado para o cliente "_pRequest.CodigoCliente)
			quit
		}

		set pResponse.Nome          = tRS.%Get("Nome")
		set pResponse.TipoAvaliacao = tRS.%Get("TipoAvaliacao")
		set pResponse.Indicador     = tRS.%Get("Indicador")
		set pResponse.Score         = tRS.%Get("Score")
	}
	catch ex
	{
		$$$TRACE("Erro no Metodo BO RecupDadosCredito " _ ex.DisplayString())
		set tSC = ex.AsStatus()
	}
	quit tSC
}

}
