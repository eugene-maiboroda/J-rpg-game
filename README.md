# RPG Web Game

**RPG Web Game** is a pet project web application designed in the RPG style for managing player entities. Built using Java and Spring Framework, the application supports creating, updating, and deleting game objects through a combination of REST endpoints and JSP-based user interfaces. The project is deployed via Tomcat and does not use `web.xml`, relying instead on Java-based Spring configuration.

---

### Description

This application allows interaction with game players via both REST API and web interface. The user can:

* create new players via a POST JSON endpoint,
* view player lists via JSP,
* filter and delete players,
* validate user data (including date of birth restrictions),
* configure and launch the application in different Spring profiles (`prod`, `test`).

---

### Technologies Used

* Java 17+
* Spring Framework (MVC, Dependency Injection)
* Jackson (for JSON serialization/deserialization)
* Jakarta Servlet API (without `web.xml`)
* Tomcat 10.1+
* JSP (UI rendering)
* Maven (with `war:exploded` deployment)
* JDBC & SQL

---

### Configuration Highlights

* **No `web.xml`** — instead uses `MyWebAppInit.java`, which extends `AbstractAnnotationConfigDispatcherServletInitializer`.

  * Initializes `AppConfig` and `WebConfig` as Java configuration classes.
  * Launches with custom profile: `-Dspring.profiles.active=prod`

* **Tomcat Integration in IntelliJ IDEA:**

  * Port: 8080
  * Context: `/rpg-1.0-SNAPSHOT`
  * Deployment: `war exploded`

---

### REST API

* Base path: `/rest/players`
* Main controller: `PlayerController`

```java
@RestController
@RequestMapping("/rest/players")
public class PlayerController { ... }
```

* JSON POST request creates a `Player` using DTO `PlayerInfo`

---

### Validation Rules

The `createPlayer()` method restricts birth year to 2000–3000:

```java
if (year < 2000 || year > 3000) {
  return ResponseEntity.status(HttpStatus.BAD_REQUEST)...
}
```

---

### Static Resources & UI

Static assets are handled via `WebConfig.java`:

```java
@Override
public void addResourceHandlers(ResourceHandlerRegistry registry) {
    registry.addResourceHandler("/**").addResourceLocations("/resources/");
}
```

* Important: Correct path (`/resources/`) is necessary for JSP UI to function

---

### Known Issues & Fixes

* `400 Bad Request` if birthday is missing or out of valid range
* POST request fails unless correct JSON with required fields is sent:

```json
{
  "name": "Player1",
  "title": "Warrior",
  "race": "HUMAN",
  "profession": "WARRIOR",
  "birthday": 1234567890000,
  "experience": 1000
}
```

---

### How to Run

1. Configure Tomcat 10.1.11+ in IntelliJ IDEA

   * VM Option: `-Dspring.profiles.active=prod`
   * Artifact: `rpg:war exploded`

2. Launch Tomcat config

3. Open browser: [http://localhost:8080/rpg-1.0-SNAPSHOT/](http://localhost:8080/rpg-1.0-SNAPSHOT/)

---

### Database Initialization

In the root directory, you will find a file named `init.sql` that initializes the main production database (`rpg`) and populates it with default player data.

You must run this script to create:

* Database: `rpg`
* Table: `player`
* 40+ sample entries (across races and professions)

⚙️ Default JDBC configuration (can be customized in your `@Configuration` class):

```java
@Profile("prod")
@Bean
public DataSource dataSource() {
    DriverManagerDataSource dataSource = new DriverManagerDataSource();
    dataSource.setDriverClassName("com.mysql.cj.jdbc.Driver");
    dataSource.setUrl("jdbc:mysql://localhost:3306/rpg");
    dataSource.setUsername("spring");
    dataSource.setPassword("spring123");
    return dataSource;
}
```

You can modify the credentials and JDBC URL to match your local MySQL configuration.

🧪 For testing purposes, a separate `TestSQL.sql` file is located in `src/test/resources/`. This script initializes the `test` database and may be used independently from the production `init.sql`.

---

### Planned Improvements

* Move hardcoded config to `.properties` or `.yaml`
* Add Swagger UI for REST API documentation
* Enhance DTO validation via annotations
* Add flexible date handling and error messaging

---

> ✅ This project helped reinforce knowledge of Java EE architecture, Spring MVC configuration, JSP handling, and RESTful endpoint integration. It also included practice with raw JDBC, SQL scripting, profile-based configuration, and full-stack deployment.
