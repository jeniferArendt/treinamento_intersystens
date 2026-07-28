Class trans.BO.DetalhesSpeedy.Operation Extends Ens.BusinessOperation
{

Parameter INVOCATION = "Queue";

XData MessageMap
{
<MapItems>
<MapItem MessageType="trans.BO.DetalhesSpeedy.VerificaDestinoSpeedy.Request">
<Method>VerificaDestinoSpeedy</Method>
</MapItem>
<MapItem MessageType="trans.BO.DetalhesSpeedy.RecupPrazoEntrega.Request">
<Method>RecupPrazoEntrega</Method>
</MapItem>
</MapItems>
}

Method VerificaDestinoSpeedy(pRequest As trans.BO.DetalhesSpeedy.VerificaDestinoSpeedy.Request, Output pResponse As trans.BO.DetalhesSpeedy.VerificaDestinoSpeedy.Response) As %Status
{
	set tSC = $system.Status.OK()
	set pResponse = ##class(trans.BO.DetalhesSpeedy.VerificaDestinoSpeedy.Response).%New()

	try
	{
		$$$TRACE("Iniciando Metodo BO VerificaDestinoSpeedy")

		if (pRequest.Cep5n = "") {
			set tSC = $$$ERROR($$$GeneralError, "Cep5n é obrigatório")
			quit
		}
		if ('$match(pRequest.Cep5n, "\d{5}")) {
			set tSC = $$$ERROR($$$GeneralError, "Cep5n deve conter exatamente 5 números")
			quit
		}

		set sql = "select count(*) from TRE_DATA.Destino where CEPInicial <= ? and CEPFinal >= ?"
		set rs = ##class(%SQL.Statement).%ExecDirect(, sql, pRequest.Cep5n, pRequest.Cep5n)

		if rs.%SQLCODE < 0 {
			set tSC = $$$ERROR($$$GeneralError, rs.%Message)
			quit
		}

		do rs.%Next()
		set pResponse.AtendidoSpeedy = (rs.%GetData(1) > 0)
	}
	catch ex
	{
		$$$TRACE("Erro no Metodo BO VerificaDestinoSpeedy " _ ex.DisplayString())
		set tSC = ex.AsStatus()
	}
	quit tSC
}

Method RecupPrazoEntrega(pRequest As trans.BO.DetalhesSpeedy.RecupPrazoEntrega.Request, Output pResponse As trans.BO.DetalhesSpeedy.RecupPrazoEntrega.Response) As %Status
{
	set tSC = $system.Status.OK()
	set pResponse = ##class(trans.BO.DetalhesSpeedy.RecupPrazoEntrega.Response).%New()

	try
	{
		$$$TRACE("Iniciando Metodo BO RecupPrazoEntrega")

		if (pRequest.Cep5n = "") {
			set tSC = $$$ERROR($$$GeneralError, "Cep5n é obrigatório")
			quit
		}
		if ('$match(pRequest.Cep5n, "\d{5}")) {
			set tSC = $$$ERROR($$$GeneralError, "Cep5n deve conter exatamente 5 números")
			quit
		}

		set sql = "select top 1 PrazoEntregaDias from TRE_DATA.Destino where CEPInicial <= ? and CEPFinal >= ?"
		set rs = ##class(%SQL.Statement).%ExecDirect(, sql, pRequest.Cep5n, pRequest.Cep5n)

		if rs.%SQLCODE < 0 {
			set tSC = $$$ERROR($$$GeneralError, rs.%Message)
			quit
		}

		if 'rs.%Next() {
			set tSC = $$$ERROR($$$GeneralError, "Nenhum destino encontrado para o CEP " _ pRequest.Cep5n)
			quit
		}

		set pResponse.PrazoEntregaDias = rs.%Get("PrazoEntregaDias")
	}
	catch ex
	{
		$$$TRACE("Erro no Metodo BO RecupPrazoEntrega " _ ex.DisplayString())
		set tSC = ex.AsStatus()
	}
	quit tSC
}

}
