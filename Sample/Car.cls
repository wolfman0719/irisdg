Class Sample.Car Extends (%Persistent, %Populate, %XML.Adaptor) [ ClassType = persistent, Inheritance = right, LegacyInstanceContext, ProcedureBlock ]
{

Property Maker As Supplier;

Property Name As %String(POPSPEC = "##Class(Sample.PopulateUtils).String()", TRUNCATE = 1);

Storage Default
{
<Data name="CarDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Maker</Value>
</Value>
<Value name="3">
<Value>Name</Value>
</Value>
</Data>
<DataLocation>^Sample.CarD</DataLocation>
<DefaultData>CarDefaultData</DefaultData>
<ExtentSize>10</ExtentSize>
<IdLocation>^Sample.CarD</IdLocation>
<IndexLocation>^Sample.CarI</IndexLocation>
<Property name="%%CLASSNAME">
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="Maker">
<Selectivity>20.0000%</Selectivity>
</Property>
<Property name="Name">
<Selectivity>12.5000%</Selectivity>
</Property>
<StreamLocation>^Sample.CarS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}