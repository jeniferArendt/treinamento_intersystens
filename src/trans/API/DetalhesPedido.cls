Class trans.API.DetalhesPedido Extends %CSP.REST
{

Parameter HandleCorsRequest = 1;

Parameter CONTENTTYPE = "application/json";

XData UrlMap
{
<Routes>
<Route Url="/" Method="GET" Call="GetCliente"/>
<Route Url="/" Method="POST" Call="PostCliente"/>
<Route Url="/" Method="PUT" Call="PutCliente"/>
<Route Url="/" Method="DELETE" Call="DeleteCliente"/>
</Routes>
}

ClassMethod OnHandleCorsRequest(pUrl As %String) As %Status
{
	do %response.SetHeader("Access-Control-Allow-Origin", "*")
	do %response.SetHeader("Access-Control-Allow-Credentials", "true")
	do %response.SetHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS")
	do %response.SetHeader("Access-Control-Allow-Headers", "Content-Type, Token")
	quit $$$OK
}

ClassMethod GetCliente() As %Status
{
	set tSC = $system.Status.OK()

	try
	{
		set tEntrada = {}
		set tEntrada.NomeContato = %request.Get("NomeContato")

		set tSC = ##class(Ens.Director).CreateBusinessService("DetalhesCliente", .tBS)
		quit:$$$ISERR(tSC)

		set tSC = tBS.OnProcessInput(tEntrada.%ToJSON(), .tSaida, "GetCliente")
		quit:$$$ISERR(tSC)

		do ..EscreveResposta(tSaida)
	}
	catch ex
	{
		set tSC = ex.AsStatus()
		do ..EscreveErro(tSC)
	}
	quit tSC
}

ClassMethod PostCliente() As %Status
{
	set tSC = $system.Status.OK()

	try
	{
		set tCorpo = %request.Content.Read()

		set tSC = ##class(Ens.Director).CreateBusinessService("DetalhesCliente", .tBS)
		quit:$$$ISERR(tSC)

		set tSC = tBS.OnProcessInput(tCorpo, .tSaida, "PostCliente")
		quit:$$$ISERR(tSC)

		do ..EscreveResposta(tSaida)
	}
	catch ex
	{
		set tSC = ex.AsStatus()
		do ..EscreveErro(tSC)
	}
	quit tSC
}

ClassMethod PutCliente() As %Status
{
	set tSC = $system.Status.OK()

	try
	{
		set tCorpo = %request.Content.Read()

		set tSC = ##class(Ens.Director).CreateBusinessService("DetalhesCliente", .tBS)
		quit:$$$ISERR(tSC)

		set tSC = tBS.OnProcessInput(tCorpo, .tSaida, "PutCliente")
		quit:$$$ISERR(tSC)

		do ..EscreveResposta(tSaida)
	}
	catch ex
	{
		set tSC = ex.AsStatus()
		do ..EscreveErro(tSC)
	}
	quit tSC
}

ClassMethod DeleteCliente() As %Status
{
	set tSC = $system.Status.OK()

	try
	{
		set tId = %request.Get("Id")

		set tSC = ##class(Ens.Director).CreateBusinessService("DetalhesCliente", .tBS)
		quit:$$$ISERR(tSC)

		set tSC = tBS.OnProcessInput(tId, .tSaida, "DeleteCliente")
		quit:$$$ISERR(tSC)

		do ..EscreveResposta(tSaida)
	}
	catch ex
	{
		set tSC = ex.AsStatus()
		do ..EscreveErro(tSC)
	}
	quit tSC
}

ClassMethod EscreveResposta(pSaida As trans.BP.DetalhesCliente.msg.Response)
{
	set tHttp = 200
	if pSaida.Status = 1 {
		set tHttp = 400
	}
	elseif pSaida.Status = 2 {
		set tHttp = 500
	}

	set %response.Status = tHttp
	set tJson = {}
	set tJson.Status = pSaida.Status
	set tJson.Contents = pSaida.Contents
	write tJson.%ToJSON()
}

ClassMethod EscreveErro(pSC As %Status)
{
	set %response.Status = 500
	set tJson = {}
	set tJson.Status = 2
	set tJson.Contents = $system.Status.GetErrorText(pSC)
	write tJson.%ToJSON()
}

}
