CREATE SEQUENCE person_id_seq;
ALTER TABLE person ALTER COLUMN id SET DEFAULT nextval('person_id_seq');
ALTER SEQUENCE person_id_seq OWNED BY person.id;

CREATE SEQUENCE address_id_seq;
ALTER TABLE address ALTER COLUMN id SET DEFAULT nextval('address_id_seq');
ALTER SEQUENCE address_id_seq OWNED BY address.id;

CREATE SEQUENCE region_id_seq;
ALTER TABLE region ALTER COLUMN id SET DEFAULT nextval('region_id_seq');
ALTER SEQUENCE region_id_seq OWNED BY region.id;

CREATE SEQUENCE attendance_map_id_seq;
ALTER TABLE attendance_map ALTER COLUMN id SET DEFAULT nextval('attendance_map_id_seq');
ALTER SEQUENCE attendance_map_id_seq OWNED BY attendance_map.id;

CREATE SEQUENCE team_type_id_seq;
ALTER TABLE team_type ALTER COLUMN id SET DEFAULT nextval('team_type_id_seq');
ALTER SEQUENCE team_type_id_seq OWNED BY team_type.id;

CREATE SEQUENCE team_map_id_seq;
ALTER TABLE team_map ALTER COLUMN id SET DEFAULT nextval('team_map_id_seq');
ALTER SEQUENCE team_map_id_seq OWNED BY team_map.id;

CREATE SEQUENCE small_group_id_seq;
ALTER TABLE small_group ALTER COLUMN id SET DEFAULT nextval('small_group_id_seq');
ALTER SEQUENCE small_group_id_seq OWNED BY small_group.id;

CREATE SEQUENCE small_group_map_id_seq;
ALTER TABLE small_group_map ALTER COLUMN id SET DEFAULT nextval('small_group_map_id_seq');
ALTER SEQUENCE small_group_map_id_seq OWNED BY small_group_map.id;

CREATE SEQUENCE foodserving_map_id_seq;
ALTER TABLE foodserving_map ALTER COLUMN id SET DEFAULT nextval('foodserving_map_id_seq');
ALTER SEQUENCE foodserving_map_id_seq OWNED BY foodserving_map.id;

CREATE SEQUENCE sunday_school_class_type_id_seq;
ALTER TABLE sunday_school_class_type ALTER COLUMN id SET DEFAULT nextval('sunday_school_class_type_id_seq');
ALTER SEQUENCE sunday_school_class_type_id_seq OWNED BY sunday_school_class_type.id;

CREATE SEQUENCE sunday_school_map_id_seq;
ALTER TABLE sunday_school_map ALTER COLUMN id SET DEFAULT nextval('sunday_school_map_id_seq');
ALTER SEQUENCE sunday_school_map_id_seq OWNED BY sunday_school_map.id;

CREATE SEQUENCE child_map_id_seq;
ALTER TABLE child_map ALTER COLUMN id SET DEFAULT nextval('child_map_id_seq');
ALTER SEQUENCE child_map_id_seq OWNED BY child_map.id;

CREATE SEQUENCE song_id_seq;
ALTER TABLE song ALTER COLUMN id SET DEFAULT nextval('song_id_seq');
ALTER SEQUENCE song_id_seq OWNED BY song.id;

CREATE SEQUENCE song_tag_id_seq;
ALTER TABLE song_tag ALTER COLUMN id SET DEFAULT nextval('song_tag_id_seq');
ALTER SEQUENCE song_tag_id_seq OWNED BY song_tag.id;

CREATE SEQUENCE song_tag_map_id_seq;
ALTER TABLE song_tag_map ALTER COLUMN id SET DEFAULT nextval('song_tag_map_id_seq');
ALTER SEQUENCE song_tag_map_id_seq OWNED BY song_tag_map.id;

CREATE SEQUENCE worship_set_id_seq;
ALTER TABLE worship_set ALTER COLUMN id SET DEFAULT nextval('worship_set_id_seq');
ALTER SEQUENCE worship_set_id_seq OWNED BY worship_set.id;

CREATE SEQUENCE worship_set_map_id_seq;
ALTER TABLE worship_set_map ALTER COLUMN id SET DEFAULT nextval('worship_set_map_id_seq');
ALTER SEQUENCE worship_set_map_id_seq OWNED BY worship_set_map.id;
