# PG

InterSystems IRIS Data Platform ディベロッパーガイドDocker Build


## ビルドプロセス

### Build&Run
* `docker-compose up -d --build`

## 管理ポータル起動方法

[localhost:52780/csp/sys/%25CSP.Portal.Home.zen?IRISUsername=_system&IRISPassword=SYS](http://localhost:52780/csp/sys/%25CSP.Portal.Home.zen?IRISUsername=_system&IRISPassword=SYS)

## Webターミナル起動方法

[localhost:52780/terminal/](http://localhost:52780/terminal/)

## クレデンシャル情報

|項目           |値         |
|--------------|-----------|
|システムログイン |_system    |
|パスワード　	    |SYS |


## サンプル実行方法

1. データ生成

Cacheターミナルでログイン

`USER>do ##class(Sales.Operation).populate(5)`

2.　注文作成　

```USER>d ##class(Sales.Operation).placeOrder(3)
北村　ゆきえ様、いつもご利用ありがとうございます
 
商品ID              商品名              単価
----------------------------------------------------
1                   ヘアジェル          1400
2                   スクラブウォッシュ  9200
3                   シャンプー          4000
4                   ボディーソープ      4600
5                   ボディーソープ      600
 
注文したい商品IDを入力して下さい　2
数量を入力して下さい　3
注文したい商品IDを入力して下さい　4
数量を入力して下さい　2
注文したい商品IDを入力して下さい　
 
USER>
```

3.　顧客別注文状況表示

```USER>d ##class(Sales.Operation).orderByCustomer(3)
 
北村　ゆきえ様のご注文履歴は、以下の様になっています
 
注文ID              注文日
-----------------------------------------------
1                   09/10/2008
 
内容を表示したい注文番号を入力してください 1
 
ご注文内容は、以下のとおりです
 
お客様名            注文日
北村　ゆきえ        2008-09-10
 
明細番号  商品ID    商品名              単価      割引率    数量      小計
-------------------------------------------------------------------------------
       1       4    ボディーソープ       4,600      90 %       2         8,280
       2       2    スクラブウォッシュ   9,200      90 %       3        24,840
```

4.　商品別売り上げ

```USER>d ##class(Sales.Operation).totalByProduct(1)
この商品の売り上げ累計は、3360円です
```
