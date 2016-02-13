package com.bereanmission.core;

import org.apache.log4j.Logger;
import org.flywaydb.core.Flyway;

import java.io.IOException;
import java.util.Properties;

/**
 * Uses FlywayDB to migrate the underlying database.
 * Code is split into main() and a Java object to
 * facilitate JUnit testing.
 */
public class Migration {

    private static final String CONFIG_FILE = "config.properties";
    private static final String DEFAULT_DATABASE_TYPE = "postgresql";
    private static final String DEFAULT_DATABASE_SCHEMA = "production";
    private final Logger logger;
    private final Flyway flyway;


    // constructor
    public Migration() {
        // initialize some object variables
        logger = Logger.getLogger(Migration.class.getName());
        Properties configProperties = new Properties();
        Properties flywayProperties = new Properties();
        flyway = new Flyway();

        try {
            // seed environment variables from config.properties
            configProperties.load(Migration.class.getClassLoader().getResourceAsStream(CONFIG_FILE));
            configProperties.setProperty("database.type", configProperties.getProperty("database.type", DEFAULT_DATABASE_TYPE));
            configProperties.setProperty("database.schema", configProperties.getProperty("database.schema", DEFAULT_DATABASE_SCHEMA));
            String databaseType = configProperties.getProperty("database.type");

            // configure Flyway properties based on databaseType
            flywayProperties.setProperty(
                    "flyway.url",
                    String.format(
                            "jdbc:%s://%s:%s/%s?user=%s&password=%s",
                            databaseType,
                            configProperties.getProperty(databaseType + ".host"),
                            configProperties.getProperty(databaseType + ".port"),
                            configProperties.getProperty(databaseType + ".database"),
                            configProperties.getProperty(databaseType + ".username"),
                            configProperties.getProperty(databaseType + ".password")
                    )
            );
            flywayProperties.setProperty("flyway.schemas", configProperties.getProperty("database.schema"));
            flywayProperties.setProperty(
                    "flyway.locations",
                    "/db/migration/shared,/db/migration/" + configProperties.getProperty("database.type")
            );
            logger.debug(String.format("Flyway properties: %s", flywayProperties));
            flyway.configure(flywayProperties);
        } catch (IOException ex) {
            logger.error(String.format("Error loading config properties from %s", CONFIG_FILE), ex);
            System.exit(127);
        }
    }

    /*
      Executes FlywayDB sub-routines through options passed in as a
      Array<String>, where the String element mirrors FlywayDB
      options; multiple options will be executed in array order
     */
    protected void execute(String[] args) {
        if (args.length >= 1) {
            for (String arg: args) {
                logger.info(String.format("Executing step '%s'...", arg));
                switch (arg) {
                    case "migrate": flyway.migrate();
                        break;
                    case "info": logger.warn("'info' step not implemented");
                        break;
                    case "validate": flyway.validate();
                        break;
                    case "baseline": flyway.baseline();
                        break;
                    case "repair": flyway.repair();
                        break;
                    case "clean": flyway.clean();
                        break;
                    default: throw new IllegalArgumentException(
                            String.format(
                                    "Unexpected input argument '%s'; expecting (migrate|validate|clean|info|baseline|repair)",
                                    arg)
                    );
                }
            }
        } else {
            logger.info("Executing step 'migrate' [DEFAULT]");
            flyway.migrate();
        }
    }

}
