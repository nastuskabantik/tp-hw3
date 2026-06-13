import csv
import random
import os
import sys

NUM_ROWS = 100
COLUMNS = ["Dance_Style", "Duration_Months", "Students_Count", "Level"]

def generate_row():
    styles = ["Hip-Hop", "Ballet", "Salsa", "Breakdance", "Bachata", "Contemporary", "Jazz-Funk", "Vogue"]
    levels = ["Beginner", "Intermediate", "Advanced", "Pro"]
    
    return {
        "Dance_Style": random.choice(styles),
        "Duration_Months": round(random.uniform(1.0, 12.0), 1),
        "Students_Count": random.randint(5, 40),
        "Level": random.choice(levels),
    }

OUTPUT_DIR = sys.argv[1] if len(sys.argv) > 1 else "/data"
OUTPUT_FILE = os.path.join(OUTPUT_DIR, "data.csv")

os.makedirs(OUTPUT_DIR, exist_ok=True)

rows = [generate_row() for _ in range(NUM_ROWS)]

with open(OUTPUT_FILE, "w", newline="", encoding="utf-8") as f:
    writer = csv.DictWriter(f, fieldnames=COLUMNS)
    writer.writeheader()
    writer.writerows(rows)