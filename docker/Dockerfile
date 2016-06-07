FROM microsoft/aspnet:1.0.0-rc1-update1

RUN printf "deb http://ftp.us.debian.org/debian jessie main\n" >> /etc/apt/sources.list
RUN apt-get -qq update \
 	&& apt-get install -y \
 		python-pip \
 		nodejs npm \
 		vim \
   	&& apt-get clean -y \
 	&& rm -rf /var/lib/apt/lists/

RUN /usr/bin/pip install supervisor
RUN mkdir -p /etc/supervisord/supervisord.d/
RUN mkdir -p /var/log/supervisord/

COPY src/OdeToFood/package.json /app/package.json
WORKDIR /app
RUN ["npm", "install"]
RUN ln -s /usr/bin/nodejs /usr/bin/node

# Adding dependencies before adding the rest of the source,
# prevents changes to source incurring a restore of dependencies
COPY src/OdeToFood/project.json /app/project.json
RUN ["dnu", "restore"]

COPY src/OdeToFood/gulpfile.js /app/gulpfile.js
COPY docker/supervisord.conf /etc/supervisord.conf

COPY src/OdeToFood /app/

EXPOSE 4000/tcp

# Run supervisord from an absolute path by specifying a "-c"
# argument to the configuration file.
ENTRYPOINT ["supervisord", "-c", "/etc/supervisord.conf"]
