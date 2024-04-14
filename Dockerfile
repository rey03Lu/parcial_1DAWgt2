#FROM maven:3.9.6-eclipse-temurin-17-focal
#COPY target/crud-0.0.1-SNAPSHOT.jar java-app.jar
#ENTRYPOINT ["java", "-jar", "java-app.jar"]

FROM maven:3.9.6-eclipse-temurin-17-focal AS builder

WORKDIR /app

COPY pom.xml .

RUN mvn dependency:go-offline

COPY src src

RUN mvn clean package -DskipTests

FROM openjdk:17-jdk-slim

COPY --from=builder /app/target/crud-0.0.1-SNAPSHOT.jar java-app.jar

ENTRYPOINT ["java", "-jar", "java-app.jar"]