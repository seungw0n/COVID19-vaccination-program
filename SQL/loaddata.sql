-- Include your INSERT SQL statements in this file.
-- Make sure to terminate each statement with a semicolon (;)

-- LEAVE this statement on. It is required to connect to your database.
CONNECT TO cs421;

-- Remember to put the INSERT statements for the tables with foreign key references
--    ONLY AFTER the parent tables!

-- This is only an example of how you add INSERT statements to this file.
--   You may remove it.


INSERT INTO PEOPLE(name, gender, phone, dob, city, postalcode, streetaddress, priority, hinsurnum) VALUES
 ('Steven Joeng', 'm', '15144348683', '10-17-1997', 'Montreal', 'H2X3R4', '350 Rue Prince Arthur O', 4, 'BOUF97101720'),
 ('Jack Lauv', 'm', '12343235324', '01-02-1980', 'Montreal', 'H2X3E2', '2257 Rue Saint O', 3, 'ABCD80010212'),
 ('Anne Hwang', 'f', '15142381929', '07-05-2019', 'Montreal', 'H2X3Q0', '123 ABC ST', 2,  'EFGD19070525'),
 ('Lilly Chang', 'f', '14482253975', '03-15-1939', 'Montreal', 'A2C3D1', '3395 Av du parc', 1, 'EFGQ39031520'),
 ('Jason Hwang', 'm', '12423235682', '05-05-1999', 'Montreal', 'A1D5Q2', 'ABCD STREET', 4, 'QKEK99050511'),
 ('Jane Doe', 'f', '18872341234', '05-05-1993', 'Montreal', 'ABCDEF', 'CDEF ST', 1, 'ABCD93050529'),
 ('Donna Mahe', 'f', '12593921245', '03-29-1990', 'MontVille', 'LKE23W', 'MY STREET', 2, 'EKQS90032977')
;

INSERT INTO REGISTRATIONS(rid, dateReg) VALUES
 ('RID00000000000000003', '02-21-2021'),
 ('RID00000000000000000', '01-01-2021'),
 ('RID00000000000000001', '01-02-2021'),
 ('RID00000000000000002', '01-09-2021'),
 ('RID00000000000000004', '01-15-2021'),
 ('RID00000000000000005', '01-19-2021')
;

INSERT INTO APPOINTMENTS(rid, hinsurnum) VALUES
 ('RID00000000000000003', 'BOUF97101720'),
 ('RID00000000000000000', 'ABCD80010212'),
 ('RID00000000000000001', 'EFGD19070525'),
 ('RID00000000000000002', 'EFGQ39031520'),
 ('RID00000000000000004', 'QKEK99050511'),
 ('RID00000000000000005', 'ABCD93050529')
;

INSERT INTO LOCATIONS(lname, npeople, laddress, lpostalcode, ldate) VALUES
 ('HealthCenter1', 150, '3374 Rue saint', 'H2X3R4', '01-21-2021'),
 ('HealthCenter2', 100, '1523 Rue Boulv', 'H2X3E2', '01-21-2021'),
 ('HealthCenter3', 75, '2812 Rue Alymor', 'H2X3Q0', '01-22-2021'),
 ('HealthCenter4', NULL,'2222 Rue blvd', 'A2C3D1', '02-25-2021'),
 ('HealthCenter5', NULL, '1234 Street', 'A2Q6E1', '03-09-2021'),
 ('Jewish General', 200, 'abc st', 'ABCDEF', '03-20-2021'),
 ('Special Center', 10, 'asdef st', 'QWER12', '02-06-2021'),
 ('HC0', 10, 'ASJFIO ST', 'H2X3R4', '02-06-2021')
;

INSERT INTO SLOTS(lname, vtime, vslot, amount) VALUES
 ('HealthCenter1', '11:00', 1, 20),
 ('HealthCenter1', '12:00', 1, 30),
 ('HealthCenter1', '12:00', 2, 30),
 ('HealthCenter1', '13:00', 1, 10),
 ('HealthCenter1', '13:00', 2, 20),
 ('HealthCenter1', '13:00', 3, 40),
 ('HealthCenter2', '08:30', 1, 50),
 ('HealthCenter2', '08:30', 2, 50),
 ('HealthCenter3', '14:25', 1, 10),
 ('HealthCenter3', '14:25', 2, 10),
 ('HealthCenter3', '14:25', 3, 10),
 ('HealthCenter3', '14:25', 4, 10),
 ('HealthCenter3', '14:25', 5, 10),
 ('HealthCenter3', '14:25', 6, 10),
 ('HealthCenter3', '16:25', 10, 15),
 ('Jewish General', '11:00', 1, 100),
 ('Jewish General', '11:30', 2, 100),
 ('Special Center', '08:30', 1, 10),
 ('HC0', '09:00', 1, 5),
 ('HC0', '09:30', 10, 5)
;

INSERT INTO HOSPITALS(hname, hstreetaddress, hcity, hpostalcode) VALUES
 ('Montreal General Hospital', '3625 Montreal Street', 'Montreal', 'H2X3R4'),
 ('AVC Children Hospital', '3622 general st', 'Montreal', 'Q23SF2'),
 ('Jewish General', '1234 Jewish st', 'Montreal', 'H2Q4W3'),
 ('Special Center in Montreal', 'ASpecial Street', 'Montreal', 'A2Q5W2'),
 ('Jewish General in LAVAL', '2456 Jewish st', 'LAVAL', 'J2Q2R2'),
 ('Special Center in LAVAL', 'mESpeicl Street', 'LAVAL', 'A2F1Q2')
 ;

INSERT INTO NURSES(licensenum, nursename, hname) VALUES
 ('ABCD12345678', 'Jennifer', 'Montreal General Hospital'),
 ('DEFG12345678', 'Kim', 'AVC Children Hospital'),
 ('ABCD11234512', 'Jack', 'Jewish General'),
 ('QWED12495211', 'Jimmy', 'Special Center in Montreal'),
 ('LAME12959391', 'A', 'Jewish General'),
 ('BNIE58292192', 'B', 'Jewish General'),
 ('EWNG59291929', 'C', 'Montreal General Hospital'),
 ('KWEQ21394952', 'D', 'Special Center in Montreal'),
 ('QWER24102952', 'E', 'Montreal General Hospital'),
 ('WEIR15243612', 'Daniel', 'Jewish General in LAVAL'),
 ('BOWK15929429', 'Amy', 'Special Center in LAVAL')
;

INSERT INTO WORKS(lname, licensenum) VALUES
 ('HealthCenter1', 'ABCD12345678'),
 ('HealthCenter1', 'DEFG12345678'),
 ('HealthCenter1', 'BOWK15929429'),
 ('HealthCenter2', 'QWED12495211'),
 ('HealthCenter2', 'WEIR15243612'),
 ('HealthCenter3', 'ABCD12345678'),
 ('HealthCenter3', 'DEFG12345678'),
 ('HealthCenter3', 'ABCD11234512'),
 ('HealthCenter3', 'QWED12495211'),
 ('HealthCenter3', 'WEIR15243612'),
 ('HealthCenter3', 'BOWK15929429'),
 ('HealthCenter4', 'ABCD12345678'),
 ('HealthCenter4', 'QWED12495211'),
 ('Jewish General', 'ABCD12345678'),
 ('Jewish General', 'BOWK15929429'),
 ('Special Center', 'QWED12495211'),
 ('HC0', 'ABCD12345678'),
 ('HC0', 'DEFG12345678')
;

INSERT INTO ADMINS(lname, vtime, vslot, licensenum) VALUES
 ('HealthCenter1', '11:00', 1, 'ABCD12345678'),
 ('HealthCenter1', '12:00', 1, 'DEFG12345678'),
 ('HealthCenter1', '12:00', 2, 'ABCD12345678'),
 ('HealthCenter1', '13:00', 1, 'BOWK15929429'),
 ('HealthCenter1', '13:00', 2, 'ABCD12345678'),
 ('HealthCenter1', '13:00', 3, 'DEFG12345678'),
 ('HealthCenter2', '08:30', 1, 'QWED12495211'),
 ('HealthCenter2', '08:30', 2, 'WEIR15243612'),
 ('HealthCenter3', '14:25', 1, 'ABCD12345678'),
 ('HealthCenter3', '14:25', 2, 'DEFG12345678'),
 ('HealthCenter3', '14:25', 3, 'WEIR15243612'),
 ('HealthCenter3', '14:25', 4, 'QWED12495211'),
 ('HealthCenter3', '14:25', 5, 'ABCD11234512'),
 ('HealthCenter3', '14:25', 6, 'BOWK15929429'),
 ('HealthCenter3', '16:25', 10, 'ABCD11234512'),
 ('Jewish General', '11:00', 1, 'ABCD12345678'),
 ('Jewish General', '11:30', 2, 'BOWK15929429'),
 ('Special Center', '08:30', 1, 'QWED12495211'),
 ('HC0', '09:00', 1, 'ABCD12345678'),
 ('HC0', '09:30', 10, 'DEFG12345678')
;

INSERT INTO VACCINES(vname, period, numdoses) VALUES
 ('Pfizer', 14, 2),
 ('BioNTech', 14, 2),
 ('Moderna', 14, 2),
 ('Favor', NULL, 1),
 ('Astra', 0, 3)
;


INSERT INTO SHOTS(vialnum, lname, hinsurnum, vname) VALUES
 ('VIAL0000', 'HealthCenter1', 'EFGQ39031520', 'Pfizer'),
 ('VIAL0002', 'HealthCenter1', 'ABCD80010212', 'Astra'),
 ('VIAL0003', 'HealthCenter1', 'ABCD80010212', 'Astra'),
 ('VIAL0004', 'HealthCenter1', 'BOUF97101720', 'BioNTech'),
 ('VIAL9999', 'Special Center', 'ABCD93050529', 'Pfizer'),
 ('VIAL1234', 'HC0', 'EKQS90032977', 'BioNTech')
;

INSERT INTO SHIPPINGS(sid, expirydate, bnumber, mdate, vname, lname) VALUES
 ('sid00000000000000000', '05-05-2021', 10, '02-10-2021', 'Pfizer', 'HealthCenter1'),
 ('sid00000000000000001', '05-06-2021', 60, '02-11-2021', 'Pfizer', 'HealthCenter1'),
 ('sid00000000000000002', '05-07-2021', 80, '02-13-2021', 'Astra', 'HealthCenter1'),
 ('sid00000000000000003', '06-03-2021', 60, '02-10-2021', 'BioNTech', 'HealthCenter2'),
 ('sid00000000000000004', '06-05-2021', 40, '02-15-2021', 'BioNTech', 'HealthCenter2'),
 ('sid00000000000000005', '09-01-2021', 75, '02-10-2021', 'Pfizer', 'HealthCenter3'),
 ('sid00000000000000006', '10-10-2022', 10, '02-10-2021', 'Pfizer', 'Special Center'),
 ('sid00000000000000007', '12-10-2023', 10, '01-09-2021', 'BioNTech', 'HC0')
;
