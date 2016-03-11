package db.migration.postgresql;

import com.google.common.base.Preconditions;
import org.flywaydb.core.api.migration.jdbc.JdbcMigration;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.Properties;

public class V1_5__SEED_main_TABLES implements JdbcMigration {

    private static String databaseType;
    private static String inFile;

    public V1_5__SEED_main_TABLES() {
        Preconditions.checkNotNull(databaseType, "Failed dependency injection check");
        Preconditions.checkNotNull(inFile, "Failed dependency injection check");
    }

    public void migrate(Connection connection) throws Exception {
        try (PreparedStatement statement = connection.prepareStatement("SELECT 2;")) {
            statement.execute();
        }
    }

    public static void inject(Properties configProperties) {
        databaseType = configProperties.getProperty("database.type");
        inFile = configProperties.getProperty("import.csv.filepath");
    }
}
