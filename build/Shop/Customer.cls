Class Shop.Customer Extends %Persistent [ ClassType = persistent, ProcedureBlock ]
{

Parameter EXTENTSIZE = 3;

Projection Java As %Projection.Java;

Property Name As %String(TRUNCATE = 1);

Property UserName As %String(TRUNCATE = 1);

Property Passwd As %String(TRUNCATE = 1);

Property Location As Shop.Address;

Relationship POrders As Shop.POrder [ Cardinality = many, Inverse = Customer ];

Property TotalOrderAmount As %Integer [ Calculated ];

Index CheckPwdIdx On (UserName As Exact, Passwd As Exact);

Index NameIdx On Name;

/// パスワードのチェック
ClassMethod CheckPasswd(user As %String, passwd As %String) As Shop.Customer
{
	quit:$get(user)="" ""

	set res=##class(%ResultSet).%New("%DynamicQuery:SQL")
	do res.Prepare("SELECT ID FROM Shop.Customer Where UserName = ? AND Passwd = ?")
	do res.Execute(user,passwd)
	
	quit:'res.Next() ""
	
	set cid=res.GetData(1)
	
	quit ..%OpenId(cid)
}

Method determinePrice(listprice As %Integer) As %Integer
{
	Quit 0
}

// これまでの購入金額を計算

Method TotalOrderAmountGet() As %Integer
{
	Set total = 0
	For i=1:1:..POrders.Count() {
		Set o = ..POrders.GetAt(i)
		
		// 処理中のオーダを除いて計算する
		If o.IsProcessing = 0 { Set total = total + o.TotalPrice }
	}
	Quit total
}

ClassMethod createTestData()
{
	d ##class(Shop.Customer).%KillExtent()

	// 個人顧客
	Set c=##class(Shop.IndvCustomer).%New()
	Set c.Name="日本 太郎"
	Set c.Location.Street="丸の内"
	Set c.Location.City="東京"
	Set c.Location.PostalCode="100-0001"
	Set c.DOB=$zdh("2/4/2003")
	Set c.UserName="taro"
	Set c.Passwd="taro"
	Do c.%Save()

	// 個人顧客
	Set c=##class(Shop.IndvCustomer).%New()
	Set c.Name="日本 花子"
	Set c.Location.Street="赤坂"
	Set c.Location.City="東京"
	Set c.Location.PostalCode="100-0001"
	Set c.DOB=$zdh("2/4/2001")
	Set c.UserName="hanako"
	Set c.Passwd="hanako"
	Do c.%Save()

	// 法人顧客
	Set c=##class(Shop.CorporateCustomer).%New()
	Set c.Name="インターシステムズジャパン"
	Set c.Location.Street="西新宿"
	Set c.Location.City="東京"
	Set c.Location.PostalCode="160-0023"
	Set c.RepName="速井 一郎"
	Set c.UserName="intersystems"
	Set c.Passwd="intersystems"
	Do c.%Save()
	
	d ##class(Shop.POrder).%KillExtent()
	d ##class(Shop.OrderItem).%KillExtent()
	k ^Shop.Order
}

Query ByName(Param1 As %String) As %SQLQuery(CONTAINID = 1)
{
SELECT %ID,Name,UserName FROM Customer
 WHERE (Name %STARTSWITH :Param1)
 ORDER BY %ID
}

Storage Default
{
<Data name="CustomerDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Location</Value>
</Value>
<Value name="3">
<Value>Name</Value>
</Value>
<Value name="4">
<Value>TotalOrderAmount</Value>
</Value>
<Value name="5">
<Value>Passwd</Value>
</Value>
<Value name="6">
<Value>UserName</Value>
</Value>
</Data>
<DataLocation>^Shop.CustomerD</DataLocation>
<DefaultData>CustomerDefaultData</DefaultData>
<ExtentSize>3</ExtentSize>
<IdLocation>^Shop.CustomerD</IdLocation>
<IndexLocation>^Shop.CustomerI</IndexLocation>
<Property name="Location"/>
<Property name="Name"/>
<Property name="Passwd"/>
<Property name="UserName"/>
<StreamLocation>^Shop.CustomerS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
