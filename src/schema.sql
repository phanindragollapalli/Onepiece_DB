-- Create and select database
CREATE DATABASE IF NOT EXISTS OnePieceWorld;
USE OnePieceWorld;

-- Devil Fruit Table
CREATE TABLE Devil_Fruit (
  Fruit_ID INT AUTO_INCREMENT NOT NULL,
  Fruit_Name VARCHAR(100) NOT NULL UNIQUE,
  Fruit_Type ENUM('Paramecia', 'Zoan', 'Logia') NOT NULL,
  Ability TEXT NOT NULL,
  Sub_Type VARCHAR(50),
  PRIMARY KEY (Fruit_ID)
);

-- Crew Table
CREATE TABLE Crew (
  Crew_ID INT AUTO_INCREMENT NOT NULL,
  Crew_Name VARCHAR(100) NOT NULL UNIQUE,
  Ship_Name VARCHAR(100),
  Total_Bounty BIGINT DEFAULT 0 CHECK (Total_Bounty >= 0),
  PRIMARY KEY (Crew_ID)
);

-- Location Table and Subclasses
CREATE TABLE Location (
  Location_ID INT AUTO_INCREMENT NOT NULL,
  Name VARCHAR(150) NOT NULL UNIQUE,
  Location_Type ENUM('Island', 'Sea', 'Sky Island') NOT NULL,
  PRIMARY KEY (Location_ID)
);

-- Island subclass
CREATE TABLE Island (
  Location_ID INT NOT NULL,
  Climate ENUM('Tropical', 'Winter', 'Desert', 'Temperate', 'Autumn', 'Spring', 'Summer', 'Extreme', 'Variable') NOT NULL,
  Dominant_Species VARCHAR(100) DEFAULT 'Human',
  Strategic_Importance ENUM('Low','Medium','High','Critical') NOT NULL,
  Controlling_Crew_ID INT,
  PRIMARY KEY (Location_ID),
  FOREIGN KEY (Location_ID) REFERENCES Location(Location_ID) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (Controlling_Crew_ID) REFERENCES Crew(Crew_ID) ON DELETE SET NULL ON UPDATE CASCADE
);

-- Sea subclass
CREATE TABLE Sea (
  Location_ID INT NOT NULL,
  Sea_type ENUM('East Blue','West Blue','North Blue','South Blue','Grand Line','New World','Calm Belt') NOT NULL,
  Danger_Level ENUM('Low','Medium','High','Extreme') NOT NULL,
  PRIMARY KEY (Location_ID),
  FOREIGN KEY (Location_ID) REFERENCES Location(Location_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Sky Island subclass
CREATE TABLE Sky_Island (
  Location_ID INT NOT NULL,
  Altitude INT NOT NULL CHECK (Altitude >= 0),
  Cloud_Type VARCHAR(50),
  Strategic_Importance ENUM('Low','Medium','High','Critical') NOT NULL,
  PRIMARY KEY (Location_ID),
  FOREIGN KEY (Location_ID) REFERENCES Location(Location_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Character Table (Superclass)
CREATE TABLE Character (
  Character_ID INT AUTO_INCREMENT NOT NULL,
  First_Name VARCHAR(50) NOT NULL,
  Middle_Name VARCHAR(50),
  Last_Name VARCHAR(50),
  Epithet VARCHAR(100),
  Origin_Island_Name VARCHAR(100),
  Origin_Sea_Name VARCHAR(100),
  Height DECIMAL(5,2) NOT NULL CHECK (Height >= 0),
  Age INT NOT NULL CHECK (Age >= 0 AND Age <= 500),
  Gender ENUM('Male','Female','Other') NOT NULL,
  Character_Type ENUM('Pirate','Marine','Revolutionary','Civilian') NOT NULL,
  PRIMARY KEY (Character_ID)
);

-- Pirate Table (Subclass)
CREATE TABLE Pirate (
  Character_ID INT NOT NULL,
  Bounty BIGINT DEFAULT 0 CHECK (Bounty >= 0 AND Bounty <= 10000000000),
  Tier ENUM('Rookie','Supernova','Veteran','Yonko Commander','Yonko','Pirate King') NOT NULL,
  Threat_Level ENUM('Low','Medium','High','Extreme','World Threat') NOT NULL,
  Status ENUM('Active','Captured','Deceased','Retired','Unknown') NOT NULL DEFAULT 'Active',
  Role VARCHAR(100),
  Crew_ID INT,
  PRIMARY KEY (Character_ID),
  FOREIGN KEY (Character_ID) REFERENCES Character(Character_ID) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (Crew_ID) REFERENCES Crew(Crew_ID) ON DELETE SET NULL ON UPDATE CASCADE
);

-- Marine Table (Subclass)
CREATE TABLE Marine (
  Character_ID INT NOT NULL,
  Rank ENUM('Seaman','Petty Officer','Lieutenant','Captain','Commodore','Rear Admiral','Vice Admiral','Admiral','Fleet Admiral') NOT NULL,
  Status ENUM('Active','On Leave','Retired','Deceased','Dishonorably Discharged') NOT NULL DEFAULT 'Active',
  Branch_ID VARCHAR(20) NOT NULL,
  Branch_Name VARCHAR(100) NOT NULL,
  Stationed_Island_ID INT,
  PRIMARY KEY (Character_ID),
  FOREIGN KEY (Character_ID) REFERENCES Character(Character_ID) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (Stationed_Island_ID) REFERENCES Island(Location_ID) ON DELETE SET NULL ON UPDATE CASCADE
);

-- Revolutionary Table (Subclass)
CREATE TABLE Revolutionary (
  Character_ID INT NOT NULL,
  Army_Role ENUM('Soldier','Officer','Commander','Army Commander','Chief of Staff','Supreme Commander') NOT NULL,
  Bounty BIGINT DEFAULT 0 CHECK (Bounty >= 0),
  Status ENUM('Active','Captured','Deceased','MIA','Undercover') NOT NULL DEFAULT 'Active',
  Stationed_Island_ID INT,
  PRIMARY KEY (Character_ID),
  FOREIGN KEY (Character_ID) REFERENCES Character(Character_ID) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (Stationed_Island_ID) REFERENCES Island(Location_ID) ON DELETE SET NULL ON UPDATE CASCADE
);

-- Crew's Jolly Roger (1:1 with Crew)
CREATE TABLE Jolly_Roger (
  Crew_ID INT NOT NULL,
  Skull_Design TEXT NOT NULL,
  Symbolism TEXT,
  PRIMARY KEY (Crew_ID),
  FOREIGN KEY (Crew_ID) REFERENCES Crew(Crew_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Crew Jolly Roger color schemes (multi-valued)
CREATE TABLE Colour_Scheme (
  Crew_ID INT NOT NULL,
  Color VARCHAR(30) NOT NULL,
  PRIMARY KEY (Crew_ID, Color),
  FOREIGN KEY (Crew_ID) REFERENCES Jolly_Roger(Crew_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Poneglyph Table
CREATE TABLE Poneglyph (
  Poneglyph_ID INT AUTO_INCREMENT NOT NULL,
  Type ENUM('Historical','Instructional','Road Poneglyph') NOT NULL,
  Last_Known_Location_ID INT,
  PRIMARY KEY (Poneglyph_ID),
  FOREIGN KEY (Last_Known_Location_ID) REFERENCES Location(Location_ID) ON DELETE SET NULL ON UPDATE CASCADE
);

-- Skill Table (each skill belongs to a character)
CREATE TABLE Skill (
  Skill_ID INT AUTO_INCREMENT NOT NULL,
  Skill_Name VARCHAR(100) NOT NULL,
  Category ENUM('Swordsmanship','Hand-to-Hand Combat','Navigation','Medical','Engineering','Cooking','Marksmanship','Other') NOT NULL,
  Difficulty ENUM('Beginner','Intermediate','Advanced','Master','Legendary') NOT NULL,
  User_ID INT NOT NULL,
  PRIMARY KEY (Skill_ID, User_ID),
  FOREIGN KEY (User_ID) REFERENCES Character(Character_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Vivre Card (each card made by a creator)
CREATE TABLE Vivre_Card (
  Card_ID INT AUTO_INCREMENT NOT NULL,
  Condition ENUM('Intact','Slightly Burned','Moderately Burned','Severely Burned','Nearly Gone') NOT NULL DEFAULT 'Intact',
  Creator_ID INT NOT NULL,
  Current_Owner_ID INT,
  PRIMARY KEY (Card_ID, Creator_ID),
  FOREIGN KEY (Creator_ID) REFERENCES Character(Character_ID) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (Current_Owner_ID) REFERENCES Character(Character_ID) ON DELETE SET NULL ON UPDATE CASCADE
);

-- CAPTAINS: Which pirate is captain of which crew (each crew has one captain)
CREATE TABLE CAPTAINS (
  Captaining_ID INT AUTO_INCREMENT NOT NULL,
  Captain_ID INT NOT NULL,
  Crew_ID INT NOT NULL,
  PRIMARY KEY (Captaining_ID),
  FOREIGN KEY (Captain_ID) REFERENCES Pirate(Character_ID) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (Crew_ID) REFERENCES Crew(Crew_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- EATS (Devil Fruit consumption) 1:1, unique on both
CREATE TABLE EATS (
  Consumption_ID INT AUTO_INCREMENT NOT NULL,
  Character_ID INT NOT NULL UNIQUE,
  Fruit_ID INT NOT NULL UNIQUE,
  PRIMARY KEY (Consumption_ID),
  FOREIGN KEY (Character_ID) REFERENCES Character(Character_ID) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (Fruit_ID) REFERENCES Devil_Fruit(Fruit_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- HAS_CARD (ownership of Vivre Cards)
CREATE TABLE HAS_CARD (
  Card_Ownership_ID INT AUTO_INCREMENT NOT NULL,
  Current_Owner_ID INT NOT NULL,
  Card_ID INT NOT NULL,
  Creator_ID INT NOT NULL,
  PRIMARY KEY (Card_Ownership_ID),
  FOREIGN KEY (Current_Owner_ID) REFERENCES Character(Character_ID) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (Card_ID, Creator_ID) REFERENCES Vivre_Card(Card_ID, Creator_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- HAS_SKILL (Character-Skill mapping)
CREATE TABLE HAS_SKILL (
  Skill_Usage_ID INT AUTO_INCREMENT NOT NULL,
  Character_ID INT NOT NULL,
  Skill_ID INT NOT NULL,
  User_ID INT NOT NULL,
  PRIMARY KEY (Skill_Usage_ID),
  FOREIGN KEY (Character_ID) REFERENCES Character(Character_ID) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (Skill_ID, User_ID) REFERENCES Skill(Skill_ID, User_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- OWNS_PONEGLYPH (Poneglyph owned by crew/pirate)
CREATE TABLE OWNS_PONEGLYPH (
  Poneglyph_Ownership_ID INT AUTO_INCREMENT NOT NULL,
  Crew_ID INT NOT NULL,
  Poneglyph_ID INT NOT NULL,
  PRIMARY KEY (Poneglyph_Ownership_ID),
  FOREIGN KEY (Crew_ID) REFERENCES Crew(Crew_ID) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (Poneglyph_ID) REFERENCES Poneglyph(Poneglyph_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- BATTLE (N-ary relationship; see PDF for Faction1Type/2Type logic)
CREATE TABLE BATTLE (
  Battle_ID INT AUTO_INCREMENT NOT NULL,
  Faction1_Type ENUM('Crew','Marine','Revolutionary') NOT NULL,
  Faction1_ID INT NOT NULL,
  Faction2_Type ENUM('Crew','Marine','Revolutionary') NOT NULL,
  Faction2_ID INT NOT NULL,
  Location_ID INT NOT NULL,
  Casualities INT DEFAULT 0 CHECK (Casualities >= 0),
  Winner ENUM('Faction1','Faction2','Draw','Ongoing'),
  PRIMARY KEY (Battle_ID),
  FOREIGN KEY (Location_ID) REFERENCES Location(Location_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- INFO_LEAK (N-ary relationship)
CREATE TABLE INFO_LEAK (
  Leak_ID INT AUTO_INCREMENT NOT NULL,
  Pirate_ID INT NOT NULL,
  Marine_ID INT NOT NULL,
  Poneglyph_ID INT NOT NULL,
  Location_ID INT NOT NULL,
  PRIMARY KEY (Leak_ID),
  FOREIGN KEY (Pirate_ID) REFERENCES Pirate(Character_ID) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (Marine_ID) REFERENCES Marine(Character_ID) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (Poneglyph_ID) REFERENCES Poneglyph(Poneglyph_ID) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (Location_ID) REFERENCES Location(Location_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- CONTEST (N-ary: conflict over a Poneglyph at a Location)
CREATE TABLE CONTEST (
  Contest_ID INT AUTO_INCREMENT NOT NULL,
  Participant1_Type ENUM('Crew','Marine') NOT NULL,
  Participant1_ID INT NOT NULL,
  Participant2_Crew_ID INT NOT NULL,
  Poneglyph_ID INT NOT NULL,
  Location_ID INT NOT NULL,
  Outcome ENUM('Crew1 Victory','Crew2 Victory','Marine Victory','Stalemate','Ongoing') NOT NULL,
  PRIMARY KEY (Contest_ID),
  FOREIGN KEY (Participant2_Crew_ID) REFERENCES Crew(Crew_ID) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (Poneglyph_ID) REFERENCES Poneglyph(Poneglyph_ID) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (Location_ID) REFERENCES Location(Location_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- HAKI (multi-valued attribute)
CREATE TABLE HAKI (
  Character_ID INT NOT NULL,
  Haki_Type ENUM('Observation','Armament','Conquerors') NOT NULL,
  PRIMARY KEY (Character_ID, Haki_Type),
  FOREIGN KEY (Character_ID) REFERENCES Character(Character_ID) ON DELETE CASCADE ON UPDATE CASCADE
);
