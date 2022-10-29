DROP DATABASE IF EXISTS ToDoDatabase;
CREATE DATABASE ToDoDatabase;
USE ToDoDatabase;

-- todo: create tables to store data

-- -- example:
-- CREATE TABLE userprofile(
--     user_id int NOT NULL AUTO_INCREMENT,
--     user_name varchar(255) NOT NULL UNIQUE,
--     user_password varchar(255) NOT NULL
-- );

CREATE TABLE User(
    user_id int NOT NULL AUTO_INCREMENT,
    user_name VARCHAR(20) NOT NULL UNIQUE,
    PRIMARY KEY (user_id)
);

CREATE TABLE List(
    list_id int NOT NULL AUTO_INCREMENT,
    user_id int NOT NULL,
    title VARCHAR(20) NOT NULL,
    PRIMARY KEY (list_id)
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

CREATE TABLE Comment(
    comment_id int NOT NULL AUTO_INCREMENT,
    task_id int NOT NULL,
    content VARCHAR(50) NOT NULL,
    order int NOT NULL,
    PRIMARY KEY (comment_id)
    FOREIGN KEY (task_id) REFERENCES Task(task_id)
);
