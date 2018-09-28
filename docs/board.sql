CREATE TABLE `board` (
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
