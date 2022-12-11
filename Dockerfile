FROM gradle:7.6.0-jdk19-alpine AS builder
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
COPY . /home/gradle/src/
RUN gradle build --no-daemon

FROM eclipse-temurin:19.0.1_10-jre AS back

WORKDIR /app

COPY --from=builder /home/gradle/src/build/libs/ /app

EXPOSE 8080
ENTRYPOINT ["java", "-jar","/app/back-0.0.1-SNAPSHOT.jar"]