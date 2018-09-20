CREATE TABLE `board` (
    `id`    int(20) NOT NULL AUTO_INCREMENT,
    `author`    tinytext    NOT NULL,
    `todate`    datetime    NOT NULL    DEFAULT '0000-00-00 00:00:00',
    `modidate`    datetime   NULL    DEFAULT '0000-00-00 00:00:00',
	  `title`  varchar(20) NULL,
    `content`   text     NULL,
    `passwd`  varchar(20) NULL,
    primary key(id)
);
