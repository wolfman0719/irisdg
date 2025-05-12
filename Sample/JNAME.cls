Class Sample.JNAME Extends %Library.Name [ ClassType = datatype, LegacyInstanceContext, ProcedureBlock ]
{

/// Converts the value of <var>%val</var> into a display string.
/// <p>Returns the formatted value of <var>%val</var>.
ClassMethod LogicalToDisplay(%val As %Name = "") As %String
{
  Quit $Piece(%val,",",1)_" "_$Piece(%val,",",2)
}

/// Converts the input value <var>%val</var>, which is a string representing
/// a name, into the internal format.
/// <p>Returns the internal value of the input string <var>%val</var>.
ClassMethod DisplayToLogical(%val As %String = "") As %Name
{
  Quit $Piece(%val," ",1)_","_$Piece(%val,",",2)
}

/// Converts the value of <var>%val</var> into a display string.
/// <p>Returns the formatted value of <var>%val</var>.
ClassMethod LogicalToODBC(%val As %Name = "") As %String
{
  Quit $Piece(%val,",",1)_" "_$Piece(%val,",",2)
}

/// Converts the input value <var>%val</var>, which is a string representing
/// a name, into the internal format.
/// <p>Returns the internal value of the input string <var>%val</var>.
ClassMethod ODBCToLogical(%val As %String = "") As %Name
{
  Quit $Piece(%val," ",1)_","_$Piece(%val,",",2)
}

}
