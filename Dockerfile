FROM ubuntu:14.04
MAINTAINER Bryce Gibson "bryce.gibson@unico.com.au"

RUN apt-get update && apt-get upgrade -y && apt-get install -y openjdk-7-jre-headless fontconfig curl
ENV SELENIUM_VERSION 2.42
ENV SELENIUM_MINOR_VERSION 2
RUN curl http://selenium-release.storage.googleapis.com/${SELENIUM_VERSION}/selenium-server-standalone-${SELENIUM_VERSION}.${SELENIUM_MINOR_VERSION}.jar -o /opt/selenium-server-standalone.jar

ENV PHANTOMJS_VERSION 1.9.7
RUN curl https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-${PHANTOMJS_VERSION}-linux-x86_64.tar.bz2 -o /tmp/phantomjs.tar.bz2 -L && (cd /opt/ ; tar xvjf /tmp/phantomjs.tar.bz2 ; )
RUN ln -s /opt/phantomjs-$PHANTOMJS_VERSION-linux-x86_64/bin/phantomjs /usr/bin/phantomjs

EXPOSE 4444
CMD java -jar /opt/selenium-server-standalone.jar -role hub & while ! nc -vz localhost 4444; do sleep 1; done; /usr/bin/phantomjs --webdriver=5555 --webdriver-selenium-grid-hub=http://localhost:4444
