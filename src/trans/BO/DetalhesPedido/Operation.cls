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
<MapItem MessageType="trans.BO.DetalhesPedido.Cliente.Rest.Get.Request">
<Method>Get</Method>
</MapItem>
<MapItem MessageType="trans.BO.DetalhesPedido.Cliente.Rest.Post.Request">
<Method>Post</Method>
</MapItem>
<MapItem MessageType="trans.BO.DetalhesPedido.Cliente.Rest.Put.Request">
<Method>Put</Method>
</MapItem>
<MapItem MessageType="trans.BO.DetalhesPedido.Cliente.Rest.Delete.Request">
<Method>Delete</Method>
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

/// Consultar Cliente REST
Method Get(pRequest As trans.BO.DetalhesPedido.Cliente.Rest.Get.Request, Output pResponse As trans.BO.DetalhesPedido.Cliente.Rest.Get.Response) As %Status
{
	set tSC = $system.Status.OK()
	set pResponse = ##class(trans.BO.DetalhesPedido.Cliente.Rest.Get.Response).%New()

	try
	{
		set tResultado = []
		set tEntrada = ##class(%DynamicObject).%FromJSON(pRequest.DATA)

		set tQuery = ""
		if (tEntrada.NomeContato '= "") {
			set tQuery = "WHERE NomeContato LIKE '%"_tEntrada.NomeContato_"%' "
		}

		set tSQL = "SELECT ID, NomeContato FROM TRE_DATA.Cliente "_tQuery_" ORDER BY NomeContato"
		$$$TRACE("SQL Gerado: "_tSQL)

		set tRS = ##class(%ResultSet).%New()
		set tSC = tRS.Prepare(tSQL)
		if tSC {
			set tSC = tRS.Execute()
		}

		if $$$ISERR(tSC) {
			set pResponse.Status = 2
			set pResponse.Contents = $system.Status.GetErrorText(tSC)
			quit
		}

		while tRS.%Next() {
			do tResultado.%Push({
				"Id": (tRS.%Get("ID")),
				"Name": (tRS.%Get("NomeContato"))
			})
		}

		if tResultado.%Size() = 0 {
			set pResponse.Status = 1
			set pResponse.Contents = "Nenhum registro encontrado."
			quit
		}

		set tSaida = {}
		set tSaida.result = tResultado
		set pResponse.Status = 0
		set pResponse.Contents = tSaida.%ToJSON()
	}
	catch ex
	{
		set tSC = ex.AsStatus()
		set pResponse.Status = 2
		set pResponse.Contents = $system.Status.GetErrorText(tSC)
	}
	quit tSC
}

/// Incluir Cliente REST
Method Post(pRequest As trans.BO.DetalhesPedido.Cliente.Rest.Post.Request, Output pResponse As trans.BO.DetalhesPedido.Cliente.Rest.Post.Response) As %Status
{
	set tSC = $system.Status.OK()
	set pResponse = ##class(trans.BO.DetalhesPedido.Cliente.Rest.Post.Response).%New()

	try
	{
		set tEntrada = ##class(%DynamicObject).%FromJSON(pRequest.DATA)

		set tSQL = "INSERT INTO TRE_DATA.Cliente (CodigoCliente, NomeEmpresa, NomeContato, Endereco, CEP, Cidade, Estado, EnderecoEmail) "
		set tSQL = tSQL_"VALUES ('"_tEntrada.CodigoCliente_"','"_tEntrada.NomeEmpresa_"','"_tEntrada.NomeContato_"','"
		set tSQL = tSQL_tEntrada.Endereco_"','"_tEntrada.CEP_"','"_tEntrada.Cidade_"','"_tEntrada.Estado_"','"_tEntrada.EnderecoEmail_"')"
		$$$TRACE("SQL Gerado: "_tSQL)

		set tRS = ##class(%ResultSet).%New()
		set tSC = tRS.Prepare(tSQL)
		if tSC {
			set tSC = tRS.Execute()
		}

		if $$$ISERR(tSC) {
			set pResponse.Status = 2
			set pResponse.Contents = $system.Status.GetErrorText(tSC)
		} else {
			set pResponse.Status = 0
			set pResponse.Contents = "Cadastro realizado com sucesso."
		}
	}
	catch ex
	{
		set tSC = ex.AsStatus()
		set pResponse.Status = 2
		set pResponse.Contents = $system.Status.GetErrorText(tSC)
	}
	quit tSC
}

/// Alterar Cliente REST
Method Put(pRequest As trans.BO.DetalhesPedido.Cliente.Rest.Put.Request, Output pResponse As trans.BO.DetalhesPedido.Cliente.Rest.Put.Response) As %Status
{
	set tSC = $system.Status.OK()
	set pResponse = ##class(trans.BO.DetalhesPedido.Cliente.Rest.Put.Response).%New()

	try
	{
		set tEntrada = ##class(%DynamicObject).%FromJSON(pRequest.DATA)

		set tSQL = "UPDATE TRE_DATA.Cliente SET NomeEmpresa = '"_tEntrada.NomeEmpresa_"' WHERE ID = "_tEntrada.Id
		$$$TRACE("SQL Gerado: "_tSQL)

		set tRS = ##class(%ResultSet).%New()
		set tSC = tRS.Prepare(tSQL)
		if tSC {
			set tSC = tRS.Execute()
		}

		if $$$ISERR(tSC) {
			set pResponse.Status = 2
			set pResponse.Contents = $system.Status.GetErrorText(tSC)
		} else {
			set pResponse.Status = 0
			set pResponse.Contents = "Alteração realizada com sucesso."
		}
	}
	catch ex
	{
		set tSC = ex.AsStatus()
		set pResponse.Status = 2
		set pResponse.Contents = $system.Status.GetErrorText(tSC)
	}
	quit tSC
}

/// Excluir Cliente REST
Method Delete(pRequest As trans.BO.DetalhesPedido.Cliente.Rest.Delete.Request, Output pResponse As trans.BO.DetalhesPedido.Cliente.Rest.Delete.Response) As %Status
{
	set tSC = $system.Status.OK()
	set pResponse = ##class(trans.BO.DetalhesPedido.Cliente.Rest.Delete.Response).%New()

	try
	{
		if (pRequest.DATA '= "") && ##class(TRE.DATA.Cliente).%ExistsId(pRequest.DATA) {
			set tSC = ##class(TRE.DATA.Cliente).%DeleteId(pRequest.DATA)
			if $$$ISERR(tSC) {
				set tCodErro = ##class(%Exception.StatusException).CreateFromStatus(tSC).Code
				if tCodErro = 5823 {
					set tSC = $system.Status.OK()
					set pResponse.Status = 1
					set pResponse.Contents = "Não é possível excluir o registro, referenciado em outra tabela, verifique!"
				} else {
					set pResponse.Status = 2
					set pResponse.Contents = $system.Status.GetErrorText(tSC)
				}
			} else {
				set pResponse.Status = 0
				set pResponse.Contents = "Exclusão realizada com sucesso."
			}
		} else {
			set pResponse.Status = 1
			set pResponse.Contents = "ID não Cadastrado, Verifique!"
		}
	}
	catch ex
	{
		set tSC = ex.AsStatus()
		set pResponse.Status = 2
		set pResponse.Contents = $system.Status.GetErrorText(tSC)
	}
	quit tSC
}

}
