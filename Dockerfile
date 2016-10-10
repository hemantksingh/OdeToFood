FROM microsoft/dotnet:latest

MAINTAINER iNivaran

RUN mkdir -p /opt/app/src

COPY global.json /opt/app/
# Adding dependencies before adding the rest of the source,
# prevents changes to source incurring a restore of dependencies
COPY src/OdeToFood/project.json opt/app/src/OdeToFood/

RUN cd /opt/app/src/OdeToFood \
	&& dotnet restore

COPY src/OdeToFood /opt/app/src/OdeToFood

EXPOSE 4000/tcp
WORKDIR /opt/app/src/OdeToFood
ENTRYPOINT ["dotnet", "run", "--server.urls=http://0.0.0.0:4000"]
