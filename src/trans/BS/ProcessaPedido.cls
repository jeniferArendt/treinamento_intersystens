Class trans.BS.ProcessaPedido Extends (Ens.BusinessService, %SOAP.WebService)
{

Parameter SERVICENAME = "ProcessaPedidos";

Parameter LOCATION = "http://localhost:52773/csp/treinamento/services";

Parameter NAMESPACE = "http://intersystem.com";

Method OnProcessInput(pInput As %RegisteredObject, Output pOutput As %RegisteredObject) As %Status
{
	set status = $$$OK
	set pOutput = ##class(trans.VO.ConfirmaPedido).%New()

	if '$IsObject($Get(%EnsRole)) {
		set %EnsRole = ""
	}

	set requestBP = ##class(trans.BP.ProcessaTransporte.Request).%New()
	set requestBP.CodigoPedido = pInput

	set status = ..SendRequestSync("ProcessaTransporteCustom", requestBP, .responseBP)

	if $$$ISOK(status) && $IsObject($Get(responseBP)) {
		set pOutput.Status = responseBP.Status
		set pOutput.CodigoTransp = responseBP.CodigoTransp
		set pOutput.DataPrevisaoEntrega = responseBP.DataPrevisaoEntrega
	}

	quit status
}

Method ProcessaPedido(pCodigoPedido As %String) As trans.VO.ConfirmaPedido [ WebMethod ]
{
	set tConfirmacao = ##class(trans.VO.ConfirmaPedido).%New()

	try
	{
		set tRequest = ##class(trans.BP.ProcessaTransporte.Request).%New()
		set tRequest.CodigoPedido = pCodigoPedido

		set tStatus = ..SendRequestSync("ProcessaTransporte", tRequest, .tResponse)
		if $$$ISERR(tStatus) {
			quit
		}

		set tConfirmacao.Status = tResponse.Status
		set tConfirmacao.CodigoTransp = tResponse.CodigoTransp
		set tConfirmacao.DataPrevisaoEntrega = tResponse.DataPrevisaoEntrega
	}
	catch ex
	{
		$$$TRACE("Erro no Metodo BS ProcessaPedido " _ ex.DisplayString())
	}

	quit tConfirmacao
}

}
