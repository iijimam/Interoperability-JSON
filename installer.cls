Class App.Installer
{

XData setup
{
<Manifest>
  <!--インストーラーの中で使用する変数NamespaceにTRYを設定 -->
  <Default Name="Namespace" Value="app"/>
  <!--変数dirにディレクトリ名：例ではirisapp -->
  <Default Name="dir" Value="irisapp" />
  
  <!--ネームスペース作成用の定義 -->
  <Namespace Name="${Namespace}" Code="${Namespace}" Data="${Namespace}" Create="yes">
    <!-- データベース作成用定義-->
    <Configuration>
      <!--データベースディレクトリをDockerfile内で予め作成した /opt/try 以下に設定するように指定 -->
      <Database Name="${Namespace}" Dir="/opt/${dir}/data" Create="yes" Resource="%DB_${Namespace}"/>
    </Configuration>
    <!--ウェブアプリケーションパス /csp/try　の作成 -->
    <CSPApplication Url="/csp/${Namespace}" Directory="${cspdir}${Namespace}"  ServeFiles="1" Recurse="1" MatchRoles=":%DB_${Namespace}" AuthenticationMethods="32"
    />

    <!-- プロダクションの自動開始 -->
    <Production Name="JSONTest.Prod" AutoStart="1" />

    <!--HSパッケージも含めて利用できる環境に変更 -->
    <Invoke Class="%ZHSLIB.HealthShareMgr" Method="EnableHealthShareNamespace">
      <Arg Value="${Namespace}" />
    </Invoke>
  </Namespace>

</Manifest>
}

ClassMethod setup(ByRef pVars, pLogLevel As %Integer = 3, pInstaller As %Installer.Installer, pLogger As %Installer.AbstractLogger) As %Status [ CodeMode = objectgenerator, Internal ]
{
  #; Let XGL document generate code for this method. 
  Quit ##class(%Installer.Manifest).%Generate(%compiledclass, %code, "setup")
}

}
