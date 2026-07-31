Class trans.VO.ConfirmaPedido Extends (%SerialObject, %XML.Adaptor)
{

Property Status As %String;

Property CodigoTransp As %String;

Property DataPrevisaoEntrega As %Date;

Storage Default
{
<Data name="ConfirmaPedidoState">
<Value name="1">
<Value>Status</Value>
</Value>
<Value name="2">
<Value>CodigoTransp</Value>
</Value>
<Value name="3">
<Value>DataPrevisaoEntrega</Value>
</Value>
</Data>
<State>ConfirmaPedidoState</State>
<StreamLocation>^trans.VO.ConfirmaPedidoS</StreamLocation>
<Type>%Storage.Serial</Type>
}

}
