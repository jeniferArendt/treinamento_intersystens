Class trans.BO.RecupDetalhesPedidos.Response Extends Ens.Response
{

Property Endereco As %String;

Property CEP As %String;

Property Cidade As %String;

Property Estado As %String;

Property Email As %String;

Property NomeEmpresa As %String;

Property NomeContato As %String;

Property PesoKg As %String;

Property Volumes As %String;

Storage Default
{
<Data name="ResponseDefaultData">
<Subscript>"Response"</Subscript>
<Value name="1">
<Value>Endereco</Value>
</Value>
<Value name="2">
<Value>CEP</Value>
</Value>
<Value name="3">
<Value>Cidade</Value>
</Value>
<Value name="4">
<Value>Estado</Value>
</Value>
<Value name="5">
<Value>Email</Value>
</Value>
<Value name="6">
<Value>NomeEmpresa</Value>
</Value>
<Value name="7">
<Value>NomeContato</Value>
</Value>
<Value name="8">
<Value>PesoKg</Value>
</Value>
<Value name="9">
<Value>Volumes</Value>
</Value>
</Data>
<DefaultData>ResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
