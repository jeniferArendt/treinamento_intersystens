Class Prova.Data.Curso Extends %Persistent
{

Parameter SISTEMA = "Desafio InterSystems";

Parameter TABELA = "Cursos disponíveis";

Parameter TITULO = "Curso";

Parameter SITUACAO = 1;

Property Nome As %String(MAXLEN = 100) [ Required ];

Property Descricao As %String(MAXLEN = 500);

Property CargaHoraria As %Integer(MINVAL = 0);

Relationship Inscricoes As Prova.Data.CandidatoCurso [ Cardinality = many, Inverse = Curso ];

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
<Value>Descricao</Value>
</Value>
<Value name="4">
<Value>CargaHoraria</Value>
</Value>
</Data>
<DataLocation>^Prova.Data.CursoD</DataLocation>
<DefaultData>CursoDefaultData</DefaultData>
<IdLocation>^Prova.Data.CursoD</IdLocation>
<IndexLocation>^Prova.Data.CursoI</IndexLocation>
<StreamLocation>^Prova.Data.CursoS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
