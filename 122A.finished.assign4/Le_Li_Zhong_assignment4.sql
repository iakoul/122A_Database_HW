-- Member information
-- STUDENT ID: 70829342, NAME: Andy Le, E-MAIL andyl8@uci.edu:
-- STUDENT ID: 92928656, NAME: Tina Li, E-MAIL tinal7@uci.edu:
-- STUDENT ID: 67737879, NAME: Aaron Zhong, E-MAIL alzhong@uci.edu:

USE cs122a;

-- Q1: put your query here
SELECT person.firstname, person.lastname
FROM person JOIN ownerof JOIN sensorplatform
WHERE person.pid = ownerof.pid AND ownerof.spid = sensorplatform.spid AND person.lastname LIKE 'heia%nua';

-- Q2: put your query here
SELECT person.pid, person.lastname, person.firstname
	FROM person, participated, event
    WHERE person.pid = participated.pid AND participated.eid = event.eid AND event.activity = 'walking';

-- Q3: put your query here
SELECT floor, COUNT(*)
	FROM building, partof, room
    WHERE building.name = 'EH' AND building.bid = partof.bid AND partof.loid = room.loid AND room.capacity > 35
	GROUP BY partof.floor;

-- Q4: put your query here
SELECT abs(temperature1.temperature - temperature2.temperature) AS TemperatureDifference
	FROM (SELECT temperature
		  FROM rawtemperature
          WHERE tstamp=(SELECT max(tstamp) FROM rawtemperature WHERE sid = 1)) 
			AS temperature1,
		 (SELECT temperature
		  FROM rawtemperature
          WHERE tstamp=(SELECT max(tstamp) FROM rawtemperature WHERE sid = 2)) 
			AS temperature2;
  
-- Q5: put your query here
SELECT sensor.sid, name
	FROM sensor
    WHERE sensor.sid NOT IN (SELECT derivedfrom.sid FROM derivedfrom);

-- Q6: put your query here
SELECT sid, month(tstamp), COUNT(*)
	FROM rawtemperature
    WHERE year(tstamp) = '2015'
	GROUP BY sid, month(tstamp) 
UNION
SELECT sid, month(tstamp), COUNT(*)
	FROM rawimage
    WHERE year(tstamp) = '2015'
	GROUP BY sid, month(tstamp) 
UNION
SELECT sid, month(tstamp), COUNT(*)
	FROM rawgps
    WHERE year(tstamp) = '2015'
	GROUP BY sid, month(tstamp)
    ORDER BY sid;

-- Q7: put your query here
SELECT sid, AVG(temperature) as Average, MIN(tstamp), MAX(tstamp)
	FROM rawtemperature
    WHERE sid = 1 AND day(tstamp) = 1 AND month(tstamp)='1' AND year(tstamp)='2015'
	GROUP BY hour(tstamp);