/*
Aaron Zhong - 67737879 - alzhong@uci.edu
Andy Le     - 70829342 -  andyl8@uci.edu
Tina Li     - 92928656 -  tinal7@uci.edu
*/

DROP DATABASE IF EXISTS `cs122a`;
CREATE DATABASE `cs122a`;
USE `cs122a`;

-- Table structure for `Persons`
DROP TABLE IF EXISTS `Persons`;
CREATE TABLE `Persons` (
  `PID` int(11) NOT NULL,
  `first_name` varchar(45),
  `last_name` varchar(45),
  PRIMARY KEY(PID)
);

-- Table structure for table `Buildings`
DROP TABLE IF EXISTS `Buildings`;
CREATE TABLE `Buildings` (
  `BID` int(11) NOT NULL,
  `name` varchar(45),
  `street` varchar(100),
  `city` varchar(45),
  `state` varchar(45),
  `zipcode` int(5),
  PRIMARY KEY (`BID`)
);


-- Table structure for table `LocationObjects`
DROP TABLE IF EXISTS `LocationObjects`;
CREATE TABLE `LocationObjects` (
  `LOID` int(11) NOT NULL,
  `BID` int(11) NOT NULL,
  `floor` varchar(3),
  `lower_left_x` int(3),
  `lower_left_y` int(3),
  `upper_right_x` int(3),
  `upper_right_y` int(3),
  PRIMARY KEY (LOID),
  FOREIGN KEY(BID) REFERENCES Buildings(BID)
);

-- Table structure for table `Rooms`
DROP TABLE IF EXISTS `Rooms`;
CREATE TABLE `Rooms` (
  `LOID` int(11) NOT NULL,
  `capacity` int(3),
  `number` int(3),
  FOREIGN KEY(LOID) REFERENCES LocationObjects(LOID)
);

-- Table structure for `Cooridors`
DROP TABLE IF EXISTS `Cooridors`;
CREATE TABLE `Corridors` (
  `LOID` int(11) NOT NULL,
  FOREIGN KEY(LOID) REFERENCES LocationObjects(LOID)
);

-- Table structure for `OpenAreas`
DROP TABLE IF EXISTS `OpenAreas`;
CREATE TABLE `OpenAreas` (
  `LOID` int(11) NOT NULL,
  FOREIGN KEY(LOID) REFERENCES LocationObjects(LOID)
);

-- Table structure for `Offices`
DROP TABLE IF EXISTS `Offices`;
CREATE TABLE `Offices` (
  `LOID` int(11) NOT NULL,
  FOREIGN KEY(LOID) REFERENCES Rooms(LOID)
);

-- Table structure for `MeetingRooms`
DROP TABLE IF EXISTS `MeetingRooms`;
CREATE TABLE `MeetingRooms` (
  `LOID` int(11) NOT NULL,
  FOREIGN KEY(LOID) REFERENCES Rooms(LOID)
);


-- Table structure for table `SensorsPlatforms`
DROP TABLE IF EXISTS `SensorsPlatforms`;
CREATE TABLE `SensorsPlatforms` (
  `SPID` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (SPID)
);


-- Table structure for table `Sensors`
DROP TABLE IF EXISTS `Sensors`;
CREATE TABLE `Sensors` (
  `SID` int(11) NOT NULL,
  `SPID` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (SID),
  FOREIGN KEY (SPID) REFERENCES SensorsPlatforms(SPID)
);

-- Table structure for table `MobilePlatforms`
DROP TABLE IF EXISTS `MobilePlatforms`;
CREATE TABLE `MobilePlatforms` (
  `real_time` bool,
  `MPID` int(11) NOT NULL,
  FOREIGN KEY (MPID) REFERENCES SensorsPlatforms(SPID)
);


-- Table structure for table `FixedPlatforms`
DROP TABLE IF EXISTS `FixedPlatforms`;
CREATE TABLE `FixedPlatforms` (
  `FPID` int(11) NOT NULL,
  FOREIGN KEY (FPID) REFERENCES SensorsPlatforms(SPID)
);


-- Table structure for table `ImageSensors`
DROP TABLE IF EXISTS `ImageSensors`;
CREATE TABLE `ImageSensors` (
  `IID` int(11) NOT NULL,
  `resolution` varchar(45),
  FOREIGN KEY (IID) REFERENCES Sensors(SID)
);
  
-- Table structure for `TemperatureSensors`
DROP TABLE IF EXISTS `TemperatureSensors`;
CREATE TABLE `TemperatureSensors` (
  `TID` int(11) NOT NULL,
  `metric_system` real,
  FOREIGN KEY (TID) REFERENCES Sensors(SID)
);

-- Table structure for `GPSSensors` 	
DROP TABLE IF EXISTS `GPSSensors`;
CREATE TABLE `GPSSensors` (
  `GPSID` int(11) NOT NULL,
  `power` real,
  FOREIGN KEY (GPSID) REFERENCES Sensors(SID)
);

-- Table structure for `LocationSensors`
DROP TABLE IF EXISTS `LocationSensors`;
CREATE TABLE `LocationSensors` (
  `LID` int(11) NOT NULL,
  `real_time` time,
  FOREIGN KEY (LID) REFERENCES Sensors(SID)
);

-- Table structure for `Events`
DROP TABLE IF EXISTS `Events`;
CREATE TABLE `Events` (
  `EID` int(11) NOT NULL,
  `LOID` int(11) NOT NULL,
  `PID` int(11) NOT NULL,
  `activity` varchar(45),
  `confidence` real,
  PRIMARY KEY (EID),
  FOREIGN KEY (LOID) REFERENCES LocationObjects(LOID),
  FOREIGN KEY (PID) REFERENCES Persons(PID)
);

-- Table structure for `Observations`
DROP TABLE IF EXISTS `Observations`;
CREATE TABLE `Observations` (
  `OID` int(11) NOT NULL,
  `EID` int(11) NOT NULL,
  PRIMARY KEY (OID, EID),
  FOREIGN KEY (EID) REFERENCES Events(EID)
);

-- Table structure for `RawImage`
DROP TABLE IF EXISTS `RawImage`;
CREATE TABLE `RawImage` (
  `EID` int(11) NOT NULL,
  `OID` int(11) NOT NULL,
  `IID` int(11) NOT NULL,
  `image` varchar(100),
  PRIMARY KEY (IID),
  FOREIGN KEY (IID) REFERENCES ImageSensors(IID),
  FOREIGN KEY (OID) REFERENCES Observations(OID),
  FOREIGN KEY (EID) REFERENCES Events(EID)
);

-- Table structure for `RawTemperature`
DROP TABLE IF EXISTS `RawTemperature`;
CREATE TABLE `RawTemperature` (
  `EID` int(11) NOT NULL,
  `OID` int(11) NOT NULL,
  `TID` int(11) NOT NULL,
  `temperature` real,
  PRIMARY KEY (TID),
  FOREIGN KEY (TID) REFERENCES TemperatureSensors(TID),
  FOREIGN KEY (OID) REFERENCES Observations(OID),
  FOREIGN KEY (EID) REFERENCES Events(EID)
);

-- Table structure for `RawGPS`
DROP TABLE IF EXISTS `RawGPS`;
CREATE TABLE `RawGPS` (
  `EID` int(11) NOT NULL,
  `OID` int(11) NOT NULL,
  `GPSID` int(11) NOT NULL,
  `longitude` real,
  `latitude` real,
  PRIMARY KEY (GPSID),
  FOREIGN KEY (GPSID) REFERENCES GPSSensors(GPSID),
  FOREIGN KEY (OID) REFERENCES Observations(OID),
  FOREIGN KEY (EID) REFERENCES Events(EID)
);

  
-- Tables for Relationships
DROP TABLE IF EXISTS `CollectImage`;
CREATE table `CollectImage` (
  `OID` int(11) NOT NULL,
  `EID` int(11) NOT NULL,
  `timestamp` datetime,
  FOREIGN KEY (OID) REFERENCES RawImage(OID),
  FOREIGN KEY (EID) REFERENCES RawImage(EID)
);

DROP TABLE IF EXISTS `CollectTemperature`;
CREATE table `CollectTemperature` (
  `OID` int(11) NOT NULL,
  `EID` int(11) NOT NULL,
  `timestamp` datetime,
  FOREIGN KEY (OID) REFERENCES RawImage(OID),
  FOREIGN KEY (EID) REFERENCES RawImage(EID)
);
      
DROP TABLE IF EXISTS `CollectGPS`;
CREATE table `CollectGPS` (
  `OID` int(11) NOT NULL,
  `EID` int(11) NOT NULL,
  `timestamp` datetime,
  FOREIGN KEY (OID) REFERENCES RawImage(OID),
  FOREIGN KEY (EID) REFERENCES RawImage(EID)
);

