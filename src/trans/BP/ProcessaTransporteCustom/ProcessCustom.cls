Class trans.BP.ProcessaTransporteCustom.ProcessCustom Extends Ens.BusinessProcess
{

Method OnRequest(pRequest As trans.BP.ProcessaTransporte.Request, Output pResponse As trans.BP.ProcessaTransporte.Response) As %Status
{
	set tSC = $system.Status.OK()
	set pResponse = ##class(trans.BP.ProcessaTransporte.Response).%New()

	try
	{
		$$$TRACE("Iniciando Metodo BP ProcessCustom OnRequest")

		set callrequest = ##class(trans.BO.RecupDetalhesPedidos.Request).%New()
		set callrequest.CodigoPedido = pRequest.CodigoPedido

		set callresponse = ##class(trans.BO.RecupDetalhesPedidos.Response).%New()

		set status = ..ChamaDetalhesPedido(callrequest, .callresponse)
		if $$$ISERR(status) {
			set tSC = status
			quit
		}

		set tCep = callresponse.CEP
		set tPesoKg = callresponse.PesoKg

		if (tCep = "") {
			set pResponse.Status = 0
		}
		else {
			set pResponse.Status = 1
			set Cep5n = $piece(tCep, "-", 1)

			set callrequestSpeedy = ##class(trans.BO.DetalhesSpeedy.VerificaDestinoSpeedy.Request).%New()
			set callrequestSpeedy.Cep5n = Cep5n

			set callresponseSpeedy = ##class(trans.BO.DetalhesSpeedy.VerificaDestinoSpeedy.Response).%New()

			set status = ..ChamaVerificaDestinoSpeedy(callrequestSpeedy, .callresponseSpeedy)
			if $$$ISERR(status) {
				set tSC = status
				quit
			}

			set tAtendidoSpeedy = callresponseSpeedy.AtendidoSpeedy

			set callrequestPrazo = ##class(trans.BO.DetalhesSpeedy.RecupPrazoEntrega.Request).%New()
			set callrequestPrazo.Cep5n = Cep5n

			set callresponsePrazo = ##class(trans.BO.DetalhesSpeedy.RecupPrazoEntrega.Response).%New()

			set status = ..ChamaRecupPrazoEntrega(callrequestPrazo, .callresponsePrazo)
			if $$$ISERR(status) {
				set tSC = status
				quit
			}

			set tPrazoEntregaDias = callresponsePrazo.PrazoEntregaDias

			if (tAtendidoSpeedy = 1) && (tPesoKg <= 50) {
				set pResponse.CodigoTransp = 1
				set dataPrevisaoEntrega = $horolog + tPrazoEntregaDias
				set pResponse.DataPrevisaoEntrega = $zdate(dataPrevisaoEntrega, 4,,4)
			}
			else {
				set pResponse.CodigoTransp = 2
				set dataPrevisaoEntrega = $horolog + 5
				set pResponse.DataPrevisaoEntrega = $zdate(dataPrevisaoEntrega, 4,,4)
			}
		}
	}
	catch ex
	{
		$$$TRACE("Erro no Metodo BP ProcessCustom OnRequest " _ ex.DisplayString())
		set tSC = ex.AsStatus()
	}
	quit tSC
}

Method ChamaDetalhesPedido(pRequest As trans.BO.RecupDetalhesPedidos.Request, Output pResponse As trans.BO.RecupDetalhesPedidos.Response) As %Status
{
	quit ..SendRequestSync("DetalhesPedido BO", pRequest, .pResponse)
}

Method ChamaVerificaDestinoSpeedy(pRequest As trans.BO.DetalhesSpeedy.VerificaDestinoSpeedy.Request, Output pResponse As trans.BO.DetalhesSpeedy.VerificaDestinoSpeedy.Response) As %Status
{
	quit ..SendRequestSync("DetalhesSpeedy BO", pRequest, .pResponse)
}

Method ChamaRecupPrazoEntrega(pRequest As trans.BO.DetalhesSpeedy.RecupPrazoEntrega.Request, Output pResponse As trans.BO.DetalhesSpeedy.RecupPrazoEntrega.Response) As %Status
{
	quit ..SendRequestSync("DetalhesSpeedy BO", pRequest, .pResponse)
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
