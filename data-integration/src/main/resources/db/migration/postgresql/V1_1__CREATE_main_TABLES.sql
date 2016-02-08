CREATE TABLE person (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(32),
  last_name VARCHAR(32),
  email VARCHAR(64),
  phone_number VARCHAR(16),
  image TEXT,
  birthdate DATE,
  gender VARCHAR(1) CHECK (LOWER(gender) ~ '[mf]'),
  shirt_size VARCHAR(4) CHECK (LOWER(shirt_size) ~ 'x*[sml]'),
  membership_date DATE,
  address_id INTEGER,
  region_id INTEGER,
  is_member BOOLEAN,
  created_date DATE DEFAULT CAST(clock_timestamp() AS DATE),
  marital_status VARCHAR(8) CHECK (LOWER(marital_status) IN ('single', 'married', 'dating'))
);


/*
 A 1:1 mapping of a person and their address.
 It's separated from the person table because
 addresses are highly optional and the fields
 are can get very long.
 */
CREATE TABLE address (
  id SERIAL PRIMARY KEY,
  person_id INTEGER REFERENCES person(id) ON UPDATE CASCADE ON DELETE CASCADE,
  address_line_1 VARCHAR(47),
  address_line_2 VARCHAR(47),
  city VARCHAR(50),
  state VARCHAR(2) DEFAULT 'CA',
  zip_code INT,
  plus_four_code INT,
  UNIQUE (person_id)
);


/*
 A 1:1 mapping of a region's name and its id;
 See the insert statement for possible range
 of values.
 */
CREATE TABLE region (
  id SERIAL PRIMARY KEY,
  region_name VARCHAR(20)
);

INSERT INTO region (region_name) VALUES
  (UNNEST(ARRAY['South Bay', 'South City', 'Peninsula', 'San Francisco', 'East Bay']))
;


/*
 A mapping of a member to their (Sunday) attendance
 for attendance tracking.
 */
CREATE TABLE attendance_map (
  id SERIAL PRIMARY KEY,
  person_id INTEGER REFERENCES person(id) ON UPDATE CASCADE ON DELETE CASCADE,
  for_date DATE DEFAULT CAST(clock_timestamp() AS DATE) -  CAST(EXTRACT(DOW FROM clock_timestamp()) AS INT),
  insert_date DATE DEFAULT clock_timestamp()
);


/*
 A 1:1 mapping of a team type and its id;
 See the insert statement for possible range
 of values.
 */
CREATE TABLE team_type (
  id SERIAL PRIMARY KEY,
  team_type VARCHAR(16)
);

INSERT INTO team_type (team_type) VALUES
  (UNNEST(ARRAY['AV', 'Events', 'Welcome', 'Worship', 'Member care', 'Sunday school']))
;


/*
 A mapping of a member to their team(s), and
 leadership designation.
 */
CREATE TABLE team_map (
  id SERIAL PRIMARY KEY,
  person_id INTEGER REFERENCES person(id) ON UPDATE CASCADE ON DELETE CASCADE,
  team_type_id INTEGER REFERENCES team_type(id) ON UPDATE CASCADE ON DELETE CASCADE,
  is_leader BOOLEAN
);


/*
 Small group information.
 */
CREATE TABLE small_group (
  id SERIAL PRIMARY KEY,
  leader_id INTEGER REFERENCES person(id) ON UPDATE CASCADE ON DELETE CASCADE,
  start_date DATE NOT NULL,
  end_date DATE,
  region_id INTEGER REFERENCES region(id) ON UPDATE CASCADE ON DELETE CASCADE
);


/*
 A mapping of a member to their small
 group(s) of the past, present, and future.
 */
CREATE TABLE small_group_map (
  id SERIAL PRIMARY KEY,
  person_id INTEGER REFERENCES person(id) ON UPDATE CASCADE ON DELETE CASCADE,
  small_group_id INTEGER REFERENCES small_group(id) ON UPDATE CASCADE ON DELETE CASCADE
);


/*
 A mapping of a member to when they are
 serving food.
 */
CREATE TABLE foodserving_map (
  id SERIAL PRIMARY KEY,
  person_id INTEGER REFERENCES person(id) ON UPDATE CASCADE ON DELETE CASCADE,
  serve_date DATE,
  is_lunch BOOLEAN DEFAULT FALSE
);


/*
 A 1:1 mapping of a Sunday school class type
 and its id; see the insert statement for
 possible range of values.
 */
CREATE TABLE sunday_school_class_type (
  id SERIAL PRIMARY KEY,
  class_type VARCHAR(16)
);

INSERT INTO sunday_school_class_type (class_type) VALUES
  (UNNEST(ARRAY['toddler', 'nursery']))
;


/*
 A mapping of a member to when they are
 serving for Sunday school.
 */
CREATE TABLE sunday_school_map (
  id SERIAL PRIMARY KEY,
  serve_date DATE,
  class_type_id INTEGER REFERENCES sunday_school_class_type(id) ON UPDATE CASCADE ON DELETE CASCADE,
  is_teacher BOOLEAN
);


/*
 A mapping of a child to their parent(s).
 TODO: improve this
 */
CREATE TABLE child_map (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(32),
  last_name VARCHAR(32),
  parent_1_id INTEGER REFERENCES person(id) ON DELETE CASCADE ON UPDATE CASCADE,
  parent_2_id INTEGER REFERENCES person(id) ON DELETE SET NULL ON UPDATE SET NULL
);


/*
 Worship song information.
 */
CREATE TABLE song (
  id SERIAL PRIMARY KEY,
  title VARCHAR(64),
  added_date DATE DEFAULT CAST(clock_timestamp() AS DATE),
  bpm INTEGER
);


/*
 Song tag information.
 */
CREATE TABLE song_tag (
  id SERIAL PRIMARY KEY,
  tag_name VARCHAR(64)
);


/*
 A mapping of a song to its tag(s).
 */
CREATE TABLE song_tag_map (
  id SERIAL PRIMARY KEY,
  song_id INTEGER REFERENCES song(id) ON DELETE CASCADE ON UPDATE CASCADE,
  song_tag_id INTEGER REFERENCES song_tag(id) ON DELETE CASCADE ON UPDATE CASCADE
);


/*
 A mapping of a worship set to its leader.
 */
CREATE TABLE worship_set (
  id SERIAL PRIMARY KEY,
  for_date DATE,
  leader_id INTEGER REFERENCES person(id) ON DELETE CASCADE ON UPDATE CASCADE
);


/*
 A mapping of a worship set to its songs.
 */
CREATE TABLE worship_set_map (
  id SERIAL PRIMARY KEY,
  song_id INTEGER REFERENCES song(id) ON DELETE CASCADE ON UPDATE CASCADE,
  worship_set_id INTEGER REFERENCES worship_set(id) ON DELETE CASCADE ON UPDATE CASCADE
);
