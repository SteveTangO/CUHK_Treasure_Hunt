/*
 Module to initialize the MySQL database
 
 Module Name: DatabaseInit
 Programmer: Hon Tik TSE
 Version: 1.0 (10 May 2020)
 
 Input Parameters:
    None
 
 Output Parameters:
    None
 */
 
-- Delete database if database exists
DROP DATABASE IF EXISTS treasure_hunt;
-- Create database
CREATE DATABASE treasure_hunt;
USE treasure_hunt;

-- Table colleges: store all the colleges in CUHK
CREATE TABLE colleges (
	college_id tinyint unsigned NOT NULL AUTO_INCREMENT,
    college char(2) NOT NULL,
    PRIMARY KEY (college_id)
);
INSERT INTO colleges VALUES (DEFAULT, "CC");
INSERT INTO colleges VALUES (DEFAULT, "CW");
INSERT INTO colleges VALUES (DEFAULT, "MC");
INSERT INTO colleges VALUES (DEFAULT, "NA");
INSERT INTO colleges VALUES (DEFAULT, "SC");
INSERT INTO colleges VALUES (DEFAULT, "SH");
INSERT INTO colleges VALUES (DEFAULT, "UC");
INSERT INTO colleges VALUES (DEFAULT, "WS");
INSERT INTO colleges VALUES (DEFAULT, "YS");
INSERT INTO colleges VALUES (DEFAULT, "--");

-- Table users: store users of the application
CREATE TABLE users (
	user_id mediumint unsigned NOT NULL AUTO_INCREMENT,
    username varchar(20) NOT NULL,
    student_id char(10) NOT NULL,
    password varchar(20) NOT NULL,
    college_id tinyint unsigned DEFAULT 10,
    year tinyint unsigned DEFAULT 0,
    dorm varchar(20) DEFAULT "--", -- foreign key, collect names of all dorms
    reputation decimal(6,5) DEFAULT -1,
    PRIMARY KEY (user_id),
    FOREIGN KEY (college_id) REFERENCES colleges(college_id)
);
INSERT INTO users VALUES (DEFAULT,'admin1','0000000000','admin1',10,0,'--',DEFAULT);
INSERT INTO users VALUES (DEFAULT, "admin2", '0000000001','admin2',6,2,'--',DEFAULT);
INSERT INTO users VALUES (DEFAULT, "admin3", '0000000002','admin3',6,2,'--',DEFAULT);
INSERT INTO users VALUES (DEFAULT, "admin4", '0000000003','admin4',6,2,'--',DEFAULT);
INSERT INTO users VALUES (DEFAULT, "admin5", '0000000004','admin5',6,2,'--',DEFAULT);

-- Table items: store all the items posted by users
CREATE TABLE items (
	item_id int unsigned NOT NULL AUTO_INCREMENT,
    poster_id mediumint unsigned NOT NULL,
    name varchar(30) NOT NULL,
    price double(6,1) NOT NULL,
    quantity smallint unsigned NOT NULL,
    description varchar(200) DEFAULT "",
    create_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    image varchar(150) NOT NULL DEFAULT "noImageUploaded.png",
    PRIMARY KEY (item_id),
    FOREIGN KEY (poster_id) REFERENCES users(user_id)
);
INSERT INTO items VALUES (DEFAULT, 1, 'homework coupon', 10000, 1, DEFAULT,DEFAULT,DEFAULT);
INSERT INTO items VALUES (DEFAULT, 1, 'coronavirus vaccine', 99999, 1, 'precious vaccine',DEFAULT,DEFAULT);
INSERT INTO items VALUES (DEFAULT, 2, 'plane ticket to chengdu', 4699, 2, 'cost me 5000 RMB',DEFAULT,DEFAULT);
INSERT INTO items VALUES (DEFAULT, 2, 'exam solution', 10000, 1, 'i know u want it',DEFAULT,DEFAULT);
INSERT INTO items VALUES (DEFAULT, 3, 'UGFH book', 10.0, 1, 'i don\'t wanna see it anymore',DEFAULT,DEFAULT);
INSERT INTO items VALUES (DEFAULT, 3, 'UGFN book', 10.0, 1, 'same',DEFAULT,DEFAULT);
INSERT INTO items VALUES (DEFAULT, 4, 'Expired Mask', 10.0, 1, 'still can be used',DEFAULT,DEFAULT);
INSERT INTO items VALUES (DEFAULT, 4, 'Used Lipstick', 100.0, 1, 'gross, oh i mean, gloss',DEFAULT,DEFAULT);
INSERT INTO items VALUES (DEFAULT, 5, 'Fingernail', 105.0, 1, 'if you wanna curse me, u know',DEFAULT,DEFAULT);
INSERT INTO items VALUES (DEFAULT, 5, 'Hair', 3.0, 1, 'good thing to have for cursing me',DEFAULT,DEFAULT);

-- Table transactions: store transactions created by users
CREATE TABLE transactions (
	transaction_id int unsigned NOT NULL AUTO_INCREMENT,
    status_s tinyint NOT NULL DEFAULT 0,
    status_b tinyint NOT NULL DEFAULT 0,
    seller_id mediumint unsigned NOT NULL,
    buyer_id mediumint unsigned NOT NULL,
    rating_s tinyint NOT NULL DEFAULT -1,  -- rating of s by b
    rating_b tinyint NOT NULL DEFAULT -1,  -- rating of b by s
    item_id int unsigned NOT NULL,
    price double(6,1) NOT NULL,
    quantity smallint unsigned NOT NULL,
    create_time datetime NOT NULL DEFAULT NOW(),
    PRIMARY KEY (transaction_id),
    FOREIGN KEY (seller_id) REFERENCES users (user_id),
    FOREIGN KEY (buyer_id) REFERENCES users (user_id),
    FOREIGN KEY (item_id) REFERENCES items (item_id)
);
INSERT INTO transactions VALUES(DEFAULT, DEFAULT, DEFAULT, 1, 2, DEFAULT, DEFAULT, 1, 2.2, 1, DEFAULT);
INSERT INTO transactions VALUES(DEFAULT, DEFAULT, DEFAULT, 1, 2, DEFAULT, DEFAULT, 1, 2.2, 1, DEFAULT);

-- Table favourites: store favourite items by each user
CREATE TABLE favourites ( -- create surrogate key to allow set null
	favourite_id int unsigned NOT NULL AUTO_INCREMENT,
	item_id int unsigned,
    user_id mediumint unsigned NOT NULL,
    PRIMARY KEY (favourite_id),
    FOREIGN KEY (item_id) REFERENCES items (item_id) ON DELETE SET NULL, -- notify user of the deletion
    FOREIGN KEY (user_id) REFERENCES users (user_id)
);
INSERT INTO favourites VALUES (DEFAULT, 1, 2);
INSERT INTO favourites VALUES (DEFAULT, 2, 2);
INSERT INTO favourites VALUES (DEFAULT, 3, 1);
INSERT INTO favourites VALUES (DEFAULT, 5, 2);
INSERT INTO favourites VALUES (DEFAULT, 9, 2);
INSERT INTO favourites VALUES (DEFAULT, 10, 2);
INSERT INTO favourites VALUES (DEFAULT, 8, 2);
INSERT INTO favourites VALUES (DEFAULT, 7, 3);
INSERT INTO favourites VALUES (DEFAULT, 8, 3);

-- Table messages: store messages sent between users
CREATE TABLE messages (
	message_id bigint unsigned NOT NULL AUTO_INCREMENT,
    sender_id mediumint unsigned NOT NULL,
    receiver_id mediumint unsigned NOT NULL,
    message varchar(200) NOT NULL,
    create_time datetime NOT NULL DEFAULT NOW(),
    PRIMARY KEY (message_id),
    FOREIGN KEY (sender_id) REFERENCES users (user_id),
    FOREIGN KEY (receiver_id) REFERENCES users (user_id)
);
INSERT INTO messages VALUES (DEFAULT,2,1,'i wanna buy ur vaccine',DEFAULT);
INSERT INTO messages VALUES (DEFAULT,1,2,'hv u got money',DEFAULT);
INSERT INTO messages VALUES (DEFAULT,2,1,'no...',DEFAULT);
INSERT INTO messages VALUES (DEFAULT,3,1,'i wanna buy ur vaccine too',DEFAULT);
INSERT INTO messages VALUES (DEFAULT,1,3,'too? how do u know???? wtf?',DEFAULT);
INSERT INTO messages VALUES (DEFAULT,1,2,'then piss off',DEFAULT);

-- Table buy_requests: store buy requests made by users
CREATE TABLE buy_requests ( -- create surrogate key to allow set null
	buy_request_id int unsigned NOT NULL AUTO_INCREMENT,
	item_id int unsigned,
    buyer_id mediumint unsigned NOT NULL,
    quantity smallint unsigned NOT NULL,
    PRIMARY KEY (buy_request_id),
    FOREIGN KEY (item_id) REFERENCES items (item_id) ON DELETE SET NULL, -- notify user of the deletion
    FOREIGN KEY (buyer_id) REFERENCES users (user_id)
);
INSERT INTO buy_requests VALUES (DEFAULT, 1, 2, 1);

-- Table tags: store all possible tags of items
CREATE TABLE tags (
	tag_id tinyint unsigned NOT NULL AUTO_INCREMENT,
    tag varchar(30) NOT NULL,
    PRIMARY KEY (tag_id)
);
INSERT INTO tags VALUES (DEFAULT, 'free');
INSERT INTO tags VALUES (DEFAULT, 'other');
INSERT INTO tags VALUES (DEFAULT, 'stationery');
INSERT INTO tags VALUES (DEFAULT, 'clothing');
INSERT INTO tags VALUES (DEFAULT, 'book');
INSERT INTO tags VALUES (DEFAULT, 'electric appliance');
INSERT INTO tags VALUES (DEFAULT, 'food');
INSERT INTO tags VALUES (DEFAULT, 'daily use');
INSERT INTO tags VALUES (DEFAULT, 'medical use');
INSERT INTO tags VALUES (DEFAULT, 'cosmetics');

-- Table item_tags: store the tags for each item
CREATE TABLE item_tags (
	item_id int unsigned NOT NULL,
    tag_id tinyint unsigned NOT NULL,
    PRIMARY KEY (item_id, tag_id),
    FOREIGN KEY (item_id) REFERENCES items(item_id) ON DELETE CASCADE,
    FOREIGN KEY (tag_id) REFERENCES tags (tag_id)
);
INSERT INTO item_tags VALUES (1, 1);
INSERT INTO item_tags VALUES (2, 9);
INSERT INTO item_tags VALUES (3, 2);
INSERT INTO item_tags VALUES (4, 8);
INSERT INTO item_tags VALUES (4, 5);
INSERT INTO item_tags VALUES (5, 5);
INSERT INTO item_tags VALUES (6, 5);
INSERT INTO item_tags VALUES (7, 9);
INSERT INTO item_tags VALUES (8, 10);
INSERT INTO item_tags VALUES (9, 2);
INSERT INTO item_tags VALUES (10, 2);
