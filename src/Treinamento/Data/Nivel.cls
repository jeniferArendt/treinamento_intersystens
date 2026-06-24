Class Treinamento.Data.Nivel Extends %Persistent
{

Property NomeNivel As %String;

Property Codigo As %String;

Storage Default
{
<Data name="NivelDefaultData">
<Value name="1"/>
<Value name="2"/>
<Value name="3"/>
<Value name="4">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="5">
<Value>NomeNivel</Value>
</Value>
<Value name="6">
<Value>Codigo</Value>
</Value>
</Data>
<DataLocation>^Treinamento.Data.NivelD</DataLocation>
<DefaultData>NivelDefaultData</DefaultData>
<IdLocation>^Treinamento.Data.NivelD</IdLocation>
<IndexLocation>^Treinamento.Data.NivelI</IndexLocation>
<StreamLocation>^Treinamento.Data.NivelS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
