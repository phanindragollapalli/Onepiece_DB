# One Piece World Database

This project is a MySQL-backed command-line application for exploring a relational database modeled around the One Piece universe. It includes:

- a normalized schema in `src/schema.sql`
- sample data in `src/populate.sql`
- a Python CLI in `src/main_app.py`

The app connects to a local MySQL database named `OnePieceWorld`, prompts for credentials at runtime, and lets you run read/write operations without typing SQL manually.

## Tech Stack

- Python
- MySQL
- PyMySQL

## Repository Layout

- `src/schema.sql`: creates the `OnePieceWorld` database and all tables
- `src/populate.sql`: inserts sample One Piece data
- `src/main_app.py`: interactive CLI application
- `requirements.txt`: Python dependency list
- `phase3.pdf`: database design documentation
- `video_link.txt`: demo link

## Database Model

The schema uses a superclass/subclass design and several relationship tables to represent the world.

Core entities:

- `Character`
- `Crew`
- `Location`
- `Devil_Fruit`
- `Poneglyph`
- `Skill`
- `Vivre_Card`

Subtype tables:

- `Pirate`
- `Marine`
- `Revolutionary`
- `Island`
- `Sea`
- `Sky_Island`

Relationship and supporting tables:

- `CAPTAINS`
- `EATS`
- `HAS_CARD`
- `HAS_SKILL`
- `OWNS_PONEGLYPH`
- `BATTLE`
- `INFO_LEAK`
- `CONTEST`
- `Jolly_Roger`
- `Colour_Scheme`
- `HAKI`

The sample dataset includes characters, crews, Devil Fruits, islands, seas, sky islands, Haki users, Poneglyphs, battles, and crew ownership links.

## Setup

### 1. Install dependencies

```bash
pip install -r requirements.txt
```

### 2. Create and populate the database

Run the SQL files in MySQL:

```bash
mysql -u your_username -p < src/schema.sql
mysql -u your_username -p OnePieceWorld < src/populate.sql
```

`schema.sql` creates the database with:

```sql
CREATE DATABASE IF NOT EXISTS OnePieceWorld;
USE OnePieceWorld;
```

So the expected database name is fixed as `OnePieceWorld`.

### 3. Start the CLI

```bash
python src/main_app.py
```

The app will prompt for:

- MySQL username
- MySQL password

It connects to:

- host: `localhost`
- database: `OnePieceWorld`

## CLI Features

The menu exposes 15 functional requirements.

Read operations:

1. Search characters by partial first, middle, or last name
2. View all members of a selected crew
3. List all Devil Fruit users
4. Find Poneglyphs by location
5. View battles at a location
6. List characters by Haki type
7. Show top pirate bounties
8. List Marines by rank
9. Show crews that own Poneglyphs
10. List islands by climate
11. View crew statistics such as total bounty, member count, average bounty, and highest bounty
12. Find characters by skill category

Write operations:

1. Add a new character to `Character`
2. Update a pirate's bounty in `Pirate`
3. Delete a Vivre Card from `Vivre_Card`

Note: the numbered menu in the app is `1` through `15`, where `11` to `13` are write operations, `14` is crew statistics, and `15` is skill-category search.

## Application Behavior

Some implementation details from `src/main_app.py`:

- results are displayed in a simple fixed-width table format
- the app uses `DictCursor` so columns are shown by name
- transactions are committed manually for write operations
- failed writes call `rollback()`
- the program exits cleanly after closing the DB connection

## Important Assumptions

- MySQL must be running locally
- the database host is hardcoded to `localhost`
- the database name is hardcoded to `OnePieceWorld`
- the app does not create/populate the database automatically; you must run the SQL scripts first

## Known Scope

The CLI supports inserts into `Character` only. It does not walk you through creating matching subtype rows in `Pirate`, `Marine`, or `Revolutionary`, so adding a character with one of those types does not automatically populate the corresponding subtype table.

Similarly, the project is designed as a terminal-based database app, not a web app or API service.
