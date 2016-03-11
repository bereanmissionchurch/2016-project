package db.migration.mysql;

import db.migration.V1_5__SEED_main_TABLES_generic;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class V1_5__SEED_main_TABLES extends V1_5__SEED_main_TABLES_generic {

    @Override
    public void executeQueries(Connection connection) throws SQLException {
        System.out.println("helli");
        try (PreparedStatement statement = connection.prepareStatement("SELECT 2;")) {
            statement.execute();
        }
    }

}
