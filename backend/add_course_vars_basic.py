import os
import sys
import json

# Fix import path issues
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))
from backend import db, create_app
from backend.models.user import User
from backend.models.course import Course, Unit
from backend.models.lesson import Lesson, MultipleChoiceQuestion, CodingExercise

# --- 1. COURSE DATA DEFINITION (VARS_BASIC) ---

VARS_BASIC_COURSE = {
    "title": "Python 變數練習 (初階)",
    "description": "從「小奇與魔法筆電」的冒險開始，學習 Python 的變數宣告、命名規則與基礎資料型別。",
    "units": [
        {
            "title": "單元一：變數大冒險 (Q1-Q10)",
            "description": "涵蓋變數建立、字串拼接、型別轉換與區域變數等核心概念。",
            "order": 1,
            "lessons": [
                {
                    "title": "Q1. 名字魔法！",
                    "order": 1,
                    "exercises": [{
                        "type": "coding",
                        "instructions": "小奇的魔法筆電說：「我需要知道你的名字才能啟動！」\n\n**要求：**\n請建立一個變數 `wizard_name`，將 `\"小奇\"` 存入，並印出這個變數。",
                        "starter_code": "# 請建立一個變數 wizard_name，並存入指定的名字\nwizard_name = \"\"",
                        "solution_code": "wizard_name = \"小奇\"\nprint(wizard_name)",
                        "test_cases": [], "max_score": 10
                    }]
                },
                {
                    "title": "Q2. 年齡通關碼",
                    "order": 2,
                    "exercises": [{
                        "type": "coding",
                        "instructions": "筆電下一關需要輸入正確的年齡通關碼（10 歲）才能通過！\n\n**要求：**\n請建立變數 `wizard_age` 並賦值為 `10`，最後印出它。",
                        "starter_code": "# 請建立變數 wizard_age 並賦值為 10\nwizard_age =",
                        "solution_code": "wizard_age = 10\nprint(wizard_age)",
                        "test_cases": [], "max_score": 10
                    }]
                },
                {
                    "title": "Q3. 魔法卡片製作機",
                    "order": 3,
                    "exercises": [{
                        "type": "coding",
                        "instructions": "筆電說：「製作一張魔法名片吧！」\n\n**要求：**\n請建立 `wizard_name`、`wizard_age`、`element` 三個變數，並依照格式印出自我介紹。\n\n**預期輸出：**\n```\n我是小奇，今年10歲，擅長雷電魔法！\n```",
                        "starter_code": "wizard_name = \"小奇\"\nwizard_age = 10\nelement = \"雷電\"\n\n# 請使用 f-string 或 str() 組合字串並印出",
                        "solution_code": "wizard_name = \"小奇\"\nwizard_age = 10\nelement = \"雷電\"\nprint(f\"我是{wizard_name}，今年{str(wizard_age)}歲，擅長{element}魔法！\")",
                        "test_cases": [], "max_score": 10
                    }]
                },
                {
                    "title": "Q4. 魔力總分大測驗",
                    "order": 4,
                    "exercises": [{
                        "type": "coding",
                        "instructions": "小奇測驗兩種魔法：冰魔法 87 分、火魔法 91 分。\n\n**要求：**\n請用變數計算平均分數並印出結果。",
                        "starter_code": "ice_magic_score = 87\nfire_magic_score = 91\n\n# 計算平均分數\naverage_score =",
                        "solution_code": "ice_magic_score = 87\nfire_magic_score = 91\naverage_score = (ice_magic_score + fire_magic_score) / 2\nprint(average_score)",
                        "test_cases": [], "max_score": 10
                    }]
                },
                {
                    "title": "Q5. 命名錯誤大警報！",
                    "order": 5,
                    "exercises": [{
                        "type": "coding",
                        "instructions": "下列變數名稱有哪些錯誤？為什麼？\n```python\n1魔力 = 50\nmy level = 99\n角色名 = \"奇奇\"\n```\n**要求：**\n請用 `print()` 函數以字串形式說明三個變數的命名問題。",
                        "starter_code": "# 請用 print() 說明每個變數的命名錯誤",
                        "solution_code": "print(\"1魔力: 變數名稱不能以數字開頭。\")\nprint(\"my level: 變數名稱不能包含空格。\")\nprint(\"角色名: 雖然 Python 3 支援中文命名，但通常不建議，以維持程式碼的通用性與可讀性。\")",
                        "test_cases": [], "max_score": 10
                    }]
                },
                {
                    "title": "Q6. 這是什麼型別？",
                    "order": 6,
                    "exercises": [{
                        "type": "coding",
                        "instructions": "筆電給了幾個資料，要你判斷型別：\n- `\"99\"`\n- `99`\n- `3.14`\n- `\"小奇\"`\n\n**要求：**\n請依序印出每個資料的型別（str, int, float）。",
                        "starter_code": "# 請使用 type() 函數並印出結果",
                        "solution_code": "print(type(\"99\"))\nprint(type(99))\nprint(type(3.14))\nprint(type(\"小奇\"))",
                        "test_cases": [], "max_score": 10
                    }]
                },
                {
                    "title": "Q7. 錯誤魔咒解除",
                    "order": 7,
                    "exercises": [{
                        "type": "coding",
                        "instructions": "小奇寫錯程式，印不出正確句子：\n```python\nage = 10\nprint(\"我今年\" + age + \"歲\")\n```\n**要求：**\n請修正程式讓它能正確執行。",
                        "starter_code": "age = 10\n# 請修正下一行，讓文字和數字可以成功組合\nprint(\"我今年\" + age + \"歲\")",
                        "solution_code": "age = 10\nprint(\"我今年\" + str(age) + \"歲\")",
                        "test_cases": [], "max_score": 10
                    }]
                },
                {
                    "title": "Q8. 魔法角色建檔機",
                    "order": 8,
                    "exercises": [{
                        "type": "coding",
                        "instructions": "請建立角色檔案並依指定格式印出。\n\n**預期輸出：**\n```\n大家好，我是小奇，10歲，我的夥伴是小龍！\n```",
                        "starter_code": "name = \"小奇\"\nage = 10\npet = \"小龍\"\n\n# 請印出指定格式的句子",
                        "solution_code": "name = \"小奇\"\nage = 10\npet = \"小龍\"\nprint(f\"大家好，我是{name}，{age}歲，我的夥伴是{pet}！\")",
                        "test_cases": [], "max_score": 10
                    }]
                },
                {
                    "title": "Q9. 魔法任務日誌",
                    "order": 9,
                    "exercises": [{
                        "type": "coding",
                        "instructions": "請記錄今天的任務日誌。\n\n**預期輸出：**\n```\n今天我和小羽一起探險火山洞窟。\n我們找到了一顆藍色水晶！\n```",
                        "starter_code": "place = \"火山洞窟\"\nitem = \"藍色水晶\"\npartner = \"小羽\"\n\n# 請印出兩行日誌",
                        "solution_code": "place = \"火山洞窟\"\nitem = \"藍色水晶\"\npartner = \"小羽\"\nprint(f\"今天我和{partner}一起探險{place}。\")\nprint(f\"我們找到了一顆{item}！\")",
                        "test_cases": [], "max_score": 10
                    }]
                },
                {
                    "title": "Q10. 這是哪個世界的變數？",
                    "order": 10,
                    "exercises": [{
                        "type": "coding",
                        "instructions": "小奇寫下：\n```python\ndef shout():\n    spell = \"轟雷術\"\n    print(spell)\n\nshout()\nprint(spell)\n```\n**要求：**\n為什麼最後一行錯了？請用 `print()` 函數印出解釋。",
                        "starter_code": "# 請用 print() 函數解釋錯誤原因",
                        "solution_code": "print(\"因為變數 'spell' 是在函式 shout() 內部定義的，它是一個區域變數(local variable)，只在該函式內部有效。函式外部無法存取它，所以最後一行會報錯 (NameError)。\")",
                        "test_cases": [], "max_score": 10
                    }]
                }
            ]
        }
    ]
}

ALL_COURSES = [
    VARS_BASIC_COURSE
]

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