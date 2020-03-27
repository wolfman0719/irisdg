Include PM

Class PM.Project Extends (%Persistent, %Populate, %JSON.Adaptor)
{

/******************************************************************************
Id:  PM.Project.cls#1
説明：プロジェクト
******************************************************************************/
/// 名前
Property Name As %String;

/// 完了フラグ
Property Completed As %Boolean;

/// 開始日
Property StartDate As %Date;

/// 完了予定日
Property DueDate As %Date;

/// 受注金額
Property OrderAmount As %Integer;

/// 予想工数（人時間）
Property AnticipatedManHours As %Integer;

/// 実工数
Property ActualManHours As %Integer [ Calculated, SqlComputeCode = { Set {ActualManHours}=##class(PM.Project).ActualManHours({ID})
}, SqlComputed ];

/// 実費用
Property ActualAmount As %Integer [ Calculated, SqlComputeCode = { Set {ActualAmount}=##class(PM.Project).ActualAmount({ID})
}, SqlComputed ];

/// 顧客
Relationship Customer As PM.Customer [ Cardinality = one, Inverse = Projects ];

/// 顧客リレーションシップ用インデックス
Index CustomerIndex On Customer;

/// アクティビティ
Relationship Activities As PM.Activity [ Cardinality = many, Inverse = Project ];

/// プロジェクトマネージャー
Relationship ProjectManager As PM.Person [ Cardinality = one, Inverse = Projects ];

/// プロジェクトマネージャー用インデックス
Index ProjectManagerIndex On ProjectManager;

/// データ自動生成処理
ClassMethod Init(pNP As %Integer) As %Status
{
	Try {
	  //Do ..%KillExtent()
	  For i = 1:1:pNP {
		  Set Project = ..%New()
		  Set Project.Completed = 0
		  Set Project.StartDate = +$Horolog - $R(1000)
		  Set Project.DueDate = Project.StartDate + $Random(1000)
		  Set Project.Name = ##class(PM.PopulateUtils).Project()
		  Set Project.OrderAmount = 100000 * $Random(1000)
		  Set Project.AnticipatedManHours = Project.OrderAmount / 3000
		  Set tSC = Project.%Save()
		  If $$$ISERR(tSC) $$$ThrowStatus(tSC)
	}
	}
	Catch tE {
		Set tSC2 = ##class(PM.Error).StoreErrorInformation(tE)
	}
	Quit tSC
}

/// 実工数計算
ClassMethod ActualManHours(pId As %Integer) As %Integer
{
	Set Project = ..%OpenId(pId)
	Set ActualManHours = 0
	For i = 1:1:Project.Activities.Count() {
		Set Activity = Project.Activities.GetAt(i)
		Set ActualManHours = ActualManHours + Activity.Hours
	}
	Quit ActualManHours
}

/// 実費用計算
ClassMethod ActualAmount(pId As %Integer) As %Integer
{
	Set Project = ..%OpenId(pId)
	Set ActualAmount = 0
	For i = 1:1:Project.Activities.Count() {
		Set Activity = Project.Activities.GetAt(i)
		Set Member = Activity.Member
		Set ClassName = Member.%ClassName()
		If (ClassName = "Member") {
		    Set ActualAmount = ActualAmount + (Activity.Hours * Member.HourlyWages)
		}
		ElseIf (ClassName = "Manager") {
			Set tHours = Activity.Hours 
			If ( tHours > ($$$MonthlyHours \ $$$ManagedProjectNo)) {
				Set tHours = $$$MonthlyHours \ $$$ManagedProjectNo
			}
		    Set ActualAmount = ActualAmount + ($Normalize((tHours / $$$MonthlyHours) * Member.MonthlyManagementFee,0))
		}
	}
	Quit ActualAmount
}

Storage Default
{
<Data name="ProjectDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
<Value name="3">
<Value>OrderAmount</Value>
</Value>
<Value name="4">
<Value>AnticipatedManHours</Value>
</Value>
<Value name="5">
<Value>ActualManHours</Value>
</Value>
<Value name="6">
<Value>ActualAmount</Value>
</Value>
<Value name="7">
<Value>Customer</Value>
</Value>
<Value name="8">
<Value>ProjectManager</Value>
</Value>
<Value name="9">
<Value>Completed</Value>
</Value>
<Value name="10">
<Value>StartDate</Value>
</Value>
<Value name="11">
<Value>DueDate</Value>
</Value>
</Data>
<DataLocation>^PM.ProjectD</DataLocation>
<DefaultData>ProjectDefaultData</DefaultData>
<IdLocation>^PM.ProjectD</IdLocation>
<IndexLocation>^PM.ProjectI</IndexLocation>
<StreamLocation>^PM.ProjectS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
