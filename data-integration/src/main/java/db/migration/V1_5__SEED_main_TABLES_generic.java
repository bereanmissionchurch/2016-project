package db.migration;

import com.google.common.base.Preconditions;
import org.flywaydb.core.api.migration.jdbc.JdbcMigration;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;

public abstract class V1_5__SEED_main_TABLES_generic implements JdbcMigration {

    protected static String databaseType;
    protected static String inFile;

    public V1_5__SEED_main_TABLES_generic() {
        Preconditions.checkNotNull(databaseType, "Failed dependency injection check");
        Preconditions.checkNotNull(inFile, "Failed dependency injection check");
    }

    public abstract void execute(Connection connection) throws SQLException;

    public void migrate(Connection connection) throws Exception {
        execute(connection);
    }

    public static void inject(Properties configProperties) {
        databaseType = configProperties.getProperty("database.type");
        inFile = configProperties.getProperty("import.csv.filepath");
    }

}
