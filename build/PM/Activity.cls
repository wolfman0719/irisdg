Class PM.Activity Extends (%Persistent, %Populate, %JSON.Adaptor)
{

/******************************************************************************
Id:  PM.Activity.cls#1
説明： プロジェクトのアクティビティ
******************************************************************************/
/// 何週目の作業か　1-52
Property Week As %Integer;

/// 年
Property Year As %Integer;

/// 作業時間
Property Hours As %Integer;

/// プロジェクトのフェーズ
Property Phase As PM.Phase;

/// どのプロジェクトのアクティビティかを表す
Relationship Project As PM.Project [ Cardinality = one, Inverse = Activities ];

/// プロジェクト・リレーションシップ用インデックス
Index ProjectIndex On Project;

/// 誰の作業かを表す
Relationship Member As PM.Person [ Cardinality = one, Inverse = Activities ];

/// メンバー・リレーションシップ用インデックス
Index MemberIndex On Member;

Index WeekIndex On Week;

Index PhaseIndex On Phase;

Index YearIndex On Year;

Index UniqueKey On (Member, Phase, Project, Week, Year) [ Unique ];

Storage Default
{
<Data name="ActivityDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Week</Value>
</Value>
<Value name="3">
<Value>Year</Value>
</Value>
<Value name="4">
<Value>Hours</Value>
</Value>
<Value name="5">
<Value>Phase</Value>
</Value>
<Value name="6">
<Value>Project</Value>
</Value>
<Value name="7">
<Value>Member</Value>
</Value>
</Data>
<DataLocation>^PM.ActivityD</DataLocation>
<DefaultData>ActivityDefaultData</DefaultData>
<IdLocation>^PM.ActivityD</IdLocation>
<IndexLocation>^PM.ActivityI</IndexLocation>
<StreamLocation>^PM.ActivityS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
