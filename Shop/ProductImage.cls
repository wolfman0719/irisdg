Class Shop.ProductImage Extends %Persistent [ ClassType = persistent, ProcedureBlock ]
{

Property Code As %String(TRUNCATE = 1);

Index CodeIdx On Code [ IdKey, PrimaryKey, Unique ];

Property Picture As %GlobalBinaryStream;

Storage Default
{
<Data name="ProductImageDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Picture</Value>
</Value>
</Data>
<DataLocation>^Shop.ProductImageD</DataLocation>
<DefaultData>ProductImageDefaultData</DefaultData>
<IdLocation>^Shop.ProductImageD</IdLocation>
<IndexLocation>^Shop.ProductImageI</IndexLocation>
<StreamLocation>^Shop.ProductImageS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
