FROM tomcat:8.5.38-jre8

ARG CATALINA_BASE
ARG GIT_COMMIT
ENV GIT_COMMIT ${GIT_COMMIT}
# for vim and less
ENV TERM vt100

COPY ./target/bloomreach_base-distribution-with-development-data.tar.gz /tmp/

# Update Tomcat OS
#  RUN apt-get update && \
#      apt-get upgrade -y && \
#      if [ $MODE = 'debug' ] ; then apt-get install tcpdump telnet strace procps ; fi && \
#      apt autoremove && \
#      apt-get clean && \
#      rm -rf /var/lib/apt/lists/* && \
#     # remove standard tomcat webapps
RUN rm -Rf ${CATALINA_BASE}/webapps/* && \
    # unpack files
    tar -xf /tmp/bloomreach_base-distribution-with-development-data.tar.gz -C $CATALINA_BASE && \
    rm -f /tmp/bloomreach_base-distribution-with-development-data.tar.gz && \
    # Download mysql connector file
    chown -R root:root ${CATALINA_BASE}/* && \
    curl -sL http://search.maven.org/remotecontent?filepath=mysql/mysql-connector-java/5.1.40/mysql-connector-java-5.1.40.jar -o ${CATALINA_BASE}/lib/mysql-connector-java-5.1.40.jar

# set environment variables in setenv.sh
RUN echo CATALINA_OPTS=\"${CATALINA_OPTS} -DMAIN_IP=$(hostname -I) -DMYSQL_HOST=\$\{BLOOMREACH_DB_HOST\} -DELASTIC_HOST=\$\{ELASTICSEARCH_HOST\} \
    -Drepo.bootstrap=false -Drepo.config=file:\$\{CATALINA_BASE\}/conf/repository.xml \
#   -Dhippo.scheduler.disabled=true && \
    -Dlog4j.configurationFile=${CATALINA_BASE}/conf/log4j2.xml\" >> ${CATALINA_BASE}/bin/setenv.sh && \
    echo 'export CATALINA_OPTS' >> ${CATALINA_BASE}/bin/setenv.sh

# CMD ["catalina.sh", "run", "-security"]

CMD ["catalina.sh", "run"]
