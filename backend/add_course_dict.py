import os
import sys
import json

# Fix import path issues
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))
from backend import db, create_app
from backend.models.user import User
from backend.models.course import Course, Unit
from backend.models.lesson import Lesson, MultipleChoiceQuestion, CodingExercise

# --- 1. COURSE DATA DEFINITION (DICTIONARY) ---

DICTIONARY_COURSE = {
    "title": "Python 字典練習",
    "description": "學習使用 Python 的字典（Dictionary）來儲存和管理鍵值對（key-value pair）資料。",
    "units": [
        {
            "title": "單元一：魔法筆記本 (Q1-Q10)",
            "description": "涵蓋字典的增刪改查、遍歷、以及結合迴圈與函式的進階應用。",
            "order": 1,
            "lessons": [
                {"title": "Q1. 魔法筆記本的第一筆記錄", "order": 1, "exercises": [{"type": "coding", "instructions": "小魔法師艾莉絲獲得一本筆記本，請她記下第一筆資料：「apple」是「紅色的水果」。\n\n**要求：**\n建立一個字典，新增一筆資料後，將整個字典印出。", "starter_code": "# 建立一個空字典\nnotebook = {}\n\n# 新增資料\n\n\n# 印出字典\nprint(notebook)", "solution_code": "notebook = {}\nnotebook[\"apple\"] = \"紅色的水果\"\nprint(notebook)", "test_cases": [], "max_score": 10}]},
                {"title": "Q2. 問問魔法筆記本：這是什麼？", "order": 2, "exercises": [{"type": "coding", "instructions": "請從下方已建立的筆記本中，查詢並印出 \"banana\" 對應的值。", "starter_code": "notebook = {\"apple\": \"紅色的水果\", \"banana\": \"黃色的水果\"}\n\n# 查詢並印出 banana 的值", "solution_code": "notebook = {\"apple\": \"紅色的水果\", \"banana\": \"黃色的水果\"}\nprint(notebook[\"banana\"])", "test_cases": [], "max_score": 10}]},
                {"title": "Q3. 魔法筆記出錯了！快刪掉它！", "order": 3, "exercises": [{"type": "coding", "instructions": "dragonfruit 被錯誤記成「會噴火的水果」，請從字典中刪除這筆記錄，並印出刪除後的字典。", "starter_code": "notebook = {\"apple\": \"紅色的水果\", \"dragonfruit\": \"會噴火的水果\"}\n\n# 刪除 dragonfruit\n\n\nprint(notebook)", "solution_code": "notebook = {\"apple\": \"紅色的水果\", \"dragonfruit\": \"會噴火的水果\"}\ndel notebook[\"dragonfruit\"]\nprint(notebook)", "test_cases": [], "max_score": 10}]},
                {"title": "Q4. 有沒有這個項目？", "order": 4, "exercises": [{"type": "coding", "instructions": "請查詢筆記本中是否記錄了 \"grape\" 這個鍵，印出判斷結果 (True/False)。", "starter_code": "notebook = {\"apple\": \"紅色的水果\", \"banana\": \"黃色的水果\"}\n\n# 判斷 \"grape\" 是否在字典的鍵中\nresult = \nprint(result)", "solution_code": "notebook = {\"apple\": \"紅色的水果\", \"banana\": \"黃色的水果\"}\nresult = \"grape\" in notebook\nprint(result)", "test_cases": [], "max_score": 10}]},
                {"title": "Q5. 龍的多重能力", "order": 5, "exercises": [{"type": "coding", "instructions": "請在字典中，將 \"dragon\" 的能力記錄成一個列表，包含「噴火」、「飛行」、「守寶藏」，並印出這個字典。", "starter_code": "abilities = {}\n\n# 將一個列表賦值給 \"dragon\" 鍵\n\n\nprint(abilities)", "solution_code": "abilities = {}\nabilities[\"dragon\"] = [\"噴火\", \"飛行\", \"守寶藏\"]\nprint(abilities)", "test_cases": [], "max_score": 15}]},
                {"title": "Q6. 計算魔力平均", "order": 6, "exercises": [{"type": "coding", "instructions": "計算下列魔法師的平均魔力分數，並印出結果。", "starter_code": "magic_scores = {\"艾莉絲\": 85, \"鮑伯\": 72, \"查理\": 91}\n\n# 計算平均分數\naverage_score = \nprint(average_score)", "solution_code": "magic_scores = {\"艾莉絲\": 85, \"鮑伯\": 72, \"查理\": 91}\naverage_score = sum(magic_scores.values()) / len(magic_scores)\nprint(average_score)", "test_cases": [], "max_score": 15}]},
                {"title": "Q7. 魔杖配對任務", "order": 7, "exercises": [{"type": "coding", "instructions": "給定兩個 list，請幫每位學徒配對魔杖，轉換成一個字典後印出。", "starter_code": "apprentices = [\"小明\", \"小華\", \"小莉\"]\nwands = [\"橡木魔杖\", \"柳木魔杖\", \"杉木魔杖\"]\n\n# 使用 zip 和 dict 進行配對\nwand_pairs = \nprint(wand_pairs)", "solution_code": "apprentices = [\"小明\", \"小華\", \"小莉\"]\nwands = [\"橡木魔杖\", \"柳木魔杖\", \"杉木魔杖\"]\nwand_pairs = dict(zip(apprentices, wands))\nprint(wand_pairs)", "test_cases": [], "max_score": 15}]},
                {"title": "Q8. 字符出現次數", "order": 8, "exercises": [{"type": "coding", "instructions": "請統計字串 \"abracadabra\" 中每個字元出現的次數，並將結果以字典形式印出。", "starter_code": "text = \"abracadabra\"\nchar_counts = {}\n\n# 使用 for 迴圈遍歷字串並計數\n\nprint(char_counts)", "solution_code": "text = \"abracadabra\"\nchar_counts = {}\nfor char in text:\n    if char not in char_counts:\n        char_counts[char] = 0\n    char_counts[char] += 1\nprint(char_counts)", "test_cases": [], "max_score": 20}]},
                {"title": "Q9. 找出最高魔力者", "order": 9, "exercises": [{"type": "coding", "instructions": "從字典中，找出分數最高的魔法師與他的分數，並依 `姓名: 分數` 的格式印出。", "starter_code": "magic_scores = {\"艾莉絲\": 85, \"鮑伯\": 72, \"查理\": 91}\n\n# 找出最高分的魔法師\nhighest_scorer = \nhighest_score = \nprint(f\"{highest_scorer}: {highest_score}\")", "solution_code": "magic_scores = {\"艾莉絲\": 85, \"鮑伯\": 72, \"查理\": 91}\nhighest_scorer = max(magic_scores, key=magic_scores.get)\nhighest_score = magic_scores[highest_scorer]\nprint(f\"{highest_scorer}: {highest_score}\")", "test_cases": [], "max_score": 20}]},
                {"title": "Q10. 找出指定顏色的魔法物品", "order": 10, "exercises": [{"type": "coding", "instructions": "找出所有顏色為 \"red\" 的魔法物品，並將它們的名稱以列表形式印出。", "starter_code": "magic_items = {\"紅寶石\": \"red\", \"藍水晶\": \"blue\", \"力量藥水\": \"red\"}\nred_items = []\n\n# 遍歷字典找出紅色的物品\n\nprint(red_items)", "solution_code": "magic_items = {\"紅寶石\": \"red\", \"藍水晶\": \"blue\", \"力量藥水\": \"red\"}\nred_items = []\nfor item, color in magic_items.items():\n    if color == \"red\":\n        red_items.append(item)\nprint(red_items)", "test_cases": [], "max_score": 20}]}
            ]
        }
    ]
}

ALL_COURSES = [
    DICTIONARY_COURSE
]

# (The rest of the process_courses function is identical to the first file)
def process_courses():
    """Adds or updates a list of courses, units, and lessons to the database."""
    app = create_app()
    with app.app_context():
        # --- 2. GET CREATOR ---
        creator_username = 'teacher1'
        creator = User.query.filter_by(username=creator_username).first()
        if not creator:
            print(f"Creator '{creator_username}' not found. Trying to find any teacher.")
            creator = User.query.filter_by(role='teacher').first()
            if not creator:
                print("No teachers found in the database. Please add a teacher first.")
                return
            print(f"Using '{creator.username}' as the course creator.")

        # --- 3. DATABASE WRITE LOGIC ---
        for course_data in ALL_COURSES:
            print(f"\n--- 正在處理課程: '{course_data['title']}' ---")
            
            course = Course.query.filter_by(title=course_data['title']).first()
            if not course:
                print(f"課程不存在，正在建立...")
                course = Course(
                    title=course_data['title'],
                    description=course_data.get('description', ''),
                    creator_id=creator.id
                )
                db.session.add(course)
                db.session.commit()
            else:
                print(f"課程已存在，正在檢查並更新內容...")

            for unit_data in course_data['units']:
                unit = Unit.query.filter_by(title=unit_data['title'], course_id=course.id).first()
                if not unit:
                    print(f"  - 新增單元: '{unit_data['title']}'")
                    unit = Unit(
                        title=unit_data['title'],
                        description=unit_data.get('description', ''),
                        order=unit_data['order'],
                        course_id=course.id
                    )
                    db.session.add(unit)
                    db.session.commit()
                
                for lesson_data in unit_data['lessons']:
                    lesson = Lesson.query.filter_by(title=lesson_data['title'], unit_id=unit.id).first()
                    if not lesson:
                        print(f"    - 新增課節: '{lesson_data['title']}'")
                        lesson = Lesson(
                            title=lesson_data['title'],
                            description=lesson_data.get('description', ''),
                            order=lesson_data['order'],
                            unit_id=unit.id
                        )
                        db.session.add(lesson)
                        db.session.commit()

                    # Clear existing exercises to avoid duplicates and ensure content is up-to-date
                    MultipleChoiceQuestion.query.filter_by(lesson_id=lesson.id).delete()
                    CodingExercise.query.filter_by(lesson_id=lesson.id).delete()
                    db.session.commit()

                    for exercise_data in lesson_data.get('exercises', []):
                        if exercise_data['type'] == 'mcq':
                            mcq = MultipleChoiceQuestion(
                                lesson_id=lesson.id,
                                question_text=exercise_data['question'],
                                options=json.dumps(exercise_data['options']),
                                correct_option_index=exercise_data['correct_index'],
                                explanation=exercise_data.get('explanation', ''),
                                points=exercise_data.get('points', 0)
                            )
                            db.session.add(mcq)
                        elif exercise_data['type'] == 'coding':
                            coding_ex = CodingExercise(
                                lesson_id=lesson.id,
                                instructions=exercise_data['instructions'],
                                starter_code=exercise_data['starter_code'],
                                solution_code=exercise_data['solution_code'],
                                test_cases=json.dumps(exercise_data.get('test_cases', [])),
                                max_score=exercise_data.get('max_score', 0)
                            )
                            db.session.add(coding_ex)
            
            db.session.commit()
            print(f"成功更新課程 '{course_data['title']}'!")

if __name__ == "__main__":
    process_courses()