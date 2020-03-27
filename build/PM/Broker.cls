Class PM.Broker Extends %CSP.REST
{

Parameter CONVERTINPUTSTREAM = 1;

XData UrlMap
{
<Routes>
  <Route Url="/getactivities" Method="GET" Call="PM.REST:GetActivities"/>
  <Route Url="/getuserandtotal" Method="GET" Call="PM.REST:GetNameAndTotal"/>
  <Route Url="/member/:id" Method="GET" Call="PM.REST:GetMember"/>
  <Route Url="/getprojects" Method="GET" Call="PM.REST:GetProjects"/>
  <Route Url="/getphases" Method="GET" Call="PM.REST:GetPhases"/>
  <Route Url="/getyearweeks/:weeks" Method="GET" Call="PM.REST:GetYearWeeks"/>
  <Route Url="/createactivityrecord" Method="POST" Call="PM.REST:CreateActivityRecord"/>
</Routes>
}

}
