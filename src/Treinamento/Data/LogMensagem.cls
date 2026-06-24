Class Treinamento.Data.LogMensagem Extends %Persistent
{

Property Metodo As %String;

Property Classe As %String;

Property LogMensagem As %String;

Property Inicio As %TimeStamp;

Property Fim As %TimeStamp;

Property Status As %String;

Property StatusProcesso As %String;

Property ListaLog As list Of %String;

ClassMethod CriarEntrada(pMetodo As %String, pClasse As %String) As Treinamento.Data.LogMensagem
{
	Set tSC = $$$OK
	try
	{
		Set classe                  = ..%ClassName()
		Set name                    = $ZNAME
		#Dim exception              As %Exception.General   = ""
		#Dim statuCode              As %Status              = $SYSTEM.Status.OK()
		#Dim logMensagem            As Treinamento.Data.LogMensagem

		Set logMensagem             = ##class(Treinamento.Data.LogMensagem).%New()
		Set logMensagem.Metodo      = pMetodo
		Set logMensagem.Classe      = pClasse
		Set logMensagem.Inicio      = $zdatetime($horolog, 3)
		Set logMensagem.Status      = "Ativo"

		Set statuCode               = logMensagem.%Save()

		Quit logMensagem
	} catch ex {
		Set tSC = ex.AsStatus()
	}
}

Storage Default
{
<Data name="LogMensagemDefaultData">
<Value name="1"/>
<Value name="2"/>
<Value name="3"/>
<Value name="4">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="5">
<Value>Metodo</Value>
</Value>
<Value name="6">
<Value>Classe</Value>
</Value>
<Value name="7">
<Value>LogMensagem</Value>
</Value>
<Value name="8">
<Value>Inicio</Value>
</Value>
<Value name="9">
<Value>Fim</Value>
</Value>
<Value name="10">
<Value>Status</Value>
</Value>
<Value name="11">
<Value>StatusProcesso</Value>
</Value>
<Value name="12">
<Value>ListaLog</Value>
</Value>
</Data>
<DataLocation>^Treinamento.Data.LogMensagemD</DataLocation>
<DefaultData>LogMensagemDefaultData</DefaultData>
<IdLocation>^Treinamento.Data.LogMensagemD</IdLocation>
<IndexLocation>^Treinamento.Data.LogMensagemI</IndexLocation>
<StreamLocation>^Treinamento.Data.LogMensagemS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
