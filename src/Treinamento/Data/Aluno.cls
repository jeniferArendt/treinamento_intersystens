Class Treinamento.Data.Aluno Extends %Persistent
{

Property Nome As %String;

Property Matricula As %Integer;

Property Idade As %Integer;

Storage Default
{
<Data name="AlunoDefaultData">
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
<Value>Matricula</Value>
</Value>
<Value name="7">
<Value>Idade</Value>
</Value>
</Data>
<DataLocation>^Treinamento.Data.AlunoD</DataLocation>
<DefaultData>AlunoDefaultData</DefaultData>
<IdLocation>^Treinamento.Data.AlunoD</IdLocation>
<IndexLocation>^Treinamento.Data.AlunoI</IndexLocation>
<StreamLocation>^Treinamento.Data.AlunoS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
