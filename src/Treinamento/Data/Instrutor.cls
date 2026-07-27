Class Treinamento.Data.Instrutor Extends %Persistent
{

Property Nome As %String;

Property Matricula As %Integer;

Storage Default
{
<Data name="InstrutorDefaultData">
<Value name="1"/>
<Value name="2"/>
<Value name="3">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="4">
<Value>Nome</Value>
</Value>
<Value name="5">
<Value>Matricula</Value>
</Value>
</Data>
<DataLocation>^Treinamento.Data.InstrutorD</DataLocation>
<DefaultData>InstrutorDefaultData</DefaultData>
<IdLocation>^Treinamento.Data.InstrutorD</IdLocation>
<IndexLocation>^Treinamento.Data.InstrutorI</IndexLocation>
<StreamLocation>^Treinamento.Data.InstrutorS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
