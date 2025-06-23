import os
import sys
import json

# Fix import path issues
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))
from backend import db, create_app
from backend.models.user import User
from backend.models.course import Course, Unit
from backend.models.lesson import Lesson, MultipleChoiceQuestion, CodingExercise

# --- 1. COURSE DATA DEFINITION (IF_ADVANCED) ---

IF_ADVANCED_COURSE = {
    "title": "Python 進階條件判斷",
    "description": "深入運用邏輯運算子 (and, or, not) 與巢狀判斷，解決具有多重條件的複雜問題。",
    "units": [
        {
            "title": "單元一：邏輯運算與複雜條件",
            "description": "學習使用 and, or, not 結合多個條件，並練習巢狀 if 結構。",
            "order": 1,
            "lessons": [
                {"title": "1. 同時通過考試", "order": 1, "exercises": [{"type": "coding", "instructions": "輸入數學與英文成績，只有當兩科都 ≥ 60 才印「通過」，否則印「不通過」。", "starter_code": "math_score = int(input(\"請輸入數學成績：\"))\neng_score  = int(input(\"請輸入英文成績：\"))\n# TODO: 若 math_score >= 60 and eng_score >= 60", "solution_code": "math_score = int(input())\neng_score  = int(input())\nif math_score >= 60 and eng_score >= 60:\n    print(\"通過\")\nelse:\n    print(\"不通過\")", "max_score": 10}]},
                {"title": "2. 購物安全檢查", "order": 2, "exercises": [{"type": "coding", "instructions": "輸入年齡與是否有身分證（輸入 Y/N），只有當年齡 ≥18 且有身分證時才印「允許購買」，否則印「拒絕購買」。", "starter_code": "age    = int(input(\"請輸入年齡：\"))\nhas_id = input(\"是否有身分證 (Y/N)：\").upper()\n# TODO: 若 age >= 18 and has_id == 'Y'", "solution_code": "age    = int(input())\nhas_id = input().upper()\nif age >= 18 and has_id == 'Y':\n    print(\"允許購買\")\nelse:\n    print(\"拒絕購買\")", "max_score": 10}]},
                {"title": "3. 會員折扣", "order": 3, "exercises": [{"type": "coding", "instructions": "輸入會員等級與是否首次購物（Y/N），若等級為 Gold 或 Platinum 且不是首次購物，印「折扣 20%」，否則印「無折扣」。", "starter_code": "level      = input(\"請輸入會員等級：\")\nfirst_time = input(\"是否首次購物 (Y/N)：\").upper()\n# TODO: 若 (level == 'Gold' or level == 'Platinum') and first_time != 'Y'", "solution_code": "level      = input()\nfirst_time = input().upper()\nif (level == 'Gold' or level == 'Platinum') and first_time != 'Y':\n    print(\"折扣 20%\")\nelse:\n    print(\"無折扣\")", "max_score": 10}]},
                {"title": "4. 水果重量分級", "order": 4, "exercises": [{"type": "coding", "instructions": "輸入水果重量（公斤），當重量 >5 印「大果」；2 < 重量 <=5 印「中果」；否則印「小果」。", "starter_code": "w = float(input(\"請輸入水果重量 (kg)：\"))\n# TODO: if w > 5, else: if w > 2", "solution_code": "w = float(input())\nif w > 5:\n    print(\"大果\")\nelse:\n    if w > 2:\n        print(\"中果\")\n    else:\n        print(\"小果\")", "max_score": 10}]},
                {"title": "5. 登山裝備檢查", "order": 5, "exercises": [{"type": "coding", "instructions": "輸入是否有水（Y/N）及是否有食物（Y/N），若兩者皆無，印「危險」，否則印「安全」。", "starter_code": "has_water = input(\"是否有水 (Y/N)：\").upper()\nhas_food  = input(\"是否有食物 (Y/N)：\").upper()\n# TODO: 若 not (has_water == 'Y' or has_food == 'Y')", "solution_code": "has_water = input().upper()\nhas_food  = input().upper()\nif has_water != 'Y' and has_food != 'Y':\n    print(\"危險\")\nelse:\n    print(\"安全\")", "max_score": 10}]},
                {"title": "6. 雙重驗證流程", "order": 6, "exercises": [{"type": "coding", "instructions": "輸入密碼與一次性密碼（OTP），若密碼正確('pass123')且 OTP 正確('0000')，印「登入成功」，否則印「登入失敗」。", "starter_code": "password = input(\"請輸入密碼：\")\notp      = input(\"請輸入 OTP：\")\n# TODO: if password == 'pass123' and otp == '0000'", "solution_code": "password = input()\notp      = input()\nif password == 'pass123' and otp == '0000':\n    print(\"登入成功\")\nelse:\n    print(\"登入失敗\")", "max_score": 10}]},
                {"title": "7. 數字奇偶與大小", "order": 7, "exercises": [{"type": "coding", "instructions": "輸入一個整數，若為偶數且大於 10，印「大偶數」，否則印「其他情況」。", "starter_code": "n = int(input(\"請輸入整數：\"))\n# TODO: if n % 2 == 0 and n > 10", "solution_code": "n = int(input())\nif n % 2 == 0 and n > 10:\n    print(\"大偶數\")\nelse:\n    print(\"其他情況\")", "max_score": 10}]},
                {"title": "8. 分數結果複合判斷", "order": 8, "exercises": [{"type": "coding", "instructions": "輸入成績，若 ≥90 印「優等」；60 ≤ 成績 < 90 印「及格」；否則印「不及格」。", "starter_code": "s = int(input(\"請輸入成績：\"))\n# TODO: if s >= 90, elif s >= 60, else", "solution_code": "s = int(input())\nif s >= 90:\n    print(\"優等\")\nelif s >= 60:\n    print(\"及格\")\nelse:\n    print(\"不及格\")", "max_score": 10}]},
                {"title": "9. 安全出行建議", "order": 9, "exercises": [{"type": "coding", "instructions": "輸入是否下雨（Y/N）及氣溫，若下雨或氣溫 < 10，印「攜帶雨具且保暖」，否則印「輕裝出行」。", "starter_code": "is_raining = input(\"是否下雨 (Y/N)：\").upper()\nt          = int(input(\"請輸入氣溫：\"))\n# TODO: if is_raining == 'Y' or t < 10", "solution_code": "is_raining = input().upper()\nt          = int(input())\nif is_raining == 'Y' or t < 10:\n    print(\"攜帶雨具且保暖\")\nelse:\n    print(\"輕裝出行\")", "max_score": 10}]},
                {"title": "10. 複合資格檢查", "order": 10, "exercises": [{"type": "coding", "instructions": "輸入年齡、是否有駕照（Y/N）及測驗分數，若年齡 ≥18 且有駕照且分數 ≥80，印「可執照練習」，否則印「條件不符」。", "starter_code": "age         = int(input(\"請輸入年齡：\"))\nhas_license = input(\"是否有駕照 (Y/N)：\").upper()\nscore       = int(input(\"請輸入測驗分數：\"))\n# TODO: if age >= 18 and has_license == 'Y' and score >= 80", "solution_code": "age         = int(input())\nhas_license = input().upper()\nscore       = int(input())\nif age >= 18 and has_license == 'Y' and score >= 80:\n    print(\"可執照練習\")\nelse:\n    print(\"條件不符\")", "max_score": 10}]}
            ]
        },
        {
            "title": "單元二：綜合應用練習",
            "description": "將條件判斷應用於更貼近真實生活的場景，如費用計算、分級建議與狀態模擬。",
            "order": 2,
            "lessons": [
                {"title": "1. 健康水量檢查", "order": 1, "exercises": [{"type": "coding", "instructions": "讀取使用者輸入的每日飲水量（毫升），若飲水量 < 1500，印出「喝水不足」，1500–3000 印「水量適中」，>3000 印「喝太多水」。", "starter_code": "water_ml = int(input(\"請輸入今日飲水量 (毫升)：\"))\n# TODO: if/elif/else 判斷並印出相應提示", "solution_code": "water_ml = int(input())\nif water_ml < 1500:\n    print(\"喝水不足\")\nelif water_ml <= 3000:\n    print(\"水量適中\")\nelse:\n    print(\"喝太多水\")", "max_score": 15}]},
                {"title": "2. 購物金額免費運費", "order": 2, "exercises": [{"type": "coding", "instructions": "讀取購物車總金額，若金額 ≥ 1000，免運費；500–999 運費 50；<500 運費 100，最後印出「運費：X 元」。", "starter_code": "total = float(input(\"請輸入購物金額：\"))\n# TODO: 判斷運費後印出", "solution_code": "total = float(input())\nif total >= 1000:\n    fee = 0\nelif total >= 500:\n    fee = 50\nelse:\n    fee = 100\nprint(f\"運費：{fee} 元\")", "max_score": 15}]},
                {"title": "3. 點餐甜度調整", "order": 3, "exercises": [{"type": "coding", "instructions": "讀取飲料甜度級別（輸入 S、M、L），分別印出「甜度：少糖」、「甜度：中糖」或「甜度：全糖」。", "starter_code": "level = input(\"請輸入甜度 (S/M/L)：\").upper()\n# TODO: if level == 'S' ... elif level == 'M' ... else", "solution_code": "level = input().upper()\nif level == 'S':\n    print(\"甜度：少糖\")\nelif level == 'M':\n    print(\"甜度：中糖\")\nelse:\n    print(\"甜度：全糖\")", "max_score": 15}]},
                {"title": "4. 電影分級建議", "order": 4, "exercises": [{"type": "coding", "instructions": "讀取觀影者年齡：< 12 → 建議「兒童」；12–17 → 建議「輔導級」；≥18 → 建議「限制級」。", "starter_code": "age = int(input(\"請輸入年齡：\"))\n# TODO: 使用 if/elif/else 印出建議分級", "solution_code": "age = int(input())\nif age < 12:\n    print(\"建議觀看：兒童\")\nelif age <= 17:\n    print(\"建議觀看：輔導級\")\nelse:\n    print(\"建議觀看：限制級\")", "max_score": 15}]},
                {"title": "5. 季節穿搭建議", "order": 5, "exercises": [{"type": "coding", "instructions": "讀取當前溫度：≤0→「穿厚大衣」, 1–15→「穿外套」, 16–25→「穿長袖」, >25→「穿短袖」。", "starter_code": "temp = int(input(\"請輸入目前氣溫 (°C)：\"))\n# TODO: 多重條件判斷後印出建議", "solution_code": "temp = int(input())\nif temp <= 0:\n    print(\"穿厚大衣\")\nelif temp <= 15:\n    print(\"穿外套\")\nelif temp <= 25:\n    print(\"穿長袖\")\nelse:\n    print(\"穿短袖\")", "max_score": 15}]},
                {"title": "6. 路燈開關控制", "order": 6, "exercises": [{"type": "coding", "instructions": "讀取光線強度（0–100）：若 <20 且時間晚於 18（18–23），則印「開燈」，否則印「關燈」。", "starter_code": "light = int(input(\"請輸入光線強度 (0-100)：\"))\nhour  = int(input(\"請輸入當前小時 (0-23)：\"))\n# TODO: if light < 20 and hour >=18", "solution_code": "light = int(input())\nhour  = int(input())\nif light < 20 and hour >= 18:\n    print(\"開燈\")\nelse:\n    print(\"關燈\")", "max_score": 15}]},
                {"title": "7. 班級及格率判斷", "order": 7, "exercises": [{"type": "coding", "instructions": "讀取及格人數與總人數，計算及格率，若 ≥0.8，印「表現優異」；0.6–0.79 印「尚可」；<0.6 印「需加強」。", "starter_code": "passed = int(input(\"輸入及格人數：\"))\ntotal  = int(input(\"輸入總人數：\"))\nrate = passed / total\n# TODO: if rate >= 0.8, elif rate >= 0.6, else", "solution_code": "passed = int(input())\ntotal  = int(input())\nrate = passed / total\nif rate >= 0.8:\n    print(\"表現優異\")\nelif rate >= 0.6:\n    print(\"尚可\")\nelse:\n    print(\"需加強\")", "max_score": 15}]},
                {"title": "8. 交通號誌模擬", "order": 8, "exercises": [{"type": "coding", "instructions": "讀取號誌顏色（Green/Yellow/Red）：Green→「可以通行」, Yellow→「請減速」, Red→「停車」。", "starter_code": "signal = input(\"請輸入號誌顏色：\").capitalize()\n# TODO: if/elif/else 判斷並印出對應文字", "solution_code": "signal = input().capitalize()\nif signal == 'Green':\n    print(\"可以通行\")\nelif signal == 'Yellow':\n    print(\"請減速\")\nelse:\n    print(\"停車\")", "max_score": 15}]},
                {"title": "9. 社群互動回應", "order": 9, "exercises": [{"type": "coding", "instructions": "讀取使用者留言情緒（Happy/Sad/Angry）：回應「太棒了！」、「抱抱」或「冷靜一下」。", "starter_code": "mood = input(\"請輸入心情 (Happy/Sad/Angry)：\").capitalize()\n# TODO: 依 mood 印出不同回應", "solution_code": "mood = input().capitalize()\nif mood == 'Happy':\n    print(\"太棒了！\")\nelif mood == 'Sad':\n    print(\"抱抱\")\nelse:\n    print(\"冷靜一下\")", "max_score": 15}]},
                {"title": "10. 銀行提款手續費", "order": 10, "exercises": [{"type": "coding", "instructions": "讀取提款金額：≤1000→手續費10元, 1001–5000→手續費20元, >5000→手續費30元。最後印出「手續費：X 元」。", "starter_code": "amount = int(input(\"請輸入提款金額：\"))\n# TODO: if/elif/else 計算 fee 並印出", "solution_code": "amount = int(input())\nif amount <= 1000:\n    fee = 10\nelif amount <= 5000:\n    fee = 20\nelse:\n    fee = 30\nprint(f\"手續費：{fee} 元\")", "max_score": 15}]}
            ]
        },
        {
            "title": "單元三：進階邏輯與綜合應用",
            "description": "挑戰更複雜的巢狀判斷與多重邏輯組合，解決如會員制度、費用計算等真實世界問題。",
            "order": 3,
            "lessons": [
                {"title": "1. 會員購物金回饋", "order": 1, "exercises": [{"type": "coding", "instructions": "輸入購物金額 amount 與會員等級 level（Gold/Silver/None）：Gold且≥500→回饋10%；Silver且≥300→回饋5%；其他→無回饋。", "starter_code": "amount = float(input(\"請輸入購物金額：\"))\nlevel  = input(\"請輸入會員等級 (Gold/Silver/None)：\")\n# TODO: 使用 and/elif 判斷回饋", "solution_code": "amount = float(input())\nlevel  = input()\nrebate = 0.0\nif level == 'Gold' and amount >= 500:\n    rebate = amount * 0.1\nelif level == 'Silver' and amount >= 300:\n    rebate = amount * 0.05\nprint(f\"回饋金：{rebate}\")", "max_score": 20}]},
                {"title": "2. 複合三角形分類", "order": 2, "exercises": [{"type": "coding", "instructions": "輸入三邊長 a,b,c，先檢查是否能構成三角形，若是，再分類為等邊、等腰或一般三角形，否則印「非三角形」。", "starter_code": "a, b, c = map(float, input(\"輸入三邊長，以空格分隔：\").split())\n# TODO: 巢狀 if：先檢查三角形成立條件，再進行分類", "solution_code": "a, b, c = map(float, input().split())\nif (a + b > c) and (a + c > b) and (b + c > a):\n    if a == b == c:\n        print(\"等邊三角形\")\n    elif a == b or b == c or a == c:\n        print(\"等腰三角形\")\n    else:\n        print(\"一般三角形\")\nelse:\n    print(\"非三角形\")", "max_score": 20}]},
                {"title": "3. 複合帳號安全檢查", "order": 3, "exercises": [{"type": "coding", "instructions": "輸入密碼 pwd 與安全性分數 score：分數≥80且長度≥12→高安全；分數≥50且長度≥8→中等安全；否則→低安全。", "starter_code": "pwd   = input(\"請輸入密碼：\")\nscore = int(input(\"請輸入安全性分數 (0-100)：\"))\n# TODO: if/elif 巢狀邏輯判斷安全等級", "solution_code": "pwd   = input()\nscore = int(input())\nif score >= 80 and len(pwd) >= 12:\n    print(\"高安全\")\nelif score >= 50 and len(pwd) >= 8:\n    print(\"中等安全\")\nelse:\n    print(\"低安全\")", "max_score": 20}]},
                {"title": "4. 購物折扣與運費結合", "order": 4, "exercises": [{"type": "coding", "instructions": "輸入購物金額 amt 與是否為 VIP（Y/N）：VIP且≥1000→8折免運；金額≥500→9折運費50；否則→原價運費100。", "starter_code": "amt = float(input(\"輸入金額：\"))\nis_vip = input(\"是否為 VIP (Y/N)：\").upper()\n# TODO: 多層 if 判斷折扣與運費", "solution_code": "amt = float(input())\nis_vip = input().upper()\nif is_vip == 'Y' and amt >= 1000:\n    final_amt = amt * 0.8\n    shipping_fee = 0\n    print(f\"總金額：{final_amt}, 運費：{shipping_fee}\")\nelif amt >= 500:\n    final_amt = amt * 0.9\n    shipping_fee = 50\n    print(f\"總金額：{final_amt}, 運費：{shipping_fee}\")\nelse:\n    final_amt = amt\n    shipping_fee = 100\n    print(f\"總金額：{final_amt}, 運費：{shipping_fee}\")", "max_score": 20}]},
                {"title": "5. 健康建議", "order": 5, "exercises": [{"type": "coding", "instructions": "輸入是否吸菸 smoke（Y/N）、運動次數 exercise（每週次數）：若吸菸或運動次數<2→印「請改善生活習慣」，其他→印「健康狀態良好」。", "starter_code": "smoke = input(\"請問是否吸菸 (Y/N)：\").upper()\nexercise = int(input(\"每週運動次數：\"))\n# TODO: 使用 or 和 < 判斷", "solution_code": "smoke = input().upper()\nexercise = int(input())\nif smoke == 'Y' or exercise < 2:\n    print(\"請改善生活習慣\")\nelse:\n    print(\"健康狀態良好\")", "max_score": 20}]},
                {"title": "6. 複合日期判斷", "order": 6, "exercises": [{"type": "coding", "instructions": "輸入年份與月份：若 month==2，判斷閏年印天數；若 month in [4,6,9,11]，印 30；其他印 31。", "starter_code": "year  = int(input(\"輸入年份：\"))\nmonth = int(input(\"輸入月份：\"))\n# TODO: 巢狀 if 處理 2 月與閏年", "solution_code": "year  = int(input())\nmonth = int(input())\nif month == 2:\n    if (year % 4 == 0 and year % 100 != 0) or (year % 400 == 0):\n        print(29)\n    else:\n        print(28)\nelif month in [4, 6, 9, 11]:\n    print(30)\nelse:\n    print(31)", "max_score": 20}]},
                {"title": "7. 登入錯誤鎖定", "order": 7, "exercises": [{"type": "coding", "instructions": "輸入嘗試次數 tries 與是否為管理員 is_admin（Y/N）：若 tries>5 且非管理員→「帳號鎖定」；若 tries>5 且是管理員→「請稍後再試」；否則→「可繼續嘗試」。", "starter_code": "tries = int(input(\"輸入嘗試次數：\"))\nis_admin = input(\"是否為管理員 (Y/N)：\").upper()\n# TODO: 巢狀 if 或 and/or 組合", "solution_code": "tries = int(input())\nis_admin = input().upper()\nif tries > 5:\n    if is_admin == 'Y':\n        print(\"請稍後再試\")\n    else:\n        print(\"帳號鎖定\")\nelse:\n    print(\"可繼續嘗試\")", "max_score": 20}]},
                {"title": "8. 電費計算", "order": 8, "exercises": [{"type": "coding", "instructions": "讀取用電度數 kwh，依照階梯計算電費：0–120度:2元/度; 121–330度:3元/度; 331–500度:4元/度; >500度:5元/度。印出總電費。", "starter_code": "kwh = int(input(\"輸入用電度數：\"))\n# TODO: 使用巢狀 if/elif 累加每階梯費用", "solution_code": "kwh = int(input())\ntotal = 0\nif kwh <= 120:\n    total = kwh * 2\nelif kwh <= 330:\n    total = 120*2 + (kwh-120)*3\nelif kwh <= 500:\n    total = 120*2 + 210*3 + (kwh-330)*4\nelse:\n    total = 120*2 + 210*3 + 170*4 + (kwh-500)*5\nprint(total)", "max_score": 20}]},
                {"title": "9. 停車費率", "order": 9, "exercises": [{"type": "coding", "instructions": "讀取停車時長 hours 與車種 (小客車/大貨車)：小客車:前2hr 30/hr,之後20/hr; 大貨車:前2hr 50/hr,之後30/hr。費用>500加收管理費100。", "starter_code": "hours = float(input(\"輸入停車時長 (小時)：\"))\ncar_type = input(\"輸入車種 (小客車/大貨車)：\")\n# TODO: 根據車種與時長計算費用，再判斷管理費", "solution_code": "hours = float(input())\ncar_type = input()\nif car_type == \"小客車\":\n    if hours <= 2:\n        fee = hours * 30\n    else:\n        fee = 2*30 + (hours-2)*20\nelse:\n    if hours <= 2:\n        fee = hours * 50\n    else:\n        fee = 2*50 + (hours-2)*30\nif fee > 500:\n    fee += 100\nprint(int(fee))", "max_score": 20}]},
                {"title": "10. 信用卡回饋分類", "order": 10, "exercises": [{"type": "coding", "instructions": "讀取消費金額與回饋類型(現金/點數/里程)：現金→1.2%; 點數→2%但需滿3000; 里程→1.5%。點數未滿額印提示，其餘印回饋金額。", "starter_code": "amount = float(input(\"輸入消費金額：\"))\nrebate_type = input(\"輸入回饋類型 (現金/點數/里程)：\")\n# TODO: 複合條件計算回饋，並處理點數滿額限制", "solution_code": "amount = float(input())\nrebate_type = input()\nrebate = 0\nif rebate_type == '現金':\n    rebate = amount * 0.012\n    print(f\"回饋 {rebate:.2f} 元\")\nelif rebate_type == '點數':\n    if amount >= 3000:\n        rebate = amount * 0.02\n        print(f\"回饋 {rebate:.2f} 元\")\n    else:\n        print(\"不符合點數回饋資格\")\nelif rebate_type == '里程':\n    rebate = amount * 0.015\n    print(f\"回饋 {rebate:.2f} 元\")", "max_score": 20}]}
            ]
        }
    ]
}


ALL_COURSES = [
    IF_ADVANCED_COURSE
]

def process_courses():
    """Adds or updates a list of courses, units, and lessons to the database."""
    app = create_app()
    with app.app_context():
        creator_username = 'teacher1'
        creator = User.query.filter_by(username=creator_username).first()
        if not creator:
            print(f"Creator '{creator_username}' not found. Trying to find any teacher.")
            creator = User.query.filter_by(role='teacher').first()
            if not creator:
                print("No teachers found in the database. Please add a teacher first.")
                return
            print(f"Using '{creator.username}' as the course creator.")

        for course_data in ALL_COURSES:
            print(f"\n--- 正在處理課程: '{course_data['title']}' ---")
            
            course = Course.query.filter_by(title=course_data['title']).first()
            if not course:
                print(f"課程不存在，正在建立...")
                course = Course(title=course_data['title'], description=course_data.get('description', ''), creator_id=creator.id)
                db.session.add(course)
                db.session.commit()
            else:
                print(f"課程已存在，正在檢查並更新內容...")

            for unit_data in course_data['units']:
                unit = Unit.query.filter_by(title=unit_data['title'], course_id=course.id).first()
                if not unit:
                    print(f"  - 新增單元: '{unit_data['title']}'")
                    unit = Unit(title=unit_data['title'], description=unit_data.get('description', ''), order=unit_data['order'], course_id=course.id)
                    db.session.add(unit)
                    db.session.commit()
                
                for lesson_data in unit_data['lessons']:
                    lesson = Lesson.query.filter_by(title=lesson_data['title'], unit_id=unit.id).first()
                    if not lesson:
                        print(f"    - 新增課節: '{lesson_data['title']}'")
                        lesson = Lesson(title=lesson_data['title'], description=lesson_data.get('description', ''), order=lesson_data['order'], unit_id=unit.id)
                        db.session.add(lesson)
                        db.session.commit()

                    MultipleChoiceQuestion.query.filter_by(lesson_id=lesson.id).delete()
                    CodingExercise.query.filter_by(lesson_id=lesson.id).delete()
                    db.session.commit()

                    for exercise_data in lesson_data.get('exercises', []):
                        if exercise_data.get('type') == 'mcq':
                            mcq = MultipleChoiceQuestion(lesson_id=lesson.id, question_text=exercise_data['question'], options=json.dumps(exercise_data['options']), correct_option_index=exercise_data['correct_index'], explanation=exercise_data.get('explanation', ''), points=exercise_data.get('points', 0))
                            db.session.add(mcq)
                        elif exercise_data.get('type') == 'coding':
                            coding_ex = CodingExercise(lesson_id=lesson.id, instructions=exercise_data.get('instructions', ''), starter_code=exercise_data.get('starter_code', ''), solution_code=exercise_data.get('solution_code', ''), test_cases=json.dumps(exercise_data.get('test_cases', [])), max_score=exercise_data.get('max_score', 0))
                            db.session.add(coding_ex)
            
            db.session.commit()
            print(f"成功更新課程 '{course_data['title']}'!")

if __name__ == "__main__":
    process_courses()