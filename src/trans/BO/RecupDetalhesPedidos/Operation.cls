Class trans.BO.RecupDetalhesPedidos.Operation Extends Ens.BusinessOperation
{

Parameter INVOCATION = "Queue";

XData MessageMap
{
<MapItems>
<MapItem MessageType="trans.BO.RecupDetalhesPedidos.Request">
<Method>RecupDetalhesPedidos</Method>
</MapItem>
</MapItems>
}

Method RecupDetalhesPedidos(pRequest As trans.BO.RecupDetalhesPedidos.Request, Output pResponse As trans.BO.RecupDetalhesPedidos.Response) As %Status
{
	set tSC = $system.Status.OK()
	set pResponse = ##class(trans.BO.RecupDetalhesPedidos.Response).%New()

	try
	{
		$$$TRACE("Iniciando Metodo BO RecupDetalhesPedidos")

		if (pRequest.CodigoPedido = "") {
			set tSC = $$$ERROR($$$GeneralError, "CodigoPedido é obrigatório")
			quit
		}

		set sql = "select Cliente.Endereco, Cliente.CEP, Cliente.Cidade, Cliente.Estado, Cliente.EnderecoEmail, Cliente.NomeEmpresa, Cliente.NomeContato, Pedido.PesoKg, Pedido.Volumes"
			_ " from TRE_DATA.Pedido as Pedido"
			_ " inner join TRE_DATA.Cliente as Cliente on Pedido.CodigoCliente = Cliente.CodigoCliente"
			_ " where Pedido.CodigoPedido = ?"

		set rs = ##class(%SQL.Statement).%ExecDirect(, sql, pRequest.CodigoPedido)

		if rs.%SQLCODE < 0 {
			set tSC = $$$ERROR($$$GeneralError, rs.%Message)
			quit
		}

		if 'rs.%Next() {
			$$$TRACE("Pedido " _ pRequest.CodigoPedido _ " não encontrado!")
			quit
		}

		set pResponse.Endereco    = rs.%Get("Endereco")
		set pResponse.CEP         = rs.%Get("CEP")
		set pResponse.Cidade      = rs.%Get("Cidade")
		set pResponse.Estado      = rs.%Get("Estado")
		set pResponse.Email       = rs.%Get("EnderecoEmail")
		set pResponse.NomeEmpresa = rs.%Get("NomeEmpresa")
		set pResponse.NomeContato = rs.%Get("NomeContato")
		set pResponse.PesoKg      = rs.%Get("PesoKg")
		set pResponse.Volumes     = rs.%Get("Volumes")
	}
	catch ex
	{
		$$$TRACE("Erro no Metodo BO RecupDetalhesPedidos " _ ex.DisplayString())
		set tSC = ex.AsStatus()
	}
	quit tSC
}

}
