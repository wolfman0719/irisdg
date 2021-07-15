/// This sample persistent class represents a person.<br>
Class Sample.Person Extends (%Persistent, %Populate, %XML.Adaptor) [ ClassType = persistent, Inheritance = right, LegacyInstanceContext, Not ProcedureBlock ]
{

Parameter EXTENTQUERYSPEC = "Name,Home.City,Home.State";

// define indices for this class

/// Define an index for <property>Name</property>.
Index NameIDX On Name [ Data = Name ];

/// Define an index for embedded object property <b>ZipCode</b>.
Index ZipCode On Home.Zip [ Type = bitmap ];

// define properties for this class

/// Person's name.
Property Name As JNAME(POPSPEC = "##Class(Sample.PopulateUtils).Name()") [ Required, SqlFieldName = 名前 ];

/// Person's Date of Birth.
Property DOB As %Date(POPSPEC = "Date()") [ SqlFieldName = 誕生日 ];

/// Person's home address. This uses an embedded object.
Property Home As Address1 [ SqlFieldName = 自宅 ];

/// Person's office address. This uses an embedded object.
Property Office As Address1 [ SqlFieldName = 勤務先 ];

/// Person's spouse. This is a reference to another persistent object.
Property Spouse As Person [ SqlFieldName = 配偶者 ];

/// Person's car. This is a reference to another persistent object.
Property Car As Car [ SqlFieldName = 車 ];

/// A collection of strings representing the person's favorite colors.
Property FavoriteColors As list Of %String(JAVATYPE = "java.util.List", POPSPEC = "ValueList("",赤,オレンジ,黄色,緑,青,紫,黒,白""):2", TRUNCATE = 1) [ SqlFieldName = 好きな色 ];

/// Person's age.<br>
/// This is a calculated field whose value is derived from <property>DOB</property>.
Property Age As %Integer [ Calculated, SqlComputeCode = { Set {年令}=##class(Sample.Person).CurrentAge({誕生日})
}, SqlComputed, SqlComputeOnChange = DOB, SqlFieldName = 年令 ];

/// This class method calculates a current age given a date of birth <var>date</var>.
ClassMethod CurrentAge(date As %Date = "") As %Integer [ CodeMode = expression ]
{
$Select(date="":"",1:(($H-date)\365))
}

/// Prints the property <property>Name</property> to the console.
Method PrintPerson()
{
 Write !, "名前: ", ..Name
 Quit
}

/// A simple, sample method: add two numbers (<var>x</var> and <var>y</var>) 
/// and return the result.
Method Addition(x As %Integer = 1, y As %Integer = 1) As %Integer
{
 Quit x + y // comment
}

/// A simple, sample expression method: returns the value 99.
Method NinetyNine() As %Integer [ CodeMode = expression ]
{
99
}

/// Invoke the <method>PrintPerson</method> on all <class>Person</class> objects 
/// within the database.
ClassMethod PrintPersons()
{
 New extent,person

 // use the extent result set to find all person
 Set extent = ##class(%ResultSet).%New("Sample.Person:Extent")
 Do extent.Execute()

 While (extent.Next()) {
 Set person = ..%OpenId(extent.GetData(1))
 Do person.PrintPerson()
 }

 Quit
}

/// Prints out data on all persons within the database using SQL to 
/// iterate over all the person data.
ClassMethod PrintPersonsSQL()
{
 New query,person

 // use dynamic SQL result set to find person data
 Set query = ##class(%ResultSet).%New("%DynamicQuery:SQL")
 Do query.Prepare("SELECT ID, 名前 FROM Sample.Person ORDER BY 名前")
 Do query.Execute()

 While (query.Next()) {
 Write !,"名前: ", query.Get("名前")
 }

 Quit
}

/// This is a sample of how to define an SQL stored procedure using a 
/// class method. This method can be called as a stored procedure via 
/// ODBC or JDBC.<br>
/// In this case this method returns the concatenation of a string value.
ClassMethod StoredProcTest(name As %String, ByRef response As %String) As %String [ SqlName = Stored_Procedure_Test, SqlProc ]
{
 // Set response to the concatenation of name.
 Set response = $Piece(name,",",1)_"  "_$Piece(name,",",2)
 QUIT response
}

/// This is a sample of how to define an SQL stored procedure using a 
/// class method. This method can be called as a stored procedure via 
/// ODBC or JDBC.<br>
/// This method performs an SQL update operation on the database 
/// using embedded SQL. The update modifies the embedded properties 
/// <var>Home.City</var> and <var>Home.State</var> for all rows whose 
/// <var>Home.Zip</var> is equal to <var>zip</zip>.
ClassMethod UpdateProcTest(zip As %String, city As %String, state As %String) As %Integer [ SqlProc ]
{
 New SQLCODE,%ROWCOUNT,%ROWID,rowcount

 &sql(UPDATE Sample.Person 
 SET 自宅_都市 = :city, 自宅_都道府県 = :state 
 WHERE 自宅_郵便番号 = :zip)

 // Return context information to client via %SQLProcContext object
 If ($g(%sqlcontext)'=$$$NULLOREF) { 
 Set %sqlcontext.SQLCode = SQLCODE
 Set %sqlcontext.RowCount = %ROWCOUNT
 }
 QUIT 1
}

/// A sample class query that defines a result set that returns Person data 
/// ordered by <property>Name</property>.<br>
/// This query can be used within another Cach&eacute; method (using the
/// <class>%ResultSet</class> class), from Java, or from ActiveX.<br>
/// This query is also accessible from ODBC and/or JDBC as the SQL stored procedure 
/// <b>SP_Sample_By_Name</b>.
Query ByName(name As %String = "") As %SQLQuery(CONTAINID = 1, ROWSPEC = "ID:%Integer,名前:%String(MAXLEN=30),誕生日", SELECTMODE = "RUNTIME") [ SqlName = SP_Sample_By_Name, SqlProc ]
{
 SELECT ID, 名前, 誕生日
 FROM Sample.Person
 WHERE (名前 %STARTSWITH :name)
 ORDER BY 名前
}

Storage Default
{
<Data name="PersonDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>DOB</Value>
</Value>
<Value name="3">
<Value>FavoriteColors</Value>
</Value>
<Value name="4">
<Value>Home</Value>
</Value>
<Value name="5">
<Value>Name</Value>
</Value>
<Value name="6">
<Value>Office</Value>
</Value>
<Value name="7">
<Value>SSN</Value>
</Value>
<Value name="8">
<Value>Spouse</Value>
</Value>
<Value name="9">
<Value>Car</Value>
</Value>
</Data>
<DataLocation>^Sample.PersonD</DataLocation>
<DefaultData>PersonDefaultData</DefaultData>
<ExtentSize>20</ExtentSize>
<IdLocation>^Sample.PersonD</IdLocation>
<IndexLocation>^Sample.PersonI</IndexLocation>
<Property name="%%CLASSNAME">
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="Age">
<Selectivity>5.5556%</Selectivity>
</Property>
<Property name="Car">
<Selectivity>10.0000%</Selectivity>
</Property>
<Property name="DOB">
<Selectivity>5.0000%</Selectivity>
</Property>
<Property name="FavoriteColors">
<Selectivity>11.1111%</Selectivity>
</Property>
<Property name="Home">
<Selectivity>5.0000%,:6.2500%</Selectivity>
</Property>
<Property name="Name">
<Selectivity>5.0000%</Selectivity>
</Property>
<Property name="Office">
<Selectivity>5.0000%,:7.6923%</Selectivity>
</Property>
<Property name="Spouse">
<Selectivity>12.5000%</Selectivity>
</Property>
<StreamLocation>^Sample.PersonS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
