Class Test.Hello Extends %CSP.Page
{

ClassMethod OnPage() As %Status
{
	&html<<html>
<head>
</head>
<body>>
	Write "<b>こんにちは、みなさん</b>",!
	Write "<ul>",!
    For i = 1:1:10 {
      Write "<LI> これは、",i,"行目です ",!
    }
    Write "</ul>",!
	&html<</body>
</html>>
	Quit $$$OK
}

}
