Java POM for easy POM definition and inheritance


# Requirements

- Apache Maven 3+

# Setup

Install the POM
```shell
$ mvn -P library install
```

# Updating
```shell
# Check for Maven Plugin updates
$ mvn versions:display-plugin-updates
# Check for Maven Dependency updates
$ mvn versions:display-dependency-updates
```


# Using it

Once this Parent POM is inside the Maven local repository or a Maven Registry, 
child projects can inherit it.

Add this to their `pom.xml` file:

```xml
<parent>
    <groupId>io.github.cardin</groupId>
    <artifactId>parent-pom</artifactId>
    <version>...</version>
</parent>
```

There are several configuration values in the `<properties>` section, 
feel free to overwrite as necessary by redefining it.

Example:
```xml
<properties>
    <property>
        <maven.compiler.source>17</maven.compiler.source>
    </property>
</properties>
```

Child projects can also utilise [profiles](#available-profiles) defined by the Parent POM.

## Available Profiles

### Default profile
`mvn <goal>`

Required Properties:
- `<cpRel>`
- `<mainClass>`

Purpose:
- enforces Java and Maven version check
- defines Maven plugin versions
- copies JAR dependencies to a classpath folder specified by property `cpRel`
- compiles the project into a lightweight JAR
    - which uses the fully qualified class name specified by property `mainClass`
    - with relative classpath specified by property `cpRel`
- includes JavaDocs in the JAR
- flags hardware classifiers in the JAR via `bannedClassifier`
  - to alert you of dependencies that are platform-specific

### `library` profile
`mvn -P library <goal>`

Meant for non-executable JARs.

It has the same behavior as the default profile, except it:

Purpose:
- does not copy JAR dependencies to a classpath folder, nor require the `cpRel` property
- does not require the `mainClass` (i.e., not executable)

### `uber` profile

Meant for compiling a standalone JAR with all dependencies embedded

It has the same behavior as the default profile, except it:

Required Properties:
- `<mainClass>`

Purpose:
- does not copy JAR dependencies to a classpath folder, nor require the `cpRel` property
- compiles a heavy, standalone JAR
    - all JAR dependencies will be embedded within it


# Deploying Offline

After you've inherited this POM and built a Java app, 
sometimes you want to deploy within an offline environment.

1. Go to an online environment
2. `git clone <url> <localDir>`
3. Build your Java app, but add this property `-D"maven.repo.local"=<dir>`
    - E.g. `mvn -Dmaven.repo.local=<dir> install`
    - You  might need `mvn -D"maven.repo.local"=<dir>` instead if you're on Windows
    - `<dir>` is where you define your temporary Maven local repository
4. Zip the Maven local repository, transfer it, and unzip it in the offline machine
    - You can unzip in the default location `~/.m2`
    - Or use the property `-Dmaven.repo.local=<dir>`
    - Or configure `<localRepository>` in Maven `settings.xml`
    - See https://maven.apache.org/settings.html
5. Configure your offline machine's Maven `settings.xml`
    - Set `<offline>true</offline>`
6. You will be able to build using Maven now
