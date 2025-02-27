# Используем официальный образ OpenJDK 21 с Maven
FROM maven:3.8.6-openjdk-21-slim AS build

# Устанавливаем рабочую директорию внутри контейнера
WORKDIR /app

# Копируем исходный код и pom.xml
COPY pom.xml .
COPY src ./src

# Собираем проект
RUN mvn clean package -DskipTests

# Используем официальный образ OpenJDK 21 для запуска приложения
FROM openjdk:21-jdk-slim

# Устанавливаем рабочую директорию внутри контейнера
WORKDIR /app

# Копируем JAR-файл из этапа сборки
COPY --from=build /app/target/OnlineStore2-0.0.1-SNAPSHOT.jar app.jar

# Открываем порт, на котором будет работать приложение
EXPOSE 8080

# Команда для запуска приложения
ENTRYPOINT ["java", "-jar", "app.jar"]