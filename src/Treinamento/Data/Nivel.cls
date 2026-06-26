Class Treinamento.Data.Nivel Extends %Persistent
{

Property NomeNivel As %String;

Property Codigo As %String;

Relationship Perfis As Treinamento.Data.Perfil [ Cardinality = many, Inverse = Nivel ];

Storage Default
{
<Data name="NivelDefaultData">
<Value name="1"/>
<Value name="2"/>
<Value name="3"/>
<Value name="4">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="5">
<Value>NomeNivel</Value>
</Value>
<Value name="6">
<Value>Codigo</Value>
</Value>
</Data>
<DataLocation>^Treinamento.Data.NivelD</DataLocation>
<DefaultData>NivelDefaultData</DefaultData>
<ExtentSize>3</ExtentSize>
<IdLocation>^Treinamento.Data.NivelD</IdLocation>
<IndexLocation>^Treinamento.Data.NivelI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="Codigo">
<AverageFieldSize>4</AverageFieldSize>
<Selectivity>33.3333%</Selectivity>
</Property>
<Property name="NomeNivel">
<AverageFieldSize>16.67</AverageFieldSize>
<Selectivity>33.3333%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^Treinamento.Data.NivelS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
