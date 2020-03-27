Class PM.Error Extends (%Persistent, %JSON.Adaptor)
{

/******************************************************************************
Id:  PM.Error.cls#1
説明：アプリケーションエラーを記録するクラス
******************************************************************************/
/// エラー発生日時
Property EventDateTime As %TimeStamp;

/// エラーの内容
Property ErrorDescription As %String(MAXLEN = 1000);

ClassMethod StoreErrorInformation(pException As %Exception.General) As %Status
{
	Set tSC = $$$OK
	Try {
	    set tError = ..%New()
	    set tError.EventDateTime = $zdatetime($zts,3)
	    set tStatus = pException.AsStatus()
	    set tSC = $System.Status.DecomposeStatus(tStatus,.tErrorContent)
	    set n = ""
	    Do {
		   set n= $order(tErrorContent(n))
		   if n = "" quit
		   set tErrorContent = $get(tErrorContent)_$get(tErrorContent(n))
	    } while n='""

	   set tError.ErrorDescription = $Get(tErrorContent)
	   set tSC = tError.%Save()
	} 
	Catch tE {
		Set ^FAQError(tError.EventDateTime)= $Get(tStatus)
	}
	quit tSC
}

Storage Default
{
<Data name="ErrorDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>EventDateTime</Value>
</Value>
<Value name="3">
<Value>ErrorDescription</Value>
</Value>
</Data>
<DataLocation>^PM.ErrorD</DataLocation>
<DefaultData>ErrorDefaultData</DefaultData>
<IdLocation>^PM.ErrorD</IdLocation>
<IndexLocation>^PM.ErrorI</IndexLocation>
<StreamLocation>^PM.ErrorS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
