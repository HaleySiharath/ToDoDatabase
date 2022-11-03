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
    user_id int NOT NULL,
    username VARCHAR(20) NOT NULL UNIQUE,
    password VARCHAR(20) NOT NULL,
    email VARCHAR(20) NOT NULL,
    PRIMARY KEY (user_id)
);

CREATE TABLE List(
    list_id int NOT NULL,
    user_id int NOT NULL,
    title VARCHAR(20) NOT NULL,
    description VARCHAR(20),
    PRIMARY KEY (list_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

CREATE TABLE Comment(
    comment_id int NOT NULL PRIMARY KEY,
    task_id int NOT NULL,
    content VARCHAR(50) NOT NULL,
    order int NOT NULL,
    PRIMARY KEY (comment_id)
    FOREIGN KEY (task_id) REFERENCES Task(task_id)
);

CREATE TABLE Task(
    task_id int NOT NULL
    list_id int FOREIGN KEY REFERENCES List(list_id),
    title VARCHAR(20) NOT NULL,
    description VARCHAR(20),
    reminder DATE,
    due_date DATETIME,
    important BOOLEAN,
    completed BOOLEAN
);

CREATE TABLE Subtask(
    subtask_id int NOT NULL PRIMARY KEY,
    task_id int FOREIGN KEY REFERENCES Task(task_id),
    priority smallint,
    description VARCHAR(20),
    completed BOOLEAN
);

-- INSERTING DATA INTO DATABASE
INSERT INTO User(id,username,password,email)
VALUES (1,'Tristan','secret password', 'telsener@uncc.edu'),
       (2,'Haley','password123','hsiharat@uncc.edu'),
       (3,'Jason','PaSsWoRd456','jkhotsom@uncc.edu');
       
INSERT INTO List(list_id,user_id,title,description)
VALUES (1,1,'Schoolwork','Assignemtns and Projects that I have for my classes'),
       (2,1,'Chores','Things that I need to get done arround the House'),
       (3,2'To-Do','All of the things that I need to get done today'),
       (4,3'UNCC-GameDevs','List of UNCC Game Devs Projects');
       
INSERT INTO Task(task_id,list_id,title,description,reminder,due_date,important,completed)
VALUES (1,1,'Project: Sprint 1','create conceptual & logical design for database and populate with appropriate data', '2022-11-03', '2022-11-04 11:59:59',TRUE,FALSE),
       (2,1,'Section 4.1: HW','complete section 4.1 homework on MyLab','2022-11-03',2022-11-03 11:59:59',FALSE,TRUE),
       (3,2,'Clean Room','clean my room','2022-11-05','2022-11-06 10:00:00',FALSE,FALSE),
       (4,3,'Complete HW','Do all of my homework for my classes','2022-12-25',2022-12-25 11:59:00',TRUE,FALSE),
       (5,3,'Walk The Dog','Take the Dog for a walk','2022-11-03','2022-11-03 05:30:00',FALSE,FALSE),
       (6,3,'Grocery Shopping','Get groceries for the week','2022-11-03','2022-11-03 09:45:00',TRUE,FALSE),
       (7,4,'Sound Design for Game','complete the sound design for the game for the next game jam','2022-11-03','2022-11-05 11:59:59',TRUE,FALSE),
       (8,4,'Art for Game','complete the art for the game in time for the next game jam','2022-11-04','2022-11-05 11:59:59',FALSE,TRUE),
       (9,4,'Code for Game','complete the code for the game in time for the next game jam','2022-11-04','2022-11-05 11:59:59',TRUE,TRUE),
       (10,4,'Level design for Game','complete the level design for the game in time for the next game jam','2022-11-05','2022-11-05 11:59:59',TRUE,TRUE);
       

