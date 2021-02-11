ARG IMAGE=intersystems/irishealth:2020.1.0.215.0
ARG IMAGE=store/intersystems/irishealth-community:2020.3.0.221.0
ARG IMAGE=intersystems/irishealth:2020.3.0.221.0
FROM $IMAGE
USER root
WORKDIR /opt/irisapp
RUN chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /opt/irisapp

USER ${ISC_PACKAGE_MGRUSER}

#ファイルコピー
COPY iris.script iris.script
COPY src src
COPY installer.cls installer.cls
COPY iris.key ${ISC_PACKAGE_INSTALLDIR}/mgr/iris.key

# iris.scriptに記載された内容を実行
RUN iris start IRIS \
	&& iris session IRIS < iris.script \
  && iris stop IRIS quietly