# InteroperabilityでメッセージにJSON（DynamicObject）を送受信する方法サンプル

サンプルでは、JSONファイルを読み、そのままJSONファイルとして出力しています。

JSONのダイナミックオブジェクトをメッセージに登録して送受信する方法として以下の方法を利用しています。

【メモ】ダイナミックオブジェクト：%DynamicObject は永続化の機能がありません。コンポーネント間でダイナミックオブジェクトを送受信するためには、一旦永続クラスなどに含めて永続化し、保存時のID番号をメッセージに格納する必要があります。受信したコンポーネントでは、メッセージで渡されるIDを利用して、保存された情報をオープンして利用しています。


### 方法A：JSONTest.JSONクラス（永続クラス）を利用してJSONのDynamicObjectを持ちまわる方法

永続クラスを用意し、ダイナミックオブジェクト（%DynamicObject）のタイプを持つプロパティを設定しています。
（[JSONTest.JSON.cls](/src/JSONTest/JSON.cls) クラスの data プロパティにダイナミックオブジェクトを格納できる設定としています）

サンプルのメッセージクラス（[JSONTest.Message.cls](/src/JSONTest/Message.cls)）の JSON プロパティのデータタイプを [JSONTest.JSON.cls](/src/JSONTest/JSON.cls) に設定しています。


### 方法B：HS.SDA3.QuickStrem を利用してJSONのDynamicObjectを持ちまわる方法(IRISforHealth/HealthConnect)

IRIS for Health／HealthConnect で利用できる HS.SDA3.QuickStream クラスを利用しています。
このクラスは、ストリームをグローバル変数に保存できる機能を持ったクラスで、方法Aと異なり、保存後 SQLで確認することはできませんが、汎用クラスとしてシステムから提供されています。
また、メモリ上のデータベース（IRISTEMP）に格納される構造になるため、ストリーム保存時ジャーナルに記録されず、IRIS 停止時自動的に消去されるデータとなります。

サンプルのメッセージクラス（[JSONTest.Message.cls](/src/JSONTest/Message.cls)）の QuickStreamId プロパティにストリーム保存時に生成されるID番号を設定し、送信しています。


## Gitに含まれるファイル

|種類|ファイル|説明|
|:--|:--|:--|
|プロダクション|[Prod.cls](/src/JSONTest/Prod.cls)|プロダクション定義のクラス|
|プロダクション|[Message.cls](/src/JSONTest/Message.cls)|プロダクションで使用するメッセージ|
|プロダクション|[JSON.cls](/src/JSONTest/JSON.cls)|ダイナミックオブジェクトを格納する永続クラス定義（方法Aで利用）|
|プロダクション|[FileBS.cls](/src/JSONTest/FileBS.cls)|ファイルインバウンドアダプタのビジネスサービス|
|プロダクション|[FileBO.cls](/src/JSONTest/FileBO.cls)|ファイルアウトバウンドアダプタのビジネスオペレーション|
|コンテナ用|[docker-compose.yml](/docker-compose.yml)|コンテナ開始時のボリュームマウント／ポート割り当てに利用|
|コンテナ用|[Dockerfile](/Dockerfile)|コンテナビルド時に利用（IRISの初期設定を行うためiris.scriptやinstaller.clsを利用）|
|IRIS初期設定用|[installer.cls](/installer.cls)|コンテナビルド時に実行するIRIS初期設定用インストーラークラス（APPネームスペース／データベースを定義）|
|IRIS初期設定用|[iris.script](/iris.script)|コンテナビルド時に実行するIRIS初期設定用コマンドをまとめたファイル|
|IRIS初期設定用|iris.key|コンテナビルド時にキー反映を行うため用意（実環境用キーに置き換えてご利用ください）|
|テスト用|[temp](/temp)|プロダクション内で使用するファイル入出力用ディレクトリとサンプルファイルを含むディレクトリ|
|テスト用|[temp/in](/temp/in)|プロダクションのビジネスサービスに設定しているファイル入力用ディレクトリ|
|テスト用|[temp/out](/temp/out)|プロダクションのビジネスオペレーションの出力ディレクトリに設定しているディレクトリ|
|テスト用|[json.txt](/temp/json.txt)|サンプルファイル。テスト時 [temp/in](/temp/in) コピーして利用します（実行後 [temp/out](/temp/out) に testA.txt と testB.txt が出力されます）。|

## コンテナ起動までの手順
詳細は、[docker-compose.yml](/docker-compose.yml) をご参照ください。

Git展開後、**./ は コンテナ内 /ISC ディレクトリをマウントしています。**
また、IRISの管理ポータルの起動に使用するWebサーバポートは 62773 が割り当てられています。
既に使用中ポートの場合は、[docker-compose.yml](/docker-compose.yml) の **15行目** を修正してご利用ください。
バージョン2020.1を利用する場合、IRISのスーパーサーバーポートは 51773 番を使用するため、[docker-compose.yml](/docker-compose.yml) の **13行目** は以下に変更してご利用ください。

**≪スーパーサーバーポート：51772 をホストの 62773 に割り当てる例≫　- "62773:51773"**

```
git clone このGitのURL
```
cloneしたディレクトリに移動後、以下実行します。

```
$ docker-compose build
```
ビルド後、コンテナを開始します。
```
$ docker-compose up -d
```
コンテナを停止する方法は以下の通りです。
```
$ docker-compose stop
```
コンテナを破棄する方法は以下の通りです（コンテナを消去します）。
```
$ docker-compose down
```

