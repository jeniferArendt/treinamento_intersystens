Class Prova.Data.Avaliacao Extends %Persistent
{

Parameter SISTEMA = "Desafio InterSystems";

Parameter TABELA = "Avaliações dos candidatos";

Parameter TITULO = "Avaliação";

Parameter SITUACAO = 1;

Relationship Candidato As Prova.Data.Candidato [ Cardinality = one, Inverse = Avaliacoes, Required ];

Property CodigoCandidato As %Integer;

Property NomeDisciplina As %String(MAXLEN = 100) [ Required ];

Property Tipo As %String(MAXLEN = 20) [ Required ];

Property Nota As %Integer(MAXVAL = 10, MINVAL = 0) [ Required ];

Index CandidatoIndex On Candidato;

Storage Default
{
<Data name="AvaliacaoDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Candidato</Value>
</Value>
<Value name="3">
<Value>CodigoCandidato</Value>
</Value>
<Value name="4">
<Value>NomeDisciplina</Value>
</Value>
<Value name="5">
<Value>Tipo</Value>
</Value>
<Value name="6">
<Value>Nota</Value>
</Value>
</Data>
<DataLocation>^Prova.Data.AvaliacaoD</DataLocation>
<DefaultData>AvaliacaoDefaultData</DefaultData>
<IdLocation>^Prova.Data.AvaliacaoD</IdLocation>
<IndexLocation>^Prova.Data.AvaliacaoI</IndexLocation>
<StreamLocation>^Prova.Data.AvaliacaoS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
