Class Prova.VO.AvaliacaoVO Extends (%RegisteredObject, %XML.Adaptor)
{

Property CodigoCandidato As %Integer;

Property NomeCandidato As %String(MAXLEN = 100);

Property NomeDisciplina As %String(MAXLEN = 100);

Property Tipo As %String(MAXLEN = 20);

Property Nota As %Integer;

Property Resultado As %String(MAXLEN = 20);

}
