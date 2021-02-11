/// このクラスは、メッセージにJSONのDynamicObjectを格納したい場合に利用する永続クラスです。
/// IRISforHealthの内部用途に利用されているHS.SDA3.QuickStreamを利用する場合は使用しません
Class JSONTest.JSON Extends %Persistent
{

Property data As %DynamicObject;

Storage Default
{
<Data name="JSONDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
</Data>
<Data name="json">
<Attribute>data</Attribute>
<Structure>node</Structure>
<Subscript>"json"</Subscript>
</Data>
<DataLocation>^JSONTest.JSOND</DataLocation>
<DefaultData>JSONDefaultData</DefaultData>
<IdLocation>^JSONTest.JSOND</IdLocation>
<IndexLocation>^JSONTest.JSONI</IndexLocation>
<StreamLocation>^JSONTest.JSONS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
