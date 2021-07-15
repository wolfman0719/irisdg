Class Sales.Customer Extends (%Persistent, %Populate) [ Inheritance = right ]
{

/// 顧客名
Property Name As %String(POPSPEC = "##class(Sales.Customer).Name()");

/// 住所
Property Address As %String(POPSPEC = "##class(Sales.Customer).Address()");

/// 電話番号
Property Telno As %String(POPSPEC = "##class(Sales.Customer).Telno()");

/// 割引率
Property Discount As %Integer(POPSPEC = "##class(Sales.Customer).Discount()");

ClassMethod Name() As %String
{
	set customerlist = $listbuild("太田　明","前島　健作","後藤　雅美","寺島　幸治","北村　ゆきえ")
	quit $list(customerlist,$random($listlength(customerlist))+1)
}

ClassMethod Address() As %String
{
	set address = "東京都新宿区西新宿"
	set b1 = $random(10)+1
	set b2 = $random(10)+1
	set b3 = $random(10)+1
	set address = address_b1_"-"_b2_"-"_b3
	
	quit address
}

ClassMethod Telno() As %String
{
	set telno = "03-5321"
	
	set tlist = $listbuild(6430,6431,6432,6433,6434,6435)
	quit telno_"-"_$list(tlist,$random($listlength(tlist))+1)
}

ClassMethod Discount() As %Integer
{
	
	quit (5+$random(5)+1)*10
}

Index NameIndex On Name;

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
<Value name="4">
<Value>Telno</Value>
</Value>
<Value name="5">
<Value>Discount</Value>
</Value>
</Data>
<DataLocation>^Sales.CustomerD</DataLocation>
<DefaultData>CustomerDefaultData</DefaultData>
<ExtentSize>10</ExtentSize>
<IdLocation>^Sales.CustomerD</IdLocation>
<IndexLocation>^Sales.CustomerI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>1</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>1.1</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="Address">
<AverageFieldSize>14.1</AverageFieldSize>
<Selectivity>10.0000%</Selectivity>
</Property>
<Property name="Discount">
<AverageFieldSize>2.2</AverageFieldSize>
<Selectivity>25.0000%</Selectivity>
</Property>
<Property name="Name">
<AverageFieldSize>5</AverageFieldSize>
<Selectivity>20.0000%</Selectivity>
</Property>
<Property name="Telno">
<AverageFieldSize>12</AverageFieldSize>
<Selectivity>25.0000%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<SQLMap name="NameIndex">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^Sales.CustomerS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
