Class JSONTest.FileBO Extends Ens.BusinessOperation [ Language = objectscript ]
{

Parameter ADAPTER = "EnsLib.File.OutboundAdapter";

Property Adapter As EnsLib.File.OutboundAdapter;

Parameter INVOCATION = "Queue";

/// === 方法A：JSONTest.JSONクラスを利用してJSONのDynamicObjectを持ちまわる方法 ===<br>
/// === 方法B：HS.SDA3.QuickStrem を利用してJSONのDynamicObjectを持ちまわる方法(IRISforHealth/HealthConnect) ===
Method Out(pRequest As JSONTest.Message, Output pResponse As Ens.Response) As %Status
{
	/* === 方法A：JSONTest.JSONクラスを利用してJSONのDynamicObjectを持ちまわる方法 ===
	 以下のコードはJSONのDynamicObjectを次のコンポーネントに渡す際、
	 JSONTest.JSONクラス（＝永続クラス）にDynamicObjectを格納し
	 作成したインスタンスをメッセージクラスに設定しています
	 （pRequest.JSON.dataでDynamicObjectが参照できます） */
	
	//ファイルアウトバウンドアダプタは文字の出力もできますが、以下の例はストリームの出力を実行しています
	set stream=##class(%Stream.FileBinary).%New()
	set st=pRequest.JSON.data.%ToJSON(.stream)
	set st=..Adapter.PutStream("testA.txt",stream)
	$$$TRACE("方法A："_$ZCVT(pRequest.JSON.data.%ToJSON(),"I","UTF8"))

	/* === 方法B：HS.SDA3.QuickStrem を利用してJSONのDynamicObjectを持ちまわる方法(IRISforHealth/HealthConnect) ===
	 以下のコードは、JSONのDynamicObjectをIRISforHealthにあるHS.SDA3.QuickStreamクラスを利用して
	 DynamicObjectをストリームとして保存し、次のコンポーネントに送付しています。
	 使用するためには、%OpenId()を利用してストリームをオープンします
	 (pRequest.QuickStreamIdにIDが格納されているのでそれを利用してオープン)*/
	set stream=##class(HS.SDA3.QuickStream).%OpenId(pRequest.QuickStreamId)
	set st=..Adapter.PutStream("testB.txt",stream)
	//トレース出力の為、一旦ストリームの先頭に移動
	do stream.Rewind()
	$$$TRACE("方法B："_$ZCVT(stream.Read(),"I","UTF8"))

	quit st
}

XData MessageMap
{
<MapItems>
	<MapItem MessageType="JSONTest.Message"> 
		<Method>Out</Method>
	</MapItem>
</MapItems>
}

}
