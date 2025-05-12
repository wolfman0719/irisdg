Class Sales.Product Extends (%Persistent, %Populate) [ Inheritance = right ]
{

/// 商品名
Property Name As %String(POPSPEC = "##class(Sales.Product).Name()");

/// 単価
Property UnitPrice As %Integer(FORMAT = ",", POPSPEC = "##class(Sales.Product).UnitPrice()");

ClassMethod Name() As %String
{
  set productlist = $listbuild("シャンプー","リンス","ボディーソープ","スクラブウォッシュ","ヘアジェル")
  quit $list(productlist,$random($listlength(productlist))+1)
}

ClassMethod UnitPrice() As %Integer
{
  quit ($random(100)+1)*100
}

Index NameIndex On Name;

Storage Default
{
<Data name="ProductDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
<Value name="3">
<Value>UnitPrice</Value>
</Value>
</Data>
<DataLocation>^Sales.ProductD</DataLocation>
<DefaultData>ProductDefaultData</DefaultData>
<ExtentSize>10</ExtentSize>
<IdLocation>^Sales.ProductD</IdLocation>
<IndexLocation>^Sales.ProductI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>1</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>1.1</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="Name">
<AverageFieldSize>5</AverageFieldSize>
<Selectivity>25.0000%</Selectivity>
</Property>
<Property name="UnitPrice">
<AverageFieldSize>3.8</AverageFieldSize>
<Selectivity>11.1111%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<SQLMap name="NameIndex">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^Sales.ProductS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
