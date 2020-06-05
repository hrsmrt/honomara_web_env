ALTER TABLE after_participant    ADD CONSTRAINT FOREIGN KEY (person_id)       REFERENCES person(id);
ALTER TABLE after_participant    ADD CONSTRAINT FOREIGN KEY (after_id)        REFERENCES after(id);
ALTER TABLE training_participant ADD CONSTRAINT FOREIGN KEY (person_id)       REFERENCES person(id);
ALTER TABLE training_participant ADD CONSTRAINT FOREIGN KEY (training_id)     REFERENCES training(id);
ALTER TABLE course               ADD CONSTRAINT FOREIGN KEY (competition_id)  REFERENCES competition(id);
ALTER TABLE race                 ADD CONSTRAINT FOREIGN KEY (course_id)         REFERENCES course(id);
ALTER TABLE result               ADD CONSTRAINT FOREIGN KEY (race_id)           REFERENCES race(id);
ALTER TABLE race_participant     ADD CONSTRAINT FOREIGN KEY (person_id)         REFERENCES person(id);
ALTER TABLE race_participant     ADD CONSTRAINT FOREIGN KEY (result_id)         REFERENCES result(id);
ALTER TABLE ekiden_race          ADD CONSTRAINT FOREIGN KEY (ekiden_competition_id)   REFERENCES ekiden_competition(id);
ALTER TABLE ekiden_team          ADD CONSTRAINT FOREIGN KEY (ekiden_race_id)    REFERENCES ekiden_race(id);
ALTER TABLE ekiden_result        ADD CONSTRAINT FOREIGN KEY (ekiden_team_id)    REFERENCES ekiden_team(id);
ALTER TABLE ekiden_result        ADD CONSTRAINT FOREIGN KEY (person_id)         REFERENCES person(id);