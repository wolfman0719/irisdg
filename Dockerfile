ARG IMAGE=store/intersystems/iris-community-arm64:2020.4.0.547.0
ARG IMAGE=store/intersystems/iris-community-arm64:2021.1.0.215.0
ARG IMAGE=store/intersystems/iris-community-arm64:2021.2.0.649.0
ARG IMAGE=intersystemsdc/iris-community:2020.3.0.221.0-zpm
ARG IMAGE=intersystemsdc/iris-community:2020.4.0.547.0-zpm
ARG IMAGE=store/intersystems/iris-community:2020.4.0.547.0
ARG IMAGE=store/intersystems/iris-community:2021.1.0.215.0
ARG IMAGE=store/intersystems/iris-community:2021.2.0.649.0
FROM $IMAGE

ARG COMMIT_ID="dgdemo"

USER ${ISC_PACKAGE_MGRUSER}

ENV ISC_TEMP_DIR=/intersystems/iris/
COPY Sales $ISC_TEMP_DIR/Sales
COPY Shop $ISC_TEMP_DIR/Shop
COPY Sample $ISC_TEMP_DIR/Sample
COPY Test $ISC_TEMP_DIR/Test
COPY OrderProc.mac $ISC_TEMP_DIR/
COPY shop-data.xml $ISC_TEMP_DIR/
COPY csp/*.* $ISC_PACKAGE_INSTALLDIR/csp/user/

RUN iris start IRIS \
	&& iris session IRIS < /tmp/iris.script \
    && iris stop IRIS quietly
	
USER root

RUN chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} $ISC_TEMP_DIR/
