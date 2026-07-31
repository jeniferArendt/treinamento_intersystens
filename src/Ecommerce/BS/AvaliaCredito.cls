Class Ecommerce.BS.AvaliaCredito Extends Ens.BusinessService
{

Method AvaliaCredito(pCodigoCliente As %Integer, pIndicador As %String, Output pOutput As Ecommerce.BP.Msg.Response) As %Status
{
	set tSC = $system.Status.OK()

	try
	{
		set tRequest = ##class(Ecommerce.BP.Msg.Request).%New()
		set tRequest.CodigoCliente = pCodigoCliente
		set tRequest.Indicador     = pIndicador

		set tSC = ..SendRequestSync("Avalia Credito BP", tRequest, .tResponse)
		quit:$$$ISERR(tSC)

		set pOutput = tResponse
	}
	catch ex
	{
		set tSC = ex.AsStatus()
	}
	quit tSC
}

}
