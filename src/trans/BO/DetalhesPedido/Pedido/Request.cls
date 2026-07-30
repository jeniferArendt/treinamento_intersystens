Class trans.BO.DetalhesPedido.Pedido.Request Extends Ens.Request
{

Property CodigoPedido As %String;

Property DataPedido As %String;

Property CodigoCliente As %String;

Property ValorPedido As %String;

Property PesoKg As %Double;

Property Volumes As %Integer;

Property CodigoTransportadora As %String;

Property DataPrevisaoEntrega As %Date;

Storage Default
{
<Data name="RequestDefaultData">
<Subscript>"Request"</Subscript>
<Value name="1">
<Value>CodigoPedido</Value>
</Value>
<Value name="2">
<Value>DataPedido</Value>
</Value>
<Value name="3">
<Value>CodigoCliente</Value>
</Value>
<Value name="4">
<Value>ValorPedido</Value>
</Value>
<Value name="5">
<Value>PesoKg</Value>
</Value>
<Value name="6">
<Value>Volumes</Value>
</Value>
<Value name="7">
<Value>CodigoTransportadora</Value>
</Value>
<Value name="8">
<Value>DataPrevisaoEntrega</Value>
</Value>
</Data>
<DefaultData>RequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
