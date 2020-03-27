/// プロジェクト構成員
Class PM.Member Extends PM.Person
{

/******************************************************************************
Id:  PM.Member.cls#1
説明：プロジェクト要員
******************************************************************************/
/// 時間給
Property HourlyWages As %Integer(POPSPEC = "##class(PM.PopulateUtils).Wage()");

/// データを自動生成
ClassMethod Init(pNum As %Integer)
{
	Set testmember = ..%New()
	Set testmember.Username = "_system"
	Set testmember.Name = "テストユーザー"
	Set testmember.HourlyWages = 20000
	Set tS = testmember.%Save()
	Do ..Populate(pNum)
}

Storage Default
{
<Data name="MemberDefaultData">
<Subscript>"Member"</Subscript>
<Value name="1">
<Value>HourlyWages</Value>
</Value>
</Data>
<DefaultData>MemberDefaultData</DefaultData>
<ExtentSize>96</ExtentSize>
<Property name="%%CLASSNAME">
<AverageFieldSize>21</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>2.36</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="HourlyWages">
<AverageFieldSize>5</AverageFieldSize>
<Selectivity>2.7027%</Selectivity>
</Property>
<Property name="Name">
<AverageFieldSize>5.02</AverageFieldSize>
<Selectivity>1.0526%</Selectivity>
</Property>
<Property name="Picture">
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="Username">
<AverageFieldSize>4.95</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Type>%Storage.Persistent</Type>
}

}
