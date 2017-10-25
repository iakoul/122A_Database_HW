-- Student ID:           name:              e-mail: 
-- Student ID:           name:              e-mail: 
-- Student ID:           name:              e-mail: 


USE cs122a;

DROP TABLE IF EXISTS `User`;

CREATE TABLE `User` (
  `bid` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `street` varchar(100) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `zipcode` int(11) DEFAULT NULL,
  `state` char(2) DEFAULT NULL
);

-- You need to adjust 'data.csv' to indicate the path where the actual file is.
-- (e.g., LOAD DATA LOCAL INFILE '/Users/xxx/Downloads/data.csv' into table User fields terminated by ',';
--        LOAD DATA LOCAL INFILE 'D:/data.csv' into table User fields terminated by ',';
--        LOAD DATA LOCAL INFILE 'D:\\data.csv' into table User fields terminated by ',';
-- Unless you do, you will see "Error Code: 2. File 'data.csv' not found (Errcode: 2 - No such file or directory."
LOAD DATA LOCAL INFILE 'data.csv' into table User fields terminated by ',';

-- Reset Query Cache
RESET QUERY CACHE;

-- Q1 - return the city and the number of users in that city
-- Put your query here


-- Q2 - create an index
-- Put your query here


-- Reset Query Cache
RESET QUERY CACHE;


-- Q1 - return the city and the number of users in that city
-- Put your Q1 query here again



-- The end of script
