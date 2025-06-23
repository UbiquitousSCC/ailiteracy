import os
import sys
import json

# Fix import path issues
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))
from backend import db, create_app
from backend.models.user import User
from backend.models.course import Course, Unit
from backend.models.lesson import Lesson, MultipleChoiceQuestion, CodingExercise

# --- 1. COURSE DATA DEFINITION (VARIABLES - COMBINED) ---

VARS_COURSE = {
    "title": "Python 變數練習",
    "description": "從「小奇與魔法筆電」的冒險開始，學習 Python 的變數宣告、命名規則、資料型別與進階應用。",
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
                        "test_cases": json.dumps([{"input": "", "expected_output": "小奇\n"}]),
                        "max_score": 10
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
                        "test_cases": json.dumps([{"input": "", "expected_output": "10\n"}]),
                        "max_score": 10
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
                        "test_cases": json.dumps([{"input": "", "expected_output": "我是小奇，今年10歲，擅長雷電魔法！\n"}]),
                        "max_score": 10
                    }]
                },
                # ... 其他題目以此類推，由於大多是靜態輸出，test_cases 內容相似 ...
                {
                    "title": "Q10. 這是哪個世界的變數？",
                    "order": 10,
                    "exercises": [{
                        "type": "coding",
                        "instructions": "小奇寫下：\n```python\ndef shout():\n    spell = \"轟雷術\"\n    print(spell)\n\nshout()\nprint(spell)\n```\n**要求：**\n為什麼最後一行錯了？請用 `print()` 函數印出解釋。",
                        "starter_code": "# 請用 print() 函數解釋錯誤原因",
                        "solution_code": "print(\"因為變數 'spell' 是在函式 shout() 內部定義的，它是一個區域變數(local variable)，只在該函式內部有效。函式外部無法存取它，所以最後一行會報錯 (NameError)。\")",
                        "test_cases": json.dumps([{"input": "", "expected_output": "因為變數 'spell' 是在函式 shout() 內部定義的，它是一個區域變數(local variable)，只在該函式內部有效。函式外部無法存取它，所以最後一行會報錯 (NameError)。\n"}]),
                        "max_score": 10
                    }]
                }
            ]
        },
        {
            "title": "單元二：變數進階加強版 (Q11-Q20)",
            "description": "涵蓋變數的複合賦值、函式設計、變數交換、與型別轉換等進階技巧。",
            "order": 2,
            "lessons": [
                {
                    "title": "Q11. 能力升級後的強化計算",
                    "order": 1,
                    "exercises": [{
                        "type": "coding",
                        "instructions": "小奇擊敗兩隻怪獸，獲得了不同的獎勵。\n- 初始狀態：`level = 5`, `exp = 120`\n- 第一隻怪獸：等級 +1，經驗值 +50\n- 第二隻怪獸：等級 +2，經驗值 +80\n\n**要求：**\n請更新變數，並依照以下格式印出最終結果：\n```\n目前等級：8，總經驗值：250\n```",
                        "starter_code": "level = 5\nexp = 120\n\n# 更新等級和經驗值\n\n\n# 印出最終結果",
                        "solution_code": "level = 5\nexp = 120\n\n# 第一次獎勵\nlevel += 1\nexp += 50\n\n# 第二次獎勵\nlevel += 2\nexp += 80\n\nprint(f\"目前等級：{level}，總經驗值：{exp}\")",
                        "test_cases": json.dumps([{"input": "", "expected_output": "目前等級：8，總經驗值：250\n"}]),
                        "max_score": 15
                    }]
                },
                # ... 其他 Q12-Q20 的題目 ...
                 {
                    "title": "Q20. 型別判斷與轉換練習",
                    "order": 10,
                    "exercises": [{
                        "type": "coding",
                        "instructions": "請給出以下每個變數的型別，並嘗試將其轉為另一種型別（若可轉換）：\n```python\na = \"15\"\nb = 12\nc = \"3.14\"\nd = \"魔法\"\n```\n**要求：**\n- 依序印出 `a, b, c, d` 的原始型別。\n- 將 `a` 轉為 `int` 並印出轉換後的值與型別。\n- 將 `b` 轉為 `str` 並印出轉換後的值與型別。\n- 將 `c` 轉為 `float` 並印出轉換後的值與型別。",
                        "starter_code": "a = \"15\"\nb = 12\nc = \"3.14\"\nd = \"魔法\"\n\n# 印出原始型別\n\n# 進行轉換並印出結果",
                        "solution_code": "a = \"15\"\nb = 12\nc = \"3.14\"\nd = \"魔法\"\n\nprint(f\"a 的原始型別: {type(a)}\")\nprint(f\"b 的原始型別: {type(b)}\")\nprint(f\"c 的原始型別: {type(c)}\")\nprint(f\"d 的原始型別: {type(d)}\")\n\nprint(\"--- 轉換後 ---\")\na_int = int(a)\nprint(f\"a 轉為 int: {a_int}, 型別: {type(a_int)}\")\nb_str = str(b)\nprint(f\"b 轉為 str: '{b_str}', 型別: {type(b_str)}\")\nc_float = float(c)\nprint(f\"c 轉為 float: {c_float}, 型別: {type(c_float)}\")\nprint(\"d ('魔法') 無法直接轉換為數值型別。\")",
                        "test_cases": json.dumps([{"input": "", "expected_output": "a 的原始型別: <class 'str'>\nb 的原始型別: <class 'int'>\nc 的原始型別: <class 'str'>\nd 的原始型別: <class 'str'>\n--- 轉換後 ---\na 轉為 int: 15, 型別: <class 'int'>\nb 轉為 str: '12', 型別: <class 'str'>\nc 轉為 float: 3.14, 型別: <class 'float'>\nd ('魔法') 無法直接轉換為數值型別。\n"}]),
                        "max_score": 15
                    }]
                }
            ]
        }
    ]
}


ALL_COURSES = [
    VARS_COURSE
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
                course.description = course_data.get('description', course.description)
                db.session.commit()

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
                else:
                    unit.description = unit_data.get('description', unit.description)
                    unit.order = unit_data.get('order', unit.order)
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
                    else:
                        lesson.order = lesson_data.get('order', lesson.order)
                        db.session.commit()

                    MultipleChoiceQuestion.query.filter_by(lesson_id=lesson.id).delete()
                    CodingExercise.query.filter_by(lesson_id=lesson.id).delete()
                    db.session.commit()

                    for exercise_data in lesson_data.get('exercises', []):
                        if exercise_data['type'] == 'mcq':
                            mcq = MultipleChoiceQuestion(
                                lesson_id=lesson.id,
                                question_text=exercise_data['question'],
                                options=exercise_data['options'],
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
                                test_cases=exercise_data.get('test_cases', '[]'),
                                max_score=exercise_data.get('max_score', 0)
                            )
                            db.session.add(coding_ex)
            
            db.session.commit()
            print(f"成功更新課程 '{course_data['title']}'!")

if __name__ == "__main__":
    process_courses()