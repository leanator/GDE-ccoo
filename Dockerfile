from gde-base-server-java8:latest

RUN mkdir -p /usr/local/tomcat/ROOT
RUN mkdir -p /usr/local/tomcat/logs/config
#COPY lib/log4j.properties /usr/local/tomcat/logs/config/
COPY alive.html /usr/local/tomcat/webapps/ROOT/alive.html
COPY index.jsp /usr/local/tomcat/webapps/ROOT/index.jsp

## tener un modelo de context.xml

## todos los modulos requieren los siguientes resources y environment variables

COPY context.xml /usr/local/tomcat/conf/context.xml

## Se deben propagar los drivers y librerias de mail y BBDD (Previamente propagados a los servers o adquiridos) (ojdbc6.jar, ucp.jar, mail-1.4.jar)
#RUN rm -Rf /usr/local/tomcat/conf/logging.properties
COPY jars/* /usr/local/tomcat/lib/
COPY lib/*  /usr/local/tomcat/lib/
ARG VAR_URI_NEXUS
ARG VAR_VERSION_MODULO
ARG VAR_NOMBRE_ARTEFACTO
ENV VAR_NOMBRE_ARTEFACTO=${VAR_NOMBRE_ARTEFACTO}
ENV VAR_VERSION_MODULO=${VAR_VERSION_MODULO}
ENV VAR_URI_NEXUS=${VAR_URI_NEXUS}

COPY deployScript/deploy.sh /usr/local/tomcat/bin/

RUN sh -x /usr/local/tomcat/bin/deploy.sh $VAR_URI_NEXUS $VAR_VERSION_MODULO $VAR_NOMBRE_ARTEFACTO

#COPY webapps/*.war /usr/local/tomcat/webapps/ccoo-web.war

RUN localedef -c -f UTF-8 -i en_US en_US.UTF-8
RUN localedef -c -f UTF-8 -i es_AR es_AR.UTF-8
ENV LANG es_AR.UTF-8

EXPOSE 8080 443
CMD ["catalina.sh", "run"]
