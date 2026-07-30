Class TRE.DATA.Pedido Extends %Persistent
{

Property CodigoPedido As %String(MAXLEN = "");

Property DataPedido As %String(MAXLEN = "");

Property CodigoCliente As %String(MAXLEN = "");

Property ValorPedido As %String(MAXLEN = "");

Property PesoKg As %Double;

Property Volumes As %Integer;

Property CodigoTransportadora As %String(MAXLEN = "");

Property DataPrevisaoEntrega As %String(MAXLEN = "");

Storage Default
{
<Data name="PedidoDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>CodigoPedido</Value>
</Value>
<Value name="3">
<Value>DataPedido</Value>
</Value>
<Value name="4">
<Value>CodigoCliente</Value>
</Value>
<Value name="5">
<Value>ValorPedido</Value>
</Value>
<Value name="6">
<Value>PesoKg</Value>
</Value>
<Value name="7">
<Value>Volumes</Value>
</Value>
<Value name="8">
<Value>CodigoTransportadora</Value>
</Value>
<Value name="9">
<Value>DataPrevisaoEntrega</Value>
</Value>
</Data>
<DataLocation>^TRE.DATA.PedidoD</DataLocation>
<DefaultData>PedidoDefaultData</DefaultData>
<ExtentSize>4</ExtentSize>
<IdLocation>^TRE.DATA.PedidoD</IdLocation>
<IndexLocation>^TRE.DATA.PedidoI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="CodigoCliente">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>33.3333%</Selectivity>
</Property>
<Property name="CodigoPedido">
<AverageFieldSize>3.25</AverageFieldSize>
<Selectivity>25.0000%</Selectivity>
</Property>
<Property name="CodigoTransportadora">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>50.0000%</Selectivity>
</Property>
<Property name="DataPedido">
<AverageFieldSize>12</AverageFieldSize>
<Selectivity>25.0000%</Selectivity>
</Property>
<Property name="DataPrevisaoEntrega">
<AverageFieldSize>12.25</AverageFieldSize>
<Selectivity>25.0000%</Selectivity>
</Property>
<Property name="PesoKg">
<AverageFieldSize>6</AverageFieldSize>
<Selectivity>25.0000%</Selectivity>
</Property>
<Property name="ValorPedido">
<AverageFieldSize>10.75</AverageFieldSize>
<Selectivity>25.0000%</Selectivity>
</Property>
<Property name="Volumes">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>33.3333%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^TRE.DATA.PedidoS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
