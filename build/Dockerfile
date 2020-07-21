FROM store/intersystems/iris-community:2020.2.0.211.0

ARG COMMIT_ID="devguide"

USER irisowner

ENV ISC_TEMP_DIR=/intersystems/iris/
COPY Sales $ISC_TEMP_DIR/Sales
COPY Shop $ISC_TEMP_DIR/Shop
COPY Sample $ISC_TEMP_DIR/Sample
COPY Test $ISC_TEMP_DIR/Test
COPY OrderProc.mac $ISC_TEMP_DIR/
COPY shop-data.xml $ISC_TEMP_DIR/
COPY csp/*.* $ISC_PACKAGE_INSTALLDIR/csp/user/

RUN  iris start $ISC_PACKAGE_INSTANCENAME \ 
&& printf 'Do ##class(Config.NLS.Locales).Install("jpuw") \
 Do ##class(%%EnsembleMgr).EnableNamespace("USER") \
 set sec = ##class("Security.Applications").%%OpenId("/csp/user") \
 set sec.DeepSeeEnabled = 1 \
 set sec.iKnowEnabled = 1 \
 set status = sec.%%Save() \
 set user = ##class(Security.Users).%%OpenId("_system") \
 set user.PasswordExternal = "demosystem" \
 set status = user.%%Save() \
 h\n' | iris session $ISC_PACKAGE_INSTANCENAME -U %SYS \ 
&& printf 'Do $system.OBJ.ImportDir("'$ISC_TEMP_DIR'/",,"ck",,1) \
 set ^Yubin.ZenkokuD = 123645 \
 do ##class(Sample.Supplier).Populate(100) \
 do ##class(Sample.Car).Populate(100) \
 do ##class(Sample.Person).Populate(100) \
 h\n' | iris session $ISC_PACKAGE_INSTANCENAME -U USER \
 && iris stop $ISC_PACKAGE_INSTANCENAME quietly

USER root

RUN chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} $ISC_TEMP_DIR/

USER irisowner

RUN rm -f $ISC_PACKAGE_INSTALLDIR/mgr/journal.log \
 && rm -f $ISC_PACKAGE_INSTALLDIR/mgr/IRIS.WIJ \
 && rm -f $ISC_PACKAGE_INSTALLDIR/mgr/iris.ids \
 && rm -f $ISC_PACKAGE_INSTALLDIR/mgr/alerts.log \
 && rm -f $ISC_PACKAGE_INSTALLDIR/mgr/journal/* \
 && rm -f $ISC_PACKAGE_INSTALLDIR/mgr/messages.log

RUN echo $COMMIT_ID > $HOME/commit.txt
