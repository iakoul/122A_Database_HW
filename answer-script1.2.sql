DROP DATABASE IF EXISTS cs122a;
CREATE DATABASE cs122a;
USE cs122a;

--
-- PROBLEM 1.2a
--

CREATE TABLE Emp(
	eid int,
    ename varchar(100),
    age int,
	salary real,
    CHECK (salary < 10000)
    );

-- MySQL doesn't support SQL check constraint

-- Testing insert of employee w/ $10000 salary
INSERT INTO emp(eid, ename, age, salary) VALUES (1, 'jones', 33, 10000);

-- Testing insert of employee w/ $9999 salary
INSERT INTO emp(eid, ename, age, salary) VALUES (2, 'jack', 21, 9999);


--
-- PROBLEM 1.2b
--

-- Version which works w/ MySQL
CREATE TABLE Dept(
	did int,
    budget real,
    managerid int
	);
    
ALTER TABLE dept
ADD CHECK (Dept.managerid IN (SELECT Emp.eid FROM emp, dept WHERE emp.age > 30 AND emp.eid = dept.managerid));

/* SQL (in class version)
CREATE TABLE Dept(
	did int,
    budget real,
    managerid int,
    CHECK (Dept.managerid IN (SELECT Emp.eid FROM emp, dept WHERE emp.age > 30 AND emp.eid = dept.managerid))
	);
*/

-- MySQL doesn't support SQL check constraint
-- Testing insert of manager (jones, age 33) into dept 1
INSERT INTO dept(did, budget, managerid) VALUES (1, 10000, 1);

-- Testing insert of manager (jack, age 21) into dept 2
INSERT INTO dept(did, budget, managerid) VALUES (2, 10000, 2);

--
-- PROBLEM 1.2c
--

/* SQL (in class version) - DBMS DO NOT SUPPORT ASSERTS
CREATE ASSERTION OldManager CHECK
(NOT EXISTS
	(SELECT Emp.eid
    FROM emp, dept
    WHERE emp.age < 30 AND emp.eid = dept.managerid));
*/

--
-- PROBLEM 1.2d
--

/*
Assertion is better since it is not restricted a single relation that a check would normally validate.
Compared to a check, assertions detect changes on any/all relations mentioned in the assert and is always guaranteed to hold.
*/

--
-- PROBLEM 1.2e
--

/* SQL (in class version)
CREATE TRIGGER NoLowerAge
AFTER UPDATE ON emp
REFERENCING
	OLD AS OldTuple,
    NEW AS NewTuple
WHEN (OldTuple.age > NewTuple.age)
	UPDATE emp
    SET age = OldTuple.age
    WHERE name = NewTuple.name
FOR EACH ROW;
*/


-- Version which works with MySQL
DELIMITER //

DROP TRIGGER IF EXISTS NoLowerAge//
CREATE TRIGGER NoLowerAge 
BEFORE UPDATE ON emp
FOR EACH ROW 
	BEGIN
		IF NEW.age < OLD.age THEN
			SET NEW.age = OLD.age;
		END IF;
	END;//

DELIMITER ;

-- Testing lowering of age of employee (jones, age 33)
UPDATE emp SET emp.age = 18 WHERE emp.eid = 1;

-- Testing increasing of age of employee (jones, age 33)
UPDATE emp SET emp.age = 34 WHERE emp.eid = 1;

