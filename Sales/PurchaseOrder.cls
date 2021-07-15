/// 購入注文
Class Sales.PurchaseOrder Extends (%Persistent, %Populate) [ Inheritance = right ]
{

/// 顧客
Property Customer As Customer;

/// 購入日
Property PurchaseDate As %Date;

Relationship Items As Sales.OrderItem [ Cardinality = children, Inverse = TheOrder ];

/// 購入日のインデックス
Index PurchaseDateIndex1 On PurchaseDate;

Storage Default
{
<Data name="PurchaseOrderDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Customer</Value>
</Value>
<Value name="3">
<Value>PurchaseDate</Value>
</Value>
</Data>
<DataLocation>^Sales.PurchaseOrderD</DataLocation>
<DefaultData>PurchaseOrderDefaultData</DefaultData>
<IdLocation>^Sales.PurchaseOrderD</IdLocation>
<IndexLocation>^Sales.PurchaseOrderI</IndexLocation>
<StreamLocation>^Sales.PurchaseOrderS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
