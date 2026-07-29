Class TRE.DATA.Destino Extends %Persistent
{

/// <B>Código do Destino</B>
Property CodigoDestino As %String(MAXLEN = "");

Property CEPInicial As %Integer;

Property CEPFinal As %Integer;

Property PrazoEntregaDias As %String(MAXLEN = "");

Storage Default
{
<Data name="DestinoDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>CodigoDestino</Value>
</Value>
<Value name="3">
<Value>CEPInicial</Value>
</Value>
<Value name="4">
<Value>CEPFinal</Value>
</Value>
<Value name="5">
<Value>PrazoEntregaDias</Value>
</Value>
</Data>
<DataLocation>^TRE.DATA.DestinoD</DataLocation>
<DefaultData>DestinoDefaultData</DefaultData>
<ExtentSize>5</ExtentSize>
<IdLocation>^TRE.DATA.DestinoD</IdLocation>
<IndexLocation>^TRE.DATA.DestinoI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="CEPFinal">
<AverageFieldSize>6.6</AverageFieldSize>
<Selectivity>20.0000%</Selectivity>
</Property>
<Property name="CEPInicial">
<AverageFieldSize>6.6</AverageFieldSize>
<Selectivity>20.0000%</Selectivity>
</Property>
<Property name="CodigoDestino">
<AverageFieldSize>4</AverageFieldSize>
<Selectivity>20.0000%</Selectivity>
</Property>
<Property name="PrazoEntregaDias">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>25.0000%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^TRE.DATA.DestinoS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
