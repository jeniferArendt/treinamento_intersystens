Class Prova.Data.CandidatoCurso Extends %Persistent
{

Parameter SISTEMA = "Desafio InterSystems";

Parameter TABELA = "Inscrições de candidatos em cursos (many-to-many)";

Parameter TITULO = "Inscrição em Curso";

Parameter SITUACAO = 1;

Relationship Candidato As Prova.Data.Candidato [ Cardinality = one, Inverse = CandidatoCursos, Required ];

Relationship Curso As Prova.Data.Curso [ Cardinality = one, Inverse = Inscricoes, Required ];

Property DataInscricao As %Date(FORMAT = 4);

Property Situacao As %String(DISPLAYLIST = ",Ativa,Cancelada,Concluída", MAXLEN = 20, VALUELIST = ",Ativa,Cancelada,Concluida");

Index CandidatoIndex On Candidato;

Index CursoIndex On Curso;

Storage Default
{
<Data name="CandidatoCursoDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Candidato</Value>
</Value>
<Value name="3">
<Value>Curso</Value>
</Value>
<Value name="4">
<Value>DataInscricao</Value>
</Value>
<Value name="5">
<Value>Situacao</Value>
</Value>
</Data>
<DataLocation>^Prova.Data.CandidatoCursoD</DataLocation>
<DefaultData>CandidatoCursoDefaultData</DefaultData>
<IdLocation>^Prova.Data.CandidatoCursoD</IdLocation>
<IndexLocation>^Prova.Data.CandidatoCursoI</IndexLocation>
<StreamLocation>^Prova.Data.CandidatoCursoS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
