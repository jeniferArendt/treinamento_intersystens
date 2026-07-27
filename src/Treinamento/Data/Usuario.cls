Class Treinamento.Data.Usuario Extends %Persistent
{

Property Nome As %String;

Property SobreNome As %String;

Property Usuario As %String;

Property Sexo As %String;

Property Email As %String;

Relationship Perfil As Treinamento.Data.Perfil [ Cardinality = one, Inverse = Usuarios ];

Index NomeIndex On Nome [ Unique ];

Storage Default
{
<Data name="UsuarioDefaultData">
<Value name="1"/>
<Value name="2"/>
<Value name="3"/>
<Value name="4">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="5">
<Value>Nome</Value>
</Value>
<Value name="6">
<Value>SobreNome</Value>
</Value>
<Value name="7">
<Value>Usuario</Value>
</Value>
<Value name="8">
<Value>Sexo</Value>
</Value>
<Value name="9">
<Value>Email</Value>
</Value>
<Value name="10">
<Value>Perfil</Value>
</Value>
</Data>
<DataLocation>^Treinamento.Data.UsuarioD</DataLocation>
<DefaultData>UsuarioDefaultData</DefaultData>
<IdLocation>^Treinamento.Data.UsuarioD</IdLocation>
<IndexLocation>^Treinamento.Data.UsuarioI</IndexLocation>
<StreamLocation>^Treinamento.Data.UsuarioS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
