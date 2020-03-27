Class PM.REST Extends %Base
{

ClassMethod GetActivities() As %Status
{
	set sts=$$$OK

    try {
	    set statement1 = ##class(%SQL.Statement).%New()
	    set sql1 = "SELECT MEMBER->NAME AS NAME,SUM(HOURS) AS TOTALHOURS FROM PM.ACTIVITY WHERE MEMBER->USERNAME = '_system' GROUP BY MEMBER->NAME"
        set qstatus = statement1.%Prepare(sql1)
        if qstatus'=$$$OK {
	      $$$ThrowStatus(qstatus)
	    }
        set rset1 = statement1.%Execute()
        set header = {}

        while rset1.%Next() {
	      set child = []
	      set dobj1 = {}
          set dobj1.NAME = rset1.NAME
          set dobj1.TOTALHOURS = rset1.TOTALHOURS
          do child.%Push(dobj1)
          set header.children = child
          set sql2 = "SELECT YEAR,WEEK,MEMBER->NAME AS NAME,PROJECT->NAME AS PROJECTNAME, PHASE->NAME AS PHASENAME,HOURS FROM PM.ACTIVITY WHERE MEMBER->USERNAME = '_system' order by year,week"
          set rset2 = ##class(%SQL.Statement).%ExecDirect(,sql2)
          set items = {}
          set children = []
          
          while rset2.%Next() {
	        set array = []
	        do array.%Push(rset2.YEAR)
	        do array.%Push(rset2.WEEK)
	        do array.%Push(rset2.PROJECTNAME)
	        do array.%Push(rset2.PHASENAME)
	        //何故かダブルクオートが付かないので強制的に文字列として出力
	        do array.%Push(rset2.HOURS,"string")
           do children.%Push(array)
	        
          }
          set items.children = children
	    
        } 
        
        set bandle = []
        do bandle.%Push(header)
        do bandle.%Push(items)
        do bandle.%ToJSON()
        

    } catch ex {
        set sts=ex.AsStatus()
    }
 
    quit sts
}

ClassMethod GetActivities2() As %Status
{
	set sts=$$$OK
	Write:$get(%request) %request.Data("callback",1)
  	write "("
    try {
	    write "["
      do ##class(%ZEN.Auxiliary.jsonSQLProvider).%WriteJSONFromSQL(,"SELECT MEMBER->NAME AS NAME,SUM(HOURS) AS TOTALHOURS FROM PM.ACTIVITY WHERE MEMBER->USERNAME = '_system' GROUP BY MEMBER->NAME","")	    	
      write ","
      //do ##class(%ZEN.Auxiliary.jsonSQLProvider).%WriteJSONFromSQL(,"SELECT YEAR,WEEK,MEMBER->NAME AS NAME,PROJECT->NAME AS PROJECTNAME, PHASE->NAME AS PHASENAME,HOURS FROM PM.ACTIVITY WHERE MEMBER->USERNAME = 'UnknownUser' order by year,week","")	    	
      do ..BuildActivityMatrix()
    }catch ex {
        set sts=ex.AsStatus()
    }
    write "]"
  	write ")"
    quit sts
}

ClassMethod GetMember(pId As %Integer) As %Status
{
	set sts=$$$OK
	set ^pid = $get(pId)
    try {
	  set member = ##class(PM.Member).%OpenId(pId,,.status)
	  if '$isobject(member) {
	    $$$ThrowStatus(status)
	  }
	  
	  set dmember = {}
	  set dmember.Name = member.Name
	  set dmember.Username = member.Username
	  do dmember.%ToJSON()
	  
    } catch ex {
        set sts=ex.AsStatus()
    }
    quit sts
}

ClassMethod GetProjects() As %Status
{
	set sts=$$$OK
    try {
	    set statement = ##class(%SQL.Statement).%New()
	    set sql = "select name from pm.project"
        set qstatus = statement.%Prepare(sql)
        if qstatus'=$$$OK {
	      $$$ThrowStatus(qstatus)
	    }
        set rset = statement.%Execute()
        set projects = []

        while rset.%Next() {
	      set dobj = {}
          set dobj.Name = rset.NAME
          do projects.%Push(dobj)
	    
        } 
        do projects.%ToJSON()
	  
    } catch ex {
        set sts=ex.AsStatus()
    }
    quit sts
}

ClassMethod GetPhases() As %Status
{
	set sts=$$$OK
    try {
	    set statement = ##class(%SQL.Statement).%New()
	    set sql = "select name from pm.phase"
        set qstatus = statement.%Prepare(sql)
        if qstatus'=$$$OK {
	      $$$ThrowStatus(qstatus)
	    }
        set rset = statement.%Execute()
        set phases = []

        while rset.%Next() {
	      set dobj = {}
          set dobj.Name = rset.NAME
          do phases.%Push(dobj)
	    
        } 
        do phases.%ToJSON()
	  
    } catch ex {
        set sts=ex.AsStatus()
    }
    quit sts
}

ClassMethod GetYearWeeks(pWeeks As %Integer) As %Status
{
	set sts=$$$OK
    try {
	    set array =[]
	    set today =$piece($h,",",1)
	    set dobj = {}
	    set day = today
	    set dobj.week = $zdate(today,3)
	    do array.%Push(dobj)
	    for i = 1:1:pWeeks-1 {
		    set day = day - 7
		    set dobj = {}
	        set dobj.week = $zdate(day,3)
		    do array.%Push(dobj)
	    }
	  
    } catch ex {
        set sts=ex.AsStatus()
    }
    do array.%ToJSON()
    quit sts
}

ClassMethod CreateActivityRecord() As %Status
{

	Try {
		
	    if $data(%request) {
	      set len = 1000
		  set jsontext = %request.Content.Read(.len,.status)
		  set json = {}.%FromJSON(jsontext)
	      set activitydate = json.week
	      set activity = ##class(PM.Activity).%New()
	      set activity.Hours = json.workhours
	      set project = ##class(PM.Project).%OpenId(json.projectindex)
	      set phase = ##class(PM.Phase).%OpenId(json.phaseindex)
	      set activity.Project = project
	      set activity.Phase = phase
	      set year = $Extract(activitydate,1,4)
	      set month = $Extract(activitydate,6,7)
	      set week = $system.SQL.WEEK(activitydate)
	      set activity.Member = ##class(PM.Person).%OpenId(json.memberid)
	      set activity.Week = week
	      set activity.Year = year
	      set status = activity.%Save()
	      if $$$ISERR(status) $$$ThrowStatus(status)			
	  }

	}
	Catch(ex) {
		Set status2 = ##class(PM.Error).StoreErrorInformation(ex)
	}
	
	Quit status
}

ClassMethod GetNameAndTotal() As %Status
{
	set sts=$$$OK
	Write:$get(%request) %request.Data("callback",1)
  	write "("
    try {	do ##class(%ZEN.Auxiliary.jsonSQLProvider).%WriteJSONFromSQL(,"SELECT MEMBER->NAME AS NAME,SUM(HOURS) AS TOTALHOURS FROM PM.ACTIVITY WHERE MEMBER->USERNAME = 'UnknownUser' GROUP BY MEMBER->NAME","")
    }catch ex {
        set sts=ex.AsStatus()
    }
  	write ")"
    quit sts
}

ClassMethod BuildActivityMatrix() As %Status
{
	set sts=$$$OK
	write "{""children"":"
	write "["
	set sql = "SELECT YEAR,WEEK,MEMBER->NAME AS NAME,PROJECT->NAME AS PROJECTNAME, PHASE->NAME AS PHASENAME,HOURS FROM PM.ACTIVITY WHERE MEMBER->USERNAME = '_system' order by year,week"
    set rset = ##class(%SQL.Statement).%ExecDirect(,sql)
    set i = 0
    while rset.%Next() {
	    if (i > 0) {
		    write ","
	    }
	    set year = rset.%Get("YEAR")
	    set week = rset.%Get("WEEK")
	    set projectname = rset.%Get("PROJECTNAME")
	    set phasename = rset.%Get("PHASENAME")
	    set hours = rset.%Get("HOURS")
	    write "["
	    write """"_year_""","
	    write """"_week_""","
	    write """"_projectname_""","
	    write """"_phasename_""","
	    write """"_hours_""""
	    write "]"
	    set i = $increment(i)
	    
    } 
    write "]"
    write "}"
    quit sts
}

}
