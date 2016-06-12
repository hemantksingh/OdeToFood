FROM microsoft/aspnet:1.0.0-rc1-update1

WORKDIR /app

# Adding dependencies before adding the rest of the source,
# prevents changes to source incurring a restore of dependencies
COPY src/OdeToFood/project.json /app/project.json
RUN ["dnu", "restore"]

COPY src/OdeToFood /app/

EXPOSE 4000/tcp

ENTRYPOINT [ "dnx", "-p", "project.json", "web" ]
