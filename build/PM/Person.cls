Class PM.Person Extends PM.Party
{

/******************************************************************************
Id:  PM.Person.cls#1
説明：プロジェクトに関わる人を表現
******************************************************************************/
/// 関係しているプロジェクト（複数可）
Relationship Projects As PM.Project [ Cardinality = many, Inverse = ProjectManager ];

/// アクティビティ
Relationship Activities As PM.Activity [ Cardinality = many, Inverse = Member ];

/// 顔写真用データ
Property Picture As %Stream.GlobalBinary;

/// ログインユーザー名
Property Username As %String(MAXLEN = 20);

/// ユーザー名用インデックス
Index UsernameIndex On Username [ Unique ];

Storage Default
{
<Data name="PersonDefaultData">
<Subscript>"Person"</Subscript>
<Value name="1">
<Value>Picture</Value>
</Value>
<Value name="2">
<Value>Username</Value>
</Value>
</Data>
<DefaultData>PersonDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
