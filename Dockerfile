ARG IMAGE=containers.intersystems.com/intersystems/iris-community-arm64:2023.1.0.235.1
ARG IMAGE=containers.intersystems.com/intersystems/iris-community-arm64:2023.2.0.221.0
ARG IMAGE=containers.intersystems.com/intersystems/iris-community:2023.1.0.235.1
ARG IMAGE=containers.intersystems.com/intersystems/iris-community:2023.2.0.221.0
FROM $IMAGE

ARG COMMIT_ID="dgdemo"

USER ${ISC_PACKAGE_MGRUSER}

ENV ISC_TEMP_DIR=/intersystems/iris/
COPY iris.script /tmp/
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

USER ${ISC_PACKAGE_MGRUSER}
