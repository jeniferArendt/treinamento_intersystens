Class trans.BP.DetalhesCliente.ProcessaCliente Extends Ens.BusinessProcess
{

Method OnRequest(pRequest As trans.BP.DetalhesCliente.msg.Request, Output pResponse As trans.BP.DetalhesCliente.msg.Response) As %Status
{
	set tSC = $system.Status.OK()
	set pResponse = ##class(trans.BP.DetalhesCliente.msg.Response).%New()

	try
	{
		if pRequest.Metodo = "Get" {
			set tReq = ##class(trans.BO.DetalhesPedido.Cliente.Rest.Get.Request).%New()
			set tReq.Metodo = pRequest.Metodo
			set tReq.DATA = pRequest.DATA
			set tSC = ..SendRequestSync("Pedido BO", tReq, .tRes)
		}
		elseif pRequest.Metodo = "Post" {
			set tReq = ##class(trans.BO.DetalhesPedido.Cliente.Rest.Post.Request).%New()
			set tReq.DATA = pRequest.DATA
			set tSC = ..SendRequestSync("Pedido BO", tReq, .tRes)
		}
		elseif pRequest.Metodo = "Put" {
			set tReq = ##class(trans.BO.DetalhesPedido.Cliente.Rest.Put.Request).%New()
			set tReq.DATA = pRequest.DATA
			set tSC = ..SendRequestSync("Pedido BO", tReq, .tRes)
		}
		elseif pRequest.Metodo = "Delete" {
			set tReq = ##class(trans.BO.DetalhesPedido.Cliente.Rest.Delete.Request).%New()
			set tReq.DATA = pRequest.DATA
			set tSC = ..SendRequestSync("Pedido BO", tReq, .tRes)
		}
		else {
			set tSC = $$$ERROR($$$GeneralError, "Metodo não suportado: "_pRequest.Metodo)
		}

		quit:$$$ISERR(tSC)

		set pResponse.Status = tRes.Status
		set pResponse.Contents = tRes.Contents
	}
	catch ex
	{
		set tSC = ex.AsStatus()
	}
	quit tSC
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
