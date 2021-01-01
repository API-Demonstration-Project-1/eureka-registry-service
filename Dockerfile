FROM maven:3.5.2-jdk-8-alpine AS MAVEN_BUILD
MAINTAINER proarchs
COPY pom.xml /build/
COPY src /build/src/
WORKDIR /build/
RUN mvn package
FROM openjdk:8-jre-alpine
WORKDIR /app
COPY --from=MAVEN_BUILD /build/target/eureka-registry-service-0.0.1-SNAPSHOT.jar /app/
ENV ENCRYPT_KEY=IMSYMMETRIC
ENTRYPOINT ["java", "-jar", "eureka-registry-service-0.0.1-SNAPSHOT.jar"]