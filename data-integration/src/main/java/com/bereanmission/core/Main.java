package com.bereanmission.core;

public class Main {
    public static void main(String[] args) {
        System.setProperty("org.jooq.no-logo", "true");
        Migration migration = new Migration();
        migration.execute(args);
    }
}
