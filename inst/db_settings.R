

# alter table DBLOG.snippets rename SNIPPETS.repo
# ALTER TABLE SNIPPETS.repo ADD lang varchar(10) NULL after query ;
# ALTER TABLE SNIPPETS.repo CHANGE query snippet text CHARACTER SET utf8 COLLATE utf8_general_ci NULL ;
# ALTER TABLE SNIPPETS.repo MODIFY COLUMN author varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT 'who saved the snippet' ;
# ALTER TABLE SNIPPETS.repo MODIFY COLUMN description varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT 'write a few keywords; perhaps useful for identifying the script latter on. ' ;
# ALTER TABLE SNIPPETS.repo MODIFY COLUMN lang varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT 'R, SQL, python, bash' ;
# ALTER TABLE SNIPPETS.repo 
# COMMENT='R, SQL, python, bash, ... snippets repository ' ;
# update SNIPPETS.repo set lang = 'mysql'

CREATE TABLE repo (
  ID          int(11)      NOT NULL AUTO_INCREMENT COMMENT 'query ID',
  snippet     text,
  lang        varchar(10)  DEFAULT NULL COMMENT 'R, SQL, python, bash',
  author      varchar(50)  DEFAULT NULL COMMENT 'who saved the snippet',
  description varchar(255) DEFAULT NULL COMMENT 'write a few keywords; perhaps useful for identifying the script latter on. ',
  PRIMARY KEY (ID)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='R, SQL, python, bash, ... snippets repository '


CREATE USER 'snipuser'@'localhost' ;
UPDATE mysql.user SET Password=PASSWORD('resupins') WHERE User='snipuser' AND Host='localhost' ;
GRANT Alter,Delete,Create view,Insert,Select,Show view,Trigger,Update,References  ON SNIPPETS.repo TO 'snipuser'@'localhost' ;
FLUSH PRIVILEGES;

# save to ~/.my.cnf
[snippets]
database=SNIPPETS
user=snipuser
password=resupins


