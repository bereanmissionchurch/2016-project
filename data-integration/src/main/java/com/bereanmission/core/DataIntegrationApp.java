package com.bereanmission.core;

import org.apache.log4j.Logger;
import org.flywaydb.core.Flyway;

import java.io.IOException;
import java.util.Properties;

/**
 * Uses FlywayDB to migrate the underlying database.
 */
public class DataIntegrationApp {

    private static final String configFile = "config.properties";
    private static final String databaseType = "postgresql";

    public static void main(String[] args) {

        // initialize some instance variables
        Logger logger = Logger.getLogger(DataIntegrationApp.class.getName());
        Properties configProperties = new Properties();
        Properties flywayProperties = new Properties();
        Flyway flyway = new Flyway();

        try {
            // seed from config.properties
            configProperties.load(DataIntegrationApp.class.getClassLoader().getResourceAsStream(configFile));

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

            // TODO: add some gating logic on migrate()
            migrate(flyway);
        } catch (IOException ex) {
            logger.error(String.format("Error loading config properties from %s", configFile), ex);
        }
    }

    private static void migrate(Flyway flyway) {
        flyway.migrate();
    }
}
