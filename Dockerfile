# ====================BUILD STAGE======================

# BASE IMAGE
FROM eclipse-temurin:21-jdk-jammy AS builder

# SET WORKING DIRECTORY
WORKDIR /app

# COPY DEPENDENCY RELATED FILES
COPY pom.xml .
COPY mvnw .
COPY .mvn .mvn

# COPY CODE
COPY src src

# BUILD JAR
RUN chmod +x mvnw && ./mvnw clean package -DskipTests

# =================== RUNTIME STAGE=====================

# BASE IMAGE
FROM gcr.io/distroless/java21

# SET WORKING DIRECTORY
WORKDIR /app

# COPY JAR
COPY --from=builder /app/target/*.jar app.jar

# EXPOSE PORT
EXPOSE 8080

# RUN & SERVE APPLICATION
ENTRYPOINT ["java", "-jar", "app.jar"]
