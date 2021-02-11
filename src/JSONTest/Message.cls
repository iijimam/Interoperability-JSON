Class JSONTest.Message Extends Ens.Request [ Language = objectscript ]
{

/// DyanmicObjectをプロパティに設定できる永続クラスを参照しています。
/// この方法は、JSONのDynamicObject格納用永続クラスを利用してメッセージに保存時のIDを設定し
/// データを受け渡す方法です
Property JSON As JSONTest.JSON;

/// HS.SDA3.QuickStreamを利用してJSONをストリームとして保存します
/// ストリームデータはIRISTEMPデータベースに格納されるグローバルに入ります。
/// ^CacheTemp.HS.Stream
/// この方法は、IRISforHealth内部で利用しているQuickStreamの構造を利用して
/// メッセージにQuickStreamIDを設定しデータを受け渡す方法です。
Property QuickStreamId As %String;

Storage Default
{
<Data name="MessageDefaultData">
<Subscript>"Message"</Subscript>
<Value name="1">
<Value>JSON</Value>
</Value>
<Value name="2">
<Value>QuickStreamId</Value>
</Value>
</Data>
<DefaultData>MessageDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
