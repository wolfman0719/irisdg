FROM store/intersystems/iris-community:2019.4.0.379.0

ARG COMMIT_ID="pgdemo"

USER irisowner

ENV ISC_TEMP_DIR=/intersystems/iris/
COPY PM $ISC_TEMP_DIR/PM
COPY solution $ISC_TEMP_DIR/solution
COPY solution/*.xml $ISC_PACKAGE_INSTALLDIR/mgr/user/

RUN  iris start $ISC_PACKAGE_INSTANCENAME \ 
&& printf 'Do ##class(Config.NLS.Locales).Install("jpuw") \
 Do ##class(%%EnsembleMgr).EnableNamespace("USER") \
 set sec = ##class("Security.Applications").%%OpenId("/csp/user") \
 set sec.DeepSeeEnabled = 1 \
 set sec.iKnowEnabled = 1 \
 set status = sec.%%Save() \
 set sec = ##class("Security.Applications").%%New() \
 set sec.Name = "/pm" \
 set sec.NameSpace = "USER" \
 set sec.DispatchClass ="PM.Broker" \
 set sec.AutheEnabled = 32 \
 set status = sec.%%Save() \
 set user = ##class(Security.Users).%%OpenId("_system") \
 set user.PasswordExternal = "demosystem" \
 set status = user.%%Save() \
 h\n' | iris session $ISC_PACKAGE_INSTANCENAME -U %SYS \ 
&& printf 'Do $system.OBJ.ImportDir("'$ISC_TEMP_DIR'/PM",,"ck",,1) \
 Set ^%%SYS("sql","sys","week ISO8601") = 1 \
 do ##class(PM.SetUp).Import("/intersystems/iris/solution/ken_all.csv") \
 do ##class(PM.SetUp).PopulateBasics() \
 do ##class(PM.SetUp).PopulateRelations() \
 do ##class(PM.SetUp).PopulateTransactions(1000) \
 do ##class(%%DeepSee.Utils).%%BuildCube("ProjectCube") \
 set ^UnitTestRoot = "/intersystems/iris/UnitTests" \
 h\n' | iris session $ISC_PACKAGE_INSTANCENAME -U USER \
 && iris stop $ISC_PACKAGE_INSTANCENAME quietly

USER root

RUN chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} $ISC_TEMP_DIR/
RUN chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} $ISC_TEMP_DIR/solution
RUN mkdir $ISC_TEMP_DIR/UnitTests
RUN mkdir $ISC_TEMP_DIR/UnitTests/JDate
RUN cp $ISC_TEMP_DIR/PM/jdate.xml $ISC_TEMP_DIR/UnitTests/JDate

USER irisowner

RUN rm -f $ISC_PACKAGE_INSTALLDIR/mgr/journal.log \
 && rm -f $ISC_PACKAGE_INSTALLDIR/mgr/IRIS.WIJ \
 && rm -f $ISC_PACKAGE_INSTALLDIR/mgr/iris.ids \
 && rm -f $ISC_PACKAGE_INSTALLDIR/mgr/alerts.log \
 && rm -f $ISC_PACKAGE_INSTALLDIR/mgr/journal/* \
 && rm -f $ISC_PACKAGE_INSTALLDIR/mgr/messages.log

RUN echo $COMMIT_ID > $HOME/commit.txt
