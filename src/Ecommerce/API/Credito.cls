Class Ecommerce.API.Credito Extends %CSP.REST
{

Parameter HandleCorsRequest = 1;

Parameter CONTENTTYPE = "application/json";

XData UrlMap
{
<Routes>
<Route Url="/credito/:CodigoCliente/:Indicador" Method="GET" Call="GetResultadoCredito"/>
</Routes>
}

ClassMethod OnHandleCorsRequest(pUrl As %String) As %Status
{
	do %response.SetHeader("Access-Control-Allow-Origin", "*")
	do %response.SetHeader("Access-Control-Allow-Credentials", "true")
	do %response.SetHeader("Access-Control-Allow-Methods", "GET, OPTIONS")
	do %response.SetHeader("Access-Control-Allow-Headers", "Content-Type, Token")
	quit $$$OK
}

ClassMethod GetResultadoCredito(pCodigoCliente As %Integer, pIndicador As %String) As %Status
{
	set tSC = $$$OK

	try
	{
		set tSC = ##class(Ens.Director).CreateBusinessService("Avalia Credito BS", .tBS)
		quit:$$$ISERR(tSC)

		set tSC = tBS.OnProcessInput(pCodigoCliente, .tResponse, .pIndicador)
		quit:$$$ISERR(tSC)

		do ..EscreveResposta(tResponse)
	}
	catch ex
	{
		set tSC = ex.AsStatus()
		do ..EscreveErro(tSC)
	}
	quit tSC
}

ClassMethod EscreveResposta(pResponse As Ecommerce.BP.Msg.Response)
{
	set %response.Status = 200
	set tJson = {}
	set tJson.Indicador = pResponse.Indicador
	set tJson.Resultado = pResponse.Resultado
	write tJson.%ToJSON()
}

ClassMethod EscreveErro(pSC As %Status)
{
	set %response.Status = 500
	set tJson = {}
	set tJson.Erro = $system.Status.GetErrorText(pSC)
	write tJson.%ToJSON()
}

}
