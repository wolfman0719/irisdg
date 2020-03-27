Class PM.Organization Extends PM.Party
{

/******************************************************************************
Id:  PM.Organization.cls#1
説明：組織
オブジェクト指向開発の定石パターンの１つであるコンポジットパターンを利用
******************************************************************************/
/// 構成するメンバー
Property Members As list Of PM.Party;

/// 管理者
Relationship Manager As PM.Manager [ Cardinality = one, Inverse = ManagedOrganizations ];

/// データの自動生成
ClassMethod Init()
{
	//Do ..%DeleteExtent()
	&sql(insert into PM.ORGANIZATION (NAME) VALUES ('インテグレーション事業部'))
	&sql(insert into PM.ORGANIZATION (NAME) VALUES ('医療システム部'))
	&sql(insert into PM.ORGANIZATION (NAME) VALUES ('医療システム１課'))
	&sql(insert into PM.ORGANIZATION (NAME) VALUES ('医療システム２課'))
	&sql(insert into PM.ORGANIZATION (NAME) VALUES ('社会システム部'))
	&sql(insert into PM.ORGANIZATION (NAME) VALUES ('社会システム１課'))
	&sql(insert into PM.ORGANIZATION (NAME) VALUES ('社会システム２課'))
	&sql(insert into PM.ORGANIZATION (NAME) VALUES ('社会システム３課'))
	&sql(insert into PM.ORGANIZATION (NAME) VALUES ('流通システム部'))
	&sql(insert into PM.ORGANIZATION (NAME) VALUES ('流通システム１課'))
	&sql(insert into PM.ORGANIZATION (NAME) VALUES ('金融システム部'))
	&sql(insert into PM.ORGANIZATION (NAME) VALUES ('金融システム１課'))
	&sql(insert into PM.ORGANIZATION (NAME) VALUES ('金融システム２課'))
	&sql(insert into PM.ORGANIZATION (NAME) VALUES ('金融システム３課'))
	&sql(insert into PM.ORGANIZATION (NAME) VALUES ('製造システム部'))
	&sql(insert into PM.ORGANIZATION (NAME) VALUES ('製造システム１課'))
	&sql(insert into PM.ORGANIZATION (NAME) VALUES ('製造システム２課'))
	&sql(insert into PM.ORGANIZATION (NAME) VALUES ('製造システム３課'))
	&sql(insert into PM.ORGANIZATION (NAME) VALUES ('製造システム４課'))
}

Storage Default
{
<Data name="OrganizationDefaultData">
<Subscript>"Organization"</Subscript>
<Value name="1">
<Value>Members</Value>
</Value>
<Value name="2">
<Value>Manager</Value>
</Value>
</Data>
<DefaultData>OrganizationDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
