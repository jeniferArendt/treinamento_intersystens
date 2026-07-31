Class trans.BS.DetalhesCliente Extends Ens.BusinessService
{

Method OnProcessInput(pInput As %String, Output pOutput As %RegisteredObject, pMethod As %String) As %Status
{
	set tSC = $system.Status.OK()

	try
	{
		set tRequest = ##class(trans.BP.DetalhesCliente.msg.Request).%New()
		set tRequest.DATA = pInput

		if pMethod = "GetCliente" {
			set tRequest.Metodo = "Get"
		}
		elseif pMethod = "PostCliente" {
			set tRequest.Metodo = "Post"
		}
		elseif pMethod = "PutCliente" {
			set tRequest.Metodo = "Put"
		}
		elseif pMethod = "DeleteCliente" {
			set tRequest.Metodo = "Delete"
		}

		set tSC = ..SendRequestSync("ProcessCliente", tRequest, .tResponse)
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
