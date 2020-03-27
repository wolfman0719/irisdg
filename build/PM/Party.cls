Class PM.Party Extends (%Persistent, %Populate, %JSON.Adaptor) [ Abstract ]
{

/******************************************************************************
Id:  PM.Party.cls#1
説明：人、組織を表す抽象クラス
オブジェクト指向開発の定石パターンの１つであるコンポジットパターンを利用
******************************************************************************/
/// 名前
Property Name As %String(MAXLEN = 100, POPSPEC = "##class(PM.PopulateUtils).Name()");

/// 名前用インデックス
Index NameIndex On Name;

Storage Default
{
<Data name="PartyDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
</Data>
<DataLocation>^PM.PartyD</DataLocation>
<DefaultData>PartyDefaultData</DefaultData>
<IdLocation>^PM.PartyD</IdLocation>
<IndexLocation>^PM.PartyI</IndexLocation>
<StreamLocation>^PM.PartyS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
