# Use an official OpenJDK image with JDK as a parent image
FROM openjdk:11-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the Gradle files to the container
COPY build.gradle .
COPY settings.gradle .

# Copy the gradle wrapper files and download the dependencies
COPY gradlew .
COPY gradle gradle
RUN chmod +x gradlew
RUN ./gradlew dependencies

# Copy the application source code
COPY src src

# Build the application
RUN ./gradlew build

# Expose the port that the application will run on (assuming your Spring Boot app uses port 8080)
EXPOSE 8080

# Specify the command to run your Spring Boot application
CMD ["java", "-jar", "build/libs/spring-boot-app-0.0.1-SNAPSHOT.jar"]
