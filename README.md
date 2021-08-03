Java POM for easy POM definition and inheritance

For more information on what this POM does, go to the [Available Profiles](#available-profiles) section.

# Recommended Tools

- AdoptOpenJDK 11 LTS
- Apache Maven 3+

# Setup

- Build the Project
    - `./build.sh`

## Running Offline

If you wish to build this in an offline environment

1. Git clone and build it in an online environment
2. Locate the Maven Local Repository
    - Use `mvn help:evaluate -Dexpression=settings.localRepository` if you need help
3. Copy the Local Repository to the offline environment's Maven Local Repository
4. Set your Maven `settings.xml` to `<offline>true</offline>`
    - See https://maven.apache.org/settings.html for settings' location

# Using it

Child projects should inherit this POM by adding this to their `pom.xml` file:

```xml
<parent>
    <groupId>info.utils</groupId>
    <artifactId>ParentPom</artifactId>
    <version>0.1</version>
</parent>
```

Child projects should ensure this POM is either installed inside the Maven Local Repo, or that they have access to a Maven Registry that
hosts this POM.

Child projects should define any needed Maven properties, for example:

```xml

<properties>
    <property>
        <mainClass>...</mainClass>
    </property>
</properties>
```

Child projects can then perform Maven actions such as compile (`mvn package`), install (`mvn -P library install`), etc.

## Checking for dependency updates
For checking plugin versions:
```shell
mvn versions:display-plugin-updates
```

For checking dependency versions:
```shell
mvn versions:display-dependency-updates
```

## Available Profiles

### Default profile

- enforces Java and Maven version check
- defines Maven plugin versions
- copies JAR dependencies to a folder specified by property `cpRel`
- compiles the project into a lightweight JAR
    - which uses the full class name specified by property `mainClass`
    - with relative classpath to JAR dependencies specified by property `cpRel`
- includes JavaDocs in the output

### `library` profile

Meant for non-executable JARs.

It has the same behavior as the default profile, except it:

- does not copy JAR dependencies to a folder, nor require the `cpRel` property
- does not require the `mainClass` (i.e., not executable)

### `uber` profile

Meant for compiling a standalone JAR with all dependencies embedded

It has the same behavior as the default profile, except it:

- does not copy JAR dependencies to a folder, nor require the `cpRel` property
- compiles a heavy, standalone JAR
    - all JAR dependencies will be embedded within it
    