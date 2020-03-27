Class PM.Phase Extends (%Persistent, %Populate, %JSON.Adaptor)
{

/******************************************************************************
Id:  PM.Phase.cls#1
説明：プロジェクトのフェーズ
******************************************************************************/
/// 名前
Property Name As %String;

/// 名前用インデックス
Index NameIndex On Name;

/// 　データ生成
ClassMethod Init()
{
	//Do ..%KillExtent()
	&sql(insert into PM.PHASE (NAME) VALUES ('要件定義'))
	&sql(insert into PM.PHASE (NAME) VALUES ('詳細設計'))
	&sql(insert into PM.PHASE (NAME) VALUES ('製造・単体テスト'))
	&sql(insert into PM.PHASE (NAME) VALUES ('結合テスト'))
	&sql(insert into PM.PHASE (NAME) VALUES ('検収'))
}

Storage Default
{
<Data name="PhaseDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
</Data>
<DataLocation>^PM.PhaseD</DataLocation>
<DefaultData>PhaseDefaultData</DefaultData>
<IdLocation>^PM.PhaseD</IdLocation>
<IndexLocation>^PM.PhaseI</IndexLocation>
<StreamLocation>^PM.PhaseS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
