FROM gradle:latest AS builder
VOLUME /tmp
WORKDIR /app
COPY . .
RUN ["gradle", "clean", "bootJar"]

FROM eclipse-temurin:17-jdk-alpine
COPY --from=builder /app/build/libs/*.jar /app/welcomeapp.jar
EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/welcomeapp.jar", "--spring.profiles.active=prod"]