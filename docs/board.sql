CREATE TABLE `board` (
    `id`    int(100) NOT NULL AUTO_INCREMENT,
    `author`    tinytext    NOT NULL,
    `todate`    datetime    NOT NULL    DEFAULT '0000-00-00 00:00:00',
    `modidate`    datetime   NULL    DEFAULT '0000-00-00 00:00:00',
  	`title`  varchar(300) NULL,
    `content`   text     NULL,
    `passwd`  varchar(30) NULL,
    `parent` int(100) NULL,
    `type` varchar(20) NULL,
    `indent` int(100) NULL DEFAULT 0,
    `step` int(100) NULL DEFAULT 0,
    `sort` int(100) NULL DEFAULT 0,
    `status` varchar(100) NULL,
    primary key(id)
);

CREATE TABLE `comment` (
    `id`    int(100) NOT NULL AUTO_INCREMENT,
    `author`    tinytext    NOT NULL,
    `todate`    datetime    NOT NULL    DEFAULT '0000-00-00 00:00:00',
    `modidate`    datetime   NULL    DEFAULT '0000-00-00 00:00:00',
  	`title`  varchar(300) NULL,
    `content`   text     NULL,
    `passwd`  varchar(30) NULL,
    `parent` int(100) NULL,
    primary key(id)
);


CREATE TABLE `account` (
	`id` int (100) NOT NULL AUTO_INCREMENT,
    `userid` varchar(15) NOT NULL,
    `userpasswd` varchar(30) NOT NULL,
    primary key(id)
);
