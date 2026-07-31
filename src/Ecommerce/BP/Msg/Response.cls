Class Ecommerce.BP.Msg.Response Extends Ens.Response
{

Property Indicador As %String;

Property Resultado As %String;

Storage Default
{
<Data name="ResponseDefaultData">
<Subscript>"Response"</Subscript>
<Value name="1">
<Value>Indicador</Value>
</Value>
<Value name="2">
<Value>Resultado</Value>
</Value>
</Data>
<DefaultData>ResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
