Class Shop.Product Extends %Persistent [ ClassType = persistent, ProcedureBlock ]
{

Parameter EXTENTSIZE = 4;

Projection NewProjection1 As %Projection.Java;

// 商品コード

Property Code As %String(TRUNCATE = 1);

Index CodeIdx On Code [ IdKey, PrimaryKey, Unique ];

// 商品名

Property Name As %String(TRUNCATE = 1);

// コメント

Property Description As %String(TRUNCATE = 1);

// 定価

Property ListPrice As %Integer;

Property Picture As %GlobalBinaryStream;

// 画像

Index NameIdx On Name;

// For testing

ClassMethod createTestData(dir As %String)
{
  Set s=##class(%FileBinaryStream).%New()
  Do s.LinkToFile(dir_"Image1.gif")
	
  Set p=##class(Shop.Product).%New()
  Set p.Code="PC001"
  Set p.Name="ThinkPad"
  Set p.Description="Intelテクノロジを採用。1.2kgのボディにDVDドライブを搭載"
  Set p.ListPrice=199800
  Do p.Picture.CopyFrom(s)
  do p.Picture.SetAttribute("ContentType","image/gif")
  Do p.%Save()
	
  Set s=##class(%FileBinaryStream).%New()
  Do s.LinkToFile(dir_"Image2.gif")

  Set p=##class(Shop.Product).%New()
  Set p.Code="MNT001"
  Set p.Name="17インチ液晶モニタ"
  Set p.Description="厚さ1.5cmの超薄型液晶モニタ"
  Set p.ListPrice=89800
  Do p.Picture.CopyFrom(s)
  do p.Picture.SetAttribute("ContentType","image/gif")
  Do p.%Save()
	
  Quit
}

Storage Default
{
<Data name="ProductDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Code</Value>
</Value>
<Value name="3">
<Value>Name</Value>
</Value>
<Value name="4">
<Value>Picture</Value>
</Value>
<Value name="5">
<Value>Price</Value>
</Value>
<Value name="6">
<Value>ListPrice</Value>
</Value>
<Value name="7">
<Value>Description</Value>
</Value>
</Data>
<DataLocation>^Shop.ProductD</DataLocation>
<DefaultData>ProductDefaultData</DefaultData>
<ExtentSize>4</ExtentSize>
<IdLocation>^Shop.ProductD</IdLocation>
<IndexLocation>^Shop.ProductI</IndexLocation>
<Property name="Code"/>
<Property name="Description"/>
<Property name="ListPrice"/>
<Property name="Name"/>
<Property name="Picture"/>
<StreamLocation>^Shop.ProductS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
