-- Include your create table DDL statements in this file.
-- Make sure to terminate each statement with a semicolon (;)

-- LEAVE this statement on. It is required to connect to your database.
CONNECT TO cs421;

-- Remember to put the create table ddls for the tables with foreign key references
--    ONLY AFTER the parent tables has already been created.

-- This is only an example of how you add create table ddls to this file.
--   You may remove it.

CREATE TABLE PEOPLE
(
    name VARCHAR(30) NOT NULL,
    gender CHAR(1) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    dob DATE NOT NULL,
    city VARCHAR(10) NOT NULL,
    postalcode VARCHAR(6) NOT NULL,
    streetaddress VARCHAR(30) NOT NULL,
    priority INTEGER NOT NULL,
    hinsurnum VARCHAR(12) NOT NULL,
    PRIMARY KEY(hinsurnum)
);

CREATE TABLE REGISTRATIONS
(
    rid VARCHAR(20) NOT NULL,
    dateReg DATE NOT NULL,
    PRIMARY KEY(rid)
);

CREATE TABLE APPOINTMENTS
(
    rid VARCHAR(20) NOT NULL,
    hinsurnum VARCHAR(12) NOT NULL,
    PRIMARY KEY(rid, hinsurnum),
    FOREIGN KEY(rid) references REGISTRATIONS(rid),
    FOREIGN KEY(hinsurnum) references PEOPLE(hinsurnum)
);

CREATE TABLE LOCATIONS
(
    lname VARCHAR(30) NOT NULL,
    npeople INTEGER,
    laddress VARCHAR(30) NOT NULL,
    lpostalcode VARCHAR(6) NOT NULL,
    ldate DATE,
    PRIMARY KEY(lname)
);

CREATE TABLE SLOTS
(
    lname VARCHAR(30) NOT NULL,
    vtime TIME NOT NULL,
    vslot INTEGER NOT NULL,
    amount INTEGER,
    PRIMARY KEY(lname, vtime, vslot),
    FOREIGN KEY(lname) REFERENCES LOCATIONS(lname)
);

CREATE TABLE HOSPITALS
(
    hname VARCHAR(30) NOT NULL,
    hstreetaddress VARCHAR(30) NOT NULL,
    hcity VARCHAR(10) NOT NULL,
    hpostalcode VARCHAR(6) NOT NULL,
    PRIMARY KEY(hname)
);

CREATE TABLE NURSES
(
    licensenum VARCHAR(12) NOT NULL,
    nursename VARCHAR(30) NOT NULL,
    hname VARCHAR(30) NOT NULL,
    PRIMARY KEY(licensenum),
    FOREIGN KEY(hname) REFERENCES HOSPITALS(hname)
);

CREATE TABLE WORKS
(
    lname VARCHAR(30) NOT NULL,
    licensenum VARCHAR(12) NOT NULL,
    PRIMARY KEY(lname, licensenum),
    FOREIGN KEY(lname) REFERENCES LOCATIONS(lname),
    FOREIGN KEY(licensenum) REFERENCES NURSES(licensenum)
);

CREATE TABLE ADMINS
(
    lname VARCHAR(30) NOT NULL,
    vtime TIME NOT NULL,
    vslot INTEGER NOT NULL,
    licensenum VARCHAR(12) NOT NULL,
    PRIMARY KEY(lname, vtime, vslot),
    FOREIGN KEY(lname, vtime, vslot) REFERENCES SLOTS(lname, vtime, vslot),
    FOREIGN KEY(licensenum) REFERENCES NURSES(licensenum)
);


CREATE TABLE VACCINES
(
    vname VARCHAR(30) NOT NULL,
    period INTEGER,
    numdoses INTEGER NOT NULL,
    PRIMARY KEY(vname)
);


CREATE TABLE SHOTS
(
    vialnum VARCHAR(8) NOT NULL,
    lname VARCHAR(30) NOT NULL,
    hinsurnum VARCHAR(12) NOT NULL,
    vname VARCHAR(30) NOT NULL,
    PRIMARY KEY(vialnum, lname),
    FOREIGN KEY(lname) REFERENCES LOCATIONS(lname),
    FOREIGN KEY(hinsurnum) REFERENCES PEOPLE(hinsurnum),
    FOREIGN KEY(vname) REFERENCES VACCINES(vname)
);

CREATE TABLE SHIPPINGS
(
    sid VARCHAR(20) NOT NULL,
    expirydate DATE NOT NULL,
    bnumber INTEGER NOT NULL,
    mdate DATE NOT NULL,
    vname VARCHAR(30) NOT NULL,
    lname VARCHAR(30) NOT NULL,
    PRIMARY KEY(sid),
    FOREIGN KEY(vname) REFERENCES VACCINES(vname),
    FOREIGN KEY(lname) REFERENCES LOCATIONS(lname)
);
