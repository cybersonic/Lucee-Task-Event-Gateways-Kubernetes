FROM lucee/lucee:latest
# Set a default password. You can override this with --build-arg password=yourpassword
ARG password="password"
# We need these env variables to be set to connect to the redis server
ENV REDIS_SERVER_LOCAL_SERVICE_HOST=redis
ENV REDIS_SERVER_LOCAL_SERVICE_PORT=6379
# bc is a calculator so we can creaate CPU load
RUN apt-get update && apt-get install bc
# ADD the extensions
ADD https://ext.lucee.org/redis.extension-3.0.0.48.lex /opt/lucee/server/lucee-server/deploy/
ADD https://ext.lucee.org/lucee.tasks.extension-1.0.0.1.lex /opt/lucee/server/lucee-server/deploy/

# Copy the lucee config file. It has a cache and task event gateway setup
COPY ./config/lucee-web.xml.cfm /opt/lucee/web/lucee-web.xml.cfm
# Warm up the server
RUN LUCEE_ENABLE_WARMUP=true catalina.sh run
# Copy to the webroot
COPY ./www /var/www
# 
RUN echo $password > /opt/lucee/server/lucee-server/context/password.txt