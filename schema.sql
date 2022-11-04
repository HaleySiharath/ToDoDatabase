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

CREATE TABLE User (
    user_id INT NOT NULL AUTO_INCREMENT,
    username VARCHAR(20) NOT NULL UNIQUE,
    password VARCHAR(20) NOT NULL,
    email VARCHAR(20) NOT NULL,
    PRIMARY KEY (user_id)
);

CREATE TABLE List(
    list_id int NOT NULL AUTO_INCREMENT,
    user_id int NOT NULL,
    title VARCHAR(20) NOT NULL,
    description VARCHAR(50),
    PRIMARY KEY (list_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

CREATE TABLE Task(
    task_id int NOT NULL AUTO_INCREMENT,
    list_id int NOT NULL,
    title VARCHAR(50) NOT NULL,
    description VARCHAR(100),
    reminder DATE,
    due_date DATETIME,
    important BOOLEAN DEFAULT FALSE,
    completed BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (task_id),
    FOREIGN KEY (list_id) REFERENCES List(list_id)
);

CREATE TABLE Comment(
    comment_id int NOT NULL AUTO_INCREMENT,
    task_id int NOT NULL,
    content VARCHAR(100) NOT NULL,
    PRIMARY KEY (comment_id),
    FOREIGN KEY (task_id) REFERENCES Task(task_id)
);


CREATE TABLE Subtask(
    subtask_id int NOT NULL AUTO_INCREMENT,
    task_id int NOT NULL,
    priority smallint,
    description VARCHAR(50),
    completed BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (subtask_id),
    FOREIGN KEY (task_id) REFERENCES Task(task_id)
);

-- INSERTING DATA INTO DATABASE
INSERT INTO User(username, password, email) -- userid is incremented auto
VALUES  ('Tristan', 'secret password', 'telsener@uncc.edu'), -- 1 user_id
        ('Haley', 'password123', 'hsiharat@uncc.edu'),       -- 2 user_id
        ('Jason', 'PaSsWoRd456', 'jkhotsom@uncc.edu');       -- 3 user_id

INSERT INTO List(user_id, title, description)
VALUES  (1, 'Schoolwork', 'Assignemtns and Projects fo class'), 				  -- 1 list_id
        (1, 'Chores', 'Things that I need to get done arround the House'),        -- 2 list_id
        (2, 'To-Do', 'All of the things that I need to get done today'),          -- 3 list_id
        (3, 'UNCC-GameDevs', 'List of UNCC Game Devs Projects');                  -- 4 list_id

INSERT INTO Task(list_id, title, description, reminder, due_date, important, completed)
VALUES 
        -- 1 task_id
        (1,'Project: Sprint 1','create conceptual & logical design for database and populate with appropriate data', '2022-11-03', '2022-11-04 11:59:59',TRUE,FALSE),
        -- 2 task_id
        (1,'Section 4.1: HW','complete section 4.1 homework on MyLab','2022-11-03','2022-11-03 11:59:59',FALSE,TRUE),
        -- 3 task_id
        (2,'Clean Room','clean my room','2022-11-05','2022-11-06 10:00:00',FALSE,FALSE),
        -- 4 task_id
        (3,'Complete HW','Do all of my homework for my classes','2022-12-25','2022-12-25 11:59:00',TRUE,FALSE),
        -- 5 task_id
        (3,'Walk The Dog','Take the Dog for a walk','2022-11-03','2022-11-03 05:30:00',FALSE,FALSE),
        -- 6 task_id
        (3,'Grocery Shopping','Get groceries for the week','2022-11-03','2022-11-03 09:45:00',TRUE,FALSE),
        -- 7 task_id
        (4,'Sound Design for Game','complete the sound design for the game for the next game jam','2022-11-03','2022-11-05 11:59:59',TRUE,FALSE),
        -- 8 task_id
        (4,'Art for Game','complete the art for the game in time for the next game jam','2022-11-04','2022-11-05 11:59:59',FALSE,TRUE),
        -- 9 task_id
        (4,'Code for Game','complete the code for the game in time for the next game jam','2022-11-04','2022-11-05 11:59:59',TRUE,TRUE),
        -- 10 task_id
        (4,'Level design for Game','complete the level design for the game in time for the next game jam','2022-11-05','2022-11-05 11:59:59',TRUE,TRUE);

INSERT INTO Subtask(task_id, priority, description, completed)
VALUES  -- 1 subtask_id
        (1, NULL, 'Finish Schema file', FALSE),
        -- 2 subtask_id
        (1, NULL, 'Push to GitHub', FALSE),
        -- 3 subtask_id
        (1, NULL, 'Submit to Canvase', FALSE),
        -- 4 subtask_id
        (4, NULL, 'Design the sickest beat for 10 seconds', TRUE);

INSERT INTO Comment(task_id, content)
VALUES  -- 1 comment_id
        (3, 'Soccer game upcomming, get before the kids go to the game'),
        -- 2 comment_id
        (4, 'Meet Natalia there at 3:00 pm so that everything works out');


-- SELECT * FROM User;
-- SELECT * FROM List;
-- SELECT * FROM Task;
-- SELECT * FROM Subtask;
-- SELECT * FROM Comment;

-- Display all of user tables and how many tasks each table has
SELECT U.username as username, L.title as list, COUNT(*) as taks_count_per_table
FROM User U
INNER JOIN List L ON (L.user_id = U.user_id)
JOIN Task T ON (T.list_id = L.list_id)
GROUP BY U.user_id, L.list_id
ORDER BY U.user_id;


-- Display all subtasks of a given task
SELECT L.title as list, T.title as task, S.subtask_id, S.description as subtask
FROM List L 
INNER JOIN Task T ON (L.list_id = T.list_id)
INNER JOIN Subtask S ON (T.task_id = S.task_id)
ORDER BY T.task_id;


-- Display all completed task
SELECT L.title as list, T.title as completed_task, T.completed
FROM Task T
INNER JOIN List L ON (L.list_id = T.list_id)
WHERE T.completed = TRUE
ORDER BY T.list_id;