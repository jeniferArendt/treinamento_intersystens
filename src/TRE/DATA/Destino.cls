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
<IdLocation>^TRE.DATA.DestinoD</IdLocation>
<IndexLocation>^TRE.DATA.DestinoI</IndexLocation>
<StreamLocation>^TRE.DATA.DestinoS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
