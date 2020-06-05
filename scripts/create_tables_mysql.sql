CREATE TABLE IF NOT EXISTS person (
  `id`            INT          PRIMARY KEY AUTO_INCREMENT,
  `family_name`   VARCHAR(30)  NOT NULL,
  `family_kana`   VARCHAR(30),
  `first_name`    VARCHAR(30), 
  `first_kana`    VARCHAR(30),
  `show_name`     VARCHAR(30)  NOT NULL,
  `entrance_year` INT          NOT NULL,
  `gender`        VARCHAR(10),
  `visible`       BOOLEAN      NOT NULL DEFAULT true,
  INDEX (entrance_year, family_kana, first_kana)
);

CREATE TABLE IF NOT EXISTS training (
  `id`            INT           PRIMARY KEY AUTO_INCREMENT,
  `date`          DATE          NOT NULL,
  `type`          VARCHAR(30)   NOT NULL,
  `weather`       VARCHAR(30),
  `title`         TEXT          NOT NULL,
  `comment`       TEXT,
  INDEX (date),
  FULLTEXT (title) WITH PARSER ngram,
  FULLTEXT (comment) WITH PARSER ngram
);

CREATE TABLE IF NOT EXISTS restaurant (
  `id`            INT PRIMARY KEY AUTO_INCREMENT,
  `name`          VARCHAR(30) NOT NULL, -- TODO: change column name to `name`
  `place`         VARCHAR(30),
  `score`        FLOAT NOT NULL DEFAULT 0,
  `comment`       TEXT
);

CREATE TABLE IF NOT EXISTS after (
  `id`            INT PRIMARY KEY AUTO_INCREMENT,
  `date`          DATE NOT NULL,
  `after_stage`   INT NOT NULL DEFAULT 1,
  `restaurant_id` INT NOT NULL, -- FOREIGN KEY (`restaurant_id`) REFERENCES restaurant(`id`),
  `title`         TEXT NOT NULL,
  `comment`       TEXT,
  INDEX (`date`),
  FULLTEXT (title) WITH PARSER ngram,
  FULLTEXT (comment) WITH PARSER ngram
);

CREATE TABLE IF NOT EXISTS  after_participant (
  `person_id`      INT NOT NULL, -- FOREIGN KEY REFERENCES person(id)
  `after_id`      INT NOT NULL  -- FOREIGN KEY REFERENCES after(id)
);


CREATE TABLE IF NOT EXISTS  training_participant (
  `person_id`     INT NOT NULL, -- FOREIGN KEY REFERENCES person(id)
  `training_id`   INT NOT NULL  -- FOREIGN KEY REFERENCES training(id)
);


CREATE TABLE IF NOT EXISTS competition (
  `id`            INT PRIMARY KEY AUTO_INCREMENT,
  `name`         VARCHAR(60) NOT NULL,
  `kana`         VARCHAR(60),
  `show_name`    VARCHAR(60) NOT NULL,
  `place`        VARCHAR(30),
  `comment`      TEXT
);



CREATE TABLE IF NOT EXISTS course (
  `id`           INT PRIMARY KEY AUTO_INCREMENT,
  `competition_id` INT NOT NULL, -- FOREIGN KEY REFERENCES competition(id)
  `type`  VARCHAR(30) NOT NULL DEFAULT 'ロード', -- ['ロード', 'トラック', 'トレイル', '時間走', 'リレマラ']
  `show_name`    VARCHAR(30),
  `time`         INT,   -- running time in seconds for type 'time' or 'relay'
  `distance`     FLOAT, -- running distance in meter
  `elevation`    INT, -- cumulative elevation in meter
  `comment`      TEXT
);

CREATE TABLE IF NOT EXISTS race (
  `id`        INT PRIMARY KEY AUTO_INCREMENT,
  `course_id` INT NOT NULL, -- FOREIGN KEY REFERENCES course(id)
  `date`      DATE NOT NULL,
  `comment`   TEXT
);

CREATE TABLE IF NOT EXISTS result (
  `id`            INT PRIMARY KEY AUTO_INCREMENT,
  `race_id`       INT NOT NULL,      -- FOREIGN KEY REFERENCES race(id)
  `time`          INT, -- net time in mili seconds
  `distance`      INT, -- running distance
  `comment`       TEXT
);

CREATE TABLE IF NOT EXISTS race_participant (
  `result_id`     INT NOT NULL, -- FOREIGN KEY REFERENCES result(id)
  `person_id`     INT NOT NULL -- FOREIGN KEY REFERENCES person(id)
);


CREATE TABLE ekiden_competition (
  `id`            INT PRIMARY KEY AUTO_INCREMENT,
  `name`         VARCHAR(60),
  `kana`         VARCHAR(60),
  `show_name`    VARCHAR(60) NOT NULL,
  `place`        VARCHAR(30),
  `comment`      TEXT
);

CREATE TABLE ekiden_race (
  `id`                    INT PRIMARY KEY AUTO_INCREMENT,
  `ekiden_competition_id` INT NOT NULL, -- FOREIGN KEY REFERENCES ekiden_competition(id)
  `sections`              JSON NOT NULL,
  `date`                  DATE NOT NULL,
  `comment`               TEXT,
  INDEX (date)
);

CREATE TABLE ekiden_team (
  `id`              INT PRIMARY KEY AUTO_INCREMENT,
  `ekiden_race_id`  INT NOT NULL, -- FOREIGN KEY REFERENCES ekiden_race(id)
  `team_name`       VARCHAR(60) NOT NULL,
  `comment`         TEXT
);


CREATE TABLE ekiden_result (
  `ekiden_team_id`  INT NOT NULL,
  `section`         INT NOT NULL,
  `person_id`       INT NOT NULL,
  `time_gross`      INT NOT NULL,
  `comment`         TEXT
);
