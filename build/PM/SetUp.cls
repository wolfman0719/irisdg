Include PM

Class PM.SetUp Extends %Base
{

/******************************************************************************
Id:  PM.SetUp.cls#1
説明：データ生成用メソッドクラス
******************************************************************************/
/// 基本的なデータを自動性する
ClassMethod PopulateBasics()
{
	do ##class(PM.Project).%KillExtent()
	do ##class(PM.Party).%KillExtent()
	do ##class(PM.Customer).%KillExtent()
	do ##class(PM.Phase).%KillExtent()
	Do ##class(PM.Customer).Init(10)
	DO ##class(PM.Phase).Init()
	Do ##class(PM.Organization).Init()
	&sql(select count(*) into :ON from PM.ORGANIZATION)
	Do ##class(PM.Manager).Init(ON)
	Do ##class(PM.Member).Init(ON * 5)
	Set tSC = ##class(PM.Project).Init(30)
}

/// リレーションシップを設定する
ClassMethod PopulateRelations() As %Status
{
	Try {
	
	  Set tSC = $$$OK
	  
	  &sql(select count(*) into :PN from PM.PROJECT)
	
	  For i = 1 : 1 : PN {
		  Set Project = ##class(PM.Project).%OpenId(i)
		  &sql(select count(*) into :CN from PM.CUSTOMER)
		  Set tCN = $Random(CN) + 1
		  Set Customer = ##class(PM.Customer).%OpenId(tCN)
		  Do Customer.Projects.Insert(Project)
		  Set tSC = Customer.%Save()
		  If $$$ISERR(tSC) $$$ThrowStatus(tSC)
	  }
	  
	  Set Division = ##class(PM.Organization).%OpenId(1)

	  Set Department1 = ##class(PM.Organization).%OpenId(2)
	  Set Department2 = ##class(PM.Organization).%OpenId(5)
	  Set Department3 = ##class(PM.Organization).%OpenId(9)
	  Set Department4 = ##class(PM.Organization).%OpenId(11)
	  Set Department5 = ##class(PM.Organization).%OpenId(15)

	  Do Division.Members.Insert(Department1)
	  Do Division.Members.Insert(Department2)
	  Do Division.Members.Insert(Department3)
	  Do Division.Members.Insert(Department4)
	  Do Division.Members.Insert(Department5)

	  Set Section1 = ##class(PM.Organization).%OpenId(3)
	  Set Section2 = ##class(PM.Organization).%OpenId(4)
	  
	  Do Department1.Members.Insert(Section1)
	  Do Department1.Members.Insert(Section2)

	  Set Section3 = ##class(PM.Organization).%OpenId(6)
	  Set Section4 = ##class(PM.Organization).%OpenId(7)
	  Set Section5 = ##class(PM.Organization).%OpenId(8)
	  
	  Do Department2.Members.Insert(Section3)
	  Do Department2.Members.Insert(Section4)
	  Do Department2.Members.Insert(Section5)

	  Set Section6 = ##class(PM.Organization).%OpenId(10)

	  Do Department3.Members.Insert(Section6)

	  Set Section7 = ##class(PM.Organization).%OpenId(12)
	  Set Section8 = ##class(PM.Organization).%OpenId(13)
	  Set Section9 = ##class(PM.Organization).%OpenId(14)

	  Do Department4.Members.Insert(Section7)
	  Do Department4.Members.Insert(Section8)
	  Do Department4.Members.Insert(Section9)

	  Set Section10 = ##class(PM.Organization).%OpenId(16)
	  Set Section11 = ##class(PM.Organization).%OpenId(17)
	  Set Section12 = ##class(PM.Organization).%OpenId(18)
	  Set Section13 = ##class(PM.Organization).%OpenId(19)

	  Do Department5.Members.Insert(Section10)
	  Do Department5.Members.Insert(Section11)
	  Do Department5.Members.Insert(Section12)
	  Do Department5.Members.Insert(Section13)
	  
	  Set tSC = Division.%Save()
	  
	  If $$$ISERR(tSC) $$$ThrowStatus(tSC)
	  	  
	  &sql(select count(*) into :MN from PM.Manager)
	  
	  For i = 1 : 1 : MN {
		  // Managerはid　20番から　データ生成数に依存しているのでデータ数を変更した際に動作しなくなる可能性
		  Set Manager = ##class(PM.Manager).%OpenId(i + 19)
		  Set Organization = ##class(PM.Organization).%OpenId(i)
		  Do Manager.ManagedOrganizations.Insert(Organization)
		  Set tSC = Manager.%Save()
	      If $$$ISERR(tSC) $$$ThrowStatus(tSC)
	  }
	  
	  &sql(select count(*) into :ON from PM.Organization)
	  &sql(select count(*) into :MN from PM.Member)
	  
	  For i = 1 : 1 : MN {
		  Set Organization = ##class(PM.Organization).%OpenId($Random(ON) + 1)
		  // memberは39番から データ生成数に依存しているのでデータ数を変更した際に動作しなくなる可能性
		  Set Member = ##class(PM.Member).%OpenId(i + 38)
		  Do Organization.Members.Insert(Member)
		  Set tSC = Organization.%Save()
	      If $$$ISERR(tSC) $$$ThrowStatus(tSC)
		  
	  }
	  
	  &sql(select count(*) into :PN from PM.PROJECT)
	  &sql(select count(*) into :PSN from PM.PARTY)
	  
	  For i = 1 : 1 : PN {
		  Set Project = ##class(PM.Project).%OpenId(i)
		  // Personは20番以降　データ生成数に依存しているのでデータ数を変更した際に動作しなくなる可能性
		  Set Person = ##class(PM.Person).%OpenId($Random(PSN - 19) + 20)
		  Set Project.ProjectManager = Person
		  Set tSC = Project.%Save()
	      If $$$ISERR(tSC) $$$ThrowStatus(tSC)
	  }

	}
	Catch tE {
		Set tSC2 = ##class(PM.Error).StoreErrorInformation(tE)
	}
	
	Quit tSC
}

/// アクティビティを自動生成する
ClassMethod PopulateTransactions(NA As %Integer) As %Status
{
	
	Try {
	   Set tSC = $$$OK
	   do ##class(PM.Activity).%KillExtent()

	   &sql(select count(*) into :PN from PM.PARTY)
	   &sql(select count(*) into :PJN from PM.PROJECT)
	   &sql(select count(*) into :PHN from PM.PHASE)
	
	   For i = 1 : 1 : NA {
		  Set Activity = ##class(PM.Activity).%New()
		  Set Activity.Week = $Random($$$NoOfWeeks) + 1
		  Set Project = ##class(PM.Project).%OpenId($Random(PJN) + 1,,.tSC)
	      If $$$ISERR(tSC) $$$ThrowStatus(tSC)
		  Set Activity.Project = Project
		  Set Activity.Year = 2010 + $Random(5) + 1
		  Set Phase = ##class(PM.Phase).%OpenId($Random(PHN) + 1,,.tSC)
	      If $$$ISERR(tSC) $$$ThrowStatus(tSC)
		  Set Activity.Phase = Phase
		  // Personは20番以降　データ生成数に依存しているのでデータ数を変更した際に動作しなくなる可能性
		  Set Person = ##class(PM.Person).%OpenId($Random(PN - 19) + 20,,.tSC)
	      If $$$ISERR(tSC) $$$ThrowStatus(tSC)
		  Set Activity.Member = Person
		  Set Activity.Hours = $Random($$$WeekHours + 30) + 1
		  Set tSC = Activity.%Save()
	      If $$$ISERR(tSC) $$$ThrowStatus(tSC)
	   }
	}
	Catch tE {
		Set tSC2 = ##class(PM.Error).StoreErrorInformation(tE)
	}

	Quit tSC
}

/// 郵便データをロードする
ClassMethod Import(pFileName As %String) As %Status [ SqlProc ]
{
  Set rowtype="DantaiCode VARCHAR(10),OldZipCode VARCHAR(5), ZipCode VARCHAR(7), KenYomi VARCHAR(100), ToshiYomi VARCHAR(100), CyouYomi VARCHAR(100), Ken VARCHAR(100), Toshi VARCHAR(100), Cyou VARCHAR(100)"
  Do ##class(%SQL.Util.Procedures).CSVTOCLASS(,rowtype,pFileName,,,,"PM.YubinData","UTF8")
  quit $$$OK
}

}
