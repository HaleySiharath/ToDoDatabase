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

CREATE TABLE Admin_User (
	admin_id INT NOT NULL AUTO_INCREMENT,
    username VARCHAR(20) NOT NULL UNIQUE,
    password VARCHAR(20) NOT NULL,
    email VARCHAR(20) NOT NULL,
    project_id INT UNIQUE,
    PRIMARY KEY (admin_id)
);

CREATE TABLE Project(
	team_id INT NOT NULL,
    project_id INT NOT NULL,
    role VARCHAR(30) NOT NULL,
    PRIMARY KEY (team_id, project_id),
  --  FOREIGN KEY (team_id) REFERENCES User(team_id),
	FOREIGN KEY (project_id) REFERENCES Admin_User(project_id)
);
SET FOREIGN_KEY_CHECKS=0;

CREATE TABLE User (
    user_id INT NOT NULL AUTO_INCREMENT,
    username VARCHAR(20) NOT NULL UNIQUE,
    password VARCHAR(20) NOT NULL,
    email VARCHAR(20) NOT NULL,
    team_id INT,
    PRIMARY KEY (user_id),
    FOREIGN KEY (team_id) REFERENCES Project(team_id)
);



CREATE TABLE Project_List(
	user_id int NOT NULL UNIQUE,
    project_id int NOT NULL,
    PRIMARY KEY (user_id),
    FOREIGN KEY (project_id) REFERENCES Project(project_id)
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

CREATE INDEX comment_index
ON Comment(comment_id, task_id);

CREATE TABLE Subtask(
    subtask_id int NOT NULL AUTO_INCREMENT,
    task_id int NOT NULL,
    priority smallint,
    description VARCHAR(50),
    completed BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (subtask_id),
    FOREIGN KEY (task_id) REFERENCES Task(task_id)
);

CREATE INDEX subtask_index
ON Subtask(subtask_id, task_id);

-- INSERTING DATA INTO DATABASE
INSERT INTO User(username, password, email, team_id) -- userid is incremented auto
VALUES  ('Tristan', 'secret password', 'telsener@uncc.edu', NULL), -- 1 user_id
        ('Haley', 'password123', 'hsiharat@uncc.edu', NULL),       -- 2 user_id
        ('Jason', 'PaSsWoRd456', 'jkhotsom@uncc.edu', NULL),       -- 3 user_id
        ('Darwin', 'Whathappen', 'dardar@gmail.com', 1),		   -- 4 user_id
        ('Goofy', 'Yonks', 'goofy@gmail.com', 1),		   		   -- 5 user_id
        ('Daffy', 'ILikeCarrots', 'daffyDuck1@gmail.com', 2),   	-- 6 user_id
        ('Donald', 'YESYES', 'donald@gmail.com', 1); 	 			-- 7 user_id

INSERT INTO Admin_User(username, password, email, project_id) -- userid is incremented auto
VALUES  ('Mone', 'passcode176', 'mone@corpirate.com', 1),		-- 1 admin_user
		('Thor', 'studfd', 'thor@corpirate.com', 2);		-- 1 admin_user

INSERT INTO Project(project_id, team_id, role)
VALUES	(1, 1, 'backend team'),										-- Project 1 team 1
		(1, 2, 'frontend team'),									-- Project 1 team 2
        (2, 1, 'stuff');											-- Project 2 team 1

INSERT INTO Project_List(user_id, project_id)
VALUES	(4, 1),
		(5, 1),
        (6, 1);
        
        
INSERT INTO List(user_id, title, description)
VALUES  (1, 'Schoolwork', 'Assignemtns and Projects fo class'), 				  -- 1 list_id
        (1, 'Chores', 'Things that I need to get done arround the House'),        -- 2 list_id
        (2, 'To-Do', 'All of the things that I need to get done today'),          -- 3 list_id
        (3, 'UNCC-GameDevs', 'List of UNCC Game Devs Projects'),                  -- 4 list_id
        (4, 'Backend tasks', 'Complete all of the backend for the website'),	  -- 5 list_id
		(5, 'Backend tasks', 'Complete all of the backend for the website'),	  -- 6 list_id
		(6, 'Frontend tasks', 'Complete all of the fronted for the website');	  -- 7 list_id
  

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
        (4,'Level design for Game','complete the level design for the game in time for the next game jam','2022-11-05','2022-11-05 11:59:59',TRUE,TRUE),

		(5,'CRUD Post','Make the CRUD element for posts','2022-11-04','2022-11-05 11:59:59',FALSE,TRUE),
        -- 11 task_id
        (5,'Database','make the interworking database','2022-11-04','2022-11-05 11:59:59',TRUE,TRUE),
        -- 12 task_id
        (5,'Password concept','Allow for password access using salt and peper','2022-11-05','2022-11-05 11:59:59',TRUE,TRUE),
		-- 13 task_id
        (6,'Login page','Make the login page pretty','2022-11-04','2022-11-05 11:59:59',FALSE,TRUE),
        -- 14 task_id
        (6,'Design interface','Make a base sketch for the whole application','2022-11-04','2022-11-05 11:59:59',TRUE,TRUE);
        -- 15 task_id

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




-- Display the list of users on a project and what roles they are assigned
SELECT U.username as teamUser, P.project_id as projectId, P.role as projectRole
FROM Project P
INNER JOIN User U on (U.team_id = P.team_id)
INNER JOIN Admin_User A on (A.project_id = P.project_id);

-- Display the tasks of a user who is in project 1 and team 1
SELECT P.project_id as Project, P.team_id as Team, T.title as Tasks
FROM Project P
INNER JOIN Project_List PL on (PL.project_id = P.project_id)
INNER JOIN List L on (PL.user_id = L.user_id)
INNER JOIN Task T on (T.list_id = L.list_id)
ORDER BY P.project_id;

-- Display the number of people on a team
SELECT P.project_id as Project, P.team_id as Team, COUNT(*)
FROM Project P
INNER JOIN User U ON (U.team_id = P.team_id)
INNER JOIN Admin_User A ON (A.project_id = P.project_id)
GROUP BY P.project_id
ORDER BY P.project_id, U.team_id;


