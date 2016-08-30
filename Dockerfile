FROM tomcat:7.0
MAINTAINER Yogesh Golande

EXPOSE 8080
ENV TOMCAT_HOME=$CATALINA_HOME
#ADD https://github.com/yogeshgcpo/gcpdemo/blob/master/dist/gcpdemo.war $CATALINA_HOME/webapps/
ADD dist/gcpdemo.war $CATALINA_HOME/webapps/