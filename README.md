# One Piece World Database Project Explained

## 1. What This Project Is

This project is a database-driven application built around the **One Piece** universe.  
Its main goal is to model a large fictional world using a proper **relational database** and then allow a user to explore and manage that data through a **Python command-line interface (CLI)**.

In simple words, this project does three important things:

1. It designs a structured **MySQL database** for storing One Piece world information.
2. It fills that database with meaningful sample data such as characters, crews, islands, Devil Fruits, battles, Haki, and Poneglyphs.
3. It provides a **menu-based Python application** that lets users run queries and perform some updates without writing SQL manually.

So this is not just a list of SQL tables and not just a Python script.  
It is a complete mini information system made of:

- database schema design
- normalization work
- sample dataset creation
- Python-MySQL integration
- interactive query/update features

## 2. Main Idea Behind the Project

The One Piece world is large and interconnected. Characters belong to crews, some are Marines, some are Revolutionaries, some use Devil Fruits, some know Haki, some own Poneglyphs, and many important events happen at different locations.

Because of that complexity, this project uses a **relational model** instead of storing everything in a single table.  
The design tries to capture:

- different **entity types**
- relationships between those entities
- specialized subtypes
- many-to-many mappings
- one-to-one and one-to-many relationships
- constraints to preserve valid data

This makes the project a good example of applying **database design theory** to a real themed dataset.

## 3. Technologies Used

The project mainly uses the following technologies:

- **MySQL** for the database
- **SQL** for schema creation, constraints, and inserting data
- **Python** for the application layer
- **PyMySQL** for connecting Python to MySQL

The dependency list is very small.  
The `requirements.txt` file contains only:

- `pymysql`

This means the application is lightweight and focused on database interaction.

## 4. Project Files and What Each One Does

The repository is small, but each file has a clear role.

### `README.md`

This file explains the application from a user perspective.  
It describes the main read and write operations, what each menu option does, and how to run the app.

### `src/schema.sql`

This file defines the entire database structure.  
It creates the database and all the tables with:

- primary keys
- foreign keys
- enums
- constraints
- relationships

This is the backbone of the project.

### `src/populate.sql`

This file inserts sample data into the tables.  
It populates the world with known One Piece characters, pirate crews, places, powers, skills, and events.

### `src/main_app.py`

This is the Python application.  
It connects to MySQL, shows a terminal menu, accepts user input, runs SQL queries, and displays results in a readable table format.

### `phase3.pdf`

This PDF documents the academic database-design side of the project.  
It explains how the ER model was converted into a relational model and how normalization was handled up to **3NF**.

### `video_link.txt`

This contains a project demo link.

### `hi.md`

This file, the one you are reading now, is meant to explain the whole project in simple and detailed language.

## 5. High-Level Architecture

The project works in three layers:

### Layer 1: Database Structure

The schema defines the world and all relationships.

### Layer 2: Stored Data

The populate script inserts example records into the schema.

### Layer 3: Application Interface

The Python CLI lets a user interact with the stored data.

So the flow is:

1. Create the database using `schema.sql`
2. Insert sample data using `populate.sql`
3. Run `main_app.py`
4. Connect to MySQL
5. Use menu options to query or modify the data

## 6. Core Database Design Philosophy

The schema is built carefully instead of putting everything in one place.

The design reflects standard database concepts:

- **strong entities** such as Character, Crew, Devil_Fruit, Location, Skill, and Poneglyph
- **subclasses/specialization** such as Pirate, Marine, Revolutionary, Island, Sea, and Sky_Island
- **relationship tables** such as EATS, HAS_SKILL, HAS_CARD, OWNS_PONEGLYPH
- **multi-valued attribute handling** such as HAKI and Colour_Scheme
- **n-ary relationships** such as BATTLE, INFO_LEAK, and CONTEST

This is useful because it avoids duplicated data and models the world more realistically.

## 7. Database Tables Explained

Below is the easiest way to understand the schema: by grouping the tables logically.

### A. Character-related tables

#### `Character`

This is the main superclass table for all people in the system.  
It stores common attributes shared by every character:

- `Character_ID`
- first, middle, and last names
- epithet
- origin island
- origin sea
- height
- age
- gender
- character type

This table acts as the base identity table.

#### `Pirate`

This table stores pirate-specific data for characters who are pirates.  
Its primary key is also a foreign key to `Character`, which means each pirate must first exist as a character.

It stores:

- bounty
- tier
- threat level
- status
- role
- crew membership

#### `Marine`

This table stores Marine-specific details:

- rank
- status
- branch ID
- branch name
- stationed island

Like `Pirate`, it extends `Character`.

#### `Revolutionary`

This table stores revolutionary-specific details:

- army role
- bounty
- status
- stationed island

This is also a subtype of `Character`.

### B. Crew-related tables

#### `Crew`

Stores pirate crew information such as:

- crew ID
- crew name
- ship name
- total bounty

This table is central because many pirates are linked to a crew.

#### `CAPTAINS`

Stores captain-to-crew mapping.  
This helps identify which pirate is the captain of which crew.

#### `Jolly_Roger`

Stores the symbolic pirate flag design for a crew.

#### `Colour_Scheme`

Stores multiple colors for a crew's Jolly Roger.  
This exists because a crew can have more than one color, and multi-valued attributes should not be stored in a single column.

### C. Location-related tables

#### `Location`

This is the superclass table for places in the One Piece world.

Each location has:

- `Location_ID`
- name
- location type

#### `Island`

Stores island-specific data:

- climate
- dominant species
- strategic importance
- controlling crew

#### `Sea`

Stores sea-specific data:

- sea type
- danger level

#### `Sky_Island`

Stores sky-island-specific data:

- altitude
- cloud type
- strategic importance

### D. Power and lore-related tables

#### `Devil_Fruit`

Stores Devil Fruit details:

- name
- fruit type
- ability
- subtype

#### `EATS`

Links a character to a Devil Fruit they consumed.  
This is modeled as a separate table so the relationship is explicit and constrained.

#### `HAKI`

Stores Haki types for characters.  
Because a character can have multiple Haki types, this is a separate table with one row per `(Character_ID, Haki_Type)`.

#### `Poneglyph`

Stores Poneglyph records with:

- Poneglyph ID
- type
- last known location

#### `OWNS_PONEGLYPH`

Links crews to the Poneglyphs they own or possess.

### E. Skill-related tables

#### `Skill`

Stores individual skills and skill metadata:

- skill name
- category
- difficulty
- user ID

The schema models skills as belonging to a character, which means the project is not treating skills as completely generic abstractions. It tracks them in context of a user.

#### `HAS_SKILL`

Maps characters to skills, making skill usage explicit and queryable.

### F. Vivre Card-related tables

#### `Vivre_Card`

Stores Vivre Cards with:

- card ID
- condition
- creator ID
- current owner ID

This is a special lore-based entity in the One Piece world and is modeled carefully.

#### `HAS_CARD`

Tracks ownership of Vivre Cards.

### G. Event and conflict tables

#### `BATTLE`

Stores battle information including:

- participating faction types
- participating IDs
- location
- casualties
- winner

This is an important table because battles are not simple character-to-character events. They may involve crews, Marines, or Revolutionaries.

#### `INFO_LEAK`

Represents an information leak involving:

- a pirate
- a marine
- a poneglyph
- a location

This is modeled as an n-ary relationship.

#### `CONTEST`

Represents conflict over a Poneglyph at a location between participants such as a crew or marine side.

## 8. Why the Schema Is Strong

The schema is not random. It shows several good database-design decisions.

### Use of superclass and subclass tables

Instead of storing pirate-only or marine-only columns directly inside `Character`, the design separates them into subtype tables.  
This keeps the main `Character` table clean and avoids many null or irrelevant fields.

### Use of foreign keys

The schema heavily uses foreign keys to preserve valid relationships.  
For example:

- a pirate must reference an existing character
- a crew reference must point to a real crew
- a Poneglyph location must point to an existing location
- a Haki row must point to a real character

### Use of enums

Many columns use `ENUM` values to limit invalid input.  
Examples include:

- fruit types
- character types
- rank
- climate
- status
- Haki type

This improves consistency and prevents bad data from being inserted easily.

### Use of constraints

The schema includes checks like:

- bounty cannot be negative
- height cannot be negative
- age must be within a valid range
- altitude cannot be negative

These rules improve data integrity.

## 9. Normalization Work

One of the academically important parts of this project is normalization.

According to `phase3.pdf`, the design was taken from an ER model and converted into a relational model using standard mapping rules. After that, the design was reviewed for normalization up to **Third Normal Form (3NF)**.

### First Normal Form (1NF)

The project satisfies 1NF by ensuring:

- no repeating groups inside a row
- no multi-valued attributes stored in a single field
- atomic values in columns

Examples:

- Haki is moved into the `HAKI` table
- Jolly Roger colors are moved into `Colour_Scheme`
- names are split into first, middle, and last name instead of one complex field

### Second Normal Form (2NF)

The schema avoids partial dependency problems.  
Tables with composite keys are mostly relationship tables, and their data depends on the full key.

### Third Normal Form (3NF)

The design avoids unnecessary transitive dependencies.  
Non-key attributes generally depend on the primary key of their own table.

In short, the schema is not just functional; it is also designed with proper relational principles.

## 10. Sample Data Inserted into the Database

The `populate.sql` file is large and important because it gives life to the schema.

It inserts:

- many famous One Piece characters
- pirate crews
- locations across seas, islands, and sky islands
- Devil Fruits and abilities
- pirate, marine, and revolutionary details
- Jolly Rogers and color schemes
- Poneglyphs
- skills
- Vivre Cards
- battles
- Haki abilities
- ownership and relationship mappings

### Examples of inserted content

The dataset includes major characters such as:

- Monkey D. Luffy
- Roronoa Zoro
- Nami
- Sanji
- Whitebeard
- Big Mom
- Kaido
- Shanks
- Blackbeard
- Trafalgar Law
- Sakazuki
- Kizaru
- Aokiji
- Monkey D. Dragon
- Sabo

It also includes major crews and places such as:

- Straw Hat Pirates
- Whitebeard Pirates
- Big Mom Pirates
- Beast Pirates
- Red Hair Pirates
- Marineford
- Alabasta
- Skypiea
- Dressrosa
- Whole Cake Island
- Wano

This means the project is not empty after schema creation. It contains a meaningful fictional world dataset that can be explored immediately.

## 11. The Python Application: How It Works

The file `src/main_app.py` is the user-facing application.

### Step 1: Import libraries

The app imports:

- `pymysql` for database access
- `sys` for error output and exit handling
- `getpass` to safely accept the MySQL password without showing it on the screen

### Step 2: Database connection

The function `get_db_connection()` connects to MySQL using user-provided credentials.

Important connection details:

- host is `localhost`
- database name is `OnePieceWorld`
- cursor class is `DictCursor`
- autocommit is disabled

Using `DictCursor` is helpful because query results come back as dictionaries, which makes output formatting easier.

### Step 3: Display helper

The function `display_results()` prints results in a simple table-like format.  
It:

- checks if there are results
- extracts column names
- prints a header row
- prints each result row
- shows total number of records

This improves usability because users do not see raw Python objects.

### Step 4: Feature functions

Each menu operation is implemented as a separate Python function.  
This makes the code modular and easier to understand.

### Step 5: Main menu loop

The `main_cli()` function runs a loop that:

1. prints the main menu
2. accepts a choice
3. calls the matching function
4. waits for the user before showing the menu again

This creates a simple interactive application.

### Step 6: Graceful exit

When the user quits, the database connection is closed properly.

## 12. Read Operations in the Application

The application supports multiple query-based features.  
These are useful for searching and analyzing the One Piece dataset.

### 1. Search Characters by Name

This feature lets the user search using partial matches on:

- first name
- middle name
- last name

The query returns:

- character ID
- full name
- epithet
- age
- gender
- character type

This is a flexible lookup feature.

### 2. View Crew Members

This feature first displays all available crews.  
After the user enters a crew ID, it shows crew members sorted by bounty.

It returns:

- character ID
- full name
- epithet
- role
- bounty
- tier
- status

This helps analyze crew composition.

### 3. List Devil Fruit Users

This feature joins `Character`, `EATS`, and `Devil_Fruit` to show:

- character name
- epithet
- fruit name
- fruit type
- ability

This is a good example of a multi-table join.

### 4. Find Poneglyphs by Location

This operation first shows valid locations that contain Poneglyphs.  
Then it returns Poneglyph records for the chosen location.

It displays:

- Poneglyph ID
- type
- location name
- location type

### 5. View Battles at Location

This feature helps users see which battles happened at a selected location.

It returns:

- battle ID
- faction 1 type
- faction 2 type
- casualties
- winner
- location name

### 6. List Characters with Specific Haki

The user chooses one Haki type:

- Observation
- Armament
- Conquerors

The query returns characters who have that Haki type, along with character category information.

### 7. View Top Bounties

This query shows the highest-bounty pirates and supports a user-defined limit.

It returns:

- full name
- epithet
- bounty
- tier
- threat level
- crew name

This feature provides ranked output and uses sorting plus `LIMIT`.

### 8. List Marines by Rank

The user chooses a rank and gets a list of matching Marines.

The output includes:

- full name
- epithet
- rank
- branch
- status
- stationed location

### 9. Find Crews Owning Poneglyphs

This query shows which crews possess which Poneglyphs.

It returns:

- crew name
- ship name
- Poneglyph ID
- Poneglyph type
- last known location

### 10. List Islands by Climate

This feature filters islands by selected climate and returns:

- island name
- climate
- dominant species
- strategic importance
- controlling crew

### 11. View Crew Statistics

This is one of the more analytical operations.  
It calculates per-crew statistics using aggregation functions.

It returns:

- crew name
- ship name
- total bounty
- member count
- average bounty
- highest bounty

This demonstrates use of:

- `COUNT`
- `AVG`
- `MAX`
- `GROUP BY`
- `ORDER BY`

### 12. Find Characters by Skill Category

This feature lets the user choose a skill category and find related characters.

It returns:

- character full name
- epithet
- skill name
- category
- difficulty

This is useful for exploring ability specialization.

## 13. Write Operations in the Application

The app also supports basic data modification, not just read-only operations.

### 13. Add New Character

This feature collects user input for a new character and inserts it into the `Character` table.

It asks for:

- names
- epithet
- origin island
- origin sea
- height
- age
- gender
- character type

Once inserted, it commits the transaction and prints the new character ID.

### 14. Update Pirate Bounty

This feature updates the bounty of a pirate.

Before updating, the app checks whether the given character ID actually belongs to a pirate.  
If not, it prevents the update.

This is a good example of application-level validation before data modification.

### 15. Delete Vivre Card

This feature:

1. shows existing Vivre Cards
2. asks for card ID and creator ID
3. asks for confirmation
4. deletes the matching record if confirmed

This operation also uses commit and rollback behavior appropriately.

## 14. SQL Concepts Demonstrated in This Project

This project demonstrates many useful SQL concepts in practice.

### Basic concepts

- `CREATE DATABASE`
- `CREATE TABLE`
- `INSERT INTO`
- `SELECT`
- `UPDATE`
- `DELETE`

### Relational concepts

- primary keys
- foreign keys
- composite keys
- superclass/subclass modeling
- many-to-many relationships
- one-to-one mappings
- one-to-many mappings

### Query concepts

- joins
- left joins
- filtering with `WHERE`
- sorting with `ORDER BY`
- grouping with `GROUP BY`
- aggregate functions
- limiting with `LIMIT`

### Integrity concepts

- enums
- uniqueness
- check constraints
- transactional commit/rollback

Because of this, the project is useful not only as a fandom-themed app, but also as a learning project for relational databases.

## 15. Why This Project Is Good Academically

This project is valuable from a database-learning perspective because it combines theory and implementation.

It does not stop at:

- drawing an ER diagram
- writing a few tables
- inserting random rows

Instead, it goes further by:

- translating an ER model into relational tables
- handling specialization and multi-valued attributes properly
- normalizing the schema
- creating meaningful sample data
- building a user-facing application on top of the database

That combination makes it a complete database project rather than a partial one.

## 16. Why This Project Is Good Practically

From a practical software perspective, this project shows how backend data systems are built.

A real application often needs:

- a structured schema
- clean relationships
- controlled input
- query logic
- a user interface layer

This project includes all of those in a lightweight form.  
Even though the interface is a terminal app, the system design pattern is similar to bigger applications:

- data layer
- business/query layer
- user interaction layer

## 17. Strengths of the Project

Some strong points of the project are:

- clear separation between schema, sample data, and application code
- use of normalization and relational modeling concepts
- strong thematic dataset that makes relationships easy to understand
- multiple useful SQL queries across many related tables
- transactional handling for write operations
- beginner-friendly terminal interface

## 18. Limitations or Things That Could Be Improved

To understand the project fully, it is also useful to know what could be improved in future versions.

Possible improvements include:

- adding setup instructions for automatically creating and populating the database
- adding input validation in more places
- handling invalid numeric input more robustly
- improving formatting for long text output
- adding search by more entity types
- building a web interface instead of only a CLI
- adding stored procedures, views, or triggers
- adding tests

These do not reduce the value of the current project, but they are natural next steps.

## 19. How Someone Should Understand the Whole Project in One Shot

If someone is seeing this repository for the first time, the easiest way to understand it is this:

This project creates a **normalized MySQL database of the One Piece universe**, fills it with detailed sample data, and provides a **Python CLI application** to search, analyze, and update that world using SQL-backed operations.

The schema models:

- characters and their subtypes
- crews and captains
- islands, seas, and sky islands
- Devil Fruits and Haki
- skills and Vivre Cards
- Poneglyph ownership
- battles, information leaks, and contests

The Python app then exposes that data through menu options so a user can interact with the system without manually writing SQL queries.

## 20. Final Summary

This is a complete database application project centered on the One Piece world.  
It demonstrates:

- relational schema design
- normalization up to 3NF
- entity and relationship modeling
- sample data population
- Python and MySQL integration
- practical query and update features

Anyone reading this project should understand that it is both:

- an academic database design project
- a working software application for exploring and managing a rich fictional dataset

If you want to study the project in code order, the best path is:

1. Read `README.md`
2. Read `src/schema.sql`
3. Read `src/populate.sql`
4. Read `src/main_app.py`
5. Read `phase3.pdf`

That order shows the project from idea to structure to data to application to design reasoning.
