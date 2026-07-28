Class trans.BO.DetalhesPedido.Operation Extends Ens.BusinessOperation
{

Parameter INVOCATION = "Queue";

XData MessageMap
{
<MapItems>
<MapItem MessageType="trans.BO.DetalhesPedido.Cliente.Request">
<Method>Cliente</Method>
</MapItem>
<MapItem MessageType="trans.BO.DetalhesPedido.Destino.Request">
<Method>Destino</Method>
</MapItem>
<MapItem MessageType="trans.BO.DetalhesPedido.Pedido.Request">
<Method>Pedido</Method>
</MapItem>
</MapItems>
}

Method Cliente(pRequest As trans.BO.DetalhesPedido.Cliente.Request, Output pResponse As trans.BO.DetalhesPedido.Cliente.Response) As %Status
{
	set tSC = $system.Status.OK()
	set pResponse = ##class(trans.BO.DetalhesPedido.Cliente.Response).%New()

	try
	{
		hang 30

		$$$TRACE("Iniciando Metodo BO Cliente")

		if (pRequest.CodigoCliente = "") {
			set tSC = $$$ERROR($$$GeneralError, "CodigoCliente é obrigatório")
			quit
		}
		if (pRequest.NomeEmpresa = "") {
			set tSC = $$$ERROR($$$GeneralError, "NomeEmpresa é obrigatório")
			quit
		}
		if (pRequest.NomeContato = "") {
			set tSC = $$$ERROR($$$GeneralError, "NomeContato é obrigatório")
			quit
		}
		if (pRequest.EnderecoEmail = "") {
			set tSC = $$$ERROR($$$GeneralError, "EnderecoEmail é obrigatório")
			quit
		}

		set obj = ##class(TRE.DATA.Cliente).%New()
		set obj.CodigoCliente = pRequest.CodigoCliente
		set obj.NomeEmpresa   = pRequest.NomeEmpresa
		set obj.NomeContato   = pRequest.NomeContato
		set obj.Endereco      = pRequest.Endereco
		set obj.CEP           = pRequest.CEP
		set obj.Cidade        = pRequest.Cidade
		set obj.Estado        = pRequest.Estado
		set obj.EnderecoEmail = pRequest.EnderecoEmail

		$$$TRACE("Salvando obj no BO de Cliente")
		set tSC = obj.%Save()
		quit:$$$ISERR(tSC)
		set pResponse.Message = "O obj de Cliente foi salvo com sucesso"
	}
	catch ex
	{
		$$$TRACE("Erro salvando Objeto Metodo BO Cliente " _ ex.DisplayString())
		set tSC = ex.AsStatus()
	}
	quit tSC
}

Method Destino(pRequest As trans.BO.DetalhesPedido.Destino.Request, Output pResponse As trans.BO.DetalhesPedido.Destino.Response) As %Status
{
	set tSC = $system.Status.OK()
	set pResponse = ##class(trans.BO.DetalhesPedido.Destino.Response).%New()

	try
	{
		hang 30
		
		$$$TRACE("Iniciando Metodo BO Destino")
		set obj = ##class(TRE.DATA.Destino).%New()
		set obj.CodigoDestino    = pRequest.CodigoDestino
		set obj.CEPInicial       = pRequest.CEPInicial
		set obj.CEPFinal         = pRequest.CEPFinal
		set obj.PrazoEntregaDias = pRequest.PrazoEntregaDias

		$$$TRACE("Salvando obj no BO de Destino")
		set tSC = obj.%Save()
		quit:$$$ISERR(tSC)
		set pResponse.Message = "O obj de Destino foi salvo com sucesso"
	}
	catch ex
	{
		$$$TRACE("Erro salvando Objeto Metodo BO Destino " _ ex.DisplayString())
		set tSC = ex.AsStatus()
	}
	quit tSC
}

Method Pedido(pRequest As trans.BO.DetalhesPedido.Pedido.Request, Output pResponse As trans.BO.DetalhesPedido.Pedido.Response) As %Status
{
	set tSC = $system.Status.OK()
	set pResponse = ##class(trans.BO.DetalhesPedido.Pedido.Response).%New()

	try
	{
		$$$TRACE("Iniciando Metodo BO Pedido")

		set obj = ##class(TRE.DATA.Pedido).%New()
		set obj.CodigoPedido         = pRequest.CodigoPedido
		set obj.DataPedido           = pRequest.DataPedido
		set obj.CodigoCliente        = pRequest.CodigoCliente
		set obj.ValorPedido          = pRequest.ValorPedido
		set obj.PesoKg               = pRequest.PesoKg
		set obj.Volumes              = pRequest.Volumes
		set obj.CodigoTransportadora = pRequest.CodigoTransportadora
		set obj.DataPrevisaoEntrega  = pRequest.DataPrevisaoEntrega

		$$$TRACE("Salvando obj no BO de Pedido")
		set tSC = obj.%Save()
		quit:$$$ISERR(tSC)
		set pResponse.Message = "O obj de Pedido foi salvo com sucesso"
	}
	catch ex
	{
		$$$TRACE("Erro salvando Objeto Metodo BO Pedido " _ ex.DisplayString())
		set tSC = ex.AsStatus()
	}
	quit tSC
}

}
