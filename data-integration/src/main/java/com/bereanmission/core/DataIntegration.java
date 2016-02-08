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
public class DataIntegration {

    private static final String configFile = "config.properties";
    private static final String databaseType = "postgresql";
    private Logger logger;
    private Flyway flyway;


    // constructor
    public DataIntegration() {
        // initialize some object variables
        logger = Logger.getLogger(DataIntegration.class.getName());
        Properties configProperties = new Properties();
        Properties flywayProperties = new Properties();
        flyway = new Flyway();

        try {
            // seed from config.properties
            configProperties.load(DataIntegration.class.getClassLoader().getResourceAsStream(configFile));

            // configure Flyway properties based on databaseType
            flywayProperties.setProperty(
                    "flyway.url",
                    String.format(
                        "jdbc:%s://%s:%s/%s",
                        databaseType,
                        configProperties.getProperty(databaseType + ".host"),
                        configProperties.getProperty(databaseType + ".port"),
                        configProperties.getProperty(databaseType + ".database")
                    )
            );
            flywayProperties.setProperty("flyway.user", configProperties.getProperty(databaseType + ".username"));
            flywayProperties.setProperty("flyway.password", configProperties.getProperty(databaseType + ".password"));
            flywayProperties.setProperty("flyway.schemas", configProperties.getProperty("flyway.schema"));
            flywayProperties.setProperty("flyway.schemas", configProperties.getProperty("flyway.schema"));
            flywayProperties.setProperty("flyway.locations", flyway.getLocations()[0] + "/" + databaseType);
            logger.debug(String.format("Flyway properties: %s", flywayProperties));
            flyway.configure(flywayProperties);
        } catch (IOException ex) {
            logger.error(String.format("Error loading config properties from %s", configFile), ex);
        }
    }

    /*
      Executes FlywayDB sub-routines through options passed in as a
      Array<String>, where the String element mirrors FlywayDB
      options; multiple options will be executed in array order
     */
    public void execute(String[] args) {
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

    public static void main(String[] args) {
        DataIntegration dataIntegration = new DataIntegration();
        dataIntegration.execute(args);
    }
}
