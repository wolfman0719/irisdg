/// 
Class PM.ProjectCube Extends %DeepSee.CubeDefinition [ DependsOn = PM.Project, ProcedureBlock ]
{

Parameter DOMAIN;

/// Cube definition from Architect.
XData Cube [ XMLNamespace = "http://www.intersystems.com/deepsee" ]
{
<cube xmlns="http://www.intersystems.com/deepsee" name="ProjectCube" displayName="ProjectCube" disabled="false" abstract="false" sourceClass="PM.Project" countMeasureName="%COUNT" bucketSize="8" bitmapChunkInMemory="false" precompute="0">
  <dimension name="CustomerName" disabled="false" hasAll="false" allCaption="All Name" allDisplayName="Name" type="data" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false">
      <level sourceProperty="Customer.Name" name="CustomerName" disabled="false" list="false" useDisplayValue="true" useAsFilter="true">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="ProjectName" disabled="false" hasAll="false" allCaption="All Name1" allDisplayName="Name1" type="data" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false">
      <level sourceProperty="Name" name="ProjectName" disabled="false" list="false" useDisplayValue="true" useAsFilter="true">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="PMName" disabled="false" hasAll="false" allCaption="All Name" allDisplayName="Name" type="data" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false">
      <level sourceProperty="ProjectManager.Name" name="PMName" disabled="false" list="false" useDisplayValue="true" useAsFilter="true">
      </level>
    </hierarchy>
  </dimension>
  <measure sourceProperty="ActualAmount" name="ActualAmount" disabled="false" aggregate="SUM" type="number" scale="0" hidden="false" searchable="false"></measure>
  <measure sourceProperty="ActualManHours" name="ActualManHours" disabled="false" aggregate="SUM" type="number" scale="0" hidden="false" searchable="false"></measure>
  <measure sourceProperty="AnticipatedManHours" name="AnticipatedManHours" disabled="false" aggregate="SUM" type="number" scale="0" hidden="false" searchable="false"></measure>
  <measure sourceProperty="OrderAmount" name="OrderAmount" disabled="false" aggregate="SUM" type="number" scale="0" hidden="false" searchable="false"></measure>
  <measure sourceExpression="%source.OrderAmount-%source.ActualAmount" name="Profit" disabled="false" aggregate="SUM" type="number" scale="0" hidden="false" searchable="false"></measure>
  <listing name="New_listing1" disabled="false" listingType="table"></listing>
</cube>
}

}
