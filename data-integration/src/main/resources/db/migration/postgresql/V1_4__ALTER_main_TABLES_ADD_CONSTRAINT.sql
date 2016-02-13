ALTER TABLE person ADD CONSTRAINT gender_chk CHECK (LOWER(gender) ~ '[mf]');
ALTER TABLE person ADD CONSTRAINT shirt_size_chk CHECK (LOWER(shirt_size) ~ 'x*[sml]');
