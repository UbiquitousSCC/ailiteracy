--
-- PostgreSQL database dump
--

-- Dumped from database version 14.18
-- Dumped by pg_dump version 14.18

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: coding_exercises; Type: TABLE; Schema: public; Owner: devuser
--

CREATE TABLE public.coding_exercises (
    id integer NOT NULL,
    lesson_id integer NOT NULL,
    instructions text NOT NULL,
    starter_code text,
    solution_code text NOT NULL,
    test_cases text NOT NULL,
    max_score integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.coding_exercises OWNER TO devuser;

--
-- Name: coding_exercises_id_seq; Type: SEQUENCE; Schema: public; Owner: devuser
--

CREATE SEQUENCE public.coding_exercises_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.coding_exercises_id_seq OWNER TO devuser;

--
-- Name: coding_exercises_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: devuser
--

ALTER SEQUENCE public.coding_exercises_id_seq OWNED BY public.coding_exercises.id;


--
-- Name: courses; Type: TABLE; Schema: public; Owner: devuser
--

CREATE TABLE public.courses (
    id integer NOT NULL,
    title character varying(200) NOT NULL,
    description text,
    creator_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.courses OWNER TO devuser;

--
-- Name: courses_id_seq; Type: SEQUENCE; Schema: public; Owner: devuser
--

CREATE SEQUENCE public.courses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.courses_id_seq OWNER TO devuser;

--
-- Name: courses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: devuser
--

ALTER SEQUENCE public.courses_id_seq OWNED BY public.courses.id;


--
-- Name: enrollments; Type: TABLE; Schema: public; Owner: devuser
--

CREATE TABLE public.enrollments (
    id integer NOT NULL,
    student_id integer NOT NULL,
    course_id integer NOT NULL,
    enrolled_at timestamp without time zone
);


ALTER TABLE public.enrollments OWNER TO devuser;

--
-- Name: enrollments_id_seq; Type: SEQUENCE; Schema: public; Owner: devuser
--

CREATE SEQUENCE public.enrollments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.enrollments_id_seq OWNER TO devuser;

--
-- Name: enrollments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: devuser
--

ALTER SEQUENCE public.enrollments_id_seq OWNED BY public.enrollments.id;


--
-- Name: fill_blank_exercises; Type: TABLE; Schema: public; Owner: devuser
--

CREATE TABLE public.fill_blank_exercises (
    id integer NOT NULL,
    lesson_id integer NOT NULL,
    text_template text NOT NULL,
    blanks text NOT NULL,
    points integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.fill_blank_exercises OWNER TO devuser;

--
-- Name: fill_blank_exercises_id_seq; Type: SEQUENCE; Schema: public; Owner: devuser
--

CREATE SEQUENCE public.fill_blank_exercises_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fill_blank_exercises_id_seq OWNER TO devuser;

--
-- Name: fill_blank_exercises_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: devuser
--

ALTER SEQUENCE public.fill_blank_exercises_id_seq OWNED BY public.fill_blank_exercises.id;


--
-- Name: lessons; Type: TABLE; Schema: public; Owner: devuser
--

CREATE TABLE public.lessons (
    id integer NOT NULL,
    title character varying(200) NOT NULL,
    description text,
    "order" integer NOT NULL,
    unit_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.lessons OWNER TO devuser;

--
-- Name: lessons_id_seq; Type: SEQUENCE; Schema: public; Owner: devuser
--

CREATE SEQUENCE public.lessons_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lessons_id_seq OWNER TO devuser;

--
-- Name: lessons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: devuser
--

ALTER SEQUENCE public.lessons_id_seq OWNED BY public.lessons.id;


--
-- Name: multiple_choice_questions; Type: TABLE; Schema: public; Owner: devuser
--

CREATE TABLE public.multiple_choice_questions (
    id integer NOT NULL,
    lesson_id integer NOT NULL,
    question_text text NOT NULL,
    options text NOT NULL,
    correct_option_index integer NOT NULL,
    explanation text,
    points integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.multiple_choice_questions OWNER TO devuser;

--
-- Name: multiple_choice_questions_id_seq; Type: SEQUENCE; Schema: public; Owner: devuser
--

CREATE SEQUENCE public.multiple_choice_questions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.multiple_choice_questions_id_seq OWNER TO devuser;

--
-- Name: multiple_choice_questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: devuser
--

ALTER SEQUENCE public.multiple_choice_questions_id_seq OWNED BY public.multiple_choice_questions.id;


--
-- Name: progress; Type: TABLE; Schema: public; Owner: devuser
--

CREATE TABLE public.progress (
    id integer NOT NULL,
    student_id integer NOT NULL,
    lesson_id integer NOT NULL,
    coding_score integer,
    multiple_choice_score integer,
    fill_blank_score integer,
    completed boolean,
    attempts integer,
    last_attempt_at timestamp without time zone,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    coding_results text,
    multiple_choice_results text,
    fill_blank_results text
);


ALTER TABLE public.progress OWNER TO devuser;

--
-- Name: progress_id_seq; Type: SEQUENCE; Schema: public; Owner: devuser
--

CREATE SEQUENCE public.progress_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.progress_id_seq OWNER TO devuser;

--
-- Name: progress_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: devuser
--

ALTER SEQUENCE public.progress_id_seq OWNED BY public.progress.id;


--
-- Name: submission_history; Type: TABLE; Schema: public; Owner: devuser
--

CREATE TABLE public.submission_history (
    id integer NOT NULL,
    student_id integer NOT NULL,
    lesson_id integer NOT NULL,
    submission_type character varying(20) NOT NULL,
    content text NOT NULL,
    score integer,
    feedback text,
    submitted_at timestamp without time zone
);


ALTER TABLE public.submission_history OWNER TO devuser;

--
-- Name: submission_history_id_seq; Type: SEQUENCE; Schema: public; Owner: devuser
--

CREATE SEQUENCE public.submission_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.submission_history_id_seq OWNER TO devuser;

--
-- Name: submission_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: devuser
--

ALTER SEQUENCE public.submission_history_id_seq OWNED BY public.submission_history.id;


--
-- Name: units; Type: TABLE; Schema: public; Owner: devuser
--

CREATE TABLE public.units (
    id integer NOT NULL,
    title character varying(200) NOT NULL,
    description text,
    "order" integer NOT NULL,
    course_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.units OWNER TO devuser;

--
-- Name: units_id_seq; Type: SEQUENCE; Schema: public; Owner: devuser
--

CREATE SEQUENCE public.units_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.units_id_seq OWNER TO devuser;

--
-- Name: units_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: devuser
--

ALTER SEQUENCE public.units_id_seq OWNED BY public.units.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: devuser
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(80) NOT NULL,
    email character varying(120),
    password_hash character varying(256) NOT NULL,
    role character varying(20) NOT NULL,
    created_at timestamp without time zone
);


ALTER TABLE public.users OWNER TO devuser;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: devuser
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO devuser;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: devuser
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: coding_exercises id; Type: DEFAULT; Schema: public; Owner: devuser
--

ALTER TABLE ONLY public.coding_exercises ALTER COLUMN id SET DEFAULT nextval('public.coding_exercises_id_seq'::regclass);


--
-- Name: courses id; Type: DEFAULT; Schema: public; Owner: devuser
--

ALTER TABLE ONLY public.courses ALTER COLUMN id SET DEFAULT nextval('public.courses_id_seq'::regclass);


--
-- Name: enrollments id; Type: DEFAULT; Schema: public; Owner: devuser
--

ALTER TABLE ONLY public.enrollments ALTER COLUMN id SET DEFAULT nextval('public.enrollments_id_seq'::regclass);


--
-- Name: fill_blank_exercises id; Type: DEFAULT; Schema: public; Owner: devuser
--

ALTER TABLE ONLY public.fill_blank_exercises ALTER COLUMN id SET DEFAULT nextval('public.fill_blank_exercises_id_seq'::regclass);


--
-- Name: lessons id; Type: DEFAULT; Schema: public; Owner: devuser
--

ALTER TABLE ONLY public.lessons ALTER COLUMN id SET DEFAULT nextval('public.lessons_id_seq'::regclass);


--
-- Name: multiple_choice_questions id; Type: DEFAULT; Schema: public; Owner: devuser
--

ALTER TABLE ONLY public.multiple_choice_questions ALTER COLUMN id SET DEFAULT nextval('public.multiple_choice_questions_id_seq'::regclass);


--
-- Name: progress id; Type: DEFAULT; Schema: public; Owner: devuser
--

ALTER TABLE ONLY public.progress ALTER COLUMN id SET DEFAULT nextval('public.progress_id_seq'::regclass);


--
-- Name: submission_history id; Type: DEFAULT; Schema: public; Owner: devuser
--

ALTER TABLE ONLY public.submission_history ALTER COLUMN id SET DEFAULT nextval('public.submission_history_id_seq'::regclass);


--
-- Name: units id; Type: DEFAULT; Schema: public; Owner: devuser
--

ALTER TABLE ONLY public.units ALTER COLUMN id SET DEFAULT nextval('public.units_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: devuser
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: coding_exercises; Type: TABLE DATA; Schema: public; Owner: devuser
--

COPY public.coding_exercises (id, lesson_id, instructions, starter_code, solution_code, test_cases, max_score, created_at, updated_at) FROM stdin;
1	3	Write a program that prints 'Hello, World!' to the console.	# Write your code here\n\n	print('Hello, World!')	[{"input": "", "expected_output": "Hello, World!"}]	100	2025-06-13 03:23:21.815494	2025-06-13 03:23:21.815498
5	5	從名為 'Users' 的資料表中，選取所有 country 為 'USA' 的使用者。	SELECT * FROM Users WHERE ...	SELECT * FROM Users WHERE country = 'USA';	[]	20	2025-06-19 18:41:46.804304	2025-06-19 18:41:46.804308
6	6	資料分散在 `Orders` 和 `Customers` 兩個資料表中。`Orders` 有 `CustomerID`，`Customers` 有 `CustomerID` 和 `CustomerName`。請寫一個查詢，找出每個訂單的 `OrderID` 以及對應的 `CustomerName`。	SELECT Orders.OrderID, Customers.CustomerName FROM Orders ...;	SELECT Orders.OrderID, Customers.CustomerName FROM Orders INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID;	[]	25	2025-06-19 18:41:46.813241	2025-06-19 18:41:46.813245
7	7	小傑每天早上都要說三次「我起床了！」，請用程式幫他完成這項任務。	# 使用 for 迴圈完成任務\nfor i in range(3):\n    # 在這裡印出「我起床了！」	for i in range(3):\n    print("我起床了！")	[]	10	2025-06-19 18:41:46.840869	2025-06-19 18:41:46.840873
8	8	請列印清單中的所有食物：「蘋果」、「香蕉」、「蛋糕」	foods = ["蘋果", "香蕉", "蛋糕"]\n# 使用 for 迴圈印出所有食物	foods = ["蘋果", "香蕉", "蛋糕"]\nfor food in foods:\n    print(food)	[]	10	2025-06-19 18:41:46.850123	2025-06-19 18:41:46.850127
9	9	小妤想學數數，請幫她印出 1 到 5。	# 使用 for 迴圈和 range 印出 1 到 5	for i in range(1, 6):\n    print(i)	[]	10	2025-06-19 18:41:46.859378	2025-06-19 18:41:46.859382
10	10	印出一排 6 顆星星。	# 使用 for 迴圈和 end="" 印出星星	for i in range(6):\n    print("*", end="")	[]	10	2025-06-19 18:41:46.868436	2025-06-19 18:41:46.868439
11	11	計算 1 到 5 的總和。	total = 0\n# 使用 for 迴圈計算總和	total = 0\nfor i in range(1, 6):\n    total += i\nprint(total)	[]	10	2025-06-19 18:41:46.877601	2025-06-19 18:41:46.877605
12	12	印出 5 到 1 的倒數。	# 使用 for 迴圈和 range 倒數	for i in range(5, 0, -1):\n    print(i)	[]	10	2025-06-19 18:41:46.886811	2025-06-19 18:41:46.886816
13	13	小妤想列出 1 到 9 的奇數，請幫她完成。	# 使用 for 迴圈和 range 的第三個參數找出奇數	for i in range(1, 10, 2):\n    print(i)	[]	10	2025-06-19 18:41:46.90408	2025-06-19 18:41:46.904084
14	14	印出一個五層的星星塔，每層星星數為層數。	# 使用 for 迴圈和字串乘法印出星星塔	for i in range(1, 6):\n    print("*" * i)	[]	15	2025-06-19 18:41:46.913278	2025-06-19 18:41:46.913283
15	15	計算 2 到 10 所有偶數的總和。	total = 0\n# 使用 for 迴圈和 range 計算偶數總和	total = 0\nfor i in range(2, 11, 2):\n    total += i\nprint(total)	[]	15	2025-06-19 18:41:46.922376	2025-06-19 18:41:46.92238
16	16	印出一個 4x4 的星星正方形。	# 使用巢狀 for 迴圈印出正方形	for i in range(4):\n    for j in range(4):\n        print("*", end=" ")\n    print()	[]	15	2025-06-19 18:41:46.932346	2025-06-19 18:41:46.932351
17	17	印出倒數的星星塔（從 5 顆到 1 顆）。	# 使用 for 迴圈和 range 印出倒數星星塔	for i in range(5, 0, -1):\n    print("*" * i)	[]	15	2025-06-19 18:41:46.941914	2025-06-19 18:41:46.941918
18	18	使用清單列出任務，列印每項任務後顯示「已完成！」	tasks = ["洗衣服", "拖地", "倒垃圾"]\n# 使用 for 迴圈完成任務打卡	tasks = ["洗衣服", "拖地", "倒垃圾"]\nfor task in tasks:\n    print(f"{task} 已完成！")	[]	15	2025-06-19 18:41:46.951002	2025-06-19 18:41:46.951006
19	19	列出 1 到 3 的乘法表，每行顯示「a x b = c」格式。	# 使用巢狀 for 迴圈印出乘法表	for i in range(1, 4):\n    for j in range(1, 10):\n        print(f"{i} x {j} = {i*j}")\n    print()	[]	20	2025-06-19 18:41:46.965533	2025-06-19 18:41:46.965537
20	20	印出一個 4 層梯形，每層比上一層多 2 顆星星，從 2 顆開始。	# 使用 for 迴圈印出梯形	for i in range(1, 5):\n    print("*" * (2 * i))	[]	20	2025-06-19 18:41:46.974413	2025-06-19 18:41:46.974417
21	21	計算 1×2×3×…×n（例如 n=5，結果是 120）	n = 5\nresult = 1\n# 使用 for 迴圈計算 n 的階乘	n = 5\nresult = 1\nfor i in range(1, n + 1):\n    result *= i\nprint(result)	[]	20	2025-06-19 18:41:46.983319	2025-06-19 18:41:46.983323
22	22	印出 3x3 座標點（如 (0,0)、(0,1)…）	# 使用巢狀 for 迴圈印出座標	for i in range(3):\n    for j in range(3):\n        print(f"({i}, {j})")	[]	20	2025-06-19 18:41:46.992287	2025-06-19 18:41:46.992291
23	23	將字串 “PYTHON” 一個字一行，從後面開始印。	s = "PYTHON"\n# 使用 for 迴圈倒著印出字串	s = "PYTHON"\nfor i in range(len(s) - 1, -1, -1):\n    print(s[i])	[]	20	2025-06-19 18:41:47.00207	2025-06-19 18:41:47.002075
24	24	給定一組數字，找出最大的數字。	numbers = [3, 1, 4, 1, 5, 9, 2, 6]\nmax_num = numbers[0]\n# 使用 for 迴圈找出最大值	numbers = [3, 1, 4, 1, 5, 9, 2, 6]\nmax_num = numbers[0]\nfor num in numbers:\n    if num > max_num:\n        max_num = num\nprint(max_num)	[]	20	2025-06-19 18:41:47.01061	2025-06-19 18:41:47.010612
25	25	印出一個 3x3 棋盤，內容全為「⬜」	# 使用巢狀 for 迴圈印出棋盤	for i in range(3):\n    for j in range(3):\n        print("⬜", end="")\n    print()	[]	20	2025-06-19 18:41:47.018404	2025-06-19 18:41:47.018408
26	26	請每隔一個字印出字串 “HELLOWORLD” 中的字。	s = "HELLOWORLD"\n# 使用 for 迴圈和 range 的步進參數	s = "HELLOWORLD"\nfor i in range(0, len(s), 2):\n    print(s[i])	[]	20	2025-06-19 18:41:47.027478	2025-06-19 18:41:47.027482
27	27	請寫一個 while 迴圈，將數字 1~5 依序印出來。	i = 1\n# 使用 while 迴圈印出 1 到 5	i = 1\nwhile i <= 5:\n    print(i)\n    i += 1	[]	10	2025-06-19 18:41:47.041925	2025-06-19 18:41:47.041929
28	28	請用 while 迴圈重複印出 3 次「Hello!」。	count = 0\n# 使用 while 迴圈印出三次 Hello!	count = 0\nwhile count < 3:\n    print("Hello!")\n    count += 1	[]	10	2025-06-19 18:41:47.05089	2025-06-19 18:41:47.050894
29	29	請用 while 迴圈將數字從 5 倒數到 1。	i = 5\n# 使用 while 迴圈倒數	i = 5\nwhile i >= 1:\n    print(i)\n    i -= 1	[]	10	2025-06-19 18:41:47.059791	2025-06-19 18:41:47.059795
30	30	請用 while 迴圈計算 1+2+3+4+5 的總和，並印出答案。	total = 0\ni = 1\n# 使用 while 迴圈計算總和	total = 0\ni = 1\nwhile i <= 5:\n    total += i\n    i += 1\nprint(total)	[]	10	2025-06-19 18:41:47.068742	2025-06-19 18:41:47.068746
31	31	請用 while 迴圈印出 1~10 之間所有的偶數。	i = 1\n# 使用 while 迴圈找出偶數	i = 1\nwhile i <= 10:\n    if i % 2 == 0:\n        print(i)\n    i += 1	[]	10	2025-06-19 18:41:47.077672	2025-06-19 18:41:47.077676
32	32	請用 while 迴圈印出 4 顆星星（每行一顆）。	count = 0\n# 使用 while 迴圈印出星星	count = 0\nwhile count < 4:\n    print(" * ")\n    count += 1	[]	10	2025-06-19 18:41:47.086612	2025-06-19 18:41:47.086616
33	33	請用 while 迴圈印出 1 到 10 之間所有的奇數。	i = 1\n# 使用 while 迴圈找出奇數	i = 1\nwhile i <= 10:\n    if i % 2 != 0:\n        print(i)\n    i += 1	[]	15	2025-06-19 18:41:47.102212	2025-06-19 18:41:47.102216
34	34	請用 while 迴圈從 1 開始累加，直到總和超過 50，並印出最後總和。	total = 0\ni = 1\n# 使用 while 迴圈累加直到超過 50	total = 0\ni = 1\nwhile total <= 50:\n    total += i\n    i += 1\nprint(total)	[]	15	2025-06-19 18:41:47.111121	2025-06-19 18:41:47.111125
35	35	請用 while 迴圈印出 7 到 12 的所有數字。	i = 7\n# 使用 while 迴圈印出 7 到 12	i = 7\nwhile i <= 12:\n    print(i)\n    i += 1	[]	15	2025-06-19 18:41:47.120995	2025-06-19 18:41:47.120999
36	36	請用 while 迴圈，從 2 開始，每次加 3，直到小於或等於 20，把所有數字印出來。	i = 2\n# 使用 while 迴圈跳步數數	i = 2\nwhile i <= 20:\n    print(i)\n    i += 3	[]	15	2025-06-19 18:41:47.129801	2025-06-19 18:41:47.129805
37	37	請用 while 迴圈找出 1~100 中第一個同時可以被 4 和 6 整除的數字，並印出這個數。	i = 1\n# 使用 while 迴圈和 break 找出最小公倍數	i = 1\nwhile i <= 100:\n    if i % 4 == 0 and i % 6 == 0:\n        print(i)\n        break\n    i += 1	[]	15	2025-06-19 18:41:47.138529	2025-06-19 18:41:47.138533
38	38	請寫一個 while 迴圈，不斷讓使用者輸入數字，並累加起來，直到輸入 0 為止，最後印出總和。	# 注意：此題在自動化環境中可能無法執行，因為需要使用者輸入。\ntotal = 0\n# 使用 while 迴圈累計輸入	total = 0\nwhile True:\n    try:\n        num = int(input("請輸入數字 (輸入 0 結束): "))\n        if num == 0:\n            break\n        total += num\n    except ValueError:\n        print("請輸入有效的數字。")\nprint(f"總和為: {total}")	[]	15	2025-06-19 18:41:47.147304	2025-06-19 18:41:47.147308
39	39	請讓使用者輸入一個正整數 n，然後用 while 迴圈把 n~1 的數字依序倒著印出來。	# 注意：此題在自動化環境中可能無法執行，因為需要使用者輸入。\nn = int(input("請輸入一個正整數: "))\n# 使用 while 迴圈倒著印	try:\n    n = int(input("請輸入一個正整數: "))\n    while n >= 1:\n        print(n)\n        n -= 1\nexcept ValueError:\n    print("請輸入有效的整數。")	[]	20	2025-06-19 18:41:47.161502	2025-06-19 18:41:47.161506
40	40	請用 while 迴圈印出 2~20 所有的質數（只能被 1 和自己整除的正整數）。	num = 2\n# 使用巢狀 while 迴圈找出質數	num = 2\nwhile num <= 20:\n    is_prime = True\n    divisor = 2\n    while divisor <= int(num**0.5):\n        if num % divisor == 0:\n            is_prime = False\n            break\n        divisor += 1\n    if is_prime:\n        print(num)\n    num += 1	[]	20	2025-06-19 18:41:47.170262	2025-06-19 18:41:47.170266
41	41	請用巢狀 while 迴圈印出 1~9 的九九乘法表（每行顯示一個數的 1~9 乘積）。	i = 1\n# 使用巢狀 while 迴圈印出九九乘法表	i = 1\nwhile i <= 9:\n    j = 1\n    while j <= 9:\n        print(f"{i}x{j}={i*j}", end="\t")\n        j += 1\n    print()\n    i += 1	[]	20	2025-06-19 18:41:47.17939	2025-06-19 18:41:47.179394
42	42	讓使用者輸入兩個正整數 a 和 b，請用 while 迴圈找出他們的最大公因數（GCD）。	# 注意：此題在自動化環境中可能無法執行，因為需要使用者輸入。\na = int(input("請輸入第一個正整數: "))\nb = int(input("請輸入第二個正整數: "))\n# 使用輾轉相除法找出最大公因數	try:\n    a = int(input("請輸入第一個正整數: "))\n    b = int(input("請輸入第二個正整數: "))\n    while b:\n        a, b = b, a % b\n    print(f"最大公因數是: {a}")\nexcept ValueError:\n    print("請輸入有效的整數。")	[]	20	2025-06-19 18:41:47.188916	2025-06-19 18:41:47.18892
43	43	設一個 while 迴圈，讓使用者最多猜 5 次某個神秘數字（答案設為 8），如果在 5 次內猜對就顯示「恭喜」，否則顯示「沒猜中」。	# 注意：此題在自動化環境中可能無法執行，因為需要使用者輸入。\nanswer = 8\nguess_count = 0\n# 使用 while 迴圈完成猜數字遊戲	answer = 8\nguess_count = 0\nwhile guess_count < 5:\n    try:\n        guess = int(input(f"猜一個數字 (剩下 {5 - guess_count} 次機會): "))\n        if guess == answer:\n            print("恭喜，你猜對了！")\n            break\n        else:\n            print("猜錯了。")\n        guess_count += 1\n    except ValueError:\n        print("請輸入有效的數字。")\nelse:\n    print(f"沒猜中，答案是 {answer}")	[]	20	2025-06-19 18:41:47.197831	2025-06-19 18:41:47.197835
44	44	請讓使用者輸入一個正整數 n，用 while 迴圈計算 n 的階乘（n!）。	# 注意：此題在自動化環境中可能無法執行，因為需要使用者輸入。\nn = int(input("請輸入一個正整數: "))\nresult = 1\n# 使用 while 迴圈計算階乘	try:\n    n = int(input("請輸入一個正整數: "))\n    if n < 0:\n        print("階乘不適用於負數。")\n    else:\n        result = 1\n        i = n\n        while i > 0:\n            result *= i\n            i -= 1\n        print(f"{n} 的階乘是 {result}")\nexcept ValueError:\n    print("請輸入有效的整數。")	[]	20	2025-06-19 18:41:47.206743	2025-06-19 18:41:47.206747
55	55	小奇的魔法筆電說：「我需要知道你的名字才能啟動！」\n\n**要求：**\n請建立一個變數 `wizard_name`，將 `"小奇"` 存入，並印出這個變數。	# 請建立一個變數 wizard_name，並存入指定的名字\nwizard_name = ""	wizard_name = "小奇"\nprint(wizard_name)	[]	10	2025-06-20 02:19:50.122007	2025-06-20 02:19:50.122012
56	56	筆電下一關需要輸入正確的年齡通關碼（10 歲）才能通過！\n\n**要求：**\n請建立變數 `wizard_age` 並賦值為 `10`，最後印出它。	# 請建立變數 wizard_age 並賦值為 10\nwizard_age =	wizard_age = 10\nprint(wizard_age)	[]	10	2025-06-20 02:19:50.130593	2025-06-20 02:19:50.130596
57	57	筆電說：「製作一張魔法名片吧！」\n\n**要求：**\n請建立 `wizard_name`、`wizard_age`、`element` 三個變數，並依照格式印出自我介紹。\n\n**預期輸出：**\n```\n我是小奇，今年10歲，擅長雷電魔法！\n```	wizard_name = "小奇"\nwizard_age = 10\nelement = "雷電"\n\n# 請使用 f-string 或 str() 組合字串並印出	wizard_name = "小奇"\nwizard_age = 10\nelement = "雷電"\nprint(f"我是{wizard_name}，今年{str(wizard_age)}歲，擅長{element}魔法！")	[]	10	2025-06-20 02:19:50.138793	2025-06-20 02:19:50.138797
58	58	小奇測驗兩種魔法：冰魔法 87 分、火魔法 91 分。\n\n**要求：**\n請用變數計算平均分數並印出結果。	ice_magic_score = 87\nfire_magic_score = 91\n\n# 計算平均分數\naverage_score =	ice_magic_score = 87\nfire_magic_score = 91\naverage_score = (ice_magic_score + fire_magic_score) / 2\nprint(average_score)	[]	10	2025-06-20 02:19:50.148115	2025-06-20 02:19:50.148119
59	59	下列變數名稱有哪些錯誤？為什麼？\n```python\n1魔力 = 50\nmy level = 99\n角色名 = "奇奇"\n```\n**要求：**\n請用 `print()` 函數以字串形式說明三個變數的命名問題。	# 請用 print() 說明每個變數的命名錯誤	print("1魔力: 變數名稱不能以數字開頭。")\nprint("my level: 變數名稱不能包含空格。")\nprint("角色名: 雖然 Python 3 支援中文命名，但通常不建議，以維持程式碼的通用性與可讀性。")	[]	10	2025-06-20 02:19:50.157663	2025-06-20 02:19:50.157667
60	60	筆電給了幾個資料，要你判斷型別：\n- `"99"`\n- `99`\n- `3.14`\n- `"小奇"`\n\n**要求：**\n請依序印出每個資料的型別（str, int, float）。	# 請使用 type() 函數並印出結果	print(type("99"))\nprint(type(99))\nprint(type(3.14))\nprint(type("小奇"))	[]	10	2025-06-20 02:19:50.166988	2025-06-20 02:19:50.166992
61	61	小奇寫錯程式，印不出正確句子：\n```python\nage = 10\nprint("我今年" + age + "歲")\n```\n**要求：**\n請修正程式讓它能正確執行。	age = 10\n# 請修正下一行，讓文字和數字可以成功組合\nprint("我今年" + age + "歲")	age = 10\nprint("我今年" + str(age) + "歲")	[]	10	2025-06-20 02:19:50.17627	2025-06-20 02:19:50.176274
62	62	請建立角色檔案並依指定格式印出。\n\n**預期輸出：**\n```\n大家好，我是小奇，10歲，我的夥伴是小龍！\n```	name = "小奇"\nage = 10\npet = "小龍"\n\n# 請印出指定格式的句子	name = "小奇"\nage = 10\npet = "小龍"\nprint(f"大家好，我是{name}，{age}歲，我的夥伴是{pet}！")	[]	10	2025-06-20 02:19:50.185514	2025-06-20 02:19:50.185518
63	63	請記錄今天的任務日誌。\n\n**預期輸出：**\n```\n今天我和小羽一起探險火山洞窟。\n我們找到了一顆藍色水晶！\n```	place = "火山洞窟"\nitem = "藍色水晶"\npartner = "小羽"\n\n# 請印出兩行日誌	place = "火山洞窟"\nitem = "藍色水晶"\npartner = "小羽"\nprint(f"今天我和{partner}一起探險{place}。")\nprint(f"我們找到了一顆{item}！")	[]	10	2025-06-20 02:19:50.194808	2025-06-20 02:19:50.194813
64	64	小奇寫下：\n```python\ndef shout():\n    spell = "轟雷術"\n    print(spell)\n\nshout()\nprint(spell)\n```\n**要求：**\n為什麼最後一行錯了？請用 `print()` 函數印出解釋。	# 請用 print() 函數解釋錯誤原因	print("因為變數 'spell' 是在函式 shout() 內部定義的，它是一個區域變數(local variable)，只在該函式內部有效。函式外部無法存取它，所以最後一行會報錯 (NameError)。")	[]	10	2025-06-20 02:19:50.204013	2025-06-20 02:19:50.204017
65	65	小奇擊敗兩隻怪獸，獲得了不同的獎勵。\n- 初始狀態：`level = 5`, `exp = 120`\n- 第一隻怪獸：等級 +1，經驗值 +50\n- 第二隻怪獸：等級 +2，經驗值 +80\n\n**要求：**\n請更新變數，並依照以下格式印出最終結果：\n```\n目前等級：8，總經驗值：250\n```	level = 5\nexp = 120\n\n# 更新等級和經驗值\n\n\n# 印出最終結果	level = 5\nexp = 120\n\n# 第一次獎勵\nlevel += 1\nexp += 50\n\n# 第二次獎勵\nlevel += 2\nexp += 80\n\nprint(f"目前等級：{level}，總經驗值：{exp}")	[]	15	2025-06-20 02:19:50.218891	2025-06-20 02:19:50.218895
66	66	小奇的裝備背包亂了，請協助他統一更新裝備。\n他決定改為：\n- 換上 `"閃電短刀"`\n- 升級盾為 `"鑽石盾"`\n- 補滿藥水為 `"治療藥水"`\n\n**要求：**\n請更新變數並輸出指定句子。	weapon = "火焰之劍"\nshield = "木盾"\npotion = "空瓶子"\n\n# 更新裝備\n\n\n# 輸出句子\n# 預期輸出: 小奇裝備了閃電短刀與鑽石盾，背包中有一瓶治療藥水。	weapon = "火焰之劍"\nshield = "木盾"\npotion = "空瓶子"\n\nweapon = "閃電短刀"\nshield = "鑽石盾"\npotion = "治療藥水"\n\nprint(f"小奇裝備了{weapon}與{shield}，背包中有一瓶{potion}。")	[]	15	2025-06-20 02:19:50.228111	2025-06-20 02:19:50.228115
67	67	小奇希望把技能說明包裝成一個可以重複呼叫的函式。\n\n**要求：**\n請完成 `skill_card` 函式，當呼叫 `skill_card("火球術", 5)` 時，會印出：\n```\n技能：火球術，冷卻時間：5 秒\n```	def skill_card(name, cooldown):\n    # 請補上這行程式碼，使用 f-string 印出結果\n\n# 呼叫函式以測試\nskill_card("火球術", 5)\nskill_card("寒冰箭", 8)	def skill_card(name, cooldown):\n    print(f"技能：{name}，冷卻時間：{cooldown} 秒")\n\nskill_card("火球術", 5)\nskill_card("寒冰箭", 8)	[]	15	2025-06-20 02:19:50.237197	2025-06-20 02:19:50.237201
68	68	小奇與他的搭檔進行角色與狀態交換。\n\n**要求：**\n請交換兩人的角色與狀態，並印出指定格式的句子。\n```\n小羽（受傷）與小奇（健康）完成交換！\n```	hero = "小奇"\nstatus = "受傷"\npartner = "小羽"\npartner_status = "健康"\n\n# 請在此處交換變數\n\n\n# 印出交換後的結果	hero = "小奇"\nstatus = "受傷"\npartner = "小羽"\npartner_status = "健康"\n\n# 交換角色與狀態\nhero, partner = partner, hero\nstatus, partner_status = partner_status, status\n\nprint(f"{hero}（{status}）與{partner}（{partner_status}）完成交換！")	[]	15	2025-06-20 02:19:50.246502	2025-06-20 02:19:50.246507
69	69	每當小奇打怪成功，他會獲得：\n- 基礎經驗：60\n- 額外加乘值：15%\n- 獎勵經驗：20 點\n\n**要求：**\n請計算總經驗值（基礎經驗 * (1 + 加乘) + 獎勵），並將最終結果保留一位小數印出。\n\n**預期輸出：**\n```\n總經驗值為：89.0 點\n```	base_exp = 60\nbonus_rate = 0.15\nreward_exp = 20\n\n# 計算總經驗值\ntotal_exp = \n\n# 印出結果	base_exp = 60\nbonus_rate = 0.15\nreward_exp = 20\n\ntotal_exp = base_exp * (1 + bonus_rate) + reward_exp\n\nprint(f"總經驗值為：{total_exp:.1f} 點")	[]	15	2025-06-20 02:19:50.256468	2025-06-20 02:19:50.256473
87	87	有一筆總分 250，滿分是 300。\n\n**要求：**\n請計算其百分比 (`總分 / 滿分 * 100`)，並將結果格式化為保留一位小數的字串印出。	score = 250\nfull_mark = 300\n\n# 計算百分比\npercentage = \n\n# 格式化輸出\nprint(f"{percentage:.1f}%")	score = 250\nfull_mark = 300\n\npercentage = (score / full_mark) * 100\n\nprint(f"{percentage:.1f}%")	[]	15	2025-06-20 02:26:25.31245	2025-06-20 02:26:25.312453
70	70	請設計一個函式 `introduce_skills(name, skills)`，其中 skills 是一個用逗號分隔的字串。\n\n**要求：**\n當呼叫 `introduce_skills("小奇", "火球術,冰牆,風刃")` 時，函式應印出：\n```\n小奇擁有的技能有：火球術、冰牆、風刃。\n```	def introduce_skills(name, skills):\n    # 請將 skills 字串中的逗號替換成「、」後印出\n    \n\n# 呼叫函式\nintroduce_skills("小奇", "火球術,冰牆,風刃")	def introduce_skills(name, skills):\n    formatted_skills = skills.replace(',', '、')\n    print(f"{name}擁有的技能有：{formatted_skills}。")\n\nintroduce_skills("小奇", "火球術,冰牆,風刃")	[]	15	2025-06-20 02:19:50.265998	2025-06-20 02:19:50.266002
71	71	小奇有技能 `"火球術"`，但冷卻時間還有 3 秒。\n\n**要求：**\n請根據變數判斷並印出：\n```\n火球術還不能使用，請等待 3 秒。\n```	skill = "火球術"\ncooldown = 3\n\n# 請使用 f-string 印出結果	skill = "火球術"\ncooldown = 3\nprint(f"{skill}還不能使用，請等待 {cooldown} 秒。")	[]	15	2025-06-20 02:19:50.275108	2025-06-20 02:19:50.275112
72	72	玩家每天登入可獲得 150 金幣，但第 5, 6, 7 天有額外加碼 50 金幣。\n\n**要求：**\n請計算 7 天的總獎勵金額，並印出。\n\n**預期輸出：**\n```\n小奇七天共獲得：1200 金幣。\n```	# 計算 7 天的總獎勵\ndaily_gold = 150\nbonus_gold = 50\ntotal_days = 7\nbonus_days = 3 # 第5, 6, 7天\n\ntotal_reward = \nprint(f"小奇七天共獲得：{total_reward} 金幣。")	daily_gold = 150\nbonus_gold = 50\ntotal_days = 7\nbonus_days = 3\n\ntotal_reward = (daily_gold * total_days) + (bonus_gold * bonus_days)\nprint(f"小奇七天共獲得：{total_reward} 金幣。")	[]	15	2025-06-20 02:19:50.284054	2025-06-20 02:19:50.284058
73	73	請寫一個函式 `report(name, place, item)`，傳入冒險者名字、地點與發現的物品。\n\n**要求：**\n當呼叫 `report("小奇", "熔岩洞穴", "魔法寶石")`，函式應印出：\n```\n冒險者小奇在熔岩洞穴中，發現了魔法寶石！\n```	def report(name, place, item):\n    # 請完成函式內容\n\n# 呼叫函式\nreport("小奇", "熔岩洞穴", "魔法寶石")	def report(name, place, item):\n    print(f"冒險者{name}在{place}中，發現了{item}！")\n\nreport("小奇", "熔岩洞穴", "魔法寶石")	[]	15	2025-06-20 02:19:50.292991	2025-06-20 02:19:50.292995
74	74	請給出以下每個變數的型別，並嘗試將其轉為另一種型別（若可轉換）：\n```python\na = "15"\nb = 12\nc = "3.14"\nd = "魔法"\n```\n**要求：**\n- 依序印出 `a, b, c, d` 的原始型別。\n- 將 `a` 轉為 `int` 並印出轉換後的值與型別。\n- 將 `b` 轉為 `str` 並印出轉換後的值與型別。\n- 將 `c` 轉為 `float` 並印出轉換後的值與型別。	a = "15"\nb = 12\nc = "3.14"\nd = "魔法"\n\n# 印出原始型別\n\n# 進行轉換並印出結果	a = "15"\nb = 12\nc = "3.14"\nd = "魔法"\n\nprint(f"a 的原始型別: {type(a)}")\nprint(f"b 的原始型別: {type(b)}")\nprint(f"c 的原始型別: {type(c)}")\nprint(f"d 的原始型別: {type(d)}")\n\nprint("--- 轉換後 ---")\na_int = int(a)\nprint(f"a 轉為 int: {a_int}, 型別: {type(a_int)}")\nb_str = str(b)\nprint(f"b 轉為 str: '{b_str}', 型別: {type(b_str)}")\nc_float = float(c)\nprint(f"c 轉為 float: {c_float}, 型別: {type(c_float)}")\nprint("d ('魔法') 無法直接轉換為數值型別。")	[]	15	2025-06-20 02:19:50.301771	2025-06-20 02:19:50.301775
75	75	一份雞排 70 元、一杯珍奶 55 元，請幫兩人平分帳單，並印出每人需付的金額。	fried_chicken = 70\nbubble_tea = 55\n\n# 計算總金額並除以2\naverage_cost =	fried_chicken = 70\nbubble_tea = 55\ntotal_cost = fried_chicken + bubble_tea\naverage_cost = total_cost / 2\nprint(average_cost)	[]	10	2025-06-20 02:26:25.204016	2025-06-20 02:26:25.20402
76	76	A 果汁 28 元、B 果汁 35 元。請用比較運算子 `<` 判斷 A 果汁是否比 B 果汁便宜，印出判斷結果 (True/False)。	juice_a = 28\njuice_b = 35\n\n# 判斷 juice_a 是否小於 juice_b\nis_cheaper =	juice_a = 28\njuice_b = 35\nis_cheaper = juice_a < juice_b\nprint(is_cheaper)	[]	10	2025-06-20 02:26:25.212339	2025-06-20 02:26:25.212341
77	77	阿哲 168 公分，阿婷 167.5 公分。請判斷阿哲是否比阿婷高，並依以下格式印出：\n```\n阿哲比阿婷高嗎？True\n```	zhe_height = 168\nting_height = 167.5\n\n# 進行比較\nis_taller =	zhe_height = 168\nting_height = 167.5\nis_taller = zhe_height > ting_height\nprint(f"阿哲比阿婷高嗎？{is_taller}")	[]	10	2025-06-20 02:26:25.220302	2025-06-20 02:26:25.220307
78	78	只有「作業完成」且「房間整齊」才能玩電動。請用 `and` 運算子判斷是否可以玩電動，並印出結果 (True/False)。	作業完成 = True\n房間整齊 = False\n\n# 判斷是否兩個條件都成立\ncan_play_games =	作業完成 = True\n房間整齊 = False\ncan_play_games = 作業完成 and 房間整齊\nprint(can_play_games)	[]	10	2025-06-20 02:26:25.229421	2025-06-20 02:26:25.229426
79	79	若成績是 78 分，請判斷是否及格（分數大於或等於 60）。	score = 78\n\n# 判斷是否及格\nis_pass =	score = 78\nis_pass = score >= 60\nprint(is_pass)	[]	10	2025-06-20 02:26:25.238933	2025-06-20 02:26:25.238937
80	80	每喝一杯水就加一，假設今天喝了三杯。請從 `水量 = 0` 開始，用複合賦值運算子 `+=` 模擬喝了三次水，最後印出總水量。	水量 = 0\n\n# 每次喝水都加 1，重複三次\n\n\nprint(水量)	水量 = 0\n水量 += 1\n水量 += 1\n水量 += 1\nprint(水量)	[]	10	2025-06-20 02:26:25.248276	2025-06-20 02:26:25.24828
81	81	總價 135 元，付款 200 元，請計算應找零多少錢並印出。	total_price = 135\npayment = 200\n\n# 計算找零\nchange =	total_price = 135\npayment = 200\nchange = payment - total_price\nprint(change)	[]	10	2025-06-20 02:26:25.257502	2025-06-20 02:26:25.257507
82	82	初始能量 100，每使用技能扣除 15 點。請模擬使用三次技能後，更新並印出剩餘的能量值。	energy = 100\n\n# 使用三次技能，每次扣除 15\n\n\nprint(energy)	energy = 100\nenergy -= 15\nenergy -= 15\nenergy -= 15\nprint(energy)	[]	10	2025-06-20 02:26:25.266496	2025-06-20 02:26:25.2665
83	83	「有帶傘」或「天氣晴」才能出門。請用 `or` 運算子判斷是否能出門，並印出結果 (True/False)。	天氣晴 = False\n有帶傘 = True\n\n# 判斷是否至少一個條件成立\ncan_go_out =	天氣晴 = False\n有帶傘 = True\ncan_go_out = 天氣晴 or 有帶傘\nprint(can_go_out)	[]	10	2025-06-20 02:26:25.275472	2025-06-20 02:26:25.275476
84	84	判斷 `(氣溫 < 35 and 濕度 < 80) or 有冷氣` 的最終結果是什麼，並印出 (True/False)。	氣溫 = 34\n濕度 = 75\n有冷氣 = True\n\n# 根據條件進行判斷\nresult =	氣溫 = 34\n濕度 = 75\n有冷氣 = True\nresult = (氣溫 < 35 and 濕度 < 80) or 有冷氣\nprint(result)	[]	10	2025-06-20 02:26:25.283651	2025-06-20 02:26:25.283654
85	85	小奇目前經驗值為 180，升級門檻為 200，每打一次怪物增加 15 點。\n\n**要求：**\n請問「最少」還要打幾次怪物才能升級？請計算並印出次數。	import math\n\ncurrent_exp = 180\nupgrade_exp = 200\nexp_per_monster = 15\n\n# 計算還需要多少經驗值\nexp_needed = \n# 計算需要打幾次怪 (無條件進位)\nmonsters_needed = \nprint(monsters_needed)	import math\n\ncurrent_exp = 180\nupgrade_exp = 200\nexp_per_monster = 15\n\nexp_needed = upgrade_exp - current_exp\nmonsters_needed = math.ceil(exp_needed / exp_per_monster)\nprint(monsters_needed)	[]	15	2025-06-20 02:26:25.29565	2025-06-20 02:26:25.295653
86	86	體力初始 100，每移動一步 -3，每跳一次 -7。\n\n**要求：**\n阿奇今天走了 10 步、跳了 2 次，請算出他剩下的體力並印出。	stamina = 100\nwalk_cost = 3\njump_cost = 7\n\nwalk_steps = 10\njump_times = 2\n\n# 計算總消耗並更新體力\n\nprint(stamina)	stamina = 100\nwalk_cost = 3\njump_cost = 7\n\nwalk_steps = 10\njump_times = 2\n\ntotal_cost = (walk_steps * walk_cost) + (jump_times * jump_cost)\nstamina -= total_cost\nprint(stamina)	[]	15	2025-06-20 02:26:25.303625	2025-06-20 02:26:25.303629
88	88	小奇參加三項賽跑（a=12s, b=15s, c=10s）。\n\n**要求：**\n請找出最快的一項（秒數最少）並依以下格式印出：\n```\n最快項目是：c，耗時 10 秒\n```	a = 12\nb = 15\nc = 10\n\n# 比較找出最小值\n# 你可以使用 if/elif/else 來完成	a = 12\nb = 15\nc = 10\n\nif a <= b and a <= c:\n    fastest_item = 'a'\n    fastest_time = a\nelif b <= a and b <= c:\n    fastest_item = 'b'\n    fastest_time = b\nelse:\n    fastest_item = 'c'\n    fastest_time = c\n\nprint(f"最快項目是：{fastest_item}，耗時 {fastest_time} 秒")	[]	15	2025-06-20 02:26:25.320529	2025-06-20 02:26:25.320532
89	89	魔法初始 80 點，使用「火焰術」一次耗 35 點。\n\n**要求：**\n請判斷魔法值是否足夠連續使用兩次「火焰術」，若可以印出 True，否則 False。	mana = 80\nskill_cost = 35\n\n# 判斷是否夠用兩次\ncan_cast_twice = \nprint(can_cast_twice)	mana = 80\nskill_cost = 35\n\ncan_cast_twice = mana >= (skill_cost * 2)\nprint(can_cast_twice)	[]	15	2025-06-20 02:26:25.328406	2025-06-20 02:26:25.328409
90	90	阿邏買了三樣東西：魔法石 120 元、靈魂瓶 85 元、光之粉塵 47 元。他付款 300 元。\n\n**要求：**\n請計算並印出應找回多少錢。	item1 = 120\nitem2 = 85\nitem3 = 47\npayment = 300\n\n# 計算總價與找零\nchange = \nprint(change)	item1 = 120\nitem2 = 85\nitem3 = 47\npayment = 300\n\ntotal_cost = item1 + item2 + item3\nchange = payment - total_cost\nprint(change)	[]	15	2025-06-20 02:26:25.33551	2025-06-20 02:26:25.335513
91	91	小奇三週的等級分別為 3、5、7。請判斷是否「每週都持續成長」（第二週比第一週高，且第三週比第二週高）。\n\n**要求：**\n請印出 True 或 False。	week1_level = 3\nweek2_level = 5\nweek3_level = 7\n\n# 判斷是否持續成長\nis_growing = \nprint(is_growing)	week1_level = 3\nweek2_level = 5\nweek3_level = 7\n\nis_growing = (week2_level > week1_level) and (week3_level > week2_level)\nprint(is_growing)	[]	15	2025-06-20 02:26:25.342577	2025-06-20 02:26:25.34258
92	92	請定義變數，並依照指定格式輸出句子。\n\n**預期輸出：**\n```\n裝備：雷電刀，攻擊力：90，耐久值：65\n```	weapon = "雷電刀"\natk = 90\ndurability = 65\n\n# 使用 f-string 格式化輸出	weapon = "雷電刀"\natk = 90\ndurability = 65\n\nprint(f"裝備：{weapon}，攻擊力：{atk}，耐久值：{durability}")	[]	15	2025-06-20 02:26:25.349797	2025-06-20 02:26:25.349801
93	93	進入火山區的條件為：裝備為「火焰盾」**且** 等級大於等於 10。\n\n**要求：**\n請根據給定變數，判斷是否可以進入，並印出 True 或 False。	裝備 = "火焰盾"\n等級 = 10\n\n# 判斷是否滿足進入條件\ncan_enter = \nprint(can_enter)	裝備 = "火焰盾"\n等級 = 10\n\ncan_enter = (裝備 == "火焰盾") and (等級 >= 10)\nprint(can_enter)	[]	15	2025-06-20 02:26:25.358163	2025-06-20 02:26:25.358167
94	94	進入副本的條件為：「血量大於 50」**且**（「技能冷卻中為 False」**或**「有補品為 True」）。\n\n**要求：**\n請根據給定變數，判斷小奇是否可進入副本，並印出 True 或 False。	血量 = 80\n技能冷卻中 = True\n有補品 = False\n\n# 判斷是否可進入副本\ncan_enter_dungeon = \nprint(can_enter_dungeon)	血量 = 80\n技能冷卻中 = True\n有補品 = False\n\ncan_enter_dungeon = (血量 > 50) and (技能冷卻中 == False or 有補品 == True)\nprint(can_enter_dungeon)	[]	15	2025-06-20 02:26:25.366814	2025-06-20 02:26:25.366819
95	95	小魔法師艾莉絲獲得一本筆記本，請她記下第一筆資料：「apple」是「紅色的水果」。\n\n**要求：**\n建立一個字典，新增一筆資料後，將整個字典印出。	# 建立一個空字典\nnotebook = {}\n\n# 新增資料\n\n\n# 印出字典\nprint(notebook)	notebook = {}\nnotebook["apple"] = "紅色的水果"\nprint(notebook)	[]	10	2025-06-20 02:28:51.05602	2025-06-20 02:28:51.056024
96	96	請從下方已建立的筆記本中，查詢並印出 "banana" 對應的值。	notebook = {"apple": "紅色的水果", "banana": "黃色的水果"}\n\n# 查詢並印出 banana 的值	notebook = {"apple": "紅色的水果", "banana": "黃色的水果"}\nprint(notebook["banana"])	[]	10	2025-06-20 02:28:51.06415	2025-06-20 02:28:51.064153
97	97	dragonfruit 被錯誤記成「會噴火的水果」，請從字典中刪除這筆記錄，並印出刪除後的字典。	notebook = {"apple": "紅色的水果", "dragonfruit": "會噴火的水果"}\n\n# 刪除 dragonfruit\n\n\nprint(notebook)	notebook = {"apple": "紅色的水果", "dragonfruit": "會噴火的水果"}\ndel notebook["dragonfruit"]\nprint(notebook)	[]	10	2025-06-20 02:28:51.07224	2025-06-20 02:28:51.072245
98	98	請查詢筆記本中是否記錄了 "grape" 這個鍵，印出判斷結果 (True/False)。	notebook = {"apple": "紅色的水果", "banana": "黃色的水果"}\n\n# 判斷 "grape" 是否在字典的鍵中\nresult = \nprint(result)	notebook = {"apple": "紅色的水果", "banana": "黃色的水果"}\nresult = "grape" in notebook\nprint(result)	[]	10	2025-06-20 02:28:51.081546	2025-06-20 02:28:51.081551
99	99	請在字典中，將 "dragon" 的能力記錄成一個列表，包含「噴火」、「飛行」、「守寶藏」，並印出這個字典。	abilities = {}\n\n# 將一個列表賦值給 "dragon" 鍵\n\n\nprint(abilities)	abilities = {}\nabilities["dragon"] = ["噴火", "飛行", "守寶藏"]\nprint(abilities)	[]	15	2025-06-20 02:28:51.092491	2025-06-20 02:28:51.092494
100	100	計算下列魔法師的平均魔力分數，並印出結果。	magic_scores = {"艾莉絲": 85, "鮑伯": 72, "查理": 91}\n\n# 計算平均分數\naverage_score = \nprint(average_score)	magic_scores = {"艾莉絲": 85, "鮑伯": 72, "查理": 91}\naverage_score = sum(magic_scores.values()) / len(magic_scores)\nprint(average_score)	[]	15	2025-06-20 02:28:51.099972	2025-06-20 02:28:51.099975
101	101	給定兩個 list，請幫每位學徒配對魔杖，轉換成一個字典後印出。	apprentices = ["小明", "小華", "小莉"]\nwands = ["橡木魔杖", "柳木魔杖", "杉木魔杖"]\n\n# 使用 zip 和 dict 進行配對\nwand_pairs = \nprint(wand_pairs)	apprentices = ["小明", "小華", "小莉"]\nwands = ["橡木魔杖", "柳木魔杖", "杉木魔杖"]\nwand_pairs = dict(zip(apprentices, wands))\nprint(wand_pairs)	[]	15	2025-06-20 02:28:51.107442	2025-06-20 02:28:51.107445
102	102	請統計字串 "abracadabra" 中每個字元出現的次數，並將結果以字典形式印出。	text = "abracadabra"\nchar_counts = {}\n\n# 使用 for 迴圈遍歷字串並計數\n\nprint(char_counts)	text = "abracadabra"\nchar_counts = {}\nfor char in text:\n    if char not in char_counts:\n        char_counts[char] = 0\n    char_counts[char] += 1\nprint(char_counts)	[]	20	2025-06-20 02:28:51.114804	2025-06-20 02:28:51.114807
103	103	從字典中，找出分數最高的魔法師與他的分數，並依 `姓名: 分數` 的格式印出。	magic_scores = {"艾莉絲": 85, "鮑伯": 72, "查理": 91}\n\n# 找出最高分的魔法師\nhighest_scorer = \nhighest_score = \nprint(f"{highest_scorer}: {highest_score}")	magic_scores = {"艾莉絲": 85, "鮑伯": 72, "查理": 91}\nhighest_scorer = max(magic_scores, key=magic_scores.get)\nhighest_score = magic_scores[highest_scorer]\nprint(f"{highest_scorer}: {highest_score}")	[]	20	2025-06-20 02:28:51.122576	2025-06-20 02:28:51.12258
104	104	找出所有顏色為 "red" 的魔法物品，並將它們的名稱以列表形式印出。	magic_items = {"紅寶石": "red", "藍水晶": "blue", "力量藥水": "red"}\nred_items = []\n\n# 遍歷字典找出紅色的物品\n\nprint(red_items)	magic_items = {"紅寶石": "red", "藍水晶": "blue", "力量藥水": "red"}\nred_items = []\nfor item, color in magic_items.items():\n    if color == "red":\n        red_items.append(item)\nprint(red_items)	[]	20	2025-06-20 02:28:51.131122	2025-06-20 02:28:51.131127
105	105	輸入一個整數後，判斷並輸出「正數」、「負數」或「零」。	num = int(input("請輸入一個整數："))\n# TODO: 判斷正負或零	num = int(input())\nif num > 0:\n    print("正數")\nelif num == 0:\n    print("零")\nelse:\n    print("負數")	[]	10	2025-06-20 02:34:34.25627	2025-06-20 02:34:34.256274
106	106	修正以下程式碼，使其能正確輸出「偶數」或「奇數」。	num = int(input("請輸入一個整數："))\nif num % 2 == 1: # 這裡有邏輯錯誤\n    print("偶數")\nelse:\n    print("奇數")	num = int(input())\nif num % 2 == 0:\n    print("偶數")\nelse:\n    print("奇數")	[]	10	2025-06-20 02:34:34.264529	2025-06-20 02:34:34.264532
107	107	輸入 0–100 之間的成績，判斷並輸出「通過」（≥60）或「再努力」（<60）。	score = int(input("請輸入成績（0-100）："))\n# TODO: 如果 score >= 60，印出「通過」, 否則印出「再努力」	score = int(input())\nif score >= 60:\n    print("通過")\nelse:\n    print("再努力")	[]	10	2025-06-20 02:34:34.273945	2025-06-20 02:34:34.273949
108	108	輸入兩個數字，輸出其中較大的值。	a, b = map(int, input("請輸入兩座山峰高度，用空格分隔：").split())\n# TODO: 比較 a 和 b 並印出較大的值	a, b = map(int, input().split())\nif a > b:\n    print(a)\nelse:\n    print(b)	[]	10	2025-06-20 02:34:34.283089	2025-06-20 02:34:34.283093
109	109	輸入三個數字，找出並輸出最大的那個數字。	x, y, z = map(int, input("請輸入三道門號碼，用空格分隔：").split())\n# TODO: 使用 if/elif 找出最大值並印出	x, y, z = map(int, input().split())\nprint(max(x, y, z))	[]	10	2025-06-20 02:34:34.292324	2025-06-20 02:34:34.292328
110	110	撰寫函式 is_vowel(ch)，判斷傳入字母是否為母音 (a, e, i, o, u)，並回傳 True/False。	def is_vowel(ch):\n    # TODO: 回傳 ch.lower() 是否在 ['a','e','i','o','u'] 中\n    pass\n\nprint(is_vowel(input("請輸入一個英文字母：")))	def is_vowel(ch):\n    return ch.lower() in ['a','e','i','o','u']\n\nprint(is_vowel(input().strip()))	[]	10	2025-06-20 02:34:34.301388	2025-06-20 02:34:34.301392
111	111	撰寫函式 is_adult(age)，判斷年齡是否 ≥18，並在程式中輸出「取得騎士資格」或「繼續修行」。	def is_adult(age):\n    # TODO: 回傳 age >= 18\n    pass\n\nage = int(input("請輸入年齡："))\n# TODO: 呼叫 is_adult，並用 if/else 印出對應訊息	def is_adult(age):\n    return age >= 18\n\nage = int(input())\nif is_adult(age):\n    print("取得騎士資格")\nelse:\n    print("繼續修行")	[]	10	2025-06-20 02:34:34.310326	2025-06-20 02:34:34.31033
112	112	利用字典將月份 (1-12) 映射到季節，輸入月份後輸出對應季節；若非 1–12，輸出「未知章節」。	month_season = {1:'冬季', 2:'冬季', 3:'春季', 4:'春季', 5:'夏季', 6:'夏季', 7:'夏季', 8:'秋季', 9:'秋季',10:'秋季',11:'冬季',12:'冬季'}\nmonth = int(input("請輸入月份："))\n# TODO: 使用 dict.get(month, "未知章節") 並印出結果	month_season = {1:'冬季',2:'冬季',3:'春季',4:'春季',5:'夏季',6:'夏季',7:'夏季',8:'秋季',9:'秋季',10:'秋季',11:'冬季',12:'冬季'}\nmonth = int(input())\nprint(month_season.get(month, "未知章節"))	[]	10	2025-06-20 02:34:34.323261	2025-06-20 02:34:34.323265
113	113	隨機選擇1–12 月份，讓使用者猜季節，輸入後判斷並輸出「猜對了！」或「再試一次」。	import random\nmonth_season = {1:'冬季', 2:'冬季', 3:'春季', 4:'春季', 5:'夏季', 6:'夏季', 7:'夏季', 8:'秋季', 9:'秋季',10:'秋季',11:'冬季',12:'冬季'}\nmonth = random.randint(1,12)\nprint(f"提示月份: {month}")\nguess = input("請猜這個月份的季節：")\n# TODO: 比對 guess 與 month_season[month]	import random\nmonth_season = {1:'冬季', 2:'冬季', 3:'春季', 4:'春季', 5:'夏季', 6:'夏季', 7:'夏季', 8:'秋季', 9:'秋季',10:'秋季',11:'冬季',12:'冬季'}\nmonth = random.randint(1,12)\n# print(f"提示月份: {month}") # 實際測試時可隱藏\nguess = input()\nif guess == month_season.get(month):\n    print("猜對了！")\nelse:\n    print("再試一次")	[]	10	2025-06-20 02:34:34.33217	2025-06-20 02:34:34.332174
114	114	預設密碼為 "python123"，讓使用者最多嘗試三次，正確則輸出「城門開啟」，否則「三次失敗，請稍後再試」。	password = "python123"\nfor i in range(3):\n    entry = input(f"第{i+1}次嘗試，輸入密碼：")\n    # TODO: 如果 entry == password，印出成功訊息並 break\nelse:\n    # TODO: 如果三次皆失敗，印出失敗訊息	password = "python123"\nfor i in range(3):\n    entry = input()\n    if entry == password:\n        print("城門開啟")\n        break\nelse:\n    print("三次失敗，請稍後再試")	[]	10	2025-06-20 02:34:34.34121	2025-06-20 02:34:34.341214
115	115	輸入一個整數溫度 t，如果 t >= 30，印出「熱」；否則印出「不熱」。	t = int(input("請輸入溫度："))\n# TODO: 判斷是否熱	t = int(input())\nif t >= 30:\n    print("熱")\nelse:\n    print("不熱")	[]	10	2025-06-20 02:34:34.355599	2025-06-20 02:34:34.355603
116	116	輸入一個整數 n，如果 n > 0 印「正數」；如果 n == 0 印「零」；否則印「負數」。	n = int(input("請輸入整數："))\n# TODO: 使用 if/elif/else	n = int(input())\nif n > 0:\n    print("正數")\nelif n == 0:\n    print("零")\nelse:\n    print("負數")	[]	10	2025-06-20 02:34:34.364378	2025-06-20 02:34:34.364383
117	117	輸入成績 score（0–100），印出：≥90 →「優秀」, 60–89 →「良好」, <60 →「待加強」。	score = int(input("請輸入成績："))\n# TODO: 判斷分數等級	score = int(input())\nif score >= 90:\n    print("優秀")\nelif score >= 60:\n    print("良好")\nelse:\n    print("待加強")	[]	10	2025-06-20 02:34:34.373243	2025-06-20 02:34:34.373247
118	118	輸入答對題數 correct（0–5），如果 correct == 5 印「全對」；correct >= 3 印「過關」；否則印「不及格」。	correct = int(input("請輸入答對題數："))\n# TODO: 判斷答對情況	correct = int(input())\nif correct == 5:\n    print("全對")\nelif correct >= 3:\n    print("過關")\nelse:\n    print("不及格")	[]	10	2025-06-20 02:34:34.382188	2025-06-20 02:34:34.382192
119	119	輸入年齡 age，如果 < 13 印「兒童」；13–18 印「青少年」；> 18 印「成人」。	age = int(input("請輸入年齡："))\n# TODO: 判斷年齡分組	age = int(input())\nif age < 13:\n    print("兒童")\nelif age <= 18:\n    print("青少年")\nelse:\n    print("成人")	[]	10	2025-06-20 02:34:34.391029	2025-06-20 02:34:34.391033
120	120	輸入一個英文字母 ch，如果是母音 (a,e,i,o,u) 印「母音」；否則印「子音」。	ch = input("請輸入一個英文字母：").lower()\n# TODO: 判斷母音或子音	ch = input().lower()\nif ch in ['a','e','i','o','u']:\n    print("母音")\nelse:\n    print("子音")	[]	10	2025-06-20 02:34:34.39979	2025-06-20 02:34:34.399794
121	121	輸入購買數量 qty，如果 qty > 10 印「打 8 折」；5–10 印「打 9 折」；< 5 印「無折扣」。	qty = int(input("請輸入購買數量："))\n# TODO: 判斷折扣	qty = int(input())\nif qty > 10:\n    print("打 8 折")\nelif qty >= 5:\n    print("打 9 折")\nelse:\n    print("無折扣")	[]	10	2025-06-20 02:34:34.408606	2025-06-20 02:34:34.40861
122	122	輸入月份 m（1–12）：3–5 →「春季」, 6–8 →「夏季」, 9–11 →「秋季」, 其餘 →「冬季」。	m = int(input("請輸入月份："))\n# TODO: 判斷季節	m = int(input())\nif 3 <= m <= 5:\n    print("春季")\nelif 6 <= m <= 8:\n    print("夏季")\nelif 9 <= m <= 11:\n    print("秋季")\nelse:\n    print("冬季")	[]	10	2025-06-20 02:34:34.417298	2025-06-20 02:34:34.417302
123	123	輸入整數 x，如果 1–10 印「範圍內」；否則印「範圍外」。	x = int(input("請輸入整數："))\n# TODO: 判斷是否在範圍內	x = int(input())\nif 1 <= x <= 10:\n    print("範圍內")\nelse:\n    print("範圍外")	[]	10	2025-06-20 02:34:34.426152	2025-06-20 02:34:34.426156
124	124	預設密碼為 "abc123"，輸入嘗試密碼 p，如果相同印「登入成功」；否則印「密碼錯誤」。	password = "abc123"\np = input("請輸入密碼：")\n# TODO: 判斷密碼是否正確	password = "abc123"\np = input()\nif p == password:\n    print("登入成功")\nelse:\n    print("密碼錯誤")	[]	10	2025-06-20 02:34:34.434924	2025-06-20 02:34:34.434928
125	125	輸入 0–100 分成績，依規則輸出等級：≥90→A, 80–89→B, 70–79→C, 60–69→D, 其他→E。	score = int(input("請輸入成績："))\n# TODO: 使用 if/elif 判斷分數區間並印出對應等級	score = int(input())\nif score >= 90:\n    print("A")\nelif score >= 80:\n    print("B")\nelif score >= 70:\n    print("C")\nelif score >= 60:\n    print("D")\nelse:\n    print("E")	[]	15	2025-06-20 02:34:34.449066	2025-06-20 02:34:34.44907
126	126	輸入年份，判斷是否為閏年。閏年條件：能被 4 整除且不能被 100 整除，或能被 400 整除。	year = int(input("請輸入年份："))\n# TODO: 根據閏年條件判斷	year = int(input())\nif (year % 4 == 0 and year % 100 != 0) or (year % 400 == 0):\n    print("閏年")\nelse:\n    print("平年")	[]	15	2025-06-20 02:34:34.457989	2025-06-20 02:34:34.457993
127	127	輸入身高（公尺）與體重（公斤），計算 BMI = 體重 / (身高**2)，並依 BMI 分類：<18.5→過輕, 18.5–24→正常, 24–27→過重, ≥27→肥胖。	height = float(input("輸入身高 (m)："))\nweight = float(input("輸入體重 (kg)："))\nbmi = weight / (height ** 2)\n# TODO: 使用 if/elif 判斷 bmi 並印出分類	height = float(input())\nweight = float(input())\nbmi = weight / (height ** 2)\nif bmi < 18.5:\n    print("過輕")\nelif bmi < 24:\n    print("正常")\nelif bmi < 27:\n    print("過重")\nelse:\n    print("肥胖")	[]	15	2025-06-20 02:34:34.466728	2025-06-20 02:34:34.466732
128	128	輸入購買數量與單價，若數量>100 給 1 折；51–100 給 9 折；1–50 無折扣，輸出總價。	qty = int(input("輸入數量："))\nprice = float(input("輸入單價："))\n# TODO: 決定折扣率 discount，計算總價	qty = int(input())\nprice = float(input())\nif qty > 100:\n    discount = 0.1\nelif qty >= 51:\n    discount = 0.9\nelse:\n    discount = 1.0\nprint(qty * price * discount)	[]	15	2025-06-20 02:34:34.475493	2025-06-20 02:34:34.475497
129	129	輸入一正整數 n，若能被 3 整除印 "Fizz"，能被 5 整除印 "Buzz"，兩者皆能則 "FizzBuzz"，否則印數字。	n = int(input("輸入正整數："))\n# TODO: 檢查 n%3 和 n%5	n = int(input())\nresult = ""\nif n % 3 == 0:\n    result += "Fizz"\nif n % 5 == 0:\n    result += "Buzz"\nprint(result or n)	[]	15	2025-06-20 02:34:34.484344	2025-06-20 02:34:34.484348
130	130	輸入一段文字，判斷是否以大寫字母開頭且長度 > 5，印 True/False。	s = input("輸入文字：")\n# TODO: 判斷 s[0].isupper() 和 len(s) > 5	s = input()\nprint(s[0].isupper() and len(s) > 5)	[]	15	2025-06-20 02:34:34.49418	2025-06-20 02:34:34.494184
131	131	輸入年份與月份，輸出該月天數（1,3,5,7,8,10,12→31天；4,6,9,11→30天；2月依閏年28/29天）。	year = int(input("輸入年份："))\nmonth = int(input("輸入月份："))\n# TODO: if month in [...] 或 month == 2	year = int(input())\nmonth = int(input())\nif month in [1,3,5,7,8,10,12]:\n    print(31)\nelif month in [4,6,9,11]:\n    print(30)\nelse:\n    if (year%4==0 and year%100!=0) or (year%400==0):\n        print(29)\n    else:\n        print(28)	[]	15	2025-06-20 02:34:34.503045	2025-06-20 02:34:34.50305
132	132	輸入三個整數，判斷是否至少有一個是偶數，印 "Yes"/"No"。	a,b,c = map(int, input("輸入三個整數：").split())\n# TODO: 使用 or 檢查 a%2==0, b%2==0, c%2==0	a,b,c = map(int, input().split())\nif a%2==0 or b%2==0 or c%2==0:\n    print("Yes")\nelse:\n    print("No")	[]	15	2025-06-20 02:34:34.512177	2025-06-20 02:34:34.512182
133	133	輸入一個正整數，判斷是否為質數（只能被 1 和自己整除），印 True/False。	n = int(input("輸入正整數："))\n# TODO: 用 for 迴圈檢查 2 到 n-1 是否有因數	n = int(input())\nis_prime = True\nif n < 2:\n    is_prime = False\nelse:\n    for i in range(2, int(n**0.5) + 1):\n        if n % i == 0:\n            is_prime = False\n            break\nprint(is_prime)	[]	15	2025-06-20 02:34:34.521414	2025-06-20 02:34:34.521418
134	134	輸入密碼，判斷長度 ≥8 且包含英文字母和數字，符合則印 "強"，否則 "弱"。	pwd = input("輸入密碼：")\n# TODO: any(c.isdigit()) and any(c.isalpha()) and len>=8	pwd = input()\nif len(pwd) >= 8 and any(c.isdigit() for c in pwd) and any(c.isalpha() for c in pwd):\n    print("強")\nelse:\n    print("弱")	[]	15	2025-06-20 02:34:34.530404	2025-06-20 02:34:34.530409
135	135	輸入數學與英文成績，只有當兩科都 ≥ 60 才印「通過」，否則印「不通過」。	math_score = int(input("請輸入數學成績："))\neng_score  = int(input("請輸入英文成績："))\n# TODO: 若 math_score >= 60 and eng_score >= 60	math_score = int(input())\neng_score  = int(input())\nif math_score >= 60 and eng_score >= 60:\n    print("通過")\nelse:\n    print("不通過")	[]	10	2025-06-20 02:36:58.521688	2025-06-20 02:36:58.521692
136	136	輸入年齡與是否有身分證（輸入 Y/N），只有當年齡 ≥18 且有身分證時才印「允許購買」，否則印「拒絕購買」。	age    = int(input("請輸入年齡："))\nhas_id = input("是否有身分證 (Y/N)：").upper()\n# TODO: 若 age >= 18 and has_id == 'Y'	age    = int(input())\nhas_id = input().upper()\nif age >= 18 and has_id == 'Y':\n    print("允許購買")\nelse:\n    print("拒絕購買")	[]	10	2025-06-20 02:36:58.529641	2025-06-20 02:36:58.529643
137	137	輸入會員等級與是否首次購物（Y/N），若等級為 Gold 或 Platinum 且不是首次購物，印「折扣 20%」，否則印「無折扣」。	level      = input("請輸入會員等級：")\nfirst_time = input("是否首次購物 (Y/N)：").upper()\n# TODO: 若 (level == 'Gold' or level == 'Platinum') and first_time != 'Y'	level      = input()\nfirst_time = input().upper()\nif (level == 'Gold' or level == 'Platinum') and first_time != 'Y':\n    print("折扣 20%")\nelse:\n    print("無折扣")	[]	10	2025-06-20 02:36:58.537636	2025-06-20 02:36:58.53764
138	138	輸入水果重量（公斤），當重量 >5 印「大果」；2 < 重量 <=5 印「中果」；否則印「小果」。	w = float(input("請輸入水果重量 (kg)："))\n# TODO: if w > 5, else: if w > 2	w = float(input())\nif w > 5:\n    print("大果")\nelse:\n    if w > 2:\n        print("中果")\n    else:\n        print("小果")	[]	10	2025-06-20 02:36:58.546391	2025-06-20 02:36:58.546395
139	139	輸入是否有水（Y/N）及是否有食物（Y/N），若兩者皆無，印「危險」，否則印「安全」。	has_water = input("是否有水 (Y/N)：").upper()\nhas_food  = input("是否有食物 (Y/N)：").upper()\n# TODO: 若 not (has_water == 'Y' or has_food == 'Y')	has_water = input().upper()\nhas_food  = input().upper()\nif has_water != 'Y' and has_food != 'Y':\n    print("危險")\nelse:\n    print("安全")	[]	10	2025-06-20 02:36:58.555318	2025-06-20 02:36:58.555322
140	140	輸入密碼與一次性密碼（OTP），若密碼正確('pass123')且 OTP 正確('0000')，印「登入成功」，否則印「登入失敗」。	password = input("請輸入密碼：")\notp      = input("請輸入 OTP：")\n# TODO: if password == 'pass123' and otp == '0000'	password = input()\notp      = input()\nif password == 'pass123' and otp == '0000':\n    print("登入成功")\nelse:\n    print("登入失敗")	[]	10	2025-06-20 02:36:58.565037	2025-06-20 02:36:58.565042
141	141	輸入一個整數，若為偶數且大於 10，印「大偶數」，否則印「其他情況」。	n = int(input("請輸入整數："))\n# TODO: if n % 2 == 0 and n > 10	n = int(input())\nif n % 2 == 0 and n > 10:\n    print("大偶數")\nelse:\n    print("其他情況")	[]	10	2025-06-20 02:36:58.574471	2025-06-20 02:36:58.574475
142	142	輸入成績，若 ≥90 印「優等」；60 ≤ 成績 < 90 印「及格」；否則印「不及格」。	s = int(input("請輸入成績："))\n# TODO: if s >= 90, elif s >= 60, else	s = int(input())\nif s >= 90:\n    print("優等")\nelif s >= 60:\n    print("及格")\nelse:\n    print("不及格")	[]	10	2025-06-20 02:36:58.583672	2025-06-20 02:36:58.583676
143	143	輸入是否下雨（Y/N）及氣溫，若下雨或氣溫 < 10，印「攜帶雨具且保暖」，否則印「輕裝出行」。	is_raining = input("是否下雨 (Y/N)：").upper()\nt          = int(input("請輸入氣溫："))\n# TODO: if is_raining == 'Y' or t < 10	is_raining = input().upper()\nt          = int(input())\nif is_raining == 'Y' or t < 10:\n    print("攜帶雨具且保暖")\nelse:\n    print("輕裝出行")	[]	10	2025-06-20 02:36:58.592895	2025-06-20 02:36:58.592899
144	144	輸入年齡、是否有駕照（Y/N）及測驗分數，若年齡 ≥18 且有駕照且分數 ≥80，印「可執照練習」，否則印「條件不符」。	age         = int(input("請輸入年齡："))\nhas_license = input("是否有駕照 (Y/N)：").upper()\nscore       = int(input("請輸入測驗分數："))\n# TODO: if age >= 18 and has_license == 'Y' and score >= 80	age         = int(input())\nhas_license = input().upper()\nscore       = int(input())\nif age >= 18 and has_license == 'Y' and score >= 80:\n    print("可執照練習")\nelse:\n    print("條件不符")	[]	10	2025-06-20 02:36:58.602806	2025-06-20 02:36:58.60281
145	145	讀取使用者輸入的每日飲水量（毫升），若飲水量 < 1500，印出「喝水不足」，1500–3000 印「水量適中」，>3000 印「喝太多水」。	water_ml = int(input("請輸入今日飲水量 (毫升)："))\n# TODO: if/elif/else 判斷並印出相應提示	water_ml = int(input())\nif water_ml < 1500:\n    print("喝水不足")\nelif water_ml <= 3000:\n    print("水量適中")\nelse:\n    print("喝太多水")	[]	15	2025-06-20 02:36:58.617515	2025-06-20 02:36:58.617519
146	146	讀取購物車總金額，若金額 ≥ 1000，免運費；500–999 運費 50；<500 運費 100，最後印出「運費：X 元」。	total = float(input("請輸入購物金額："))\n# TODO: 判斷運費後印出	total = float(input())\nif total >= 1000:\n    fee = 0\nelif total >= 500:\n    fee = 50\nelse:\n    fee = 100\nprint(f"運費：{fee} 元")	[]	15	2025-06-20 02:36:58.626552	2025-06-20 02:36:58.626557
147	147	讀取飲料甜度級別（輸入 S、M、L），分別印出「甜度：少糖」、「甜度：中糖」或「甜度：全糖」。	level = input("請輸入甜度 (S/M/L)：").upper()\n# TODO: if level == 'S' ... elif level == 'M' ... else	level = input().upper()\nif level == 'S':\n    print("甜度：少糖")\nelif level == 'M':\n    print("甜度：中糖")\nelse:\n    print("甜度：全糖")	[]	15	2025-06-20 02:36:58.635593	2025-06-20 02:36:58.635597
148	148	讀取觀影者年齡：< 12 → 建議「兒童」；12–17 → 建議「輔導級」；≥18 → 建議「限制級」。	age = int(input("請輸入年齡："))\n# TODO: 使用 if/elif/else 印出建議分級	age = int(input())\nif age < 12:\n    print("建議觀看：兒童")\nelif age <= 17:\n    print("建議觀看：輔導級")\nelse:\n    print("建議觀看：限制級")	[]	15	2025-06-20 02:36:58.644742	2025-06-20 02:36:58.644746
149	149	讀取當前溫度：≤0→「穿厚大衣」, 1–15→「穿外套」, 16–25→「穿長袖」, >25→「穿短袖」。	temp = int(input("請輸入目前氣溫 (°C)："))\n# TODO: 多重條件判斷後印出建議	temp = int(input())\nif temp <= 0:\n    print("穿厚大衣")\nelif temp <= 15:\n    print("穿外套")\nelif temp <= 25:\n    print("穿長袖")\nelse:\n    print("穿短袖")	[]	15	2025-06-20 02:36:58.653754	2025-06-20 02:36:58.653758
150	150	讀取光線強度（0–100）：若 <20 且時間晚於 18（18–23），則印「開燈」，否則印「關燈」。	light = int(input("請輸入光線強度 (0-100)："))\nhour  = int(input("請輸入當前小時 (0-23)："))\n# TODO: if light < 20 and hour >=18	light = int(input())\nhour  = int(input())\nif light < 20 and hour >= 18:\n    print("開燈")\nelse:\n    print("關燈")	[]	15	2025-06-20 02:36:58.662733	2025-06-20 02:36:58.662737
151	151	讀取及格人數與總人數，計算及格率，若 ≥0.8，印「表現優異」；0.6–0.79 印「尚可」；<0.6 印「需加強」。	passed = int(input("輸入及格人數："))\ntotal  = int(input("輸入總人數："))\nrate = passed / total\n# TODO: if rate >= 0.8, elif rate >= 0.6, else	passed = int(input())\ntotal  = int(input())\nrate = passed / total\nif rate >= 0.8:\n    print("表現優異")\nelif rate >= 0.6:\n    print("尚可")\nelse:\n    print("需加強")	[]	15	2025-06-20 02:36:58.671665	2025-06-20 02:36:58.67167
152	152	讀取號誌顏色（Green/Yellow/Red）：Green→「可以通行」, Yellow→「請減速」, Red→「停車」。	signal = input("請輸入號誌顏色：").capitalize()\n# TODO: if/elif/else 判斷並印出對應文字	signal = input().capitalize()\nif signal == 'Green':\n    print("可以通行")\nelif signal == 'Yellow':\n    print("請減速")\nelse:\n    print("停車")	[]	15	2025-06-20 02:36:58.680534	2025-06-20 02:36:58.680538
153	153	讀取使用者留言情緒（Happy/Sad/Angry）：回應「太棒了！」、「抱抱」或「冷靜一下」。	mood = input("請輸入心情 (Happy/Sad/Angry)：").capitalize()\n# TODO: 依 mood 印出不同回應	mood = input().capitalize()\nif mood == 'Happy':\n    print("太棒了！")\nelif mood == 'Sad':\n    print("抱抱")\nelse:\n    print("冷靜一下")	[]	15	2025-06-20 02:36:58.689433	2025-06-20 02:36:58.689437
154	154	讀取提款金額：≤1000→手續費10元, 1001–5000→手續費20元, >5000→手續費30元。最後印出「手續費：X 元」。	amount = int(input("請輸入提款金額："))\n# TODO: if/elif/else 計算 fee 並印出	amount = int(input())\nif amount <= 1000:\n    fee = 10\nelif amount <= 5000:\n    fee = 20\nelse:\n    fee = 30\nprint(f"手續費：{fee} 元")	[]	15	2025-06-20 02:36:58.698384	2025-06-20 02:36:58.698388
155	155	輸入購物金額 amount 與會員等級 level（Gold/Silver/None）：Gold且≥500→回饋10%；Silver且≥300→回饋5%；其他→無回饋。	amount = float(input("請輸入購物金額："))\nlevel  = input("請輸入會員等級 (Gold/Silver/None)：")\n# TODO: 使用 and/elif 判斷回饋	amount = float(input())\nlevel  = input()\nrebate = 0.0\nif level == 'Gold' and amount >= 500:\n    rebate = amount * 0.1\nelif level == 'Silver' and amount >= 300:\n    rebate = amount * 0.05\nprint(f"回饋金：{rebate}")	[]	20	2025-06-20 02:36:58.71291	2025-06-20 02:36:58.712914
156	156	輸入三邊長 a,b,c，先檢查是否能構成三角形，若是，再分類為等邊、等腰或一般三角形，否則印「非三角形」。	a, b, c = map(float, input("輸入三邊長，以空格分隔：").split())\n# TODO: 巢狀 if：先檢查三角形成立條件，再進行分類	a, b, c = map(float, input().split())\nif (a + b > c) and (a + c > b) and (b + c > a):\n    if a == b == c:\n        print("等邊三角形")\n    elif a == b or b == c or a == c:\n        print("等腰三角形")\n    else:\n        print("一般三角形")\nelse:\n    print("非三角形")	[]	20	2025-06-20 02:36:58.722022	2025-06-20 02:36:58.722026
157	157	輸入密碼 pwd 與安全性分數 score：分數≥80且長度≥12→高安全；分數≥50且長度≥8→中等安全；否則→低安全。	pwd   = input("請輸入密碼：")\nscore = int(input("請輸入安全性分數 (0-100)："))\n# TODO: if/elif 巢狀邏輯判斷安全等級	pwd   = input()\nscore = int(input())\nif score >= 80 and len(pwd) >= 12:\n    print("高安全")\nelif score >= 50 and len(pwd) >= 8:\n    print("中等安全")\nelse:\n    print("低安全")	[]	20	2025-06-20 02:36:58.731086	2025-06-20 02:36:58.731091
158	158	輸入購物金額 amt 與是否為 VIP（Y/N）：VIP且≥1000→8折免運；金額≥500→9折運費50；否則→原價運費100。	amt = float(input("輸入金額："))\nis_vip = input("是否為 VIP (Y/N)：").upper()\n# TODO: 多層 if 判斷折扣與運費	amt = float(input())\nis_vip = input().upper()\nif is_vip == 'Y' and amt >= 1000:\n    final_amt = amt * 0.8\n    shipping_fee = 0\n    print(f"總金額：{final_amt}, 運費：{shipping_fee}")\nelif amt >= 500:\n    final_amt = amt * 0.9\n    shipping_fee = 50\n    print(f"總金額：{final_amt}, 運費：{shipping_fee}")\nelse:\n    final_amt = amt\n    shipping_fee = 100\n    print(f"總金額：{final_amt}, 運費：{shipping_fee}")	[]	20	2025-06-20 02:36:58.740152	2025-06-20 02:36:58.740156
159	159	輸入是否吸菸 smoke（Y/N）、運動次數 exercise（每週次數）：若吸菸或運動次數<2→印「請改善生活習慣」，其他→印「健康狀態良好」。	smoke = input("請問是否吸菸 (Y/N)：").upper()\nexercise = int(input("每週運動次數："))\n# TODO: 使用 or 和 < 判斷	smoke = input().upper()\nexercise = int(input())\nif smoke == 'Y' or exercise < 2:\n    print("請改善生活習慣")\nelse:\n    print("健康狀態良好")	[]	20	2025-06-20 02:36:58.749043	2025-06-20 02:36:58.749047
160	160	輸入年份與月份：若 month==2，判斷閏年印天數；若 month in [4,6,9,11]，印 30；其他印 31。	year  = int(input("輸入年份："))\nmonth = int(input("輸入月份："))\n# TODO: 巢狀 if 處理 2 月與閏年	year  = int(input())\nmonth = int(input())\nif month == 2:\n    if (year % 4 == 0 and year % 100 != 0) or (year % 400 == 0):\n        print(29)\n    else:\n        print(28)\nelif month in [4, 6, 9, 11]:\n    print(30)\nelse:\n    print(31)	[]	20	2025-06-20 02:36:58.759042	2025-06-20 02:36:58.759046
161	161	輸入嘗試次數 tries 與是否為管理員 is_admin（Y/N）：若 tries>5 且非管理員→「帳號鎖定」；若 tries>5 且是管理員→「請稍後再試」；否則→「可繼續嘗試」。	tries = int(input("輸入嘗試次數："))\nis_admin = input("是否為管理員 (Y/N)：").upper()\n# TODO: 巢狀 if 或 and/or 組合	tries = int(input())\nis_admin = input().upper()\nif tries > 5:\n    if is_admin == 'Y':\n        print("請稍後再試")\n    else:\n        print("帳號鎖定")\nelse:\n    print("可繼續嘗試")	[]	20	2025-06-20 02:36:58.767872	2025-06-20 02:36:58.767876
162	162	讀取用電度數 kwh，依照階梯計算電費：0–120度:2元/度; 121–330度:3元/度; 331–500度:4元/度; >500度:5元/度。印出總電費。	kwh = int(input("輸入用電度數："))\n# TODO: 使用巢狀 if/elif 累加每階梯費用	kwh = int(input())\ntotal = 0\nif kwh <= 120:\n    total = kwh * 2\nelif kwh <= 330:\n    total = 120*2 + (kwh-120)*3\nelif kwh <= 500:\n    total = 120*2 + 210*3 + (kwh-330)*4\nelse:\n    total = 120*2 + 210*3 + 170*4 + (kwh-500)*5\nprint(total)	[]	20	2025-06-20 02:36:58.775319	2025-06-20 02:36:58.775322
163	163	讀取停車時長 hours 與車種 (小客車/大貨車)：小客車:前2hr 30/hr,之後20/hr; 大貨車:前2hr 50/hr,之後30/hr。費用>500加收管理費100。	hours = float(input("輸入停車時長 (小時)："))\ncar_type = input("輸入車種 (小客車/大貨車)：")\n# TODO: 根據車種與時長計算費用，再判斷管理費	hours = float(input())\ncar_type = input()\nif car_type == "小客車":\n    if hours <= 2:\n        fee = hours * 30\n    else:\n        fee = 2*30 + (hours-2)*20\nelse:\n    if hours <= 2:\n        fee = hours * 50\n    else:\n        fee = 2*50 + (hours-2)*30\nif fee > 500:\n    fee += 100\nprint(int(fee))	[]	20	2025-06-20 02:36:58.782664	2025-06-20 02:36:58.782667
164	164	讀取消費金額與回饋類型(現金/點數/里程)：現金→1.2%; 點數→2%但需滿3000; 里程→1.5%。點數未滿額印提示，其餘印回饋金額。	amount = float(input("輸入消費金額："))\nrebate_type = input("輸入回饋類型 (現金/點數/里程)：")\n# TODO: 複合條件計算回饋，並處理點數滿額限制	amount = float(input())\nrebate_type = input()\nrebate = 0\nif rebate_type == '現金':\n    rebate = amount * 0.012\n    print(f"回饋 {rebate:.2f} 元")\nelif rebate_type == '點數':\n    if amount >= 3000:\n        rebate = amount * 0.02\n        print(f"回饋 {rebate:.2f} 元")\n    else:\n        print("不符合點數回饋資格")\nelif rebate_type == '里程':\n    rebate = amount * 0.015\n    print(f"回饋 {rebate:.2f} 元")	[]	20	2025-06-20 02:36:58.789917	2025-06-20 02:36:58.789922
\.


--
-- Data for Name: courses; Type: TABLE DATA; Schema: public; Owner: devuser
--

COPY public.courses (id, title, description, creator_id, created_at, updated_at) FROM stdin;
1	Python Basics	Learn the fundamentals of Python programming	1	2025-06-13 03:23:21.789646	2025-06-13 03:23:21.789652
2	Advanced Python	Take your Python skills to the next level	1	2025-06-13 03:23:21.789655	2025-06-13 03:23:21.789658
3	Python for Data Science	Learn to use Python for data analysis and visualization	2	2025-06-13 03:23:21.78966	2025-06-13 03:23:21.789663
4	SQL 入門	學習如何使用 SQL 管理和查詢資料庫。	1	2025-06-19 18:06:50.143817	2025-06-19 18:06:50.143822
5	迴圈 - for、while函數的使用	學習 Python 中的 for 和 while 迴圈，從基礎語法到高階應用，解決各種重複性問題。	1	2025-06-19 18:41:46.820138	2025-06-19 18:41:46.820142
7	Variable 變數練習	從「小奇與魔法筆電」的冒險開始，學習 Python 的變數宣告、命名規則、資料型別與進階應用。	1	2025-06-20 02:19:50.083118	2025-06-20 02:27:32.725999
8	Operator 運算子練習	學習 Python 中的算術、比較、邏輯運算子，並應用於實戰情境解決問題。	1	2025-06-20 02:26:25.165192	2025-06-20 02:27:47.900093
9	 資料結構 - Dictionary 字典練習	學習使用 Python 的字典（Dictionary）來儲存和管理鍵值對（key-value pair）資料。	1	2025-06-20 02:28:51.016913	2025-06-20 02:29:23.802069
10	Python 條件判斷入門	學習使用 if, elif, else 關鍵字來控制程式流程，解決生活中的各種判斷問題。	1	2025-06-20 02:34:34.213979	2025-06-20 02:34:34.213984
11	Python 進階條件判斷	深入運用邏輯運算子 (and, or, not) 與巢狀判斷，解決具有多重條件的複雜問題。	1	2025-06-20 02:36:58.485195	2025-06-20 02:36:58.4852
\.


--
-- Data for Name: enrollments; Type: TABLE DATA; Schema: public; Owner: devuser
--

COPY public.enrollments (id, student_id, course_id, enrolled_at) FROM stdin;
4	3	2	2025-06-13 03:23:21.838089
5	3	1	2025-06-13 04:32:18.856726
6	4	1	2025-06-13 04:32:18.856731
7	5	1	2025-06-13 04:32:18.856734
8	6	1	2025-06-13 04:32:18.856736
9	6	4	2025-06-19 18:13:37.0795
25	6	5	2025-06-20 01:14:06.946959
26	3	5	2025-06-20 01:14:06.946962
27	7	5	2025-06-20 01:14:06.946964
28	8	5	2025-06-20 01:14:06.946965
29	9	5	2025-06-20 01:14:06.946966
30	10	5	2025-06-20 01:14:06.946968
31	11	5	2025-06-20 01:14:06.946969
32	12	5	2025-06-20 01:14:06.94697
33	13	5	2025-06-20 01:14:06.946972
34	14	5	2025-06-20 01:14:06.946973
35	15	5	2025-06-20 01:14:06.946974
36	16	5	2025-06-20 01:14:06.946975
38	6	7	2025-06-20 02:23:47.250221
39	7	7	2025-06-20 02:23:47.250224
40	16	7	2025-06-20 02:23:47.250225
41	15	7	2025-06-20 02:23:47.250226
42	13	7	2025-06-20 02:23:47.250228
43	14	7	2025-06-20 02:23:47.250229
44	12	7	2025-06-20 02:23:47.25023
45	11	7	2025-06-20 02:23:47.250231
46	9	7	2025-06-20 02:23:47.250232
47	8	7	2025-06-20 02:23:47.250234
48	10	7	2025-06-20 02:23:47.250235
49	6	8	2025-06-20 02:26:54.715373
50	7	8	2025-06-20 02:26:54.715376
51	8	8	2025-06-20 02:26:54.715377
52	9	8	2025-06-20 02:26:54.715379
53	10	8	2025-06-20 02:26:54.71538
54	11	8	2025-06-20 02:26:54.715381
55	12	8	2025-06-20 02:26:54.715382
56	13	8	2025-06-20 02:26:54.715383
57	14	8	2025-06-20 02:26:54.715384
58	15	8	2025-06-20 02:26:54.715386
59	16	8	2025-06-20 02:26:54.715387
60	6	9	2025-06-20 02:29:48.972977
61	7	9	2025-06-20 02:29:48.97298
62	8	9	2025-06-20 02:29:48.972981
63	9	9	2025-06-20 02:29:48.972982
64	10	9	2025-06-20 02:29:48.972983
65	11	9	2025-06-20 02:29:48.972985
66	12	9	2025-06-20 02:29:48.972986
67	13	9	2025-06-20 02:29:48.972987
68	14	9	2025-06-20 02:29:48.972988
69	15	9	2025-06-20 02:29:48.972989
70	16	9	2025-06-20 02:29:48.972991
71	6	10	2025-06-20 02:35:41.516453
72	7	10	2025-06-20 02:35:41.516456
73	8	10	2025-06-20 02:35:41.516457
74	9	10	2025-06-20 02:35:41.516459
75	10	10	2025-06-20 02:35:41.51646
76	11	10	2025-06-20 02:35:41.516461
77	12	10	2025-06-20 02:35:41.516463
78	13	10	2025-06-20 02:35:41.516464
79	14	10	2025-06-20 02:35:41.516465
80	15	10	2025-06-20 02:35:41.516466
81	16	10	2025-06-20 02:35:41.516467
82	6	11	2025-06-20 02:37:45.307363
83	7	11	2025-06-20 02:37:45.307367
84	8	11	2025-06-20 02:37:45.307368
85	9	11	2025-06-20 02:37:45.30737
86	10	11	2025-06-20 02:37:45.307371
87	11	11	2025-06-20 02:37:45.307372
88	12	11	2025-06-20 02:37:45.307373
89	13	11	2025-06-20 02:37:45.307375
90	14	11	2025-06-20 02:37:45.307376
91	15	11	2025-06-20 02:37:45.307377
92	16	11	2025-06-20 02:37:45.307378
\.


--
-- Data for Name: fill_blank_exercises; Type: TABLE DATA; Schema: public; Owner: devuser
--

COPY public.fill_blank_exercises (id, lesson_id, text_template, blanks, points, created_at, updated_at) FROM stdin;
1	2	To check your Python version, you can use the command {{0}} in your terminal. Python files have the extension {{1}}.	[{"options": ["python --version", "python -v", "py --version", "python -version"], "correct_answer": "python --version"}, {"options": [".py", ".python", ".pyth", ".pyt"], "correct_answer": ".py"}]	20	2025-06-13 03:23:21.828597	2025-06-13 03:23:21.828601
\.


--
-- Data for Name: lessons; Type: TABLE DATA; Schema: public; Owner: devuser
--

COPY public.lessons (id, title, description, "order", unit_id, created_at, updated_at) FROM stdin;
1	What is Python?	Introduction to Python programming language	1	1	2025-06-13 03:23:21.807613	2025-06-13 03:23:21.807617
2	Setting Up Your Environment	Installing Python and tools	2	1	2025-06-13 03:23:21.80762	2025-06-13 03:23:21.807622
3	Your First Python Program	Writing and running a simple program	3	1	2025-06-13 03:23:21.807624	2025-06-13 03:23:21.807626
4	課節 1.1：SELECT 陳述式	學習 SELECT 的基本語法。	1	4	2025-06-19 18:06:50.160514	2025-06-19 18:06:50.160517
5	課節 1.2：使用 WHERE 過濾	如何過濾您的查詢結果。	2	4	2025-06-19 18:06:50.171052	2025-06-19 18:06:50.171056
6	課節 2.1：INNER JOIN	學習如何執行 INNER JOIN。	1	5	2025-06-19 18:06:50.184312	2025-06-19 18:06:50.184316
7	題目 1：早起的任務		1	6	2025-06-19 18:41:46.833386	2025-06-19 18:41:46.83339
8	題目 2：我的購物清單		2	6	2025-06-19 18:41:46.84308	2025-06-19 18:41:46.843084
9	題目 3：幫我數到五		3	6	2025-06-19 18:41:46.852345	2025-06-19 18:41:46.852349
10	題目 4：一層星星		4	6	2025-06-19 18:41:46.861527	2025-06-19 18:41:46.861531
11	題目 5：總和計算機		5	6	2025-06-19 18:41:46.870607	2025-06-19 18:41:46.870611
12	題目 6：我會倒數！		6	6	2025-06-19 18:41:46.879745	2025-06-19 18:41:46.879749
13	題目 7：奇數挑戰		1	7	2025-06-19 18:41:46.895262	2025-06-19 18:41:46.895267
14	題目 8：星星樓梯		2	7	2025-06-19 18:41:46.906254	2025-06-19 18:41:46.906258
15	題目 9：偶數總和		3	7	2025-06-19 18:41:46.915401	2025-06-19 18:41:46.915405
16	題目 10：星星正方形		4	7	2025-06-19 18:41:46.924565	2025-06-19 18:41:46.924569
17	題目 11：倒數星星塔		5	7	2025-06-19 18:41:46.934865	2025-06-19 18:41:46.93487
18	題目 12：重複任務打卡機		6	7	2025-06-19 18:41:46.944014	2025-06-19 18:41:46.944018
19	題目 13：九九乘法表（局部）		1	8	2025-06-19 18:41:46.958605	2025-06-19 18:41:46.958609
20	題目 14：梯形圖形		2	8	2025-06-19 18:41:46.967622	2025-06-19 18:41:46.967626
21	題目 15：階乘計算機		3	8	2025-06-19 18:41:46.976485	2025-06-19 18:41:46.976489
22	題目 16：座標表列印		4	8	2025-06-19 18:41:46.985384	2025-06-19 18:41:46.985388
23	題目 17：字串倒轉印出		5	8	2025-06-19 18:41:46.994337	2025-06-19 18:41:46.994341
24	題目 18：找最大值		6	8	2025-06-19 18:41:47.004787	2025-06-19 18:41:47.004792
25	題目 19：井字遊戲板		7	8	2025-06-19 18:41:47.011832	2025-06-19 18:41:47.011834
26	題目 20：步進文字顯示		8	8	2025-06-19 18:41:47.020509	2025-06-19 18:41:47.020513
27	題目 1：連續印出數字		1	9	2025-06-19 18:41:47.035088	2025-06-19 18:41:47.035092
28	題目 2：Hello 連發		2	9	2025-06-19 18:41:47.04401	2025-06-19 18:41:47.044014
29	題目 3：倒數計時		3	9	2025-06-19 18:41:47.052971	2025-06-19 18:41:47.052975
30	題目 4：累加求和		4	9	2025-06-19 18:41:47.061854	2025-06-19 18:41:47.061858
31	題目 5：找出偶數		5	9	2025-06-19 18:41:47.07081	2025-06-19 18:41:47.070814
32	題目 6：數星星		6	9	2025-06-19 18:41:47.079739	2025-06-19 18:41:47.079743
33	題目 7：列印奇數		1	10	2025-06-19 18:41:47.094745	2025-06-19 18:41:47.09475
34	題目 8：累加到超過 50		2	10	2025-06-19 18:41:47.10429	2025-06-19 18:41:47.104294
35	題目 9：指定範圍輸出		3	10	2025-06-19 18:41:47.113305	2025-06-19 18:41:47.113309
36	題目 10：跳步數數		4	10	2025-06-19 18:41:47.123004	2025-06-19 18:41:47.123008
37	題目 11：找最小倍數		5	10	2025-06-19 18:41:47.131822	2025-06-19 18:41:47.131826
38	題目 12：累計輸入直到輸入0		6	10	2025-06-19 18:41:47.140545	2025-06-19 18:41:47.140549
39	題目 13：數字倒著印		1	11	2025-06-19 18:41:47.154736	2025-06-19 18:41:47.15474
40	題目 14：輸出所有質數		2	11	2025-06-19 18:41:47.16351	2025-06-19 18:41:47.163514
41	題目 15：九九乘法表（橫式）		3	11	2025-06-19 18:41:47.172265	2025-06-19 18:41:47.172269
42	題目 16：找最大公因數		4	11	2025-06-19 18:41:47.181532	2025-06-19 18:41:47.181536
43	題目 17：神秘數字猜猜樂（最多5次）		5	11	2025-06-19 18:41:47.190978	2025-06-19 18:41:47.190982
44	題目 18：計算階乘		6	11	2025-06-19 18:41:47.199889	2025-06-19 18:41:47.199892
55	Q1. 名字魔法！		1	13	2025-06-20 02:19:50.110965	2025-06-20 02:19:50.110969
56	Q2. 年齡通關碼		2	13	2025-06-20 02:19:50.124642	2025-06-20 02:19:50.124646
57	Q3. 魔法卡片製作機		3	13	2025-06-20 02:19:50.13191	2025-06-20 02:19:50.131913
58	Q4. 魔力總分大測驗		4	13	2025-06-20 02:19:50.141008	2025-06-20 02:19:50.141014
59	Q5. 命名錯誤大警報！		5	13	2025-06-20 02:19:50.150503	2025-06-20 02:19:50.150508
60	Q6. 這是什麼型別？		6	13	2025-06-20 02:19:50.159874	2025-06-20 02:19:50.159878
61	Q7. 錯誤魔咒解除		7	13	2025-06-20 02:19:50.169168	2025-06-20 02:19:50.169172
62	Q8. 魔法角色建檔機		8	13	2025-06-20 02:19:50.178453	2025-06-20 02:19:50.178458
63	Q9. 魔法任務日誌		9	13	2025-06-20 02:19:50.187643	2025-06-20 02:19:50.187647
64	Q10. 這是哪個世界的變數？		10	13	2025-06-20 02:19:50.196944	2025-06-20 02:19:50.196949
65	Q11. 能力升級後的強化計算		1	14	2025-06-20 02:19:50.211802	2025-06-20 02:19:50.211807
66	Q12. 自動裝備整理		2	14	2025-06-20 02:19:50.221024	2025-06-20 02:19:50.221028
67	Q13. 技能說明函式		3	14	2025-06-20 02:19:50.230204	2025-06-20 02:19:50.230208
68	Q14. 交換角色與狀態		4	14	2025-06-20 02:19:50.239274	2025-06-20 02:19:50.239279
69	Q15. 經驗值進階計算		5	14	2025-06-20 02:19:50.248597	2025-06-20 02:19:50.248601
70	Q16. 多技能介紹函式		6	14	2025-06-20 02:19:50.258906	2025-06-20 02:19:50.258911
71	Q17. 檢查技能是否可用		7	14	2025-06-20 02:19:50.268179	2025-06-20 02:19:50.268183
72	Q18. 多日簽到獎勵細節		8	14	2025-06-20 02:19:50.277151	2025-06-20 02:19:50.277155
73	Q19. 冒險報告產生器		9	14	2025-06-20 02:19:50.286105	2025-06-20 02:19:50.286109
74	Q20. 型別判斷與轉換練習		10	14	2025-06-20 02:19:50.295057	2025-06-20 02:19:50.295061
75	Q21. 點餐計算機：誰付錢？		1	15	2025-06-20 02:26:25.193213	2025-06-20 02:26:25.193217
76	Q22. 價格比較器：哪個便宜？		2	15	2025-06-20 02:26:25.206574	2025-06-20 02:26:25.206578
77	Q23. 身高爭霸戰：真的比較高嗎？		3	15	2025-06-20 02:26:25.213617	2025-06-20 02:26:25.21362
78	Q24. 任務達成條件		4	15	2025-06-20 02:26:25.222488	2025-06-20 02:26:25.222492
79	Q25. 給分系統設計		5	15	2025-06-20 02:26:25.231751	2025-06-20 02:26:25.231755
80	Q26. 水量追蹤器		6	15	2025-06-20 02:26:25.241304	2025-06-20 02:26:25.241308
81	Q27. 自動找零計算機		7	15	2025-06-20 02:26:25.2505	2025-06-20 02:26:25.250504
82	Q28. 能量條更新公式		8	15	2025-06-20 02:26:25.259598	2025-06-20 02:26:25.259602
83	Q29. 出門條件挑戰		9	15	2025-06-20 02:26:25.268639	2025-06-20 02:26:25.268643
84	Q30. 綜合挑戰題：阿邏智慧判斷		10	15	2025-06-20 02:26:25.277605	2025-06-20 02:26:25.277609
85	Q31. 自動經驗升級機		1	16	2025-06-20 02:26:25.28994	2025-06-20 02:26:25.289943
86	Q32. 體力消耗計算器		2	16	2025-06-20 02:26:25.297116	2025-06-20 02:26:25.297119
87	Q33. 分數轉換系統		3	16	2025-06-20 02:26:25.305754	2025-06-20 02:26:25.305759
88	Q34. 三項比較挑戰		4	16	2025-06-20 02:26:25.31392	2025-06-20 02:26:25.313923
89	Q35. 魔法值可用判斷		5	16	2025-06-20 02:26:25.322094	2025-06-20 02:26:25.322098
90	Q36. 費用加總與找零		6	16	2025-06-20 02:26:25.329874	2025-06-20 02:26:25.329877
91	Q37. 等級成長表現		7	16	2025-06-20 02:26:25.336952	2025-06-20 02:26:25.336955
92	Q38. 裝備能力綜合輸出		8	16	2025-06-20 02:26:25.344017	2025-06-20 02:26:25.34402
93	Q39. 簡易條件模擬：是否可進入火山區		9	16	2025-06-20 02:26:25.351413	2025-06-20 02:26:25.351417
94	Q40. 複合邏輯挑戰		10	16	2025-06-20 02:26:25.360236	2025-06-20 02:26:25.360241
95	Q1. 魔法筆記本的第一筆記錄		1	17	2025-06-20 02:28:51.045188	2025-06-20 02:28:51.045192
96	Q2. 問問魔法筆記本：這是什麼？		2	17	2025-06-20 02:28:51.058407	2025-06-20 02:28:51.05841
97	Q3. 魔法筆記出錯了！快刪掉它！		3	17	2025-06-20 02:28:51.065495	2025-06-20 02:28:51.065498
98	Q4. 有沒有這個項目？		4	17	2025-06-20 02:28:51.074355	2025-06-20 02:28:51.074359
99	Q5. 龍的多重能力		5	17	2025-06-20 02:28:51.083695	2025-06-20 02:28:51.083698
100	Q6. 計算魔力平均		6	17	2025-06-20 02:28:51.09409	2025-06-20 02:28:51.094093
101	Q7. 魔杖配對任務		7	17	2025-06-20 02:28:51.101591	2025-06-20 02:28:51.101594
102	Q8. 字符出現次數		8	17	2025-06-20 02:28:51.109019	2025-06-20 02:28:51.109023
103	Q9. 找出最高魔力者		9	17	2025-06-20 02:28:51.116374	2025-06-20 02:28:51.116377
104	Q10. 找出指定顏色的魔法物品		10	17	2025-06-20 02:28:51.124596	2025-06-20 02:28:51.1246
105	1. 數字精靈的挑戰		1	18	2025-06-20 02:34:34.244774	2025-06-20 02:34:34.24478
106	2. 森林邏輯的錯誤魔咒		2	18	2025-06-20 02:34:34.258895	2025-06-20 02:34:34.258899
107	3. 勇者的及格考驗		3	18	2025-06-20 02:34:34.265896	2025-06-20 02:34:34.265899
108	4. 龍與山峰的高度比較		4	18	2025-06-20 02:34:34.276171	2025-06-20 02:34:34.276175
109	5. 三道魔法門的密碼		5	18	2025-06-20 02:34:34.285443	2025-06-20 02:34:34.285447
110	6. 水晶母音的守護		6	18	2025-06-20 02:34:34.294505	2025-06-20 02:34:34.294509
111	7. 成年騎士的資格		7	18	2025-06-20 02:34:34.303598	2025-06-20 02:34:34.303602
112	8. 四季之書的章節索引		8	18	2025-06-20 02:34:34.312482	2025-06-20 02:34:34.312486
113	9. 猜季節大冒險		9	18	2025-06-20 02:34:34.325395	2025-06-20 02:34:34.325399
114	10. 守護者的密碼試煉		10	18	2025-06-20 02:34:34.334315	2025-06-20 02:34:34.334319
115	1. 溫度判斷		1	19	2025-06-20 02:34:34.348747	2025-06-20 02:34:34.348751
116	2. 數字檢查		2	19	2025-06-20 02:34:34.357678	2025-06-20 02:34:34.357682
117	3. 分數等級		3	19	2025-06-20 02:34:34.366435	2025-06-20 02:34:34.366446
118	4. 多選題自動判分		4	19	2025-06-20 02:34:34.37532	2025-06-20 02:34:34.375325
119	5. 年齡分組		5	19	2025-06-20 02:34:34.384274	2025-06-20 02:34:34.384278
120	6. 字母辨識		6	19	2025-06-20 02:34:34.393095	2025-06-20 02:34:34.393099
121	7. 購物折扣		7	19	2025-06-20 02:34:34.401905	2025-06-20 02:34:34.40191
122	8. 季節判斷		8	19	2025-06-20 02:34:34.410726	2025-06-20 02:34:34.41073
123	9. 數字範圍檢查		9	19	2025-06-20 02:34:34.419372	2025-06-20 02:34:34.419376
124	10. 密碼檢驗		10	19	2025-06-20 02:34:34.428226	2025-06-20 02:34:34.42823
125	1. 魔法成績評鑑		1	20	2025-06-20 02:34:34.442397	2025-06-20 02:34:34.442402
126	2. 閏年密令		2	20	2025-06-20 02:34:34.451203	2025-06-20 02:34:34.451207
127	3. 健康之湯的 BMI 分析		3	20	2025-06-20 02:34:34.460055	2025-06-20 02:34:34.460059
128	4. 水果攤大折扣		4	20	2025-06-20 02:34:34.468783	2025-06-20 02:34:34.468787
129	5. FizzBuzz 試煉		5	20	2025-06-20 02:34:34.47758	2025-06-20 02:34:34.477584
130	6. 神秘字串的守護		6	20	2025-06-20 02:34:34.486408	2025-06-20 02:34:34.486412
131	7. 月之精靈的天數詛咒		7	20	2025-06-20 02:34:34.496275	2025-06-20 02:34:34.496279
132	8. 偶數偵查隊		8	20	2025-06-20 02:34:34.505196	2025-06-20 02:34:34.5052
133	9. 質數守衛的挑戰		9	20	2025-06-20 02:34:34.514407	2025-06-20 02:34:34.514412
134	10. 密碼強度之鑰		10	20	2025-06-20 02:34:34.523608	2025-06-20 02:34:34.523612
135	1. 同時通過考試		1	21	2025-06-20 02:36:58.511513	2025-06-20 02:36:58.511517
136	2. 購物安全檢查		2	21	2025-06-20 02:36:58.524027	2025-06-20 02:36:58.524031
137	3. 會員折扣		3	21	2025-06-20 02:36:58.530998	2025-06-20 02:36:58.531001
138	4. 水果重量分級		4	21	2025-06-20 02:36:58.539718	2025-06-20 02:36:58.539722
139	5. 登山裝備檢查		5	21	2025-06-20 02:36:58.548589	2025-06-20 02:36:58.548594
140	6. 雙重驗證流程		6	21	2025-06-20 02:36:58.557322	2025-06-20 02:36:58.557326
141	7. 數字奇偶與大小		7	21	2025-06-20 02:36:58.567501	2025-06-20 02:36:58.567505
142	8. 分數結果複合判斷		8	21	2025-06-20 02:36:58.576695	2025-06-20 02:36:58.5767
143	9. 安全出行建議		9	21	2025-06-20 02:36:58.585867	2025-06-20 02:36:58.585872
144	10. 複合資格檢查		10	21	2025-06-20 02:36:58.595246	2025-06-20 02:36:58.59525
145	1. 健康水量檢查		1	22	2025-06-20 02:36:58.610519	2025-06-20 02:36:58.610523
146	2. 購物金額免費運費		2	22	2025-06-20 02:36:58.619654	2025-06-20 02:36:58.619659
147	3. 點餐甜度調整		3	22	2025-06-20 02:36:58.628664	2025-06-20 02:36:58.628668
148	4. 電影分級建議		4	22	2025-06-20 02:36:58.637691	2025-06-20 02:36:58.637696
149	5. 季節穿搭建議		5	22	2025-06-20 02:36:58.646842	2025-06-20 02:36:58.646846
150	6. 路燈開關控制		6	22	2025-06-20 02:36:58.655851	2025-06-20 02:36:58.655855
151	7. 班級及格率判斷		7	22	2025-06-20 02:36:58.664816	2025-06-20 02:36:58.664821
152	8. 交通號誌模擬		8	22	2025-06-20 02:36:58.673746	2025-06-20 02:36:58.67375
153	9. 社群互動回應		9	22	2025-06-20 02:36:58.68262	2025-06-20 02:36:58.682624
154	10. 銀行提款手續費		10	22	2025-06-20 02:36:58.691531	2025-06-20 02:36:58.691535
155	1. 會員購物金回饋		1	23	2025-06-20 02:36:58.706024	2025-06-20 02:36:58.706028
156	2. 複合三角形分類		2	23	2025-06-20 02:36:58.715067	2025-06-20 02:36:58.715072
157	3. 複合帳號安全檢查		3	23	2025-06-20 02:36:58.724155	2025-06-20 02:36:58.724159
158	4. 購物折扣與運費結合		4	23	2025-06-20 02:36:58.733195	2025-06-20 02:36:58.733199
159	5. 健康建議		5	23	2025-06-20 02:36:58.742285	2025-06-20 02:36:58.74229
160	6. 複合日期判斷		6	23	2025-06-20 02:36:58.751141	2025-06-20 02:36:58.751146
161	7. 登入錯誤鎖定		7	23	2025-06-20 02:36:58.7612	2025-06-20 02:36:58.761204
162	8. 電費計算		8	23	2025-06-20 02:36:58.769466	2025-06-20 02:36:58.769469
163	9. 停車費率		9	23	2025-06-20 02:36:58.776874	2025-06-20 02:36:58.776878
164	10. 信用卡回饋分類		10	23	2025-06-20 02:36:58.784169	2025-06-20 02:36:58.784172
\.


--
-- Data for Name: multiple_choice_questions; Type: TABLE DATA; Schema: public; Owner: devuser
--

COPY public.multiple_choice_questions (id, lesson_id, question_text, options, correct_option_index, explanation, points, created_at, updated_at) FROM stdin;
5	1	Which of the following is NOT a characteristic of Python?	["Interpreted language", "Statically typed", "Object-oriented", "Cross-platform"]	1	\N	10	2025-06-13 04:31:58.960058	2025-06-13 04:31:58.960064
8	4	哪個關鍵字用於從資料庫中檢索資料？	["GET", "SELECT", "FETCH", "RETRIEVE"]	1	SELECT 是用於查詢資料的標準 SQL 關鍵字。	10	2025-06-19 18:41:46.794579	2025-06-19 18:41:46.794584
\.


--
-- Data for Name: progress; Type: TABLE DATA; Schema: public; Owner: devuser
--

COPY public.progress (id, student_id, lesson_id, coding_score, multiple_choice_score, fill_blank_score, completed, attempts, last_attempt_at, created_at, updated_at, coding_results, multiple_choice_results, fill_blank_results) FROM stdin;
1	6	3	100	0	0	f	2	2025-06-19 17:42:58.093021	2025-06-14 10:34:47.3784	2025-06-19 17:42:58.098805	\N	\N	\N
3	6	8	100	0	0	t	2	2025-06-20 01:38:57.467495	2025-06-19 19:54:17.722286	2025-06-20 01:38:57.467942	\N	\N	\N
2	6	7	100	0	0	t	14	2025-06-20 01:47:01.428277	2025-06-19 18:45:10.803621	2025-06-20 01:47:01.428691	\N	\N	\N
4	7	7	100	0	0	t	1	2025-06-20 01:47:08.616624	2025-06-20 01:47:08.618113	2025-06-20 01:47:08.618118	\N	\N	\N
5	12	7	100	0	0	t	1	2025-06-20 01:47:31.873352	2025-06-20 01:47:31.87406	2025-06-20 01:47:31.874065	\N	\N	\N
6	10	7	100	0	0	t	1	2025-06-20 01:48:02.3042	2025-06-20 01:48:02.304791	2025-06-20 01:48:02.304796	\N	\N	\N
8	7	8	100	0	0	t	1	2025-06-20 01:52:33.761164	2025-06-20 01:52:33.761766	2025-06-20 01:52:33.761771	\N	\N	\N
7	7	9	100	0	0	t	2	2025-06-20 01:58:21.667689	2025-06-20 01:52:16.117812	2025-06-20 01:58:21.668087	\N	\N	\N
9	7	10	100	0	0	t	2	2025-06-20 02:02:40.971302	2025-06-20 02:02:32.809646	2025-06-20 02:02:40.971844	\N	\N	\N
10	7	11	100	0	0	t	1	2025-06-20 02:18:29.469858	2025-06-20 02:18:29.470465	2025-06-20 02:18:29.47047	\N	\N	\N
11	9	14	100	0	0	t	1	2025-06-20 02:20:58.731165	2025-06-20 02:20:58.731863	2025-06-20 02:20:58.731868	\N	\N	\N
12	7	14	100	0	0	t	1	2025-06-20 02:21:03.851778	2025-06-20 02:21:03.852491	2025-06-20 02:21:03.852498	\N	\N	\N
13	7	16	100	0	0	t	1	2025-06-20 02:24:09.047023	2025-06-20 02:24:09.047453	2025-06-20 02:24:09.047457	\N	\N	\N
14	16	19	100	0	0	t	1	2025-06-20 03:47:35.085415	2025-06-20 03:47:35.086843	2025-06-20 03:47:35.086847	\N	\N	\N
15	7	20	100	0	0	t	1	2025-06-20 03:49:23.407969	2025-06-20 03:49:23.408521	2025-06-20 03:49:23.408526	\N	\N	\N
16	7	21	100	0	0	t	1	2025-06-20 03:55:09.104475	2025-06-20 03:55:09.105053	2025-06-20 03:55:09.105059	\N	\N	\N
17	7	24	100	0	0	t	1	2025-06-20 04:08:14.700493	2025-06-20 04:08:14.701025	2025-06-20 04:08:14.70103	\N	\N	\N
18	7	27	100	0	0	t	1	2025-06-20 05:18:45.285825	2025-06-20 05:18:45.287218	2025-06-20 05:18:45.287222	\N	\N	\N
19	7	28	100	0	0	t	1	2025-06-20 05:22:31.941495	2025-06-20 05:22:31.942874	2025-06-20 05:22:31.942879	\N	\N	\N
20	7	29	100	0	0	t	1	2025-06-20 05:24:06.17835	2025-06-20 05:24:06.179292	2025-06-20 05:24:06.179295	\N	\N	\N
21	7	33	100	0	0	t	1	2025-06-20 07:00:32.620439	2025-06-20 07:00:32.621514	2025-06-20 07:00:32.621517	\N	\N	\N
23	10	34	100	0	0	t	1	2025-06-20 07:04:20.528981	2025-06-20 07:04:20.529304	2025-06-20 07:04:20.529307	\N	\N	\N
22	7	34	100	0	0	t	2	2025-06-20 07:04:27.16975	2025-06-20 07:03:14.594291	2025-06-20 07:04:27.170896	\N	\N	\N
24	10	35	100	0	0	t	1	2025-06-20 07:06:11.323203	2025-06-20 07:06:11.324359	2025-06-20 07:06:11.324362	\N	\N	\N
25	10	37	100	0	0	t	1	2025-06-20 07:08:48.0315	2025-06-20 07:08:48.031891	2025-06-20 07:08:48.031895	\N	\N	\N
26	7	37	100	0	0	t	1	2025-06-20 07:10:53.505533	2025-06-20 07:10:53.506557	2025-06-20 07:10:53.50656	\N	\N	\N
\.


--
-- Data for Name: submission_history; Type: TABLE DATA; Schema: public; Owner: devuser
--

COPY public.submission_history (id, student_id, lesson_id, submission_type, content, score, feedback, submitted_at) FROM stdin;
1	6	3	coding	# Write your code here\n\nprint("Hello World!")	100	通过 3/3 个测试用例	2025-06-14 10:34:47.371595
2	6	3	coding	# Write your code here\nprint("Hello, World!")	100	通过 3/3 个测试用例	2025-06-19 17:42:58.088864
3	6	7	coding	# 使用 for 迴圈完成任務\nfor i in range(3):\n  print("我起床了！")\n    # 在這裡印出「我起床了！」	66	通过 2/3 个测试用例	2025-06-19 18:45:10.801046
4	6	7	coding	# 使用 for 迴圈完成任務\nfor i in range(3):\n  print("我起床了！")\n    # 在這裡印出「我起床了！」	66	通过 2/3 个测试用例	2025-06-19 18:49:05.342331
5	6	7	coding	# 使用 for 迴圈完成任務\nfor i in range(3):\n  print("我起床了！")\n    # 在這裡印出「我起床了！」	66	通过 2/3 个测试用例	2025-06-19 18:52:43.908757
6	6	7	coding	# 使用 for 迴圈完成任務\nfor i in range(3):\n  print("我起床了！")\n    # 在這裡印出「我起床了！」	66	通过 2/3 个测试用例	2025-06-19 18:56:45.51392
7	6	7	coding	# 使用 for 迴圈完成任務\nfor i in range(3):\n  print("我起床了！")\n    # 在這裡印出「我起床了！」	66	通过 2/3 个测试用例	2025-06-19 19:03:23.486045
8	6	7	coding	# 使用 for 迴圈完成任務\nfor i in range(3):\n  print("我起床了！")\n    # 在這裡印出「我起床了！」	100	通过 2/2 个测试用例	2025-06-19 19:03:45.566316
9	6	7	coding	# 使用 for 迴圈完成任務\nfor i in range(3):\n    # 在這裡印出「我起床了！」\n  print("grg")	100	通过 2/2 个测试用例	2025-06-19 19:48:57.728335
10	6	8	coding	foods = ["蘋果", "香蕉", "蛋糕"]\n# 使用 for 迴圈印出所有食物\nfor i in foods:\n  print(i)	100	通过 2/2 个测试用例	2025-06-19 19:54:17.713425
11	6	7	coding	# 使用 for 迴圈完成任務\nfor i in range(3):\n    # 在這裡印出「我起床了！」\n  print("我起床了！")	100	通过 2/2 个测试用例	2025-06-19 20:06:07.799663
12	6	7	coding	# 使用 for 迴圈完成任務\nfor i in range(3):\n    # 在這裡印出「我起床了！」\n  print("hfiewu")	100	通过 2/2 个测试用例	2025-06-20 01:04:02.877235
13	6	7	coding	# 使用 for 迴圈完成任務\nfor i in range(3):\n    # 在這裡印出「我起床了！」\n  print("我起床了！")	100	通过 2/2 个测试用例	2025-06-20 01:30:37.087312
14	6	7	coding	# 使用 for 迴圈完成任務\nfor i in range(3):\n    # 在這裡印出「我起床了！」\n  print("我起床了！")	100	通过 2/2 个测试用例	2025-06-20 01:33:51.437466
15	6	7	coding	# 使用 for 迴圈完成任務\nfor i in range(3):\n    # 在這裡印出「我起床了！」\n  print("我起床了！")	100	通过 2/2 个测试用例	2025-06-20 01:38:47.110511
16	6	8	coding	foods = ["蘋果", "香蕉", "蛋糕"]\n# 使用 for 迴圈印出所有食物\nfor i in foods:\n  print(i)	100	通过 2/2 个测试用例	2025-06-20 01:38:57.465432
17	6	7	coding	# 使用 for 迴圈完成任務\nfor i in range(3):\n    # 在這裡印出「我起床了！」\n  print("hfiewu")	100	通过 2/2 个测试用例	2025-06-20 01:45:35.184673
18	6	7	coding	# 使用 for 迴圈完成任務\nfor i in range(3):\n    # 在這裡印出「我起床了！」\n  print("我起床了！")	100	通过 2/2 个测试用例	2025-06-20 01:47:01.426409
19	7	7	coding	# 使用 for 迴圈完成任務\nfor i in range(3):\n    # 在這裡印出「我起床了！」\n  print("我起床了!")	100	通过 2/2 个测试用例	2025-06-20 01:47:08.614685
20	12	7	coding	# 使用 for 迴圈完成任務\nfor i in range(3):\n    # 在這裡印出「我起床了！」\n  print("我起床了！")	100	通过 2/2 个测试用例	2025-06-20 01:47:31.871522
21	10	7	coding	# 使用 for 迴圈完成任務\nfor i in range(3):\n  print("我起床了！")\n    # 在這裡印出「我起床了！」	100	通过 2/2 个测试用例	2025-06-20 01:48:02.302336
22	7	9	coding	# 使用 for 迴圈和 range 印出 1 到 5\nfor i in range(1,6):\n  print(i)	100	通过 2/2 个测试用例	2025-06-20 01:52:16.115286
23	7	8	coding	foods = ["蘋果", "香蕉", "蛋糕"]\n# 使用 for 迴圈印出所有食物\nfoods = ["蘋果", "香蕉", "蛋糕"]\nfor food in foods:\n  print(food)	100	通过 2/2 个测试用例	2025-06-20 01:52:33.759202
24	7	9	coding	# 使用 for 迴圈和 range 印出 1 到 5\nfor i in range(1,6):\n  print(i)	100	通过 2/2 个测试用例	2025-06-20 01:58:21.665955
25	7	10	coding	# 使用 for 迴圈和 end="" 印出星星\nfor i in range(6):\n  print("*",end="")	100	通过 2/2 个测试用例	2025-06-20 02:02:32.807582
26	7	10	coding	# 使用 for 迴圈和 end="" 印出星星\nfor i in range(6):\n  print("*",end=" ")	100	通过 2/2 个测试用例	2025-06-20 02:02:40.969428
27	7	11	coding	total = 0\n# 使用 for 迴圈計算總和\nfor i in range(1,6):\n  total=total+i\nprint (total)	100	通过 2/2 个测试用例	2025-06-20 02:18:29.4682
28	9	14	coding	# 使用 for 迴圈和字串乘法印出星星塔\nfor i in range(1,6):\n  print("*"*i)	100	通过 2/2 个测试用例	2025-06-20 02:20:58.729354
29	7	14	coding	# 使用 for 迴圈和字串乘法印出星星塔\nfor i in range(6):\n  print("*"*i)	100	通过 2/2 个测试用例	2025-06-20 02:21:03.850029
30	7	16	coding	# 使用巢狀 for 迴圈印出正方形\nfor i in range(4):\n  for j in range(4):\n    print("*", end=" ")\n  print()	100	通过 2/2 个测试用例	2025-06-20 02:24:09.045251
31	16	19	coding	# 使用巢狀 for 迴圈印出乘法表\nfor i in range(1,10):\n  for j in range(1,10):\n    print(f"{i}*{j}={i*j}",end = "\\t")\n  print()	100	通过 2/2 个测试用例	2025-06-20 03:47:35.083413
32	7	20	coding	# 使用 for 迴圈印出梯形\nfor i in range(1,5):\n  print("*" * (i*2))	100	通过 2/2 个测试用例	2025-06-20 03:49:23.40624
33	7	21	coding	n = 5\nresult = 1\n# 使用 for 迴圈計算 n 的階乘\nfor i in range(1,n+1):\n  result=result*i\nprint(result)	100	通过 2/2 个测试用例	2025-06-20 03:55:09.102586
34	7	24	coding	nums = [12,28,90,49,20]\nmax=nums[0]\n\nfor num in nums:\n  if num > max:\n    max= num\nprint("最大值是:", max)	100	通过 2/2 个测试用例	2025-06-20 04:08:14.698756
35	7	27	coding	i = 1\n# 使用 while 迴圈印出 1 到 5\nwhile i <= 5:\n  print(i)\n  i = i+1	100	通过 2/2 个测试用例	2025-06-20 05:18:45.283467
36	7	28	coding	count = 1\n# 使用 while 迴圈印出三次 Hello!\nwhile count <= 3:\n  print("Hello!")\n  count = count+1	100	通过 2/2 个测试用例	2025-06-20 05:22:31.937128
37	7	29	coding	i = 5\n# 使用 while 迴圈倒數\nwhile i >= 1:\n  print(i)\n  i = i-1	100	通过 2/2 个测试用例	2025-06-20 05:24:06.17331
38	7	33	coding	i = 1\n# 使用 while 迴圈找出奇數\nwhile(i<=10):\n  if(i%2==1):\n    print(i)\n  i += 1	100	通过 2/2 个测试用例	2025-06-20 07:00:32.6147
39	7	34	coding	total = 0\ni = 1\n# 使用 while 迴圈累加直到超過 50\nwhile(total<=50):\n  total += i\n  i += 1\nprint(total)	100	通过 2/2 个测试用例	2025-06-20 07:03:14.587959
40	10	34	coding	total = 0\ni = 1\n# 使用 while 迴圈累加直到超過 50\nwhile total<=50:\n  total=total+i\n  print(total)\n  i+=1	100	通过 2/2 个测试用例	2025-06-20 07:04:20.52766
41	7	34	coding	total = 0\ni = 1\n# 使用 while 迴圈累加直到超過 50\nwhile(total<=50):\n  total += i\n  i += 1\nprint(total)	100	通过 2/2 个测试用例	2025-06-20 07:04:27.16821
42	10	35	coding	i = 7\n# 使用 while 迴圈印出 7 到 12\nwhile i<=12:\n  print(i)\n  i+=1	100	通过 2/2 个测试用例	2025-06-20 07:06:11.320615
43	10	37	coding	i = 1\n# 使用 while 迴圈和 break 找出最小公倍數\nwhile i<=100:\n  if i%4==0 and i%6==0:\n    break\n  i+=1\nprint(i)	100	通过 2/2 个测试用例	2025-06-20 07:08:48.029539
44	7	37	coding	num = 1\n# 使用 while 迴圈和 break 找出最小公倍數\nwhile (num<=100):\n  if(num % 4 == 0) and (num % 6 == 0):\n    print(num)\n    break\n  num += 1	100	通过 2/2 个测试用例	2025-06-20 07:10:53.500793
\.


--
-- Data for Name: units; Type: TABLE DATA; Schema: public; Owner: devuser
--

COPY public.units (id, title, description, "order", course_id, created_at, updated_at) FROM stdin;
1	Introduction to Python	Get started with Python	1	1	2025-06-13 03:23:21.799238	2025-06-13 03:23:21.799242
2	Variables and Data Types	Learn about Python's data types	2	1	2025-06-13 03:23:21.799245	2025-06-13 03:23:21.799246
3	Control Flow	Conditionals and loops	3	1	2025-06-13 03:23:21.799249	2025-06-13 03:23:21.799251
4	單元一：基本查詢	開始學習 SELECT 陳述式。	1	4	2025-06-19 18:06:50.152439	2025-06-19 18:06:50.152443
5	單元二：連接資料表	組合來自多個資料表的資料。	2	4	2025-06-19 18:06:50.179449	2025-06-19 18:06:50.179453
6	單元一：初級for練習	利用 for 迴圈處理重複性任務與簡單的數列運算。	1	5	2025-06-19 18:41:46.826851	2025-06-19 18:41:46.826855
7	單元二：中階for練習	使用range()的其他函數	2	5	2025-06-19 18:41:46.888862	2025-06-19 18:41:46.888867
8	單元三：for迴圈的高階練習	針對日常生活問題設計 for 迴圈解決方案。	3	5	2025-06-19 18:41:46.95301	2025-06-19 18:41:46.953014
9	單元四：初階while練習	設定 while 迴圈的條件與變數更新方式	4	5	2025-06-19 18:41:47.029473	2025-06-19 18:41:47.029477
10	單元五：中階while練習	迴圈最適合處理那些「不知道會重複幾次」的問題，例如：反覆猜數字、持續等待某個條件發生。	5	5	2025-06-19 18:41:47.088582	2025-06-19 18:41:47.088586
11	單元六：while迴圈的高階練習	根據不同情境靈活選擇合適的迴圈類型解決問題	6	5	2025-06-19 18:41:47.149208	2025-06-19 18:41:47.149212
13	單元一：變數大冒險 (Q1-Q10)	涵蓋變數建立、字串拼接、型別轉換與區域變數等核心概念。	1	7	2025-06-20 02:19:50.101618	2025-06-20 02:19:50.101623
14	單元二：變數進階加強版 (Q11-Q20)	涵蓋變數的複合賦值、函式設計、變數交換、與型別轉換等進階技巧。	2	7	2025-06-20 02:19:50.206071	2025-06-20 02:19:50.206076
15	單元一：運算子的魔法挑戰 (Q21-Q30)	包含加減乘除、大小比較 (>, <, >=) 與邏輯判斷 (and, or)。	1	8	2025-06-20 02:26:25.184007	2025-06-20 02:26:25.184013
16	單元二：運算子的實戰魔法 (Q31-Q40)	綜合應用算術、比較、邏輯運算子解決多步驟問題。	2	8	2025-06-20 02:26:25.285109	2025-06-20 02:26:25.285112
17	單元一：魔法筆記本 (Q1-Q10)	涵蓋字典的增刪改查、遍歷、以及結合迴圈與函式的進階應用。	1	9	2025-06-20 02:28:51.035798	2025-06-20 02:28:51.035804
18	單元一：條件判斷的基本概念	學習 if 的基礎語法，包含正負數判斷、奇偶數檢查與及格考驗。	1	10	2025-06-20 02:34:34.232956	2025-06-20 02:34:34.232961
19	單元二：else 和 elif 的應用	學習使用 else 處理條件不成立時的情況，以及使用 elif 處理多重條件判斷。	2	10	2025-06-20 02:34:34.34327	2025-06-20 02:34:34.343275
20	單元三：中等難度練習	將條件判斷應用於更複雜的情境，例如閏年判斷、BMI 計算和 FizzBuzz 挑戰。	3	10	2025-06-20 02:34:34.43694	2025-06-20 02:34:34.436945
21	單元一：邏輯運算與複雜條件	學習使用 and, or, not 結合多個條件，並練習巢狀 if 結構。	1	11	2025-06-20 02:36:58.50273	2025-06-20 02:36:58.502734
22	單元二：綜合應用練習	將條件判斷應用於更貼近真實生活的場景，如費用計算、分級建議與狀態模擬。	2	11	2025-06-20 02:36:58.604893	2025-06-20 02:36:58.604897
23	單元三：進階邏輯與綜合應用	挑戰更複雜的巢狀判斷與多重邏輯組合，解決如會員制度、費用計算等真實世界問題。	3	11	2025-06-20 02:36:58.700414	2025-06-20 02:36:58.700419
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: devuser
--

COPY public.users (id, username, email, password_hash, role, created_at) FROM stdin;
1	teacher1	teacher1@example.com	pbkdf2:sha256:260000$WjnT00wVnSemnIox$3abd87b341157d2d3897054485e93b34c45be6a74bdbe2905ef21ad9306928a6	teacher	2025-06-13 03:23:21.771921
2	teacher2	teacher2@example.com	pbkdf2:sha256:260000$djOTX3TWPcjGrMpB$b4a8f573ae4edb04a31cab9c9a955143c4d2ee3c826e6241900ccc4bf43cd58a	teacher	2025-06-13 03:23:21.771925
3	student1	student1@example.com	pbkdf2:sha256:260000$UuHyjhh3opnCkSz8$7425734ead0c362e0e4d1bb2d94c6097d74a2cea66a5eacbc03bc0656c1da45b	student	2025-06-13 03:23:21.771927
4	student2	student2@example.com	pbkdf2:sha256:260000$eITPa6JTM5jfp35f$c388f711ef82a46ba8500cf2e66e447c7c0067f04b4ca9b8b611d2076d1b443c	student	2025-06-13 03:23:21.771928
5	student3	student3@example.com	pbkdf2:sha256:260000$GQ5DmjL1R1ZcGU7j$bf86741414f649d5c1374a78fe0961852aa4a7f8587390a8e9379ae7f788109e	student	2025-06-13 03:23:21.771929
6	1111		pbkdf2:sha256:260000$DYbb3HkTPbRu9ciR$5eb770ca86a00a7cea0bcce0a2f6bd0d7f38fb09290c99073c6acec7b04b787b	student	2025-06-13 04:27:03.667273
7	baidateach10		pbkdf2:sha256:260000$gF3SdUsjEUUJFHZW$0001057fbdf7c1bc90d270dbd34a3aabb9747f5946c944b84293b60eed112920	student	2025-06-20 00:52:26.328455
8	baidateach11		pbkdf2:sha256:260000$oBCh15OBzOhkXUV5$633489423cd92df54c6e497cdde2f197e75fbbee5c5c8575dfddbcf5159750c3	student	2025-06-20 00:52:55.621276
9	baidateach12		pbkdf2:sha256:260000$EkXHnaNo3Gw12w1F$9352f87668b2b1e19bc85204d70f72109cfd51512425cdd95713c6774d84d9ba	student	2025-06-20 00:53:09.632684
10	baidateach13		pbkdf2:sha256:260000$zRXaVWJTh8tohIbl$2175518016b351bc25abafe8edaf16f37c7807cf6a2d693ecedb02eb28db1018	student	2025-06-20 00:53:38.307459
11	baidateach14		pbkdf2:sha256:260000$t7FsUWu8ZAWeRFkP$b8382d97ad1216fbe8f759039f0aa92d2321ebdc21295675590c0a53bdd26f71	student	2025-06-20 00:53:55.289747
12	baidateach15		pbkdf2:sha256:260000$smj5BGKkrvsptqa5$08b9b10ef0a26bd22ddb0a4a69c5cc23d1b44956ae083bdadfcf97c40e6782b9	student	2025-06-20 00:54:16.346807
13	baidateach16		pbkdf2:sha256:260000$wf3wF3knztSSQznk$ba09732f5298cf846bafd07fc2d898ef0f5b06be818631851ef8fe0107dbf398	student	2025-06-20 00:54:36.538123
14	baidateach17		pbkdf2:sha256:260000$xNArFvztTmse45yz$228603ef5e9acbb45468f545f5111a93f9d05a509f0aa8ec22a2ceb5e870ae17	student	2025-06-20 00:54:55.909539
15	baidateach18		pbkdf2:sha256:260000$f6XTrHXVzezP9NGw$c7adf4a9bce44744ab6d8ae584101660c3ea7d15d470ebae0f6c8f8c648073dd	student	2025-06-20 00:55:12.369847
16	baidateach19		pbkdf2:sha256:260000$Mx6qwICS97x518tA$b9991623af7bb770b2eceb80346f52df7dfd0795feda78b6a07f8a2d3626e65a	student	2025-06-20 00:55:42.680235
\.


--
-- Name: coding_exercises_id_seq; Type: SEQUENCE SET; Schema: public; Owner: devuser
--

SELECT pg_catalog.setval('public.coding_exercises_id_seq', 164, true);


--
-- Name: courses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: devuser
--

SELECT pg_catalog.setval('public.courses_id_seq', 11, true);


--
-- Name: enrollments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: devuser
--

SELECT pg_catalog.setval('public.enrollments_id_seq', 92, true);


--
-- Name: fill_blank_exercises_id_seq; Type: SEQUENCE SET; Schema: public; Owner: devuser
--

SELECT pg_catalog.setval('public.fill_blank_exercises_id_seq', 1, true);


--
-- Name: lessons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: devuser
--

SELECT pg_catalog.setval('public.lessons_id_seq', 164, true);


--
-- Name: multiple_choice_questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: devuser
--

SELECT pg_catalog.setval('public.multiple_choice_questions_id_seq', 8, true);


--
-- Name: progress_id_seq; Type: SEQUENCE SET; Schema: public; Owner: devuser
--

SELECT pg_catalog.setval('public.progress_id_seq', 57, true);


--
-- Name: submission_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: devuser
--

SELECT pg_catalog.setval('public.submission_history_id_seq', 75, true);


--
-- Name: units_id_seq; Type: SEQUENCE SET; Schema: public; Owner: devuser
--

SELECT pg_catalog.setval('public.units_id_seq', 23, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: devuser
--

SELECT pg_catalog.setval('public.users_id_seq', 16, true);


--
-- Name: coding_exercises coding_exercises_lesson_id_key; Type: CONSTRAINT; Schema: public; Owner: devuser
--

ALTER TABLE ONLY public.coding_exercises
    ADD CONSTRAINT coding_exercises_lesson_id_key UNIQUE (lesson_id);


--
-- Name: coding_exercises coding_exercises_pkey; Type: CONSTRAINT; Schema: public; Owner: devuser
--

ALTER TABLE ONLY public.coding_exercises
    ADD CONSTRAINT coding_exercises_pkey PRIMARY KEY (id);


--
-- Name: courses courses_pkey; Type: CONSTRAINT; Schema: public; Owner: devuser
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (id);


--
-- Name: enrollments enrollments_pkey; Type: CONSTRAINT; Schema: public; Owner: devuser
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT enrollments_pkey PRIMARY KEY (id);


--
-- Name: fill_blank_exercises fill_blank_exercises_pkey; Type: CONSTRAINT; Schema: public; Owner: devuser
--

ALTER TABLE ONLY public.fill_blank_exercises
    ADD CONSTRAINT fill_blank_exercises_pkey PRIMARY KEY (id);


--
-- Name: lessons lessons_pkey; Type: CONSTRAINT; Schema: public; Owner: devuser
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_pkey PRIMARY KEY (id);


--
-- Name: multiple_choice_questions multiple_choice_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: devuser
--

ALTER TABLE ONLY public.multiple_choice_questions
    ADD CONSTRAINT multiple_choice_questions_pkey PRIMARY KEY (id);


--
-- Name: progress progress_pkey; Type: CONSTRAINT; Schema: public; Owner: devuser
--

ALTER TABLE ONLY public.progress
    ADD CONSTRAINT progress_pkey PRIMARY KEY (id);


--
-- Name: submission_history submission_history_pkey; Type: CONSTRAINT; Schema: public; Owner: devuser
--

ALTER TABLE ONLY public.submission_history
    ADD CONSTRAINT submission_history_pkey PRIMARY KEY (id);


--
-- Name: enrollments unique_enrollment; Type: CONSTRAINT; Schema: public; Owner: devuser
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT unique_enrollment UNIQUE (student_id, course_id);


--
-- Name: progress unique_student_lesson_progress; Type: CONSTRAINT; Schema: public; Owner: devuser
--

ALTER TABLE ONLY public.progress
    ADD CONSTRAINT unique_student_lesson_progress UNIQUE (student_id, lesson_id);


--
-- Name: units units_pkey; Type: CONSTRAINT; Schema: public; Owner: devuser
--

ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: devuser
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: devuser
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: coding_exercises coding_exercises_lesson_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: devuser
--

ALTER TABLE ONLY public.coding_exercises
    ADD CONSTRAINT coding_exercises_lesson_id_fkey FOREIGN KEY (lesson_id) REFERENCES public.lessons(id);


--
-- Name: courses courses_creator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: devuser
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_creator_id_fkey FOREIGN KEY (creator_id) REFERENCES public.users(id);


--
-- Name: enrollments enrollments_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: devuser
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT enrollments_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.courses(id);


--
-- Name: enrollments enrollments_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: devuser
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT enrollments_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.users(id);


--
-- Name: fill_blank_exercises fill_blank_exercises_lesson_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: devuser
--

ALTER TABLE ONLY public.fill_blank_exercises
    ADD CONSTRAINT fill_blank_exercises_lesson_id_fkey FOREIGN KEY (lesson_id) REFERENCES public.lessons(id);


--
-- Name: lessons lessons_unit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: devuser
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_unit_id_fkey FOREIGN KEY (unit_id) REFERENCES public.units(id);


--
-- Name: multiple_choice_questions multiple_choice_questions_lesson_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: devuser
--

ALTER TABLE ONLY public.multiple_choice_questions
    ADD CONSTRAINT multiple_choice_questions_lesson_id_fkey FOREIGN KEY (lesson_id) REFERENCES public.lessons(id);


--
-- Name: progress progress_lesson_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: devuser
--

ALTER TABLE ONLY public.progress
    ADD CONSTRAINT progress_lesson_id_fkey FOREIGN KEY (lesson_id) REFERENCES public.lessons(id);


--
-- Name: progress progress_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: devuser
--

ALTER TABLE ONLY public.progress
    ADD CONSTRAINT progress_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.users(id);


--
-- Name: submission_history submission_history_lesson_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: devuser
--

ALTER TABLE ONLY public.submission_history
    ADD CONSTRAINT submission_history_lesson_id_fkey FOREIGN KEY (lesson_id) REFERENCES public.lessons(id);


--
-- Name: submission_history submission_history_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: devuser
--

ALTER TABLE ONLY public.submission_history
    ADD CONSTRAINT submission_history_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.users(id);


--
-- Name: units units_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: devuser
--

ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.courses(id);


--
-- PostgreSQL database dump complete
--

