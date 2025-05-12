Include %occStatus

Class Sales.Operation
{

ClassMethod populate(no As %Integer) As %Boolean
{
  do ##class(Sales.Customer).%KillExtent()
  do ##class(Sales.Product).%KillExtent()
	
  do ##class(Sales.Customer).Populate(no)
  do ##class(Sales.Product).Populate(no)
	
  quit $$$OK
}

ClassMethod placeOrder(customerId As %Integer) As %Boolean
{
	
  if customerId="" write "顧客IDを入力してください",! quit '$$$OK
 
  if '##class(Sales.Customer).%ExistsId(customerId) write "顧客IDが登録されていません",! quit '$$$OK
 
  set customer = ##class(Sales.Customer).%OpenId(customerId)
	
  write customer.Name_"様、いつもご利用ありがとうございます",!!

  set result=##class(%SQL.Statement).%ExecDirect(,"select id,name,unitprice from Sales.Product")
  set resultset = result.%CurrentResult
	 
  write "商品ID",?20,	"商品名",?40,"単価",!
  write "----------------------------------------------------",!
 
  While resultset.%Next(.sc) {
    If $$$ISERR(sc) quit
      write resultset.id,?20,resultset.name,?40,##class(Sales.Product).UnitPriceLogicalToDisplay(resultset.unitprice),! 
    }
		
    write !
	
    set itemNo = 0
    
    for {
      read "注文したい商品IDを入力してください　", pid,!

      if pid="" quit

      if '##class(Sales.Product).%ExistsId(pid) write "商品が存在しません",! continue
	  
      read "数量を入力してください　", amount,!
      if amount'?.N write "正しい数値を入力してください",! continue
      set itemNo = itemNo + 1
      set items(itemNo) = $listbuild(pid,amount) 
    }
	
    if itemNo = 0 quit '$$$OK
	
    set order = ##class(Sales.PurchaseOrder).%New()
    set order.Customer = customer		
    set order.PurchaseDate = $piece($horolog,",",1)

    for i = 1:1:itemNo {
      set item = ##class(Sales.OrderItem).%New()
      set pid = $list(items(i),1)
      set product = ##class(Sales.Product).%OpenId(pid)
      set item.Product = product
      set item.Amount = $list(items(i),2)
      do order.Items.Insert(item)
    }
	
    set sc = order.%Save()
	
    if $$$ISERR(sc) {
      Do $system.Status.DisplayError(sc)
    }
    Else {
      write "注文を受け付けました",!
    }
    quit $$$OK
}

ClassMethod placeOrderWithFullSQL(customerId As %Integer) As %Boolean
{
	
  if customerId="" write "顧客IDを入力してください",! quit '$$$OK
 
  set result=##class(%SQL.Statement).%ExecDirect(,"select Name from Sales.Customer where id = ?",.customerId)
  set resultset = result.%CurrentResult

  if 'resultset.%Next(.sc) write "顧客IDが登録されていません" quit '$$$OK
 	
  write resultset.Name_"様、いつもご利用ありがとうございます",!!

  set result = ##class(%SQL.Statement).%New()
  set result.%SelectMode = 2 //表示モード

  set sc = result.%Prepare("select id,name,unitprice from Sales.Product")
  if $$$ISERR(sc) Do $system.Status.DisplayError(sc) quit '$$$OK
  set resultset = result.%Execute()
	 
  write "商品ID",?20,	"商品名",?40,"単価",!
  write "----------------------------------------------------",!
 
  While resultset.%Next(.sc) {
    If $$$ISERR(sc) quit
    write resultset.id,?20,resultset.name,?40,resultset.unitprice,! 
  }
		
  write !
	
  set itemNo = 0
    
  for {
    read "注文したい商品IDを入力してください　", pid,!

    if pid="" quit

    set result=##class(%SQL.Statement).%ExecDirect(,"select Name from Sales.Product where id = ?",.customerId)
    set resultset = result.%CurrentResult

    if 'resultset.%Next(.sc) write "商品が存在しません",! continue
	  	  
    read "数量を入力してください　", amount,!
    if amount'?.N write "正しい数値を入力してください",! continue
    set itemNo = itemNo + 1
    set items(itemNo) = $listbuild(pid,amount) 
  }
	
  if itemNo = 0 quit '$$$OK
	
  //&sqlは、変数スコープのコンテキストが異なるため、簡易的に%をつけて、変数をPUBLIC変数にする

  set %customerId = customerId		
  set %purchaseDate = $piece($horolog,",",1)
	
  tstart

  &sql(insert into Sales.PurchaseOrder (Customer,PurchaseDate) VALUES (:%customerId,:%purchaseDate))
        
  if SQLCODE '=0 {
    write "注文情報の登録に失敗しました",!
    trollback
    quit '$$$OK
  }
    
  set %orderid = %ROWID
    
  set success = 1
                    
  for i = 1:1:itemNo {
    set %pid = $list(items(i),1)
    set %amount = $list(items(i),2)

    &sql(insert into Sales.OrderItem (TheOrder,Product,Amount) VALUES (:%orderid,:%pid,:%amount))

    if SQLCODE '=0 {
      write "注文明細の登録に失敗しました",!
      trollback
      set success = 0
      quit
    }
  }
		
  if success {
    write "注文を受け付けました",!
    tcommit
  }
    
  kill %customerId,%orderid,%purchaseDate,%ROWID    

  quit $$$OK
}

ClassMethod orderByCustomer(customerId As %String) As %Boolean
{
 
  if customerId="" write "顧客IDを入力してください",! quit '$$$OK
 
  if '##class(Sales.Customer).%ExistsId(customerId) write "顧客IDが登録されていません" quit '$$$OK
 
  set customer = ##class(Sales.Customer).%OpenId(customerId)

  write !!,customer.Name_"様のご注文履歴は、以下のようになっています",!!
	
  set result=##class(%SQL.Statement).%ExecDirect(,"select id,purchasedate from Sales.PurchaseOrder where customer->id = ?",.customerId)
  set resultset = result.%CurrentResult

  write "注文ID",?20,"注文日",!
  write "-----------------------------------------------",!

  While resultset.%Next(.sc) {
    If $$$ISERR(sc) quit
    write resultset.id,?20,##class(%Date).LogicalToDisplay(resultset.purchasedate),! 
  }
	
  write !
	
  read "内容を表示したい注文番号を入力してください ",oid,!!

  if oid = "" quit '$$$OK

  if '##class(Sales.PurchaseOrder).%ExistsId(oid) write "注文が存在しません",! quit '$$$OK
	
  set porder = ##class(Sales.PurchaseOrder).%OpenId(oid)
     
  write "ご注文内容は、以下のとおりです",!!
	
  write "お客様名",?20,"注文日",!
  write porder.Customer.Name,?20,porder.PurchaseDateLogicalToOdbc(porder.PurchaseDate),!!
	
  write "明細番号",?10,"商品ID",?20,"商品名",?40,"単価",?50,"割引率",?60,"数量",?70,"小計",!
  write "-------------------------------------------------------------------------------",!
  
  for i=1:1:porder.Items.Count() {
    set item = porder.Items.GetAt(i)
    write $justify(i,8),?10,$justify(item.Product.%Id(),6),?20,item.Product.Name,?40,$justify(item.Product.UnitPriceLogicalToDisplay(item.Product.UnitPrice),6),?50,$justify(porder.Customer.Discount,4)," %",?60,$justify(item.Amount,4),?70,$justify(item.SubTotalLogicalToDisplay(item.SubTotal),8),!
  }
  quit $$$OK
}

ClassMethod totalByProduct(productId As %Integer) As %Boolean
{
  if productId="" write "商品IDを入力してください",! quit '$$$OK
 
  if '##class(Sales.Product).%ExistsId(productId) write "商品IDが登録されていません" quit '$$$OK
	
  set total = 0
 
  set result=##class(%SQL.Statement).%ExecDirect(,"select id from Sales.OrderItem where product->id = ?",.productId)
  set resultset = result.%CurrentResult

  While resultset.%Next(.sc) {

    If $$$ISERR(sc) quit
		
    set id = resultset.id
    set item = ##class(Sales.OrderItem).%OpenId(id)

    set total = total + item.SubTotal
  }

			
  write "この商品の売り上げ累計は、",total,"円です",!
	
  quit $$$OK
}

}
