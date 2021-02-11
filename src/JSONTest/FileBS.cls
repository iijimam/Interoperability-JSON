Class JSONTest.FileBS Extends Ens.BusinessService [ Language = objectscript ]
{

Parameter ADAPTER = "EnsLib.File.InboundAdapter";

/// === 方法A：JSONTest.JSONクラスを利用してJSONのDynamicObjectを持ちまわる方法 ===<br>
/// === 方法B：HS.SDA3.QuickStrem を利用してJSONのDynamicObjectを持ちまわる方法(IRISforHealth/HealthConnect) ===
Method OnProcessInput(pInput As %Stream.Object, Output pOutput As %RegisteredObject) As %Status
{
	/* === 方法A：JSONTest.JSONクラスを利用してJSONのDynamicObjectを持ちまわる方法 ===
	 以下のコードはJSONのDynamicObjectを次のコンポーネントに渡す際、
	 JSONTest.JSONクラス（＝永続クラス）にDynamicObjectを格納し
	 作成したインスタンスをメッセージクラスに設定することで情報を送信しています */
	set dynamicobj={}.%FromJSON(pInput)
	set msg=##class(JSONTest.Message).%New()
	set jsondata=##class(JSONTest.JSON).%New()
	// 次のコンポーネントで情報を取得できるように、メッセージに永続クラスのIDを設定して送信します
	set jsondata.data=dynamicobj
	set msg.JSON=jsondata


	/* === 方法B：HS.SDA3.QuickStrem を利用してJSONのDynamicObjectを持ちまわる方法(IRISforHealth/HealthConnect) ===
	 以下のコードは、JSONのDynamicObjectをIRISforHealthにあるHS.SDA3.QuickStreamクラスを利用して
	 DynamicObjectをストリームとして保存し、次のコンポーネントに送付しています。
	 QuickStreamは専用グローバルに格納されるため、SQLでは参照できません。
		^CacheTemp.HS.Stream  （このグローバルはIRISTEMPに格納されるため、IRIS再起動で消えます）*/
	set stream=##class(HS.SDA3.QuickStream).%New()
	// ストリームをグローバルに保存
	set st=stream.CopyFromAndSave(pInput)
	// 次のコンポーネントで情報を取得するため、メッセージにQuickStreamの保存IDを登録して送信します
	set msg.QuickStreamId=stream.%Id()
	$$$LOGINFO("QuickStaremID="_stream.%Id())

	set st=..SendRequestAsync("JSONTest.FileBO",msg)
	quit st
}

}
