Class Treinamento.Data.Perfil Extends %Persistent
{

Property NomePerfil As %String;

Property Codigo As %String;

Relationship Nivel As Treinamento.Data.Nivel [ Cardinality = one, Inverse = Perfis ];

Relationship Usuarios As Treinamento.Data.Usuario [ Cardinality = many, Inverse = Perfil ];

Storage Default
{
<Data name="PerfilDefaultData">
<Value name="1"/>
<Value name="2"/>
<Value name="3"/>
<Value name="4">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="5">
<Value>NomePerfil</Value>
</Value>
<Value name="6">
<Value>Codigo</Value>
</Value>
<Value name="7">
<Value>Usuarios</Value>
</Value>
<Value name="8">
<Value>Nivel</Value>
</Value>
</Data>
<DataLocation>^Treinamento.Data.PerfilD</DataLocation>
<DefaultData>PerfilDefaultData</DefaultData>
<ExtentSize>3</ExtentSize>
<IdLocation>^Treinamento.Data.PerfilD</IdLocation>
<IndexLocation>^Treinamento.Data.PerfilI</IndexLocation>
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
<AverageFieldSize>5</AverageFieldSize>
<Selectivity>33.3333%</Selectivity>
</Property>
<Property name="Nivel">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>33.3333%</Selectivity>
</Property>
<Property name="NomePerfil">
<AverageFieldSize>10.33</AverageFieldSize>
<Selectivity>33.3333%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^Treinamento.Data.PerfilS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
