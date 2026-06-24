Class Treinamento.Data.Curso Extends %Persistent
{

Property Nome As %String;

Property Preco As %Float;

Property Duracao As %Integer;

Storage Curso
{
<Data name="CursoDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Nome</Value>
</Value>
<Value name="3">
<Value>Preco</Value>
</Value>
<Value name="4">
<Value>Duracao</Value>
</Value>
</Data>
<DataLocation>^Treinamento.Data.CursoD</DataLocation>
<DefaultData>CursoDefaultData</DefaultData>
<IdLocation>^Treinamento.Data.CursoD</IdLocation>
<IndexLocation>^Treinamento.Data.CursoI</IndexLocation>
<StreamLocation>^Treinamento.Data.CursoS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

Storage Default
{
<Data name="CursoDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Nome</Value>
</Value>
<Value name="3">
<Value>Preco</Value>
</Value>
<Value name="4">
<Value>Duracao</Value>
</Value>
</Data>
<DataLocation>^Treinamento.Data.CursoD</DataLocation>
<DefaultData>CursoDefaultData</DefaultData>
<IdLocation>^Treinamento.Data.CursoD</IdLocation>
<IndexLocation>^Treinamento.Data.CursoI</IndexLocation>
<StreamLocation>^Treinamento.Data.CursoS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
