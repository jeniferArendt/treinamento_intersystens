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
