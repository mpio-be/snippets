

CREATE DATABASE SNIPPETS;
CREATE TABLE repo (
  ID          int(11)      NOT NULL AUTO_INCREMENT COMMENT 'query ID',
  snippet     text,
  lang        varchar(10)  DEFAULT NULL COMMENT 'R, SQL, python, bash',
  author      varchar(50)  DEFAULT NULL COMMENT 'who saved the snippet',
  description varchar(255) DEFAULT NULL COMMENT 'write a few keywords; perhaps useful for identifying the script latter on. ',
  PRIMARY KEY (ID)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='R, SQL, python, bash, ... snippets repository '


CREATE USER 'snipuser'@'%' ;
UPDATE mysql.user SET Password=PASSWORD('*******') WHERE User='snipuser' AND Host='%' ;
GRANT Alter,Delete,Create, Drop, Create view,Insert,Select,Show view,Trigger,Update,References  ON SNIPPETS.* TO 'snipuser'@'%' ;
GRANT Select, Execute ON *.* TO 'snipuser'@'%' ;

FLUSH PRIVILEGES;

# save to ~/.my.cnf
[snippets]
database=SNIPPETS
host=scidb.mpio.orn.mpg.de
user=snipuser
password=*******


# install run_snippets() on cron (see scidbadmin)

