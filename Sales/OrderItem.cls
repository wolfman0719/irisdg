Class Sales.OrderItem Extends (%Persistent, %Populate) [ Inheritance = right, ProcedureBlock ]
{

Relationship TheOrder As Sales.PurchaseOrder [ Cardinality = parent, Inverse = Items ];

Property Product As Product;

Property Amount As %Integer;

Property SubTotal As %Integer(FORMAT = ",") [ Calculated ];

Method SubTotalGet() As %Integer
{
  Quit $normalize((..Product.UnitPrice * ..Amount * ..TheOrder.Customer.Discount / 100),0)
}

Storage Default
{
<Data name="OrderItemDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Product</Value>
</Value>
<Value name="3">
<Value>Amount</Value>
</Value>
</Data>
<DataLocation>{%%PARENT}("Items")</DataLocation>
<DefaultData>OrderItemDefaultData</DefaultData>
<IdLocation>^Sales.PurchaseOrderC("Items")</IdLocation>
<IndexLocation>^Sales.OrderItemI</IndexLocation>
<StreamLocation>^Sales.OrderItemS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
