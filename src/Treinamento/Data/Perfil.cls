Class Treinamento.Data.Perfil Extends %Persistent
{

Property NomePerfil As %String;

Property Codigo As %String;

Property Nivel As Treinamento.Data.Nivel;

Property Usuarios As list Of Treinamento.Data.Usuario;

Storage Default
{
<Data name="PerfilDefaultData">
<Value name="1"/>
<Value name="2"/>
<Value name="3"/>
<Value name="4">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="5">
<Value>NomePerfil</Value>
</Value>
<Value name="6">
<Value>Codigo</Value>
</Value>
<Value name="7">
<Value>Nivel</Value>
</Value>
<Value name="8">
<Value>Usuarios</Value>
</Value>
</Data>
<DataLocation>^Treinamento.Data.PerfilD</DataLocation>
<DefaultData>PerfilDefaultData</DefaultData>
<IdLocation>^Treinamento.Data.PerfilD</IdLocation>
<IndexLocation>^Treinamento.Data.PerfilI</IndexLocation>
<StreamLocation>^Treinamento.Data.PerfilS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
