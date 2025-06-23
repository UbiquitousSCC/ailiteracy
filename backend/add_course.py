import os
import sys
import json

# Fix import path issues
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))
from backend import db, create_app
from backend.models.user import User
from backend.models.course import Course, Unit
from backend.models.lesson import Lesson, MultipleChoiceQuestion, CodingExercise

# --- 1. COURSE DATA DEFINITIONS ---

SQL_COURSE = {
    "title": "SQL 入門",
    "description": "學習如何使用 SQL 管理和查詢資料庫。",
    "units": [
        {
            "title": "單元一：基本查詢",
            "description": "開始學習 SELECT 陳述式。",
            "order": 1,
            "lessons": [
                {
                    "title": "課節 1.1：SELECT 陳述式",
                    "description": "學習 SELECT 的基本語法。",
                    "order": 1,
                    "exercises": [
                        {
                            "type": "mcq",
                            "question": "哪個關鍵字用於從資料庫中檢索資料？",
                            "options": ["GET", "SELECT", "FETCH", "RETRIEVE"],
                            "correct_index": 1,
                            "explanation": "SELECT 是用於查詢資料的標準 SQL 關鍵字。",
                            "points": 10
                        }
                    ]
                },
                {
                    "title": "課節 1.2：使用 WHERE 過濾",
                    "description": "如何過濾您的查詢結果。",
                    "order": 2,
                    "exercises": [
                        {
                            "type": "coding",
                            "instructions": "從名為 'Users' 的資料表中，選取所有 country 為 'USA' 的使用者。",
                            "starter_code": "SELECT * FROM Users WHERE ...",
                            "solution_code": "SELECT * FROM Users WHERE country = 'USA';",
                            "test_cases": [],
                            "max_score": 20
                        }
                    ]
                }
            ]
        },
        {
            "title": "單元二：連接資料表",
            "description": "組合來自多個資料表的資料。",
            "order": 2,
            "lessons": [
                {
                    "title": "課節 2.1：INNER JOIN",
                    "description": "學習如何執行 INNER JOIN。",
                    "order": 1,
                    "exercises": [
                        {
                            "type": "coding",
                            "instructions": "資料分散在 `Orders` 和 `Customers` 兩個資料表中。`Orders` 有 `CustomerID`，`Customers` 有 `CustomerID` 和 `CustomerName`。請寫一個查詢，找出每個訂單的 `OrderID` 以及對應的 `CustomerName`。",
                            "starter_code": "SELECT Orders.OrderID, Customers.CustomerName FROM Orders ...;",
                            "solution_code": "SELECT Orders.OrderID, Customers.CustomerName FROM Orders INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID;",
                            "test_cases": [],
                            "max_score": 25
                        }
                    ]
                }
            ]
        }
    ]
}

LOOPS_COURSE = {
    "title": "迴圈 - for、while函數的使用",
    "description": "學習 Python 中的 for 和 while 迴圈，從基礎語法到高階應用，解決各種重複性問題。",
    "units": [
        {
            "title": "單元一：初級for練習",
            "description": "利用 for 迴圈處理重複性任務與簡單的數列運算。",
            "order": 1,
            "lessons": [
                {"title": "題目 1：早起的任務", "order": 1, "exercises": [{"type": "coding", "instructions": "小傑每天早上都要說三次「我起床了！」，請用程式幫他完成這項任務。", "starter_code": "# 使用 for 迴圈完成任務\nfor i in range(3):\n    # 在這裡印出「我起床了！」", "solution_code": "for i in range(3):\n    print(\"我起床了！\")", "test_cases": [], "max_score": 10}]},
                {"title": "題目 2：我的購物清單", "order": 2, "exercises": [{"type": "coding", "instructions": "請列印清單中的所有食物：「蘋果」、「香蕉」、「蛋糕」", "starter_code": "foods = [\"蘋果\", \"香蕉\", \"蛋糕\"]\n# 使用 for 迴圈印出所有食物", "solution_code": "foods = [\"蘋果\", \"香蕉\", \"蛋糕\"]\nfor food in foods:\n    print(food)", "test_cases": [], "max_score": 10}]},
                {"title": "題目 3：幫我數到五", "order": 3, "exercises": [{"type": "coding", "instructions": "小妤想學數數，請幫她印出 1 到 5。", "starter_code": "# 使用 for 迴圈和 range 印出 1 到 5", "solution_code": "for i in range(1, 6):\n    print(i)", "test_cases": [], "max_score": 10}]},
                {"title": "題目 4：一層星星", "order": 4, "exercises": [{"type": "coding", "instructions": "印出一排 6 顆星星。", "starter_code": "# 使用 for 迴圈和 end=\"\" 印出星星", "solution_code": "for i in range(6):\n    print(\"*\", end=\"\")", "test_cases": [], "max_score": 10}]},
                {"title": "題目 5：總和計算機", "order": 5, "exercises": [{"type": "coding", "instructions": "計算 1 到 5 的總和。", "starter_code": "total = 0\n# 使用 for 迴圈計算總和", "solution_code": "total = 0\nfor i in range(1, 6):\n    total += i\nprint(total)", "test_cases": [], "max_score": 10}]},
                {"title": "題目 6：我會倒數！", "order": 6, "exercises": [{"type": "coding", "instructions": "印出 5 到 1 的倒數。", "starter_code": "# 使用 for 迴圈和 range 倒數", "solution_code": "for i in range(5, 0, -1):\n    print(i)", "test_cases": [], "max_score": 10}]}
            ]
        },
        {
            "title": "單元二：中階for練習",
            "description": "使用range()的其他函數",
            "order": 2,
            "lessons": [
                {"title": "題目 7：奇數挑戰", "order": 1, "exercises": [{"type": "coding", "instructions": "小妤想列出 1 到 9 的奇數，請幫她完成。", "starter_code": "# 使用 for 迴圈和 range 的第三個參數找出奇數", "solution_code": "for i in range(1, 10, 2):\n    print(i)", "test_cases": [], "max_score": 10}]},
                {"title": "題目 8：星星樓梯", "order": 2, "exercises": [{"type": "coding", "instructions": "印出一個五層的星星塔，每層星星數為層數。", "starter_code": "# 使用 for 迴圈和字串乘法印出星星塔", "solution_code": "for i in range(1, 6):\n    print(\"*\" * i)", "test_cases": [], "max_score": 15}]},
                {"title": "題目 9：偶數總和", "order": 3, "exercises": [{"type": "coding", "instructions": "計算 2 到 10 所有偶數的總和。", "starter_code": "total = 0\n# 使用 for 迴圈和 range 計算偶數總和", "solution_code": "total = 0\nfor i in range(2, 11, 2):\n    total += i\nprint(total)", "test_cases": [], "max_score": 15}]},
                {"title": "題目 10：星星正方形", "order": 4, "exercises": [{"type": "coding", "instructions": "印出一個 4x4 的星星正方形。", "starter_code": "# 使用巢狀 for 迴圈印出正方形", "solution_code": "for i in range(4):\n    for j in range(4):\n        print(\"*\", end=\" \")\n    print()", "test_cases": [], "max_score": 15}]},
                {"title": "題目 11：倒數星星塔", "order": 5, "exercises": [{"type": "coding", "instructions": "印出倒數的星星塔（從 5 顆到 1 顆）。", "starter_code": "# 使用 for 迴圈和 range 印出倒數星星塔", "solution_code": "for i in range(5, 0, -1):\n    print(\"*\" * i)", "test_cases": [], "max_score": 15}]},
                {"title": "題目 12：重複任務打卡機", "order": 6, "exercises": [{"type": "coding", "instructions": "使用清單列出任務，列印每項任務後顯示「已完成！」", "starter_code": "tasks = [\"洗衣服\", \"拖地\", \"倒垃圾\"]\n# 使用 for 迴圈完成任務打卡", "solution_code": "tasks = [\"洗衣服\", \"拖地\", \"倒垃圾\"]\nfor task in tasks:\n    print(f\"{task} 已完成！\")", "test_cases": [], "max_score": 15}]}
            ]
        },
        {
            "title": "單元三：for迴圈的高階練習",
            "description": "針對日常生活問題設計 for 迴圈解決方案。",
            "order": 3,
            "lessons": [
                {"title": "題目 13：九九乘法表（局部）", "order": 1, "exercises": [{"type": "coding", "instructions": "列出 1 到 3 的乘法表，每行顯示「a x b = c」格式。", "starter_code": "# 使用巢狀 for 迴圈印出乘法表", "solution_code": "for i in range(1, 4):\n    for j in range(1, 10):\n        print(f\"{i} x {j} = {i*j}\")\n    print()", "test_cases": [], "max_score": 20}]},
                {"title": "題目 14：梯形圖形", "order": 2, "exercises": [{"type": "coding", "instructions": "印出一個 4 層梯形，每層比上一層多 2 顆星星，從 2 顆開始。", "starter_code": "# 使用 for 迴圈印出梯形", "solution_code": "for i in range(1, 5):\n    print(\"*\" * (2 * i))", "test_cases": [], "max_score": 20}]},
                {"title": "題目 15：階乘計算機", "order": 3, "exercises": [{"type": "coding", "instructions": "計算 1×2×3×…×n（例如 n=5，結果是 120）", "starter_code": "n = 5\nresult = 1\n# 使用 for 迴圈計算 n 的階乘", "solution_code": "n = 5\nresult = 1\nfor i in range(1, n + 1):\n    result *= i\nprint(result)", "test_cases": [], "max_score": 20}]},
                {"title": "題目 16：座標表列印", "order": 4, "exercises": [{"type": "coding", "instructions": "印出 3x3 座標點（如 (0,0)、(0,1)…）", "starter_code": "# 使用巢狀 for 迴圈印出座標", "solution_code": "for i in range(3):\n    for j in range(3):\n        print(f\"({i}, {j})\")", "test_cases": [], "max_score": 20}]},
                {"title": "題目 17：字串倒轉印出", "order": 5, "exercises": [{"type": "coding", "instructions": "將字串 “PYTHON” 一個字一行，從後面開始印。", "starter_code": "s = \"PYTHON\"\n# 使用 for 迴圈倒著印出字串", "solution_code": "s = \"PYTHON\"\nfor i in range(len(s) - 1, -1, -1):\n    print(s[i])", "test_cases": [], "max_score": 20}]},
                {"title": "題目 18：找最大值", "order": 6, "exercises": [{"type": "coding", "instructions": "給定一組數字，找出最大的數字。", "starter_code": "numbers = [3, 1, 4, 1, 5, 9, 2, 6]\nmax_num = numbers[0]\n# 使用 for 迴圈找出最大值", "solution_code": "numbers = [3, 1, 4, 1, 5, 9, 2, 6]\nmax_num = numbers[0]\nfor num in numbers:\n    if num > max_num:\n        max_num = num\nprint(max_num)", "test_cases": [], "max_score": 20}]},
                {"title": "題目 19：井字遊戲板", "order": 7, "exercises": [{"type": "coding", "instructions": "印出一個 3x3 棋盤，內容全為「⬜」", "starter_code": "# 使用巢狀 for 迴圈印出棋盤", "solution_code": "for i in range(3):\n    for j in range(3):\n        print(\"⬜\", end=\"\")\n    print()", "test_cases": [], "max_score": 20}]},
                {"title": "題目 20：步進文字顯示", "order": 8, "exercises": [{"type": "coding", "instructions": "請每隔一個字印出字串 “HELLOWORLD” 中的字。", "starter_code": "s = \"HELLOWORLD\"\n# 使用 for 迴圈和 range 的步進參數", "solution_code": "s = \"HELLOWORLD\"\nfor i in range(0, len(s), 2):\n    print(s[i])", "test_cases": [], "max_score": 20}]}
            ]
        },
        {
            "title": "單元四：初階while練習",
            "description": "設定 while 迴圈的條件與變數更新方式",
            "order": 4,
            "lessons": [
                {"title": "題目 1：連續印出數字", "order": 1, "exercises": [{"type": "coding", "instructions": "請寫一個 while 迴圈，將數字 1~5 依序印出來。", "starter_code": "i = 1\n# 使用 while 迴圈印出 1 到 5", "solution_code": "i = 1\nwhile i <= 5:\n    print(i)\n    i += 1", "test_cases": [], "max_score": 10}]},
                {"title": "題目 2：Hello 連發", "order": 2, "exercises": [{"type": "coding", "instructions": "請用 while 迴圈重複印出 3 次「Hello!」。", "starter_code": "count = 0\n# 使用 while 迴圈印出三次 Hello!", "solution_code": "count = 0\nwhile count < 3:\n    print(\"Hello!\")\n    count += 1", "test_cases": [], "max_score": 10}]},
                {"title": "題目 3：倒數計時", "order": 3, "exercises": [{"type": "coding", "instructions": "請用 while 迴圈將數字從 5 倒數到 1。", "starter_code": "i = 5\n# 使用 while 迴圈倒數", "solution_code": "i = 5\nwhile i >= 1:\n    print(i)\n    i -= 1", "test_cases": [], "max_score": 10}]},
                {"title": "題目 4：累加求和", "order": 4, "exercises": [{"type": "coding", "instructions": "請用 while 迴圈計算 1+2+3+4+5 的總和，並印出答案。", "starter_code": "total = 0\ni = 1\n# 使用 while 迴圈計算總和", "solution_code": "total = 0\ni = 1\nwhile i <= 5:\n    total += i\n    i += 1\nprint(total)", "test_cases": [], "max_score": 10}]},
                {"title": "題目 5：找出偶數", "order": 5, "exercises": [{"type": "coding", "instructions": "請用 while 迴圈印出 1~10 之間所有的偶數。", "starter_code": "i = 1\n# 使用 while 迴圈找出偶數", "solution_code": "i = 1\nwhile i <= 10:\n    if i % 2 == 0:\n        print(i)\n    i += 1", "test_cases": [], "max_score": 10}]},
                {"title": "題目 6：數星星", "order": 6, "exercises": [{"type": "coding", "instructions": "請用 while 迴圈印出 4 顆星星（每行一顆）。", "starter_code": "count = 0\n# 使用 while 迴圈印出星星", "solution_code": "count = 0\nwhile count < 4:\n    print(\" * \")\n    count += 1", "test_cases": [], "max_score": 10}]}
            ]
        },
        {
            "title": "單元五：中階while練習",
            "description": "迴圈最適合處理那些「不知道會重複幾次」的問題，例如：反覆猜數字、持續等待某個條件發生。",
            "order": 5,
            "lessons": [
                {"title": "題目 7：列印奇數", "order": 1, "exercises": [{"type": "coding", "instructions": "請用 while 迴圈印出 1 到 10 之間所有的奇數。", "starter_code": "i = 1\n# 使用 while 迴圈找出奇數", "solution_code": "i = 1\nwhile i <= 10:\n    if i % 2 != 0:\n        print(i)\n    i += 1", "test_cases": [], "max_score": 15}]},
                {"title": "題目 8：累加到超過 50", "order": 2, "exercises": [{"type": "coding", "instructions": "請用 while 迴圈從 1 開始累加，直到總和超過 50，並印出最後總和。", "starter_code": "total = 0\ni = 1\n# 使用 while 迴圈累加直到超過 50", "solution_code": "total = 0\ni = 1\nwhile total <= 50:\n    total += i\n    i += 1\nprint(total)", "test_cases": [], "max_score": 15}]},
                {"title": "題目 9：指定範圍輸出", "order": 3, "exercises": [{"type": "coding", "instructions": "請用 while 迴圈印出 7 到 12 的所有數字。", "starter_code": "i = 7\n# 使用 while 迴圈印出 7 到 12", "solution_code": "i = 7\nwhile i <= 12:\n    print(i)\n    i += 1", "test_cases": [], "max_score": 15}]},
                {"title": "題目 10：跳步數數", "order": 4, "exercises": [{"type": "coding", "instructions": "請用 while 迴圈，從 2 開始，每次加 3，直到小於或等於 20，把所有數字印出來。", "starter_code": "i = 2\n# 使用 while 迴圈跳步數數", "solution_code": "i = 2\nwhile i <= 20:\n    print(i)\n    i += 3", "test_cases": [], "max_score": 15}]},
                {"title": "題目 11：找最小倍數", "order": 5, "exercises": [{"type": "coding", "instructions": "請用 while 迴圈找出 1~100 中第一個同時可以被 4 和 6 整除的數字，並印出這個數。", "starter_code": "i = 1\n# 使用 while 迴圈和 break 找出最小公倍數", "solution_code": "i = 1\nwhile i <= 100:\n    if i % 4 == 0 and i % 6 == 0:\n        print(i)\n        break\n    i += 1", "test_cases": [], "max_score": 15}]},
                {"title": "題目 12：累計輸入直到輸入0", "order": 6, "exercises": [{"type": "coding", "instructions": "請寫一個 while 迴圈，不斷讓使用者輸入數字，並累加起來，直到輸入 0 為止，最後印出總和。", "starter_code": "# 注意：此題在自動化環境中可能無法執行，因為需要使用者輸入。\ntotal = 0\n# 使用 while 迴圈累計輸入", "solution_code": "total = 0\nwhile True:\n    try:\n        num = int(input(\"請輸入數字 (輸入 0 結束): \"))\n        if num == 0:\n            break\n        total += num\n    except ValueError:\n        print(\"請輸入有效的數字。\")\nprint(f\"總和為: {total}\")", "test_cases": [], "max_score": 15}]}
            ]
        },
        {
            "title": "單元六：while迴圈的高階練習",
            "description": "根據不同情境靈活選擇合適的迴圈類型解決問題",
            "order": 6,
            "lessons": [
                {"title": "題目 13：數字倒著印", "order": 1, "exercises": [{"type": "coding", "instructions": "請讓使用者輸入一個正整數 n，然後用 while 迴圈把 n~1 的數字依序倒著印出來。", "starter_code": "# 注意：此題在自動化環境中可能無法執行，因為需要使用者輸入。\nn = int(input(\"請輸入一個正整數: \"))\n# 使用 while 迴圈倒著印", "solution_code": "try:\n    n = int(input(\"請輸入一個正整數: \"))\n    while n >= 1:\n        print(n)\n        n -= 1\nexcept ValueError:\n    print(\"請輸入有效的整數。\")", "test_cases": [], "max_score": 20}]},
                {"title": "題目 14：輸出所有質數", "order": 2, "exercises": [{"type": "coding", "instructions": "請用 while 迴圈印出 2~20 所有的質數（只能被 1 和自己整除的正整數）。", "starter_code": "num = 2\n# 使用巢狀 while 迴圈找出質數", "solution_code": "num = 2\nwhile num <= 20:\n    is_prime = True\n    divisor = 2\n    while divisor <= int(num**0.5):\n        if num % divisor == 0:\n            is_prime = False\n            break\n        divisor += 1\n    if is_prime:\n        print(num)\n    num += 1", "test_cases": [], "max_score": 20}]},
                {"title": "題目 15：九九乘法表（橫式）", "order": 3, "exercises": [{"type": "coding", "instructions": "請用巢狀 while 迴圈印出 1~9 的九九乘法表（每行顯示一個數的 1~9 乘積）。", "starter_code": "i = 1\n# 使用巢狀 while 迴圈印出九九乘法表", "solution_code": "i = 1\nwhile i <= 9:\n    j = 1\n    while j <= 9:\n        print(f\"{i}x{j}={i*j}\", end=\"\t\")\n        j += 1\n    print()\n    i += 1", "test_cases": [], "max_score": 20}]},
                {"title": "題目 16：找最大公因數", "order": 4, "exercises": [{"type": "coding", "instructions": "讓使用者輸入兩個正整數 a 和 b，請用 while 迴圈找出他們的最大公因數（GCD）。", "starter_code": "# 注意：此題在自動化環境中可能無法執行，因為需要使用者輸入。\na = int(input(\"請輸入第一個正整數: \"))\nb = int(input(\"請輸入第二個正整數: \"))\n# 使用輾轉相除法找出最大公因數", "solution_code": "try:\n    a = int(input(\"請輸入第一個正整數: \"))\n    b = int(input(\"請輸入第二個正整數: \"))\n    while b:\n        a, b = b, a % b\n    print(f\"最大公因數是: {a}\")\nexcept ValueError:\n    print(\"請輸入有效的整數。\")", "test_cases": [], "max_score": 20}]},
                {"title": "題目 17：神秘數字猜猜樂（最多5次）", "order": 5, "exercises": [{"type": "coding", "instructions": "設一個 while 迴圈，讓使用者最多猜 5 次某個神秘數字（答案設為 8），如果在 5 次內猜對就顯示「恭喜」，否則顯示「沒猜中」。", "starter_code": "# 注意：此題在自動化環境中可能無法執行，因為需要使用者輸入。\nanswer = 8\nguess_count = 0\n# 使用 while 迴圈完成猜數字遊戲", "solution_code": "answer = 8\nguess_count = 0\nwhile guess_count < 5:\n    try:\n        guess = int(input(f\"猜一個數字 (剩下 {5 - guess_count} 次機會): \"))\n        if guess == answer:\n            print(\"恭喜，你猜對了！\")\n            break\n        else:\n            print(\"猜錯了。\")\n        guess_count += 1\n    except ValueError:\n        print(\"請輸入有效的數字。\")\nelse:\n    print(f\"沒猜中，答案是 {answer}\")", "test_cases": [], "max_score": 20}]},
                {"title": "題目 18：計算階乘", "order": 6, "exercises": [{"type": "coding", "instructions": "請讓使用者輸入一個正整數 n，用 while 迴圈計算 n 的階乘（n!）。", "starter_code": "# 注意：此題在自動化環境中可能無法執行，因為需要使用者輸入。\nn = int(input(\"請輸入一個正整數: \"))\nresult = 1\n# 使用 while 迴圈計算階乘", "solution_code": "try:\n    n = int(input(\"請輸入一個正整數: \"))\n    if n < 0:\n        print(\"階乘不適用於負數。\")\n    else:\n        result = 1\n        i = n\n        while i > 0:\n            result *= i\n            i -= 1\n        print(f\"{n} 的階乘是 {result}\")\nexcept ValueError:\n    print(\"請輸入有效的整數。\")", "test_cases": [], "max_score": 20}]}
            ]
        }
    ]
}

ALL_COURSES = [
    SQL_COURSE,
    LOOPS_COURSE
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
                    # print(f"      - 更新練習 for '{lesson_data['title']}'")
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
