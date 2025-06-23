import os
import sys
import json

# Fix import path issues
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))
from backend import db, create_app
from backend.models.user import User
from backend.models.course import Course, Unit
from backend.models.lesson import Lesson, MultipleChoiceQuestion, CodingExercise

# --- 1. COURSE DATA DEFINITION (OPERATORS - COMBINED) ---

OPERATORS_COURSE = {
    "title": "Python 運算子練習",
    "description": "學習 Python 中的算術、比較、邏輯運算子，並應用於實戰情境解決問題。",
    "units": [
        {
            "title": "單元一：運算子的魔法挑戰 (Q21-Q30)",
            "description": "包含加減乘除、大小比較 (>, <, >=) 與邏輯判斷 (and, or)。",
            "order": 1,
            "lessons": [
                {"title": "Q21. 點餐計算機：誰付錢？", "order": 1, "exercises": [{"type": "coding", "instructions": "一份雞排 70 元、一杯珍奶 55 元，請幫兩人平分帳單，並印出每人需付的金額。", "starter_code": "fried_chicken = 70\nbubble_tea = 55\n\n# 計算總金額並除以2\naverage_cost =", "solution_code": "fried_chicken = 70\nbubble_tea = 55\ntotal_cost = fried_chicken + bubble_tea\naverage_cost = total_cost / 2\nprint(average_cost)", "test_cases": [], "max_score": 10}]},
                {"title": "Q22. 價格比較器：哪個便宜？", "order": 2, "exercises": [{"type": "coding", "instructions": "A 果汁 28 元、B 果汁 35 元。請用比較運算子 `<` 判斷 A 果汁是否比 B 果汁便宜，印出判斷結果 (True/False)。", "starter_code": "juice_a = 28\njuice_b = 35\n\n# 判斷 juice_a 是否小於 juice_b\nis_cheaper =", "solution_code": "juice_a = 28\njuice_b = 35\nis_cheaper = juice_a < juice_b\nprint(is_cheaper)", "test_cases": [], "max_score": 10}]},
                {"title": "Q23. 身高爭霸戰：真的比較高嗎？", "order": 3, "exercises": [{"type": "coding", "instructions": "阿哲 168 公分，阿婷 167.5 公分。請判斷阿哲是否比阿婷高，並依以下格式印出：\n```\n阿哲比阿婷高嗎？True\n```", "starter_code": "zhe_height = 168\nting_height = 167.5\n\n# 進行比較\nis_taller =", "solution_code": "zhe_height = 168\nting_height = 167.5\nis_taller = zhe_height > ting_height\nprint(f\"阿哲比阿婷高嗎？{is_taller}\")", "test_cases": [], "max_score": 10}]},
                {"title": "Q24. 任務達成條件", "order": 4, "exercises": [{"type": "coding", "instructions": "只有「作業完成」且「房間整齊」才能玩電動。請用 `and` 運算子判斷是否可以玩電動，並印出結果 (True/False)。", "starter_code": "作業完成 = True\n房間整齊 = False\n\n# 判斷是否兩個條件都成立\ncan_play_games =", "solution_code": "作業完成 = True\n房間整齊 = False\ncan_play_games = 作業完成 and 房間整齊\nprint(can_play_games)", "test_cases": [], "max_score": 10}]},
                {"title": "Q25. 給分系統設計", "order": 5, "exercises": [{"type": "coding", "instructions": "若成績是 78 分，請判斷是否及格（分數大於或等於 60）。", "starter_code": "score = 78\n\n# 判斷是否及格\nis_pass =", "solution_code": "score = 78\nis_pass = score >= 60\nprint(is_pass)", "test_cases": [], "max_score": 10}]},
                {"title": "Q26. 水量追蹤器", "order": 6, "exercises": [{"type": "coding", "instructions": "每喝一杯水就加一，假設今天喝了三杯。請從 `水量 = 0` 開始，用複合賦值運算子 `+=` 模擬喝了三次水，最後印出總水量。", "starter_code": "水量 = 0\n\n# 每次喝水都加 1，重複三次\n\n\nprint(水量)", "solution_code": "水量 = 0\n水量 += 1\n水量 += 1\n水量 += 1\nprint(水量)", "test_cases": [], "max_score": 10}]},
                {"title": "Q27. 自動找零計算機", "order": 7, "exercises": [{"type": "coding", "instructions": "總價 135 元，付款 200 元，請計算應找零多少錢並印出。", "starter_code": "total_price = 135\npayment = 200\n\n# 計算找零\nchange =", "solution_code": "total_price = 135\npayment = 200\nchange = payment - total_price\nprint(change)", "test_cases": [], "max_score": 10}]},
                {"title": "Q28. 能量條更新公式", "order": 8, "exercises": [{"type": "coding", "instructions": "初始能量 100，每使用技能扣除 15 點。請模擬使用三次技能後，更新並印出剩餘的能量值。", "starter_code": "energy = 100\n\n# 使用三次技能，每次扣除 15\n\n\nprint(energy)", "solution_code": "energy = 100\nenergy -= 15\nenergy -= 15\nenergy -= 15\nprint(energy)", "test_cases": [], "max_score": 10}]},
                {"title": "Q29. 出門條件挑戰", "order": 9, "exercises": [{"type": "coding", "instructions": "「有帶傘」或「天氣晴」才能出門。請用 `or` 運算子判斷是否能出門，並印出結果 (True/False)。", "starter_code": "天氣晴 = False\n有帶傘 = True\n\n# 判斷是否至少一個條件成立\ncan_go_out =", "solution_code": "天氣晴 = False\n有帶傘 = True\ncan_go_out = 天氣晴 or 有帶傘\nprint(can_go_out)", "test_cases": [], "max_score": 10}]},
                {"title": "Q30. 綜合挑戰題：阿邏智慧判斷", "order": 10, "exercises": [{"type": "coding", "instructions": "判斷 `(氣溫 < 35 and 濕度 < 80) or 有冷氣` 的最終結果是什麼，並印出 (True/False)。", "starter_code": "氣溫 = 34\n濕度 = 75\n有冷氣 = True\n\n# 根據條件進行判斷\nresult =", "solution_code": "氣溫 = 34\n濕度 = 75\n有冷氣 = True\nresult = (氣溫 < 35 and 濕度 < 80) or 有冷氣\nprint(result)", "test_cases": [], "max_score": 10}]}
            ]
        },
        {
            "title": "單元二：運算子的實戰魔法 (Q31-Q40)",
            "description": "綜合應用算術、比較、邏輯運算子解決多步驟問題。",
            "order": 2,
            "lessons": [
                {"title": "Q31. 自動經驗升級機", "order": 1, "exercises": [{"type": "coding", "instructions": "小奇目前經驗值為 180，升級門檻為 200，每打一次怪物增加 15 點。\n\n**要求：**\n請問「最少」還要打幾次怪物才能升級？請計算並印出次數。", "starter_code": "import math\n\ncurrent_exp = 180\nupgrade_exp = 200\nexp_per_monster = 15\n\n# 計算還需要多少經驗值\nexp_needed = \n# 計算需要打幾次怪 (無條件進位)\nmonsters_needed = \nprint(monsters_needed)", "solution_code": "import math\n\ncurrent_exp = 180\nupgrade_exp = 200\nexp_per_monster = 15\n\nexp_needed = upgrade_exp - current_exp\nmonsters_needed = math.ceil(exp_needed / exp_per_monster)\nprint(monsters_needed)", "test_cases": [], "max_score": 15}]},
                {"title": "Q32. 體力消耗計算器", "order": 2, "exercises": [{"type": "coding", "instructions": "體力初始 100，每移動一步 -3，每跳一次 -7。\n\n**要求：**\n阿奇今天走了 10 步、跳了 2 次，請算出他剩下的體力並印出。", "starter_code": "stamina = 100\nwalk_cost = 3\njump_cost = 7\n\nwalk_steps = 10\njump_times = 2\n\n# 計算總消耗並更新體力\n\nprint(stamina)", "solution_code": "stamina = 100\nwalk_cost = 3\njump_cost = 7\n\nwalk_steps = 10\njump_times = 2\n\ntotal_cost = (walk_steps * walk_cost) + (jump_times * jump_cost)\nstamina -= total_cost\nprint(stamina)", "test_cases": [], "max_score": 15}]},
                {"title": "Q33. 分數轉換系統", "order": 3, "exercises": [{"type": "coding", "instructions": "有一筆總分 250，滿分是 300。\n\n**要求：**\n請計算其百分比 (`總分 / 滿分 * 100`)，並將結果格式化為保留一位小數的字串印出。", "starter_code": "score = 250\nfull_mark = 300\n\n# 計算百分比\npercentage = \n\n# 格式化輸出\nprint(f\"{percentage:.1f}%\")", "solution_code": "score = 250\nfull_mark = 300\n\npercentage = (score / full_mark) * 100\n\nprint(f\"{percentage:.1f}%\")", "test_cases": [], "max_score": 15}]},
                {"title": "Q34. 三項比較挑戰", "order": 4, "exercises": [{"type": "coding", "instructions": "小奇參加三項賽跑（a=12s, b=15s, c=10s）。\n\n**要求：**\n請找出最快的一項（秒數最少）並依以下格式印出：\n```\n最快項目是：c，耗時 10 秒\n```", "starter_code": "a = 12\nb = 15\nc = 10\n\n# 比較找出最小值\n# 你可以使用 if/elif/else 來完成", "solution_code": "a = 12\nb = 15\nc = 10\n\nif a <= b and a <= c:\n    fastest_item = 'a'\n    fastest_time = a\nelif b <= a and b <= c:\n    fastest_item = 'b'\n    fastest_time = b\nelse:\n    fastest_item = 'c'\n    fastest_time = c\n\nprint(f\"最快項目是：{fastest_item}，耗時 {fastest_time} 秒\")", "test_cases": [], "max_score": 15}]},
                {"title": "Q35. 魔法值可用判斷", "order": 5, "exercises": [{"type": "coding", "instructions": "魔法初始 80 點，使用「火焰術」一次耗 35 點。\n\n**要求：**\n請判斷魔法值是否足夠連續使用兩次「火焰術」，若可以印出 True，否則 False。", "starter_code": "mana = 80\nskill_cost = 35\n\n# 判斷是否夠用兩次\ncan_cast_twice = \nprint(can_cast_twice)", "solution_code": "mana = 80\nskill_cost = 35\n\ncan_cast_twice = mana >= (skill_cost * 2)\nprint(can_cast_twice)", "test_cases": [], "max_score": 15}]},
                {"title": "Q36. 費用加總與找零", "order": 6, "exercises": [{"type": "coding", "instructions": "阿邏買了三樣東西：魔法石 120 元、靈魂瓶 85 元、光之粉塵 47 元。他付款 300 元。\n\n**要求：**\n請計算並印出應找回多少錢。", "starter_code": "item1 = 120\nitem2 = 85\nitem3 = 47\npayment = 300\n\n# 計算總價與找零\nchange = \nprint(change)", "solution_code": "item1 = 120\nitem2 = 85\nitem3 = 47\npayment = 300\n\ntotal_cost = item1 + item2 + item3\nchange = payment - total_cost\nprint(change)", "test_cases": [], "max_score": 15}]},
                {"title": "Q37. 等級成長表現", "order": 7, "exercises": [{"type": "coding", "instructions": "小奇三週的等級分別為 3、5、7。請判斷是否「每週都持續成長」（第二週比第一週高，且第三週比第二週高）。\n\n**要求：**\n請印出 True 或 False。", "starter_code": "week1_level = 3\nweek2_level = 5\nweek3_level = 7\n\n# 判斷是否持續成長\nis_growing = \nprint(is_growing)", "solution_code": "week1_level = 3\nweek2_level = 5\nweek3_level = 7\n\nis_growing = (week2_level > week1_level) and (week3_level > week2_level)\nprint(is_growing)", "test_cases": [], "max_score": 15}]},
                {"title": "Q38. 裝備能力綜合輸出", "order": 8, "exercises": [{"type": "coding", "instructions": "請定義變數，並依照指定格式輸出句子。\n\n**預期輸出：**\n```\n裝備：雷電刀，攻擊力：90，耐久值：65\n```", "starter_code": "weapon = \"雷電刀\"\natk = 90\ndurability = 65\n\n# 使用 f-string 格式化輸出", "solution_code": "weapon = \"雷電刀\"\natk = 90\ndurability = 65\n\nprint(f\"裝備：{weapon}，攻擊力：{atk}，耐久值：{durability}\")", "test_cases": [], "max_score": 15}]},
                {"title": "Q39. 簡易條件模擬：是否可進入火山區", "order": 9, "exercises": [{"type": "coding", "instructions": "進入火山區的條件為：裝備為「火焰盾」**且** 等級大於等於 10。\n\n**要求：**\n請根據給定變數，判斷是否可以進入，並印出 True 或 False。", "starter_code": "裝備 = \"火焰盾\"\n等級 = 10\n\n# 判斷是否滿足進入條件\ncan_enter = \nprint(can_enter)", "solution_code": "裝備 = \"火焰盾\"\n等級 = 10\n\ncan_enter = (裝備 == \"火焰盾\") and (等級 >= 10)\nprint(can_enter)", "test_cases": [], "max_score": 15}]},
                {"title": "Q40. 複合邏輯挑戰", "order": 10, "exercises": [{"type": "coding", "instructions": "進入副本的條件為：「血量大於 50」**且**（「技能冷卻中為 False」**或**「有補品為 True」）。\n\n**要求：**\n請根據給定變數，判斷小奇是否可進入副本，並印出 True 或 False。", "starter_code": "血量 = 80\n技能冷卻中 = True\n有補品 = False\n\n# 判斷是否可進入副本\ncan_enter_dungeon = \nprint(can_enter_dungeon)", "solution_code": "血量 = 80\n技能冷卻中 = True\n有補品 = False\n\ncan_enter_dungeon = (血量 > 50) and (技能冷卻中 == False or 有補品 == True)\nprint(can_enter_dungeon)", "test_cases": [], "max_score": 15}]}
            ]
        }
    ]
}


ALL_COURSES = [
    OPERATORS_COURSE
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
                # Update course description if it has changed
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
                    # Update unit details if they have changed
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
                        # Update lesson details
                        lesson.order = lesson_data.get('order', lesson.order)
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