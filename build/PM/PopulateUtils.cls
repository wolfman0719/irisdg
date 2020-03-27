Class PM.PopulateUtils Extends %RegisteredObject [ ClassType = "", ProcedureBlock ]
{

/******************************************************************************
Id:  PM.PopulateUtils.cls#1
説明：データ自動生成用支援クラス
******************************************************************************/
/// ランダムな都市名を返す
ClassMethod City() As %String
{
 s t1=$lb("大阪市","札幌市","仙台市","大宮市","金沢市","横浜市","川崎市","福岡市","広島市","佐賀市","熊本市","松山市","鹿児島市","山口市","徳山市","岡山市","神戸市","京都市","福知山市","川西市","宝塚市","西宮市","池田市","豊中市","大阪市","奈良市")
 Quit $li(t1,$r($ll(t1))+1)
}

/// ランダムな年齢を返す
ClassMethod Age() As %Integer
{
 Set age=$R(99)
 Quit age
}

/// ランダムな請求額を返す
ClassMethod Bill() As %Integer
{
 Set bill=$R(99)
 Quit bill*1000
}

/// ランダムな賃金を返す
ClassMethod Wage() As %Integer
{
 Set bill=$R(50)
 Set bill = bill * 1000
 If bill < 10000 Set bill = bill + 10000 
 Quit bill
}

/// ランダムな診療科を返す
ClassMethod Practice() As %String
{
 s t1=$lb("内科","外科","小児科","神経外科","皮膚科","眼科","脳外科")
 Quit $li(t1,$r($ll(t1))+1)
}

/// 性別を返す
ClassMethod Sex() As %String
{
 s t1=$lb("男","女")
 Quit $li(t1,$r($ll(t1))+1)
}

/// ランダムな会社名を返す
ClassMethod Company() As %String
{
 Set c1=$LB("住井","三友","ＮＴＳ","丸田","タクト","電金","新光","出光","アオキ","東川","富士","ディジタル","コスモ","プライス","暗電","総芝","つばさ","ラックス","東経","セコミ","ビーエスシ","SES","IDGG","小文社","ミック","高地歩","ストラテス")
 Set c2=$LB("商事","証券","銀行","損保","製造","機械","石油","情報","研究所","サービス","医療システム","ジャパン","システムズ","コミュニケーションズ","データ","ウェア","総業","工業","建設","技研","薬品")
 Set c3=$LB("株式会社","有限会社","株式会社","株式会社","株式会社","株式会社","株式会社")
 Quit $LI(c1,$Random($LL(c1))+1)_$LI(c2,$random($LL(c2))+1)_$LI(c3,$random($LL(c3))+1)
}

/// MINとMAXの間のランダムな価格を返す。
ClassMethod Currency(min As %Integer = 0, max As %Integer = 10000000) As %Integer
{
 Quit ##class(%PopulateUtils).Float(min,max,4)
}

/// ランダムな名前を返す
/// <p><var>gender</var>は、生成する名前を性別で制御するオプション:
///  1は男性、 2は女性、""はどちらか
ClassMethod FirstName(gender As %String = "") As %String
{
 #; gender is 1:MALE,2:FEMALE
 s:$g(gender)="" gender=$r(2)+1
 If (gender = 1) {
 Set list = $LB("博康","新太郎","俊哉","実","一二三","俊夫",
 "幹夫","正行","渉","雅夫","誠一","博史",
 "直弘","孝雄","茂","徹",
 "雄三","道元","聡","弘明","敏明","信昭",
 "良成","哲治","芳郎","俊介","操",
 "英明","道夫","康之","仁孝","浩二郎","和彦",
 "一成","道裕","亮","武","英之","勝一郎",
 "哲郎","秀和","幸博","豊","道男","司","徹冶",
 "高志","昭","明雄","義彦","清司","保之",
 "徹也","勇","幸太郎","勝","信弘",
 "達也","勝彦","亮一","敏哉","寛文","照美",
 "克郎","貴英","正夫","崇","克道",
 "誠一","正一","孝","公人","泰久")
 }
 Else {
 Set list = $lb("茜","明子","晶子","あずみ","麻美",
 "泉","いずみ","ひとえ","仁美",
 "瞳","日登美","美穂","美保",
 "香織","和美","一美","馨","エミリ","エミ","恵美",
 "紀子","規子","由紀","雪","孝子","貴子","敏子",
 "俊子","恵","恵美","愛","藍","三咲",
 "美咲","みどり","みさえ","由紀子",
 "由貴","裕香","かなえ","幸子","祥子",
 "早苗","綾","彩","恵理子","エリカ",
 "江美","博美","浩美",
 "智子","友子","真紀","真樹","昌枝",
 "正枝","静江","順子","淳子","雅子","恭子",
 "京子","秀美","秀美",
 "伊代","千恵美","智恵美","洋子","陽子","静香","京香","千春")
 }
 Quit $LI(list,$Random($LL(list))+1)
}

/// minとmaxの間のランダムな浮動小数を返す
ClassMethod Float(min As %Integer = 0, max As %Integer = 100000000, scale As %Integer = 0) As %Integer
{
 s float=min+$Random(max-min+1)
 q $s((float<max)&scale:+(float_"."_$Random(scalemax+1)),1:float)
}

/// minとmaxの間のランダムな整数を返す 
ClassMethod Integer(min As %Integer = 0, max As %Integer = 10000) As %Integer
{
 If min>max Quit 0
 Quit min+$Random(max-min+1)
}

/// ランダムな姓名を返す
ClassMethod LastName() As %String
{
 Set x = $R(26)+1
 If (x = 1) 	{ Set list = $LB("伊藤","安部","梅田","石川","宇高") }
 ElseIf (x = 2)	{ Set list = $LB("大崎","江原","安藤","榎本","荒川","大田","上村","大谷","石丸","大野","小島","長田") }
 ElseIf (x = 3)	{ Set list = $LB("大林","石橋","石田","鬼塚","岩島","井口","小笠原","内野","大沢","岡本","上田","石村","小倉") }
 ElseIf (x = 4)	{ Set list = $LB("有海","井村","梅沢","大島","井上","上田","奥山","大幡","宇津木") }
 ElseIf (x = 5)	{ Set list = $LB("阿部","岩淵","荒川","大原","赤羽","新井","板谷") }
 ElseIf (x = 6)	{ Set list = $LB("金子","川島","河野","金沢","川越","川下") }
 ElseIf (x = 7)	{ Set list = $LB("甲斐","久保","小林","児玉","木内","亀谷","川原") }
 ElseIf (x = 8)	{ Set list = $LB("柏木","小谷","北川","川西","加藤","吉川","鎌田") }
 ElseIf (x = 9)	{ Set list = $LB("岸田","木村","川口") }
 ElseIf (x = 10)	{ Set list = $LB("佐藤","嵯峨","新庄","鈴木","島","塩田") }
 ElseIf (x = 11)	{ Set list = $LB("斉藤","笹原","正田","品川","杉山","砂川") }
 ElseIf (x = 12)	{ Set list = $LB("桜井","清水","関口","白井","篠田","境","坂口","志村","芝戸","高橋","多久和") }
 ElseIf (x = 13)	{ Set list = $LB("竹林","高松","田畑","高柳","田村","高藤","鷹野","田中","田畑","武田","高岡","滝藤","土井","中村","永尾") }
 ElseIf (x = 14)	{ Set list = $LB("中沢","中村","長島","中本","中元","野田","西山","乗口","野口") }
 ElseIf (x = 15)	{ Set list = $LB("西野","西本","西原","内藤","藤居","成井","波内") }
 ElseIf (x = 16)	{ Set list = $LB("野村","野原","永井","長塚","中武","根本","林","広本","樋口","平田","尾藤","花木") }
 ElseIf (x = 17)	{ Set list = $LB("廣田","本間","藤木") }
 ElseIf (x = 18)	{ Set list = $LB("古川","古田","尾藤","福居","日高") }
 ElseIf (x = 19)	{ Set list = $LB("本田","原田","平山","浜屋","橋本","平本","福嶋","長谷川","平島","吉野","廣瀬","細田") }
 ElseIf (x = 20)	{ Set list = $LB("古館","早川","吉野","森本","松尾","松田","松本") }
 ElseIf (x = 21)	{ Set list = $LB("宮崎","三沢","宮本","前川") }
 ElseIf (x = 22)	{ Set list = $LB("三好","枡屋","武藤","森永") }
 ElseIf (x = 23)	{ Set list = $LB("望月","丸山","森","溝上","三浦","丸谷","山本","山崎","吉村","安田") }
 ElseIf (x = 24)	{ Set list = $LB("山中","柳井","横山") }
 ElseIf (x = 25)	{ Set list = $LB("柳","山野","山原","山口") }
 ElseIf (x = 26)	{ Set list = $LB("渡辺","渡部","渡邊") }
 Quit $LI(list,$Random($LL(list))+1)
}

/// ランダムに生成した職種を返す
ClassMethod Mission() As %String
{
 Set c1=$LB("リーダ ","ディベロッパ ","プロバイダ ","リセラー","オンライン配信")
 Set c2=$LB("先進","インターネット","先端","ブレークスルー","複雑な","高性能","スケーラブル","クロスプラットフォーム","ジャストインタイム","オープン",
 "パーソナル","ハイテク","ハイタッチ","オープンソース","仮想","インタラクティブ")
 Set c3=$LB("クオンタム","ナノ","ハイパー","光学","ファイナンシャル","マルチメディア","オブジェクト指向","ブロードバンド","セキュア","ディジタル","Java",
 "エンタープライズ","リナックスベース","遺伝子 ","ワイヤレス","サテライトベース","ISO 9003準備","Y2K認可済")
 Set c4=$LB("デバイス","設置作業","グラフィカル","XML ","InterNet ","アプリケーション","データベース","データウェアハウス","フォーキャスティング","音声可能",
 "コールドフュージョンにて稼働中cold-fusion powered ")
 Set c5=$LB("サービス","テクノロジー","メディア","内容","ミドルウェア","接続性","コンサルティング","製薬")
 Set c6=$LB("インターネット用","金融コミュニティ","著名な投資家用","娯楽業界用","家庭用","フォーチュン5用","フォーチュン50用","フォーチュン500用",
 "フォーチュン5000用","大企業用","デスクトップ用","ヘルスケアコミュニティ用")
 Quit $LI(c1,$Random($LL(c1))+1)_$LI(c2,$random($LL(c2))+1)_$LI(c3,$random($LL(c3))+1)_$LI(c4,$random($LL(c4))+1)_$LI(c5,$random($LL(c5))+1)_$LI(c6,$random($LL(c6))+1)
}

/// ランダムな氏名を<i>lastname firstname</i>の形式で返す
/// <p><var>gender</var>は、オプションの文字で生成する名前の性別を制御する: 
/// 1は、男性、2は女性、""は、どちらか一方
ClassMethod Name(gender As %String = "") As %String
{
 Quit ..LastName()_" "_..FirstName($g(gender))
}

/// ランダムな文字列を返す
ClassMethod String(len As %Integer = 1) As %String
{
 s:'$g(len) len=1
 Set slist=$LB("メトロゴールド","モダンアミュズメント","モンスター","ラブラ","ラブラドル","ランドリー","ルショップシピー",
 "レッドウッド","ロイヤルフラッシュ","６６６","フィラシューズ","フィールドライン","４５ｒｐｍ","フォワード","フラミンゴサルン",
 "ブレイクビーツ","ボイコット","ボーダメイド","ポールスミス","ミリオンエア","メイドインワールド")
 s string=$List(slist,$R($LL(slist))+1)
 QUIT string
}

/// プロジェクト名を返す
ClassMethod Project() As %String
{
 Set slist1=$LB("新規","追加","改修","刷新")
 Set slist2=$LB("初期","第一期","第二期","第三期","最終工期")
 s string=$List(slist1,$R($LL(slist1))+1)_"プロジェクト　"_$List(slist2,$R($LL(slist2))+1)
 QUIT string
}

/// 通りの名前を返す
ClassMethod Street() As %String
{
 s t1=$lb("Maple","Ash","Elm","Oak","Main","First","Second","Washington","Franklin","Clinton","Madison")
 s t2=$lb("Street","Avenue","Blvd","Court","Place","Drive")
 Quit ($r(9999)+1)_" "_$li(t1,$r($ll(t1))+1)_" "_$li(t2,$r($ll(t2))+1)
}

/// ランダムな肩書きを返す
ClassMethod Title() As %String
{
 Set t1=$LB("","上級","副","アシスタント","戦略","国際","研究","エグゼクティブ")
 Set t2=$LB("エンジニア","営業担当","サポートエンジニア","開発担当","マーケティングマネージャ","アカウント担当","リソースディレクタ","ディレクタ",
 "製品マネージャ","リサーチアシスタント","システムエンジニア","テクニシャン","ウェブマスタ","管理者","製品スペシャリスト","会計士","衛生士")
 Quit $LI(t1,$Random($LL(t1))+1)_$LI(t2,$random($LL(t2))+1)
}

/// ランダムな日本の電話番号を返す
ClassMethod JPNPhone() As %String [ CodeMode = expression ]
{
"0"_($Random(999))_"-"_($Random(9999))_"-"_($Random(9999))
}

ClassMethod JPNZip() As %String [ CodeMode = expression ]
{
($Random(899)+100)_"-"_($Random(8999)+1000)
}

}
