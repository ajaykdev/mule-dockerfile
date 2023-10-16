# Build mule 4 image from parent image 
FROM openjdk:8

# Remove the app folder
RUN rm -rf app
RUN mkdir app

# Add Mule runtime to the Docker container
RUN echo "Adding Mule distribution zip file to Docker container" 
ADD mule-ee-distribution-standalone-4.4.0-20230522.zip /app

# Add Work Directory
RUN echo "**Adding Work Directory**"
WORKDIR /app

# Extract the Mule runtime in the container and rename Mule 4 home folder. 
RUN echo "**Extracting the zip file and installing the Mule 4 runtime**" 
RUN unzip mule-ee-distribution-standalone-4.4.0-20230522.zip && \
        mv mule-enterprise-standalone-4.4.0-20230522 mule4 && \
        rm mule-ee-distribution-standalone-4.4.0-20230522.zip

# Define volume mount points
RUN echo "**Mounting volume**" 
VOLUME ["/app/mule4/logs", "/app/mule4/apps", "/app/mule4/domains"]

# Expose the HTTP port 8081
EXPOSE  8081
EXPOSE  8082

# Starting Mule 4 runtime
RUN echo "**Starting Mule runtime 4.4.0**"
CMD ["mule4/bin/mule"]