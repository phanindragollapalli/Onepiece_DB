-- ========================================
-- 1. DEVIL FRUITS (No dependencies)
-- ========================================

INSERT INTO Devil_Fruit (Fruit_Name, Fruit_Type, Ability, Sub_Type) VALUES
('Gomu Gomu no Mi', 'Paramecia', 'Grants the user rubber-like properties, making them immune to blunt attacks and electricity while allowing extreme stretching', 'Rubber'),
('Mera Mera no Mi', 'Logia', 'Allows the user to create, control, and transform into fire at will', 'Fire'),
('Hie Hie no Mi', 'Logia', 'Enables the user to create, control, and become ice, freezing anything they touch', 'Ice'),
('Gura Gura no Mi', 'Paramecia', 'Grants the power to create devastating earthquakes and shockwaves capable of destroying the world', 'Tremor'),
('Yami Yami no Mi', 'Logia', 'Allows manipulation of darkness and gravity, including the ability to nullify other Devil Fruit powers', 'Darkness'),
('Ope Ope no Mi', 'Paramecia', 'Creates a spherical territory where the user can manipulate anything, including performing miraculous surgeries', 'Operation'),
('Pika Pika no Mi', 'Logia', 'Enables the user to create, control, and transform into light, moving at light speed', 'Light'),
('Magu Magu no Mi', 'Logia', 'Grants the ability to create, control, and become magma, with offensive power superior to fire', 'Magma'),
('Hana Hana no Mi', 'Paramecia', 'Allows the user to sprout duplicates of their body parts on any surface', 'Bloom'),
('Suna Suna no Mi', 'Logia', 'Enables creation, control, and transformation into sand, along with moisture absorption', 'Sand'),
('Mochi Mochi no Mi', 'Paramecia', 'Allows creation, control, and transformation into mochi, a special Paramecia with Logia-like properties', 'Mochi'),
('Nikyu Nikyu no Mi', 'Paramecia', 'Grants paw pads that can repel anything, including air, pain, fatigue, and people', 'Paw'),
('Soru Soru no Mi', 'Paramecia', 'Allows manipulation of souls, creating homies by placing souls into objects and animals', 'Soul'),
('Bari Bari no Mi', 'Paramecia', 'Creates indestructible barriers that can be shaped into various forms', 'Barrier'),
('Hobi Hobi no Mi', 'Paramecia', 'Transforms people into toys and erases memories of their existence, user never ages', 'Hobby'),
('Zushi Zushi no Mi', 'Paramecia', 'Manipulates gravity, allowing the user to increase or decrease gravitational forces', 'Gravity'),
('Gasu Gasu no Mi', 'Logia', 'Allows creation, control, and transformation into various types of gas', 'Gas'),
('Yuki Yuki no Mi', 'Logia', 'Grants the ability to create, control, and transform into snow', 'Snow'),
('Ito Ito no Mi', 'Paramecia', 'Allows creation and manipulation of strings for various purposes including controlling people', 'String'),
('Zou Zou no Mi Model: Mammoth', 'Zoan', 'Allows transformation into a mammoth or mammoth-human hybrid', 'Ancient Zoan'),
('Ryu Ryu no Mi Model: Pteranodon', 'Zoan', 'Allows transformation into a pteranodon or pteranodon-human hybrid', 'Ancient Zoan'),
('Hebi Hebi no Mi Model: Yamata no Orochi', 'Zoan', 'Allows transformation into an eight-headed serpent or hybrid form', 'Mythical Zoan'),
('Inu Inu no Mi Model: Okuchi no Makami', 'Zoan', 'Allows transformation into a divine wolf deity or hybrid form', 'Mythical Zoan'),
('Tori Tori no Mi Model: Phoenix', 'Zoan', 'Allows transformation into a phoenix with regenerative blue flames', 'Mythical Zoan');

-- ========================================
-- 2. CREWS (No dependencies)
-- ========================================

INSERT INTO Crew (Crew_Name, Ship_Name, Total_Bounty) VALUES
('Straw Hat Pirates', 'Thousand Sunny', 8816000500),
('Whitebeard Pirates', 'Moby Dick', 5564000000),
('Big Mom Pirates', 'Queen Mama Chanter', 10373000000),
('Beast Pirates', 'Onigashima', 8347100000),
('Red Hair Pirates', 'Red Force', 4048900000),
('Blackbeard Pirates', 'Saber of Xebec', 3996000000),
('Heart Pirates', 'Polar Tang', 3000000000),
('Kid Pirates', 'Victoria Punk', 3162000000),
('Donquixote Pirates', 'Numancia Flamingo', 640000000),
('Baroque Works', 'Full', 162000000),
('Arlong Pirates', 'Shark Superb', 40000000),
('Buggy Pirates', 'Big Top', 15000000),
('Revolutionary Army', 'Wind Granma', 8000000000),
('Cross Guild', 'Unknown', 7849000000);

-- ========================================
-- 3. LOCATIONS (No dependencies)
-- ========================================

INSERT INTO Location (Name, Location_Type) VALUES
('East Blue', 'Sea'),
('West Blue', 'Sea'),
('North Blue', 'Sea'),
('South Blue', 'Sea'),
('Grand Line - Paradise', 'Sea'),
('Grand Line - New World', 'Sea'),
('Calm Belt', 'Sea'),
('Dawn Island', 'Island'),
('Cocoyasi Village Island', 'Island'),
('Syrup Village Island', 'Island'),
('Baratie Island', 'Island'),
('Drum Island', 'Island'),
('Alabasta', 'Island'),
('Jaya', 'Island'),
('Skypiea', 'Sky Island'),
('Long Ring Long Land', 'Island'),
('Water 7', 'Island'),
('Enies Lobby', 'Island'),
('Thriller Bark', 'Island'),
('Sabaody Archipelago', 'Island'),
('Amazon Lily', 'Island'),
('Impel Down', 'Island'),
('Marineford', 'Island'),
('Fish-Man Island', 'Island'),
('Punk Hazard', 'Island'),
('Dressrosa', 'Island'),
('Zou', 'Island'),
('Whole Cake Island', 'Island'),
('Wano Country', 'Island'),
('Sphinx', 'Island'),
('Elbaf', 'Island'),
('Weatheria', 'Sky Island'),
('Birka', 'Sky Island');

-- ========================================
-- 4. LOCATION SUBCLASSES (Depends on Location & Crew)
-- ========================================

-- Seas
INSERT INTO Sea (Location_ID, Sea_type, Danger_Level) VALUES
(1, 'East Blue', 'Low'),
(2, 'West Blue', 'Low'),
(3, 'North Blue', 'Medium'),
(4, 'South Blue', 'Low'),
(5, 'Grand Line', 'High'),
(6, 'New World', 'Extreme'),
(7, 'Calm Belt', 'Extreme');

-- Islands (some with controlling crews, most without)
INSERT INTO Island (Location_ID, Climate, Dominant_Species, Strategic_Importance, Controlling_Crew_ID) VALUES
(8, 'Temperate', 'Human', 'Medium', NULL),
(9, 'Tropical', 'Human', 'Low', NULL),
(10, 'Temperate', 'Human', 'Low', NULL),
(11, 'Tropical', 'Human', 'Medium', NULL),
(12, 'Winter', 'Human', 'Medium', NULL),
(13, 'Desert', 'Human', 'High', NULL),
(14, 'Tropical', 'Human', 'Medium', NULL),
(16, 'Tropical', 'Human', 'Low', NULL),
(17, 'Temperate', 'Human', 'Critical', NULL),
(18, 'Temperate', 'Human', 'Critical', NULL),
(19, 'Extreme', 'Zombie', 'Low', NULL),
(20, 'Tropical', 'Human', 'Critical', NULL),
(21, 'Tropical', 'Kuja', 'Medium', NULL),
(22, 'Extreme', 'Human', 'Critical', NULL),
(23, 'Temperate', 'Human', 'Critical', NULL),
(24, 'Tropical', 'Fishman', 'High', NULL),
(25, 'Extreme', 'Human', 'High', NULL),
(26, 'Tropical', 'Human', 'High', NULL),
(27, 'Variable', 'Mink', 'High', NULL),
(28, 'Tropical', 'Human', 'High', 3),
(29, 'Temperate', 'Human', 'Critical', NULL),
(30, 'Tropical', 'Human', 'Low', 2),
(31, 'Temperate', 'Giant', 'High', NULL);

-- Sky Islands
INSERT INTO Sky_Island (Location_ID, Altitude, Cloud_Type, Strategic_Importance) VALUES
(15, 10000, 'Island Cloud', 'Medium'),
(32, 7000, 'Sea Cloud', 'Low'),
(33, 9000, 'Island Cloud', 'Low');

-- ========================================
-- 5. CHARACTERS (Depends on Locations)
-- ========================================

INSERT INTO Character (First_Name, Middle_Name, Last_Name, Epithet, Origin_Island_Name, Origin_Sea_Name, Height, Age, Gender, Character_Type) VALUES
-- Straw Hat Pirates
('Monkey', 'D.', 'Luffy', 'Straw Hat', 'Dawn Island', 'East Blue', 174.00, 19, 'Male', 'Pirate'),
('Roronoa', NULL, 'Zoro', 'Pirate Hunter', 'Shimotsuki Village', 'East Blue', 181.00, 21, 'Male', 'Pirate'),
('Nami', NULL, NULL, 'Cat Burglar', 'Cocoyasi Village', 'East Blue', 170.00, 20, 'Female', 'Pirate'),
('Usopp', NULL, NULL, 'God Usopp', 'Syrup Village', 'East Blue', 176.00, 19, 'Male', 'Pirate'),
('Sanji', NULL, 'Vinsmoke', 'Black Leg', 'North Blue', 'North Blue', 180.00, 21, 'Male', 'Pirate'),
('Tony Tony', NULL, 'Chopper', 'Cotton Candy Lover', 'Drum Island', 'Grand Line', 90.00, 17, 'Male', 'Pirate'),
('Nico', NULL, 'Robin', 'Devil Child', 'Ohara', 'West Blue', 188.00, 30, 'Female', 'Pirate'),
('Franky', NULL, NULL, 'Cyborg', 'Water 7', 'Grand Line', 240.00, 36, 'Male', 'Pirate'),
('Brook', NULL, NULL, 'Soul King', 'West Blue', 'West Blue', 277.00, 90, 'Male', 'Pirate'),
('Jinbe', NULL, NULL, 'Knight of the Sea', 'Fish-Man Island', 'Grand Line', 301.00, 46, 'Male', 'Pirate'),

-- Whitebeard Pirates
('Edward', NULL, 'Newgate', 'Whitebeard', 'Sphinx', 'Grand Line', 666.00, 72, 'Male', 'Pirate'),
('Marco', NULL, NULL, 'The Phoenix', 'Grand Line', 'Grand Line', 203.00, 45, 'Male', 'Pirate'),
('Portgas', 'D.', 'Ace', 'Fire Fist', 'Dawn Island', 'East Blue', 185.00, 20, 'Male', 'Pirate'),

-- Big Mom Pirates
('Charlotte', NULL, 'Linlin', 'Big Mom', 'Whole Cake Island', 'Grand Line', 880.00, 68, 'Female', 'Pirate'),
('Charlotte', NULL, 'Katakuri', 'Sweet Commander', 'Whole Cake Island', 'Grand Line', 509.00, 48, 'Male', 'Pirate'),

-- Beast Pirates
('Kaido', NULL, NULL, 'King of the Beasts', 'Grand Line', 'Grand Line', 710.00, 59, 'Male', 'Pirate'),
('King', NULL, NULL, 'The Wildfire', 'Red Line', 'Grand Line', 613.00, 47, 'Male', 'Pirate'),
('Queen', NULL, NULL, 'The Plague', 'Grand Line', 'Grand Line', 612.00, 56, 'Male', 'Pirate'),
('Jack', NULL, NULL, 'The Drought', 'Grand Line', 'Grand Line', 830.00, 28, 'Male', 'Pirate'),

-- Red Hair Pirates
('Shanks', NULL, NULL, 'Red Hair', 'West Blue', 'West Blue', 199.00, 39, 'Male', 'Pirate'),
('Benn', NULL, 'Beckman', 'First Mate', 'North Blue', 'North Blue', 206.00, 50, 'Male', 'Pirate'),

-- Blackbeard Pirates
('Marshall', 'D.', 'Teach', 'Blackbeard', 'Grand Line', 'Grand Line', 344.00, 40, 'Male', 'Pirate'),

-- Heart Pirates
('Trafalgar', 'D. Water', 'Law', 'Surgeon of Death', 'North Blue', 'North Blue', 191.00, 26, 'Male', 'Pirate'),

-- Kid Pirates
('Eustass', NULL, 'Kid', 'Captain Kid', 'South Blue', 'South Blue', 205.00, 23, 'Male', 'Pirate'),

-- Donquixote Pirates
('Donquixote', NULL, 'Doflamingo', 'Heavenly Demon', 'North Blue', 'North Blue', 305.00, 41, 'Male', 'Pirate'),

-- Baroque Works
('Crocodile', NULL, NULL, 'Sir Crocodile', 'Grand Line', 'Grand Line', 253.00, 46, 'Male', 'Pirate'),

-- Arlong Pirates
('Arlong', NULL, NULL, 'Saw-Tooth', 'Fish-Man Island', 'Grand Line', 263.00, 41, 'Male', 'Pirate'),

-- Buggy Pirates
('Buggy', NULL, NULL, 'The Clown', 'Grand Line', 'Grand Line', 192.00, 39, 'Male', 'Pirate'),

-- Marines
('Sakazuki', NULL, NULL, 'Akainu', 'North Blue', 'North Blue', 306.00, 55, 'Male', 'Marine'),
('Borsalino', NULL, NULL, 'Kizaru', 'North Blue', 'North Blue', 302.00, 58, 'Male', 'Marine'),
('Kuzan', NULL, NULL, 'Aokiji', 'South Blue', 'South Blue', 298.00, 49, 'Male', 'Marine'),
('Issho', NULL, NULL, 'Fujitora', 'Grand Line', 'Grand Line', 270.00, 54, 'Male', 'Marine'),
('Smoker', NULL, NULL, 'White Hunter', 'Grand Line', 'Grand Line', 209.00, 36, 'Male', 'Marine'),
('Monkey', 'D.', 'Garp', 'Garp the Fist', 'Dawn Island', 'East Blue', 287.00, 78, 'Male', 'Marine'),
('Sengoku', NULL, NULL, 'The Buddha', 'Grand Line', 'Grand Line', 278.00, 79, 'Male', 'Marine'),
('Tsuru', NULL, NULL, 'Great Staff Officer', 'Grand Line', 'Grand Line', 204.00, 76, 'Female', 'Marine'),
('Koby', NULL, NULL, 'Hero', 'East Blue', 'East Blue', 167.00, 18, 'Male', 'Marine'),
('Helmeppo', NULL, NULL, NULL, 'East Blue', 'East Blue', 179.00, 22, 'Male', 'Marine'),

-- Revolutionaries
('Monkey', 'D.', 'Dragon', 'The Revolutionary', 'Dawn Island', 'East Blue', 256.00, 55, 'Male', 'Revolutionary'),
('Sabo', NULL, NULL, 'Flame Emperor', 'Dawn Island', 'East Blue', 187.00, 22, 'Male', 'Revolutionary'),
('Emporio', NULL, 'Ivankov', 'Miracle Person', 'Grand Line', 'Grand Line', 449.00, 53, 'Male', 'Revolutionary'),
('Bartholomew', NULL, 'Kuma', 'Tyrant', 'South Blue', 'South Blue', 689.00, 47, 'Male', 'Revolutionary'),

-- Civilians
('Nefertari', NULL, 'Vivi', 'Princess', 'Alabasta', 'Grand Line', 169.00, 18, 'Female', 'Civilian'),
('Shirahoshi', NULL, NULL, 'Princess', 'Fish-Man Island', 'Grand Line', 1187.00, 16, 'Female', 'Civilian');

-- ========================================
-- 6. CHARACTER SUBCLASSES (Depends on Character, Crew, Island)
-- ========================================

-- Pirates
INSERT INTO Pirate (Character_ID, Bounty, Tier, Threat_Level, Status, Role, Crew_ID) VALUES
(1, 3000000000, 'Yonko', 'World Threat', 'Active', 'Captain', 1),
(2, 1111000000, 'Supernova', 'High', 'Active', 'First Mate/Combatant', 1),
(3, 366000000, 'Supernova', 'Medium', 'Active', 'Navigator', 1),
(4, 500000000, 'Supernova', 'Medium', 'Active', 'Sniper', 1),
(5, 1032000000, 'Supernova', 'High', 'Active', 'Cook', 1),
(6, 1000, 'Rookie', 'Low', 'Active', 'Doctor', 1),
(7, 930000000, 'Veteran', 'High', 'Active', 'Archaeologist', 1),
(8, 394000000, 'Veteran', 'Medium', 'Active', 'Shipwright', 1),
(9, 383000000, 'Veteran', 'Medium', 'Active', 'Musician', 1),
(10, 1100000000, 'Veteran', 'High', 'Active', 'Helmsman', 1),
(11, 5046000000, 'Yonko', 'World Threat', 'Deceased', 'Captain', 2),
(12, 1374000000, 'Yonko Commander', 'Extreme', 'Active', 'First Division Commander', 2),
(13, 550000000, 'Yonko Commander', 'Extreme', 'Deceased', 'Second Division Commander', 2),
(14, 4388000000, 'Yonko', 'World Threat', 'Active', 'Captain', 3),
(15, 1057000000, 'Yonko Commander', 'Extreme', 'Active', 'Sweet Commander', 3),
(16, 4611100000, 'Yonko', 'World Threat', 'Deceased', 'Captain', 4),
(17, 1390000000, 'Yonko Commander', 'Extreme', 'Active', 'All-Star', 4),
(18, 1320000000, 'Yonko Commander', 'Extreme', 'Active', 'All-Star', 4),
(19, 1000000000, 'Yonko Commander', 'Extreme', 'Active', 'All-Star', 4),
(20, 4048900000, 'Yonko', 'World Threat', 'Active', 'Captain', 5),
(21, 0, 'Yonko Commander', 'Extreme', 'Active', 'First Mate', 5),
(22, 3996000000, 'Yonko', 'World Threat', 'Active', 'Captain', 6),
(23, 3000000000, 'Supernova', 'Extreme', 'Active', 'Captain', 7),
(24, 3000000000, 'Supernova', 'Extreme', 'Active', 'Captain', 8),
(25, 340000000, 'Veteran', 'High', 'Captured', 'Captain', 9),
(26, 81000000, 'Veteran', 'Medium', 'Captured', 'Leader', 10),
(27, 20000000, 'Rookie', 'Low', 'Deceased', 'Captain', 11),
(28, 3189000000, 'Yonko', 'High', 'Active', 'Chairman', 12),

-- Marines
INSERT INTO Marine (Character_ID, Rank, Status, Branch_ID, Branch_Name, Stationed_Island_ID) VALUES
(29, 'Fleet Admiral', 'Active', 'HQ-001', 'Marine Headquarters', 23),
(30, 'Admiral', 'Active', 'HQ-002', 'Marine Headquarters', 23),
(31, 'Admiral', 'Retired', 'HQ-003', 'Marine Headquarters', NULL),
(32, 'Admiral', 'Active', 'HQ-004', 'Marine Headquarters', 23),
(33, 'Vice Admiral', 'Active', 'G5-001', 'G-5 Branch', 25),
(34, 'Vice Admiral', 'Active', 'HQ-005', 'Marine Headquarters', 23),
(35, 'Fleet Admiral', 'Retired', 'HQ-006', 'Marine Headquarters', 23),
(36, 'Vice Admiral', 'Active', 'HQ-007', 'Marine Headquarters', 23),
(37, 'Captain', 'Active', 'HQ-008', 'Marine Headquarters', 23),
(38, 'Lieutenant', 'Active', 'HQ-009', 'Marine Headquarters', 23),

-- Revolutionaries
INSERT INTO Revolutionary (Character_ID, Army_Role, Bounty, Status, Stationed_Island_ID) VALUES
(39, 'Supreme Commander', 5000000000, 'Active', NULL),
(40, 'Chief of Staff', 602000000, 'Active', NULL),
(41, 'Army Commander', 0, 'Active', NULL),
(42, 'Officer', 296000000, 'Active', NULL);

-- ========================================
-- 7. JOLLY ROGERS (Depends on Crew)
-- ========================================

INSERT INTO Jolly_Roger (Crew_ID, Skull_Design, Symbolism) VALUES
(1, 'Skull with straw hat and crossbones', 'Represents Luffy''s trademark straw hat and the crew''s pirate identity'),
(2, 'Skull with white mustache', 'Represents Whitebeard''s distinctive facial feature and paternal nature'),
(3, 'Skull with pirate hat and pink hair', 'Represents Big Mom''s appearance and sweet-themed crew'),
(4, 'Skull with horns and crossbones', 'Represents Kaido''s devil-like horns and beast theme'),
(5, 'Skull with crossed swords and three scars', 'Represents Shanks'' scars and swordsmanship'),
(6, 'Three skulls with horns', 'Represents Blackbeard''s ability to wield multiple powers'),
(7, 'Smiling skull with spotted hat', 'Represents Law''s carefree nature despite his serious demeanor'),
(8, 'Skull with spiked hair and goggles', 'Represents Kid''s punk aesthetic'),
(9, 'Skull with sunglasses and flamingo feathers', 'Represents Doflamingo''s style'),
(12, 'Skull with clown nose', 'Represents Buggy''s circus theme');

-- ========================================
-- 8. COLOUR SCHEMES (Depends on Jolly_Roger)
-- ========================================

INSERT INTO Colour_Scheme (Crew_ID, Color) VALUES
(1, 'Red'),
(1, 'Black'),
(1, 'Yellow'),
(2, 'Purple'),
(2, 'White'),
(3, 'Pink'),
(3, 'White'),
(3, 'Black'),
(4, 'Purple'),
(4, 'Black'),
(5, 'Red'),
(5, 'Black'),
(6, 'Black'),
(6, 'Red'),
(6, 'Purple'),
(7, 'Yellow'),
(7, 'Black'),
(8, 'Red'),
(8, 'Black'),
(9, 'Pink'),
(9, 'Black'),
(12, 'Red'),
(12, 'White'),
(12, 'Blue');

-- ========================================
-- 9. PONEGLYPHS (Depends on Location)
-- ========================================

INSERT INTO Poneglyph (Type, Last_Known_Location_ID) VALUES
('Road Poneglyph', 27),
('Road Poneglyph', 28),
('Road Poneglyph', 29),
('Road Poneglyph', 24),
('Historical', 13),
('Historical', 15),
('Historical', 17),
('Historical', 26),
('Historical', 28),
('Instructional', 20);

-- ========================================
-- 10. SKILLS (Depends on Character)
-- ========================================

INSERT INTO Skill (Skill_Name, Category, Difficulty, User_ID) VALUES
('Santoryu', 'Swordsmanship', 'Master', 2),
('Asura', 'Swordsmanship', 'Legendary', 2),
('Clima-Tact Mastery', 'Other', 'Advanced', 3),
('Cartography', 'Navigation', 'Master', 3),
('Marksmanship Excellence', 'Marksmanship', 'Master', 4),
('Observation Haki Sniping', 'Marksmanship', 'Legendary', 4),
('Diable Jambe', 'Hand-to-Hand Combat', 'Master', 5),
('Sky Walk', 'Hand-to-Hand Combat', 'Advanced', 5),
('Rumble Ball Medicine', 'Medical', 'Master', 6),
('Monster Point Control', 'Medical', 'Advanced', 6),
('Archaeology', 'Other', 'Legendary', 7),
('Ancient Language Reading', 'Other', 'Legendary', 7),
('Cyborg Engineering', 'Engineering', 'Master', 8),
('Weaponry Integration', 'Engineering', 'Advanced', 8),
('Soul Solid Fencing', 'Swordsmanship', 'Master', 9),
('Musical Combat', 'Other', 'Advanced', 9),
('Fish-Man Karate', 'Hand-to-Hand Combat', 'Legendary', 10),
('Fish-Man Jujutsu', 'Hand-to-Hand Combat', 'Master', 10),
('Phoenix Regeneration', 'Other', 'Legendary', 12),
('Fire Fist Techniques', 'Other', 'Legendary', 13),
('Mochi Combat', 'Hand-to-Hand Combat', 'Legendary', 15),
('Dragon Form Combat', 'Other', 'Legendary', 16),
('Wildfire Techniques', 'Swordsmanship', 'Legendary', 17),
('Plague Rounds', 'Engineering', 'Master', 18),
('Haki Mastery', 'Hand-to-Hand Combat', 'Legendary', 20),
('Swordsmanship', 'Swordsmanship', 'Master', 20),
('Darkness Control', 'Other', 'Legendary', 22),
('ROOM Techniques', 'Medical', 'Legendary', 23),
('Shambles', 'Medical', 'Master', 23),
('Magnetism Manipulation', 'Other', 'Master', 24),
('String Manipulation', 'Other', 'Legendary', 25),
('Parasite Control', 'Other', 'Master', 25),
('Sand Control', 'Other', 'Legendary', 26),
('Saw Combat', 'Hand-to-Hand Combat', 'Advanced', 27),
('Bara Bara Techniques', 'Other', 'Advanced', 28),
('Magma Control', 'Other', 'Legendary', 29),
('Light Speed Movement', 'Other', 'Legendary', 30),
('Ice Age', 'Other', 'Legendary', 31),
('Gravity Manipulation', 'Swordsmanship', 'Legendary', 32),
('Smoke Control', 'Other', 'Advanced', 33),
('Galaxy Impact', 'Hand-to-Hand Combat', 'Legendary', 34);

-- ========================================
-- 11. VIVRE CARDS (Depends on Character)
-- ========================================

INSERT INTO Vivre_Card (Condition, Creator_ID, Current_Owner_ID) VALUES
('Intact', 13, 1),
('Intact', 1, 2),
('Intact', 1, 3),
('Slightly Burned', 12, 13),
('Intact', 20, 21),
('Moderately Burned', 42, 39),
('Intact', 7, 1),
('Intact', 23, 24),
('Intact', 14, 15),
('Severely Burned', 13, 12);

-- ========================================
-- 12. CAPTAINS (Depends on Pirate and Crew)
-- ========================================

INSERT INTO CAPTAINS (Captain_ID, Crew_ID) VALUES
(1, 1),
(11, 2),
(14, 3),
(16, 4),
(20, 5),
(22, 6),
(23, 7),
(24, 8),
(25, 9),
(26, 10),
(27, 11),
(28, 12);

-- ========================================
-- 13. EATS (Depends on Character and Devil_Fruit)
-- ========================================

INSERT INTO EATS (Character_ID, Fruit_ID) VALUES
(1, 1),   -- Luffy - Gomu Gomu no Mi
(13, 2),  -- Ace - Mera Mera no Mi
(31, 3),  -- Aokiji - Hie Hie no Mi
(11, 4),  -- Whitebeard - Gura Gura no Mi
(22, 5),  -- Blackbeard - Yami Yami no Mi
(23, 6),  -- Law - Ope Ope no Mi
(30, 7),  -- Kizaru - Pika Pika no Mi
(29, 8),  -- Akainu - Magu Magu no Mi
(7, 9),   -- Robin - Hana Hana no Mi
(26, 10), -- Crocodile - Suna Suna no Mi
(15, 11), -- Katakuri - Mochi Mochi no Mi
(42, 12), -- Kuma - Nikyu Nikyu no Mi
(14, 13), -- Big Mom - Soru Soru no Mi
(25, 19), -- Doflamingo - Ito Ito no Mi
(19, 20), -- Jack - Zou Zou no Mi
(17, 21), -- King - Ryu Ryu no Mi (Pteranodon)
(16, 22), -- Kaido - Hebi Hebi no Mi (Yamata no Orochi) [Actually Uo Uo no Mi, but using what's available]
(12, 24); -- Marco - Tori Tori no Mi (Phoenix)

-- ========================================
-- 14. HAS_CARD (Depends on Character and Vivre_Card)
-- ========================================

INSERT INTO HAS_CARD (Current_Owner_ID, Card_ID, Creator_ID) VALUES
(1, 1, 13),
(2, 2, 1),
(3, 3, 1),
(13, 4, 12),
(21, 5, 20),
(39, 6, 42),
(1, 7, 7),
(24, 8, 23),
(15, 9, 14),
(12, 10, 13);

-- ========================================
-- 15. HAS_SKILL (Depends on Character and Skill)
-- ========================================

INSERT INTO HAS_SKILL (Character_ID, Skill_ID, User_ID) VALUES
(2, 1, 2),
(2, 2, 2),
(3, 3, 3),
(3, 4, 3),
(4, 5, 4),
(4, 6, 4),
(5, 7, 5),
(5, 8, 5),
(6, 9, 6),
(6, 10, 6),
(7, 11, 7),
(7, 12, 7),
(8, 13, 8),
(8, 14, 8),
(9, 15, 9),
(9, 16, 9),
(10, 17, 10),
(10, 18, 10),
(12, 19, 12),
(13, 20, 13),
(15, 21, 15),
(16, 22, 16),
(17, 23, 17),
(18, 24, 18),
(20, 25, 20),
(20, 26, 20),
(22, 27, 22),
(23, 28, 23),
(23, 29, 23),
(24, 30, 24),
(25, 31, 25),
(25, 32, 25),
(26, 33, 26),
(27, 34, 27),
(28, 35, 28),
(29, 36, 29),
(30, 37, 30),
(31, 38, 31),
(32, 39, 32),
(33, 40, 33),
(34, 41, 34);

-- ========================================
-- 16. OWNS_PONEGLYPH (Depends on Crew and Poneglyph)
-- ========================================

INSERT INTO OWNS_PONEGLYPH (Crew_ID, Poneglyph_ID) VALUES
(3, 2),  -- Big Mom Pirates own Road Poneglyph at Whole Cake Island
(4, 3),  -- Beast Pirates owned Road Poneglyph at Wano
(1, 4),  -- Straw Hats found Road Poneglyph at Fish-Man Island
(1, 5),  -- Straw Hats found Historical Poneglyph at Alabasta
(1, 6),  -- Straw Hats found Historical Poneglyph at Skypiea
(1, 7),  -- Straw Hats found Historical Poneglyph at Water 7
(1, 8),  -- Straw Hats found Historical Poneglyph at Dressrosa
(1, 9);  -- Straw Hats found Historical Poneglyph at Whole Cake Island

-- ========================================
-- 17. BATTLE (Depends on Crew, Location, and various factions)
-- ========================================

INSERT INTO BATTLE (Faction1_Type, Faction1_ID, Faction2_Type, Faction2_ID, Location_ID, Casualities, Winner) VALUES
('Crew', 1, 'Crew', 11, 9, 25, 'Faction1'),        -- Straw Hats vs Arlong Pirates at Cocoyasi
('Crew', 1, 'Crew', 10, 13, 100, 'Faction1'),       -- Straw Hats vs Baroque Works at Alabasta
('Crew', 1, 'Marine', NULL, 18, 500, 'Draw'),       -- Straw Hats vs Marines at Enies Lobby
('Crew', 2, 'Marine', NULL, 23, 10000, 'Faction2'), -- Whitebeard Pirates vs Marines at Marineford
('Crew', 1, 'Crew', 9, 26, 300, 'Faction1'),        -- Straw Hats vs Donquixote Pirates at Dressrosa
('Crew', 1, 'Crew', 3, 28, 500, 'Faction1'),        -- Straw Hats vs Big Mom Pirates at Whole Cake Island
('Crew', 1, 'Crew', 4, 29, 5000, 'Faction1'),       -- Straw Hats vs Beast Pirates at Wano
('Crew', 8, 'Crew', 3, 6, 200, 'Draw'),             -- Kid Pirates vs Big Mom Pirates at New World
('Marine', NULL, 'Revolutionary', NULL, 26, 150, 'Ongoing'); -- Marines vs Revolutionaries at Dressrosa

-- ========================================
-- 18. INFO_LEAK (N-ary relationship)
-- ========================================

INSERT INTO INFO_LEAK (Pirate_ID, Marine_ID, Poneglyph_ID, Location_ID) VALUES
(7, 33, 5, 13),   -- Robin leaked info about Alabasta Poneglyph to Smoker
(7, 31, 6, 15),   -- Robin's knowledge about Skypiea Poneglyph known to Aokiji
(23, 32, 8, 26);  -- Law's knowledge about Dressrosa Poneglyph known to Fujitora

-- ========================================
-- 19. CONTEST (N-ary relationship)
-- ========================================

INSERT INTO CONTEST (Participant1_Type, Participant1_ID, Participant2_Crew_ID, Poneglyph_ID, Location_ID, Outcome) VALUES
('Crew', 1, 3, 2, 28, 'Crew1 Victory'),       -- Straw Hats vs Big Mom Pirates over Road Poneglyph at WCI
('Crew', 1, 4, 3, 29, 'Crew1 Victory'),       -- Straw Hats vs Beast Pirates over Road Poneglyph at Wano
('Marine', NULL, 1, 5, 13, 'Crew2 Victory'),  -- Marines vs Straw Hats over Historical Poneglyph at Alabasta
('Crew', 7, 8, 4, 24, 'Stalemate');           -- Heart Pirates vs Kid Pirates over Road Poneglyph at Fish-Man Island

-- ========================================
-- 20. HAKI (Multi-valued attribute)
-- ========================================

INSERT INTO HAKI (Character_ID, Haki_Type) VALUES
-- Straw Hat Pirates
(1, 'Observation'),
(1, 'Armament'),
(1, 'Conquerors'),
(2, 'Observation'),
(2, 'Armament'),
(2, 'Conquerors'),
(3, 'Observation'),
(4, 'Observation'),
(5, 'Observation'),
(5, 'Armament'),
(7, 'Observation'),
(7, 'Armament'),
(9, 'Observation'),
(9, 'Armament'),
(10, 'Observation'),
(10, 'Armament'),

-- Legendary Pirates
(11, 'Observation'),
(11, 'Armament'),
(11, 'Conquerors'),
(12, 'Observation'),
(12, 'Armament'),
(13, 'Observation'),
(13, 'Armament'),
(14, 'Observation'),
(14, 'Armament'),
(14, 'Conquerors'),
(15, 'Observation'),
(15, 'Armament'),
(16, 'Observation'),
(16, 'Armament'),
(16, 'Conquerors'),
(17, 'Observation'),
(17, 'Armament'),
(18, 'Observation'),
(18, 'Armament'),
(19, 'Armament'),
(20, 'Observation'),
(20, 'Armament'),
(20, 'Conquerors'),
(21, 'Observation'),
(21, 'Armament'),
(22, 'Observation'),
(22, 'Armament'),
(23, 'Observation'),
(23, 'Armament'),
(24, 'Observation'),
(24, 'Armament'),
(24, 'Conquerors'),
(25, 'Observation'),
(25, 'Armament'),
(25, 'Conquerors'),

-- Marines
(29, 'Observation'),
(29, 'Armament'),
(30, 'Observation'),
(30, 'Armament'),
(31, 'Observation'),
(31, 'Armament'),
(32, 'Observation'),
(32, 'Armament'),
(33, 'Observation'),
(33, 'Armament'),
(34, 'Observation'),
(34, 'Armament'),
(34, 'Conquerors'),
(35, 'Observation'),
(35, 'Armament'),
(35, 'Conquerors'),
(36, 'Observation'),
(36, 'Armament'),

-- Revolutionaries
(39, 'Observation'),
(39, 'Armament'),
(39, 'Conquerors'),
(40, 'Observation'),
(40, 'Armament'),
(42, 'Observation'),
(42, 'Armament');

-- ========================================
-- END OF POPULATE.SQL
-- ========================================