Class Treinamento.Data.Turma Extends %Persistent
{

Property Instrutor As Treinamento.Data.Instrutor;

Property DataInicio As %Date;

Property Status As %String;

Property Alunos As list Of Treinamento.Data.Aluno;

Property Curso As Treinamento.Data.Curso;

Storage Default
{
<Data name="TurmaDefaultData">
<Value name="1"/>
<Value name="2"/>
<Value name="3"/>
<Value name="4"/>
<Value name="5"/>
<Value name="6">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="7">
<Value>Instrutor</Value>
</Value>
<Value name="8">
<Value>DataInicio</Value>
</Value>
<Value name="9">
<Value>Status</Value>
</Value>
<Value name="10">
<Value>Alunos</Value>
</Value>
<Value name="11">
<Value>Curso</Value>
</Value>
</Data>
<DataLocation>^Treinamento.Data.TurmaD</DataLocation>
<DefaultData>TurmaDefaultData</DefaultData>
<IdLocation>^Treinamento.Data.TurmaD</IdLocation>
<IndexLocation>^Treinamento.Data.TurmaI</IndexLocation>
<StreamLocation>^Treinamento.Data.TurmaS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
