/// マネージャー
Class PM.Manager Extends PM.Person
{

/******************************************************************************
Id:  PM.Manager.cls#1
説明：組織の長
******************************************************************************/
/// 月額固定給
Property MonthlyManagementFee As %Integer;

/// 管理する組織
Relationship ManagedOrganizations As PM.Organization [ Cardinality = many, Inverse = Manager ];

/// データを自動生成
ClassMethod Init(pNM As %Integer) As %Status
{
	Set tSC = $$$OK
	Try {
	  //Do ..%DeleteExtent()
	  For i = 1:1:pNM {
		  Set Manager = ..%New()
		  Set Manager.Name = ##class(PM.PopulateUtils).Name()
		  Set Manager.MonthlyManagementFee = ($Random(100) * 10000) + 500000
		  set Manager.Username = ##class(%PopulateUtils).String(20)
		  Set tSC = Manager.%Save()
		  If $$$ISERR(tSC) $$$ThrowStatus(tSC)
	  }
	}
	Catch tE {
		Set tSC2 = ##class(PM.Error).StoreErrorInformation(tE)
	}
	Quit tSC
}

Storage Default
{
<Data name="ManagerDefaultData">
<Subscript>"Manager"</Subscript>
<Value name="1">
<Value>MonthlyManagementFee</Value>
</Value>
</Data>
<DefaultData>ManagerDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
