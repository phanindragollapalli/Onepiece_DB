"""
One Piece World Database - Command Line Interface
This application provides an interactive interface to query and manage the One Piece database.
"""

import pymysql
import sys
from getpass import getpass


def get_db_connection(db_user, db_pass, db_host, db_name):
    """Establishes a connection to the MySQL database."""
    try:
        connection = pymysql.connect(
            host=db_host,
            user=db_user,
            password=db_pass,
            database=db_name,
            cursorclass=pymysql.cursors.DictCursor,
            autocommit=False
        )
        print("✓ Database connection successful.")
        return connection
    except pymysql.Error as e:
        print(f"✗ Error connecting to MySQL Database: {e}", file=sys.stderr)
        return None


def display_results(results, title="Results"):
    """Display query results in a formatted table."""
    if not results:
        print("No results found.")
        return
    
    print(f"\n{'='*80}")
    print(f"{title}")
    print(f"{'='*80}")
    
    # Get column names from first row
    columns = list(results[0].keys())
    
    # Print header
    header = " | ".join(str(col)[:20].ljust(20) for col in columns)
    print(header)
    print("-" * len(header))
    
    # Print rows
    for row in results:
        row_data = " | ".join(str(row[col])[:20].ljust(20) if row[col] is not None else "NULL".ljust(20) for col in columns)
        print(row_data)
    
    print(f"\nTotal records: {len(results)}\n")


# ========================================
# FUNCTIONAL REQUIREMENT FUNCTIONS
# ========================================

def search_characters_by_name(connection):
    """FR1: Search for characters by name (partial match)."""
    print("\n--- Search Characters by Name ---")
    search_name = input("Enter character name (or part of name): ").strip()
    
    try:
        with connection.cursor() as cursor:
            sql_query = """
                SELECT Character_ID, 
                       CONCAT_WS(' ', First_Name, Middle_Name, Last_Name) AS Full_Name,
                       Epithet, Age, Gender, Character_Type
                FROM Character
                WHERE First_Name LIKE %s 
                   OR Last_Name LIKE %s 
                   OR Middle_Name LIKE %s
                ORDER BY Character_ID
            """
            cursor.execute(sql_query, (f'%{search_name}%', f'%{search_name}%', f'%{search_name}%'))
            results = cursor.fetchall()
            display_results(results, f"Characters matching '{search_name}'")
    except pymysql.Error as e:
        print(f"Error during query: {e}", file=sys.stderr)


def view_crew_members(connection):
    """FR2: View all members of a specific crew."""
    print("\n--- View Crew Members ---")
    
    # First, show available crews
    try:
        with connection.cursor() as cursor:
            cursor.execute("SELECT Crew_ID, Crew_Name, Ship_Name FROM Crew ORDER BY Crew_Name")
            crews = cursor.fetchall()
            
            print("\nAvailable Crews:")
            for crew in crews:
                print(f"  {crew['Crew_ID']}: {crew['Crew_Name']} (Ship: {crew['Ship_Name']})")
            
            crew_id = input("\nEnter Crew ID: ").strip()
            
            sql_query = """
                SELECT c.Character_ID,
                       CONCAT_WS(' ', c.First_Name, c.Middle_Name, c.Last_Name) AS Full_Name,
                       c.Epithet,
                       p.Role,
                       p.Bounty,
                       p.Tier,
                       p.Status
                FROM Character c
                JOIN Pirate p ON c.Character_ID = p.Character_ID
                JOIN Crew cr ON p.Crew_ID = cr.Crew_ID
                WHERE cr.Crew_ID = %s
                ORDER BY p.Bounty DESC
            """
            cursor.execute(sql_query, (crew_id,))
            results = cursor.fetchall()
            display_results(results, f"Members of Crew ID {crew_id}")
    except pymysql.Error as e:
        print(f"Error during query: {e}", file=sys.stderr)


def list_devil_fruit_users(connection):
    """FR3: List all characters who have eaten a Devil Fruit."""
    print("\n--- Devil Fruit Users ---")
    
    try:
        with connection.cursor() as cursor:
            sql_query = """
                SELECT CONCAT_WS(' ', c.First_Name, c.Middle_Name, c.Last_Name) AS Full_Name,
                       c.Epithet,
                       df.Fruit_Name,
                       df.Fruit_Type,
                       df.Ability
                FROM Character c
                JOIN EATS e ON c.Character_ID = e.Character_ID
                JOIN Devil_Fruit df ON e.Fruit_ID = df.Fruit_ID
                ORDER BY df.Fruit_Type, c.First_Name
            """
            cursor.execute(sql_query)
            results = cursor.fetchall()
            display_results(results, "Devil Fruit Users")
    except pymysql.Error as e:
        print(f"Error during query: {e}", file=sys.stderr)


def find_poneglyphs_by_location(connection):
    """FR4: Find Poneglyphs at a specific location."""
    print("\n--- Find Poneglyphs by Location ---")
    
    try:
        with connection.cursor() as cursor:
            # Show available locations with poneglyphs
            cursor.execute("""
                SELECT DISTINCT l.Location_ID, l.Name, l.Location_Type
                FROM Location l
                JOIN Poneglyph p ON l.Location_ID = p.Last_Known_Location_ID
                ORDER BY l.Name
            """)
            locations = cursor.fetchall()
            
            print("\nLocations with Poneglyphs:")
            for loc in locations:
                print(f"  {loc['Location_ID']}: {loc['Name']} ({loc['Location_Type']})")
            
            location_id = input("\nEnter Location ID: ").strip()
            
            sql_query = """
                SELECT p.Poneglyph_ID,
                       p.Type,
                       l.Name AS Location_Name,
                       l.Location_Type
                FROM Poneglyph p
                JOIN Location l ON p.Last_Known_Location_ID = l.Location_ID
                WHERE l.Location_ID = %s
            """
            cursor.execute(sql_query, (location_id,))
            results = cursor.fetchall()
            display_results(results, f"Poneglyphs at Location ID {location_id}")
    except pymysql.Error as e:
        print(f"Error during query: {e}", file=sys.stderr)


def view_battles_at_location(connection):
    """FR5: View all battles that occurred at a specific location."""
    print("\n--- View Battles at Location ---")
    
    try:
        with connection.cursor() as cursor:
            # Show locations with battles
            cursor.execute("""
                SELECT DISTINCT l.Location_ID, l.Name
                FROM Location l
                JOIN BATTLE b ON l.Location_ID = b.Location_ID
                ORDER BY l.Name
            """)
            locations = cursor.fetchall()
            
            print("\nLocations with Battles:")
            for loc in locations:
                print(f"  {loc['Location_ID']}: {loc['Name']}")
            
            location_id = input("\nEnter Location ID: ").strip()
            
            sql_query = """
                SELECT b.Battle_ID,
                       b.Faction1_Type,
                       b.Faction2_Type,
                       b.Casualities,
                       b.Winner,
                       l.Name AS Location_Name
                FROM BATTLE b
                JOIN Location l ON b.Location_ID = l.Location_ID
                WHERE l.Location_ID = %s
            """
            cursor.execute(sql_query, (location_id,))
            results = cursor.fetchall()
            display_results(results, f"Battles at Location ID {location_id}")
    except pymysql.Error as e:
        print(f"Error during query: {e}", file=sys.stderr)


def list_characters_with_haki(connection):
    """FR6: List all characters who can use a specific type of Haki."""
    print("\n--- Characters with Haki ---")
    print("Haki Types: 1) Observation  2) Armament  3) Conquerors")
    
    haki_choice = input("Enter choice (1-3): ").strip()
    haki_map = {'1': 'Observation', '2': 'Armament', '3': 'Conquerors'}
    
    if haki_choice not in haki_map:
        print("Invalid choice.")
        return
    
    haki_type = haki_map[haki_choice]
    
    try:
        with connection.cursor() as cursor:
            sql_query = """
                SELECT CONCAT_WS(' ', c.First_Name, c.Middle_Name, c.Last_Name) AS Full_Name,
                       c.Epithet,
                       c.Character_Type,
                       h.Haki_Type
                FROM Character c
                JOIN HAKI h ON c.Character_ID = h.Character_ID
                WHERE h.Haki_Type = %s
                ORDER BY c.Character_Type, c.First_Name
            """
            cursor.execute(sql_query, (haki_type,))
            results = cursor.fetchall()
            display_results(results, f"Characters with {haki_type} Haki")
    except pymysql.Error as e:
        print(f"Error during query: {e}", file=sys.stderr)


def view_top_bounties(connection):
    """FR7: View pirates with the highest bounties."""
    print("\n--- Top Bounties ---")
    
    limit = input("How many top bounties to display? (default: 10): ").strip()
    limit = int(limit) if limit.isdigit() else 10
    
    try:
        with connection.cursor() as cursor:
            sql_query = """
                SELECT CONCAT_WS(' ', c.First_Name, c.Middle_Name, c.Last_Name) AS Full_Name,
                       c.Epithet,
                       p.Bounty,
                       p.Tier,
                       p.Threat_Level,
                       cr.Crew_Name
                FROM Character c
                JOIN Pirate p ON c.Character_ID = p.Character_ID
                LEFT JOIN Crew cr ON p.Crew_ID = cr.Crew_ID
                ORDER BY p.Bounty DESC
                LIMIT %s
            """
            cursor.execute(sql_query, (limit,))
            results = cursor.fetchall()
            display_results(results, f"Top {limit} Bounties")
    except pymysql.Error as e:
        print(f"Error during query: {e}", file=sys.stderr)


def list_marines_by_rank(connection):
    """FR8: List all Marines of a specific rank."""
    print("\n--- Marines by Rank ---")
    print("Ranks: 1) Fleet Admiral  2) Admiral  3) Vice Admiral  4) Captain  5) Lieutenant")
    
    rank_choice = input("Enter choice (1-5): ").strip()
    rank_map = {
        '1': 'Fleet Admiral',
        '2': 'Admiral',
        '3': 'Vice Admiral',
        '4': 'Captain',
        '5': 'Lieutenant'
    }
    
    if rank_choice not in rank_map:
        print("Invalid choice.")
        return
    
    rank = rank_map[rank_choice]
    
    try:
        with connection.cursor() as cursor:
            sql_query = """
                SELECT CONCAT_WS(' ', c.First_Name, c.Middle_Name, c.Last_Name) AS Full_Name,
                       c.Epithet,
                       m.Rank,
                       m.Branch_Name,
                       m.Status,
                       l.Name AS Stationed_Location
                FROM Character c
                JOIN Marine m ON c.Character_ID = m.Character_ID
                LEFT JOIN Island i ON m.Stationed_Island_ID = i.Location_ID
                LEFT JOIN Location l ON i.Location_ID = l.Location_ID
                WHERE m.Rank = %s
                ORDER BY c.First_Name
            """
            cursor.execute(sql_query, (rank,))
            results = cursor.fetchall()
            display_results(results, f"Marines with rank: {rank}")
    except pymysql.Error as e:
        print(f"Error during query: {e}", file=sys.stderr)


def find_crew_by_poneglyph_ownership(connection):
    """FR9: Find which crews own specific Road Poneglyphs."""
    print("\n--- Crews Owning Poneglyphs ---")
    
    try:
        with connection.cursor() as cursor:
            sql_query = """
                SELECT cr.Crew_Name,
                       cr.Ship_Name,
                       p.Poneglyph_ID,
                       p.Type,
                       l.Name AS Last_Known_Location
                FROM Crew cr
                JOIN OWNS_PONEGLYPH op ON cr.Crew_ID = op.Crew_ID
                JOIN Poneglyph p ON op.Poneglyph_ID = p.Poneglyph_ID
                LEFT JOIN Location l ON p.Last_Known_Location_ID = l.Location_ID
                ORDER BY p.Type, cr.Crew_Name
            """
            cursor.execute(sql_query)
            results = cursor.fetchall()
            display_results(results, "Crews Owning Poneglyphs")
    except pymysql.Error as e:
        print(f"Error during query: {e}", file=sys.stderr)


def list_islands_by_climate(connection):
    """FR10: List islands with a specific climate."""
    print("\n--- Islands by Climate ---")
    print("Climates: 1) Tropical  2) Winter  3) Desert  4) Temperate  5) Extreme")
    
    climate_choice = input("Enter choice (1-5): ").strip()
    climate_map = {
        '1': 'Tropical',
        '2': 'Winter',
        '3': 'Desert',
        '4': 'Temperate',
        '5': 'Extreme'
    }
    
    if climate_choice not in climate_map:
        print("Invalid choice.")
        return
    
    climate = climate_map[climate_choice]
    
    try:
        with connection.cursor() as cursor:
            sql_query = """
                SELECT l.Name AS Island_Name,
                       i.Climate,
                       i.Dominant_Species,
                       i.Strategic_Importance,
                       cr.Crew_Name AS Controlling_Crew
                FROM Location l
                JOIN Island i ON l.Location_ID = i.Location_ID
                LEFT JOIN Crew cr ON i.Controlling_Crew_ID = cr.Crew_ID
                WHERE i.Climate = %s
                ORDER BY i.Strategic_Importance DESC, l.Name
            """
            cursor.execute(sql_query, (climate,))
            results = cursor.fetchall()
            display_results(results, f"Islands with {climate} climate")
    except pymysql.Error as e:
        print(f"Error during query: {e}", file=sys.stderr)


def add_new_character(connection):
    """FR11: Add a new character to the database."""
    print("\n--- Add New Character ---")
    
    try:
        first_name = input("First Name: ").strip()
        middle_name = input("Middle Name (press Enter to skip): ").strip() or None
        last_name = input("Last Name (press Enter to skip): ").strip() or None
        epithet = input("Epithet (press Enter to skip): ").strip() or None
        origin_island = input("Origin Island Name: ").strip()
        origin_sea = input("Origin Sea Name: ").strip()
        height = float(input("Height (in cm): ").strip())
        age = int(input("Age: ").strip())
        
        print("Gender: 1) Male  2) Female  3) Other")
        gender_choice = input("Enter choice: ").strip()
        gender_map = {'1': 'Male', '2': 'Female', '3': 'Other'}
        gender = gender_map.get(gender_choice, 'Male')
        
        print("Character Type: 1) Pirate  2) Marine  3) Revolutionary  4) Civilian")
        type_choice = input("Enter choice: ").strip()
        type_map = {'1': 'Pirate', '2': 'Marine', '3': 'Revolutionary', '4': 'Civilian'}
        character_type = type_map.get(type_choice, 'Civilian')
        
        with connection.cursor() as cursor:
            sql_query = """
                INSERT INTO Character 
                (First_Name, Middle_Name, Last_Name, Epithet, Origin_Island_Name, 
                 Origin_Sea_Name, Height, Age, Gender, Character_Type)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            """
            cursor.execute(sql_query, (first_name, middle_name, last_name, epithet,
                                      origin_island, origin_sea, height, age, 
                                      gender, character_type))
            connection.commit()
            print(f"✓ Character '{first_name}' added successfully with ID: {cursor.lastrowid}")
    except ValueError:
        print("Invalid input format.")
    except pymysql.Error as e:
        connection.rollback()
        print(f"Error adding character: {e}", file=sys.stderr)


def update_pirate_bounty(connection):
    """FR12: Update a pirate's bounty."""
    print("\n--- Update Pirate Bounty ---")
    
    try:
        character_id = input("Enter Character ID of the pirate: ").strip()
        new_bounty = input("Enter new bounty amount: ").strip()
        
        with connection.cursor() as cursor:
            # Verify it's a pirate
            cursor.execute("SELECT Character_ID FROM Pirate WHERE Character_ID = %s", (character_id,))
            if not cursor.fetchone():
                print("Character is not a pirate or does not exist.")
                return
            
            sql_query = "UPDATE Pirate SET Bounty = %s WHERE Character_ID = %s"
            cursor.execute(sql_query, (new_bounty, character_id))
            connection.commit()
            print(f"✓ Bounty updated successfully for Character ID {character_id}")
    except pymysql.Error as e:
        connection.rollback()
        print(f"Error updating bounty: {e}", file=sys.stderr)


def delete_vivre_card(connection):
    """FR13: Delete a Vivre Card."""
    print("\n--- Delete Vivre Card ---")
    
    try:
        with connection.cursor() as cursor:
            # Show existing vivre cards
            cursor.execute("""
                SELECT v.Card_ID, v.Creator_ID, v.Condition,
                       CONCAT_WS(' ', c.First_Name, c.Last_Name) AS Creator_Name
                FROM Vivre_Card v
                JOIN Character c ON v.Creator_ID = c.Character_ID
                ORDER BY v.Card_ID
            """)
            cards = cursor.fetchall()
            
            print("\nExisting Vivre Cards:")
            for card in cards:
                print(f"  Card ID: {card['Card_ID']}, Creator ID: {card['Creator_ID']}, "
                      f"Creator: {card['Creator_Name']}, Condition: {card['Condition']}")
            
            card_id = input("\nEnter Card ID to delete: ").strip()
            creator_id = input("Enter Creator ID: ").strip()
            
            confirm = input(f"Are you sure you want to delete Vivre Card {card_id}? (yes/no): ").strip().lower()
            
            if confirm == 'yes':
                sql_query = "DELETE FROM Vivre_Card WHERE Card_ID = %s AND Creator_ID = %s"
                cursor.execute(sql_query, (card_id, creator_id))
                connection.commit()
                
                if cursor.rowcount > 0:
                    print(f"✓ Vivre Card {card_id} deleted successfully.")
                else:
                    print("No matching Vivre Card found.")
            else:
                print("Deletion cancelled.")
    except pymysql.Error as e:
        connection.rollback()
        print(f"Error deleting Vivre Card: {e}", file=sys.stderr)


def view_crew_statistics(connection):
    """FR14: View statistics about crews (total bounty, member count, etc.)."""
    print("\n--- Crew Statistics ---")
    
    try:
        with connection.cursor() as cursor:
            sql_query = """
                SELECT cr.Crew_Name,
                       cr.Ship_Name,
                       cr.Total_Bounty,
                       COUNT(p.Character_ID) AS Member_Count,
                       AVG(p.Bounty) AS Avg_Bounty,
                       MAX(p.Bounty) AS Highest_Bounty
                FROM Crew cr
                LEFT JOIN Pirate p ON cr.Crew_ID = p.Crew_ID
                GROUP BY cr.Crew_ID, cr.Crew_Name, cr.Ship_Name, cr.Total_Bounty
                ORDER BY cr.Total_Bounty DESC
            """
            cursor.execute(sql_query)
            results = cursor.fetchall()
            display_results(results, "Crew Statistics")
    except pymysql.Error as e:
        print(f"Error during query: {e}", file=sys.stderr)


def find_characters_by_skill(connection):
    """FR15: Find characters who have mastered a specific skill category."""
    print("\n--- Find Characters by Skill Category ---")
    print("Categories: 1) Swordsmanship  2) Hand-to-Hand Combat  3) Medical  4) Navigation")
    print("            5) Engineering  6) Cooking  7) Marksmanship  8) Other")
    
    category_choice = input("Enter choice (1-8): ").strip()
    category_map = {
        '1': 'Swordsmanship',
        '2': 'Hand-to-Hand Combat',
        '3': 'Medical',
        '4': 'Navigation',
        '5': 'Engineering',
        '6': 'Cooking',
        '7': 'Marksmanship',
        '8': 'Other'
    }
    
    if category_choice not in category_map:
        print("Invalid choice.")
        return
    
    category = category_map[category_choice]
    
    try:
        with connection.cursor() as cursor:
            sql_query = """
                SELECT DISTINCT CONCAT_WS(' ', c.First_Name, c.Middle_Name, c.Last_Name) AS Full_Name,
                       c.Epithet,
                       s.Skill_Name,
                       s.Category,
                       s.Difficulty
                FROM Character c
                JOIN HAS_SKILL hs ON c.Character_ID = hs.Character_ID
                JOIN Skill s ON hs.Skill_ID = s.Skill_ID AND hs.User_ID = s.User_ID
                WHERE s.Category = %s
                ORDER BY s.Difficulty DESC, c.First_Name
            """
            cursor.execute(sql_query, (category,))
            results = cursor.fetchall()
            display_results(results, f"Characters with {category} skills")
    except pymysql.Error as e:
        print(f"Error during query: {e}", file=sys.stderr)


# ========================================
# MAIN CLI INTERFACE
# ========================================

def main_cli(connection):
    """The main command-line interface loop."""
    while True:
        print("\n" + "="*80)
        print(" ONE PIECE WORLD DATABASE - MAIN MENU".center(80))
        print("="*80)
        print("\n📖 READ OPERATIONS:")
        print("  1. Search Characters by Name")
        print("  2. View Crew Members")
        print("  3. List Devil Fruit Users")
        print("  4. Find Poneglyphs by Location")
        print("  5. View Battles at Location")
        print("  6. List Characters with Specific Haki")
        print("  7. View Top Bounties")
        print("  8. List Marines by Rank")
        print("  9. Find Crews Owning Poneglyphs")
        print(" 10. List Islands by Climate")
        print(" 14. View Crew Statistics")
        print(" 15. Find Characters by Skill Category")
        
        print("\n✏️  WRITE OPERATIONS:")
        print(" 11. Add New Character")
        print(" 12. Update Pirate Bounty")
        print(" 13. Delete Vivre Card")
        
        print("\n  Q. Quit Application")
        print("="*80)
        
        choice = input("\nEnter your choice: ").strip().lower()
        
        if choice == '1':
            search_characters_by_name(connection)
        elif choice == '2':
            view_crew_members(connection)
        elif choice == '3':
            list_devil_fruit_users(connection)
        elif choice == '4':
            find_poneglyphs_by_location(connection)
        elif choice == '5':
            view_battles_at_location(connection)
        elif choice == '6':
            list_characters_with_haki(connection)
        elif choice == '7':
            view_top_bounties(connection)
        elif choice == '8':
            list_marines_by_rank(connection)
        elif choice == '9':
            find_crew_by_poneglyph_ownership(connection)
        elif choice == '10':
            list_islands_by_climate(connection)
        elif choice == '11':
            add_new_character(connection)
        elif choice == '12':
            update_pirate_bounty(connection)
        elif choice == '13':
            delete_vivre_card(connection)
        elif choice == '14':
            view_crew_statistics(connection)
        elif choice == '15':
            find_characters_by_skill(connection)
        elif choice == 'q':
            print("\n👋 Exiting application...")
            break
        else:
            print("❌ Invalid choice. Please try again.")
        
        input("\nPress Enter to continue...")


# ========================================
# APPLICATION ENTRY POINT
# ========================================

if __name__ == "__main__":
    # Database configuration
    DB_HOST = 'localhost'
    DB_NAME = 'OnePieceWorld'
    
    print("\n" + "="*80)
    print(" WELCOME TO ONE PIECE WORLD DATABASE".center(80))
    print("="*80)
    print("\n🔐 Please enter your MySQL credentials.\n")
    
    DB_USER = input("Username: ").strip()
    DB_PASS = getpass("Password: ")
    
    # Establish connection
    db_conn = get_db_connection(DB_USER, DB_PASS, DB_HOST, DB_NAME)
    
    if db_conn:
        try:
            main_cli(db_conn)
        finally:
            if db_conn:
                db_conn.close()
                print("✓ Database connection closed.")
    else:
        print("❌ Failed to connect to the database. Application will exit.")
        sys.exit(1)
