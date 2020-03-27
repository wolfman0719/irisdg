Class PM.Utility Extends %Base
{

/******************************************************************************
Id:  PM.Utility.cls#1
説明：各種ユーティリティメソッド用クラス
******************************************************************************/
/// 全国郵便データをロードする
ClassMethod ImportYubinData(pFile As %String) As %Status
{
	Set rowtype="DantaiCode VARCHAR(10),OldZipCode VARCHAR(5), ZipCode VARCHAR(7), KenYomi VARCHAR(30), ToshiYomi VARCHAR(30), CyouYomi VARCHAR(30), Ken VARCHAR(30), Toshi VARCHAR(30), Cyou VARCHAR(30)"
    Set classname = "PM.YubinData"
    Do ##class(%SQL.Util.Procedures).CSVTOCLASS(,rowtype,pFile,,,0,classname)
    Quit $$$OK
}

/// 写真ファイルをロードする
ClassMethod LoadPersonImage(pId As %Integer, pFileName As %String) As %Status
{
 set person = ##class(MyApp.Person).%OpenId(pId)
 set stream = ##class(%Stream.FileBinary).%New() 
 set tS = stream.LinkToFile(pFileName) 
 do person.Picture.CopyFromAndSave(stream) 
 set tS =  person.%Save()
 Quit tS
}

}
