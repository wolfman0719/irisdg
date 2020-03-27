Class PM.Customer Extends (%Persistent, %Populate, %JSON.Adaptor)
{

/******************************************************************************
Id:  PM.Customer.cls#1
説明： 顧客情報
******************************************************************************/
/// 名前
Property Name As %String(POPSPEC = "##class(PM.PopulateUtils).Company()");

/// 住所
Property Address As Address;

/// 関係しているプロジェクト
Relationship Projects As PM.Project [ Cardinality = many, Inverse = Customer ];

/// テストデータ生成用メソッド
ClassMethod Init(pNum As %Integer)
{
	//Do ..%KillExtent()
	Do ..Populate(pNum)
}

Storage Default
{
<Data name="CustomerDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
<Value name="3">
<Value>Address</Value>
</Value>
</Data>
<DataLocation>^PM.CustomerD</DataLocation>
<DefaultData>CustomerDefaultData</DefaultData>
<ExtentSize>10</ExtentSize>
<IdLocation>^PM.CustomerD</IdLocation>
<IndexLocation>^PM.CustomerI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>1</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>1.1</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="Address">
<AverageFieldSize>37.6,City:3.6,Prefecture:3.2,Street:4.5,Zipcode:7</AverageFieldSize>
<Selectivity>10.0000%,City:10.0000%,Prefecture:11.1111%,Street:10.0000%,Zipcode:10.0000%</Selectivity>
</Property>
<Property name="Name">
<AverageFieldSize>9.9</AverageFieldSize>
<Selectivity>10.0000%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^PM.CustomerS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
