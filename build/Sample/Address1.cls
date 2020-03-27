/// This is a sample embeddable class representing an address.
Class Sample.Address1 Extends (%SerialObject, %Populate, %XML.Adaptor) [ ClassType = serial, Inheritance = right, LegacyInstanceContext, Not ProcedureBlock, SqlTableName = 住所, StorageStrategy = "" ]
{

/// The street address.
Property Street As %String(MAXLEN = 80, TRUNCATE = 1) [ SqlFieldName = 地名 ];

/// The city name.
Property City As %String(MAXLEN = 80, TRUNCATE = 1) [ SqlFieldName = 都市 ];

/// State(Province)
Property State As %String(MAXLEN = 10, TRUNCATE = 1) [ SqlFieldName = 都道府県 ];

/// The 5-digit U.S. Zone Improvement Plan (ZIP) code.
Property Zip As %String(MAXLEN = 7, TRUNCATE = 1) [ SqlFieldName = 郵便番号 ];

Method OnPopulate() As %Status
{
	Set id=$R($Get(^Yubin.ZenkokuD)+1)
	Set yubindata=^Yubin.ZenkokuD(id)
	Set ..Zip=$List(yubindata,4)
	Set ..State=$List(yubindata,8)
	Set ..City=$List(yubindata,9)
	Set ..Street=$List(yubindata,10)
	QUIT $$$OK
}

// directly specify the serialized state of this object

//Set %ShopList=$LB("メトロゴールド","モダンアミュズメント","モンスター","ラブラ","ラブラドル","ランドリー","ルショップシピー","レッドウッド","ロイヤルフラッシュ","６６６","フィラシューズ","フィールドライン","４５ｒｐｍ","フォワード","フラミンゴサルン","ブレイクビーツ","ボイコット","ボーダメイド","ポールスミス","ミリオンエア","メイドインワールド")

// [this is optional: if omitted, the compiler will assign a structure]

Storage Default
{
<Data name="Address1State">
<Subscript>"Sample.Address1"</Subscript>
<Value name="1">
<Value>City</Value>
</Value>
<Value name="2">
<Value>State</Value>
</Value>
<Value name="3">
<Value>Street</Value>
</Value>
<Value name="4">
<Value>Zip</Value>
</Value>
</Data>
<State>Address1State</State>
<StreamLocation>^Sample.Address1S</StreamLocation>
<Type>%Storage.Serial</Type>
}

}
