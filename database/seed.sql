-- WheelSteal demonstration data for wheelsteal_corrected_schema.sql
-- Use only after creating the six tables in a fresh database.
-- Demo VINs are synthetic identifiers, not genuine manufacturer VINs.
USE `WheelSteal`;

INSERT INTO `body_type` VALUES (1,'Body Type',NULL),(2,'Car',1),(3,'SUV',1),(4,'Truck',1),(5,'Sedan',2),(6,'Hatchback',2),(7,'Coupe',2),(8,'Full-Size SUV',3),(9,'Mid-Size SUV',3),(10,'Compact SUV',3),(11,'Pickup',4),(12,'Heavy-Duty Pickup',4),(13,'Commercial Truck',4);

INSERT INTO `customer` (`customer_id`,`first_name`,`last_name`,`phone`,`email`) VALUES
(1,'John','Doe','208-111-2222','john.doe@test.com');

INSERT INTO `salesperson` (`salesperson_id`,`first_name`,`last_name`,`phone`,`email`) VALUES
(1,'Eliot','Bicak','208-800-1122','eliot.bicak@test.com');

INSERT INTO `car` (`vin`,`make`,`model`,`year`,`mileage`,`listing_price`,`status`,`city`,`state`,`body_type_id`,`image_url`,`exterior_color`,`fuel_type`,`transmission`,`title`,`description`,`owners`,`papers`,`interior_color`,`drivetrain`,`created_at`) VALUES
('D8FD4F95CD58111F1','Honda','Civic',2022,28500,24500.00,'Available','Moscow','ID',5,'/images/civic.jpg','Blue','Gas','Automatic','2022 Honda Civic - Clean, Low Miles','One owner, no accidents. Regular oil changes and new tires last spring. Great on gas.',1,'Clean','Black','FWD','2026-10-31 00:00:00'),
('D8FD50686D58111F1','Ford','Mustang',2020,36000,29995.00,'Available','Pullman','WA',7,'/images/mustang.jpg','Red','Gas','Manual','2020 Ford Mustang 6-Speed Manual','Fun to drive manual. Recently serviced, clean title. Some light scratches on the rear bumper.',2,'Clean','Black','RWD','2026-10-31 00:00:00'),
('D8FD50924D58111F1','Volkswagen','Golf',2019,54000,17995.00,'Available','Spokane','WA',6,'/images/golf.jpg','White','Gas','Automatic','2019 VW Golf Hatchback','Reliable daily driver with plenty of cargo space. Heated seats and Apple CarPlay.',3,'Rebuilt','Gray','FWD','2026-10-31 00:00:00'),
('D8FD50A3CD58111F1','Toyota','RAV4',2022,31000,28995.00,'Available','Moscow','ID',10,'/images/rav4.jpg','Gray','Hybrid','Automatic','2022 Toyota RAV4 Hybrid AWD','Gets around 40 mpg. All-wheel drive, perfect for winter. Still under factory warranty.',1,'Clean','Black','AWD','2026-10-31 00:00:00'),
('D8FD50B36D58111F1','Honda','CR-V',2021,46000,25995.00,'Available','Coeur d\'Alene','ID',10,'/images/crv.jpg','Black','Gas','Automatic','2021 Honda CR-V - Great Family SUV','Spacious and comfortable. Backup camera, lane assist, and all-weather floor mats included.',1,'Clean','Beige','AWD','2026-10-31 00:00:00'),
('D8FD510EAD58111F1','Chevrolet','Tahoe',2020,67000,38995.00,'Available','Spokane','WA',8,'/images/tahoe.jpg','Black','Gas','Automatic','2020 Chevy Tahoe - Seats 8','Third-row seating and towing package. Runs great, minor wear on the interior.',2,'Clean','Black','4WD','2026-10-31 00:00:00'),
('D8FD51202D58111F1','Ford','F-150',2021,49000,34995.00,'Available','Lewiston','ID',11,'/images/f150.jpg','Blue','Gas','Automatic','2021 Ford F-150 Crew Cab','Bed liner and tow hitch. Well maintained, service records available.',1,'Clean','Gray','4WD','2026-10-31 00:00:00'),
('D8FD5132ED58111F1','Chevrolet','Silverado 2500HD',2019,81000,36500.00,'Available','Spokane','WA',12,'/images/silverado.jpg','Silver','Diesel','Automatic','2019 Silverado 2500HD Duramax Diesel','Heavy-duty diesel, ready for work. Gooseneck hitch installed. Mostly highway miles.',3,'Clean','Gray','4WD','2026-10-31 00:00:00'),
('D8FD51446D58111F1','Toyota','Tacoma',2022,33000,32995.00,'Available','Pullman','WA',11,'/images/tacoma.jpg','Green','Gas','Automatic','2022 Toyota Tacoma TRD','Off-road package. No rust, garage kept.',1,'Clean','Black','4WD','2026-10-31 00:00:00'),
('DEMO0000000000001','Toyota','Camry',2021,42000,22995.00,'Sold','Moscow','ID',5,'/images/camry.jpg','Silver','Gas','Automatic','2021 Toyota Camry SE','Comfortable commuter with low maintenance costs. Recently detailed.',1,'Clean','Beige','FWD','2026-10-31 00:00:00');

INSERT INTO `sale` (`sale_id`,`vin`,`customer_id`,`salesperson_id`,`sale_price`,`sale_date`) VALUES
(1,'DEMO0000000000001',1,1,22500.00,'2026-10-31');

-- No saved favorites are seeded: customers can save cars after login.
-- password_hash is NULL for imported demo customers. Registration/login must
-- populate a hash using PHP password_hash(), never a plaintext password.
