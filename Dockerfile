# Use OpenJDK base image
FROM openjdk:17-jdk-slim

# Copy the jar file
COPY target/dockerapp.jar app.jar

# Expose port 8082 (or any free port)
EXPOSE 8082

# Run the jar
ENTRYPOINT ["java","-jar","/app.jar"]
