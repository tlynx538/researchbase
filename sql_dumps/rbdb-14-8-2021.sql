--
-- PostgreSQL database dump
--

-- Dumped from database version 13.3
-- Dumped by pg_dump version 13.3

-- Started on 2021-08-14 19:29:00 IST

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

--
-- TOC entry 3 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 3335 (class 0 OID 0)
-- Dependencies: 3
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 205 (class 1259 OID 16596)
-- Name: college; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.college (
    college_id bigint NOT NULL,
    college_name character varying NOT NULL
);


ALTER TABLE public.college OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 16610)
-- Name: college_college_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.college_college_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.college_college_id_seq OWNER TO postgres;

--
-- TOC entry 3336 (class 0 OID 0)
-- Dependencies: 206
-- Name: college_college_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.college_college_id_seq OWNED BY public.college.college_id;


--
-- TOC entry 209 (class 1259 OID 16703)
-- Name: department; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.department (
    department_id bigint NOT NULL,
    department_name character varying NOT NULL
);


ALTER TABLE public.department OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 16442)
-- Name: guides; Type: TABLE; Schema: public; Owner: vinayakjaiwant
--

CREATE TABLE public.guides (
    guide_id bigint NOT NULL,
    guide_name character varying(50),
    guide_email character varying NOT NULL,
    guide_phone character varying(10),
    guide_password character varying(60) NOT NULL,
    admin_approve boolean DEFAULT false,
    guide_usn character varying,
    is_guide_registered boolean DEFAULT false,
    guide_college_id bigint,
    guide_department_id bigint
);


ALTER TABLE public.guides OWNER TO vinayakjaiwant;

--
-- TOC entry 208 (class 1259 OID 16668)
-- Name: guides_guide_college_id_seq; Type: SEQUENCE; Schema: public; Owner: vinayakjaiwant
--

CREATE SEQUENCE public.guides_guide_college_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.guides_guide_college_id_seq OWNER TO vinayakjaiwant;

--
-- TOC entry 3337 (class 0 OID 0)
-- Dependencies: 208
-- Name: guides_guide_college_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vinayakjaiwant
--

ALTER SEQUENCE public.guides_guide_college_id_seq OWNED BY public.guides.guide_college_id;


--
-- TOC entry 200 (class 1259 OID 16440)
-- Name: guides_guide_id_seq; Type: SEQUENCE; Schema: public; Owner: vinayakjaiwant
--

CREATE SEQUENCE public.guides_guide_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.guides_guide_id_seq OWNER TO vinayakjaiwant;

--
-- TOC entry 3338 (class 0 OID 0)
-- Dependencies: 200
-- Name: guides_guide_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vinayakjaiwant
--

ALTER SEQUENCE public.guides_guide_id_seq OWNED BY public.guides.guide_id;


--
-- TOC entry 213 (class 1259 OID 16727)
-- Name: schedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schedule (
    schedule_id bigint NOT NULL,
    guide_id bigint NOT NULL,
    scholar_id bigint NOT NULL,
    name_of_event character varying NOT NULL,
    date_of_event date NOT NULL,
    time_of_event time with time zone NOT NULL,
    body text,
    is_cancelled boolean DEFAULT false,
    event_completed boolean
);


ALTER TABLE public.schedule OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16723)
-- Name: newtable_guide_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.newtable_guide_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.newtable_guide_id_seq OWNER TO postgres;

--
-- TOC entry 3339 (class 0 OID 0)
-- Dependencies: 211
-- Name: newtable_guide_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.newtable_guide_id_seq OWNED BY public.schedule.guide_id;


--
-- TOC entry 210 (class 1259 OID 16721)
-- Name: newtable_schedule_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.newtable_schedule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.newtable_schedule_id_seq OWNER TO postgres;

--
-- TOC entry 3340 (class 0 OID 0)
-- Dependencies: 210
-- Name: newtable_schedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.newtable_schedule_id_seq OWNED BY public.schedule.schedule_id;


--
-- TOC entry 212 (class 1259 OID 16725)
-- Name: newtable_scholar_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.newtable_scholar_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.newtable_scholar_id_seq OWNER TO postgres;

--
-- TOC entry 3341 (class 0 OID 0)
-- Dependencies: 212
-- Name: newtable_scholar_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.newtable_scholar_id_seq OWNED BY public.schedule.scholar_id;


--
-- TOC entry 203 (class 1259 OID 16516)
-- Name: scholar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scholar (
    scholar_id bigint NOT NULL,
    scholar_name character varying(50),
    scholar_email character varying(50) NOT NULL,
    scholar_password character varying(60) NOT NULL,
    scholar_phone character varying(10),
    scholar_usn character varying,
    is_scholar_registered boolean DEFAULT false,
    guide_approve boolean DEFAULT false,
    scholar_guide_id bigint,
    scholar_college_id bigint,
    scholar_department_id bigint
);


ALTER TABLE public.scholar OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 16634)
-- Name: scholar_scholar_college_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.scholar_scholar_college_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.scholar_scholar_college_id_seq OWNER TO postgres;

--
-- TOC entry 3342 (class 0 OID 0)
-- Dependencies: 207
-- Name: scholar_scholar_college_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.scholar_scholar_college_id_seq OWNED BY public.scholar.scholar_college_id;


--
-- TOC entry 204 (class 1259 OID 16563)
-- Name: scholar_scholar_guide_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.scholar_scholar_guide_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.scholar_scholar_guide_id_seq OWNER TO postgres;

--
-- TOC entry 3343 (class 0 OID 0)
-- Dependencies: 204
-- Name: scholar_scholar_guide_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.scholar_scholar_guide_id_seq OWNED BY public.scholar.scholar_guide_id;


--
-- TOC entry 202 (class 1259 OID 16514)
-- Name: scholar_scholar_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.scholar_scholar_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.scholar_scholar_id_seq OWNER TO postgres;

--
-- TOC entry 3344 (class 0 OID 0)
-- Dependencies: 202
-- Name: scholar_scholar_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.scholar_scholar_id_seq OWNED BY public.scholar.scholar_id;


--
-- TOC entry 3152 (class 2604 OID 16445)
-- Name: guides guide_id; Type: DEFAULT; Schema: public; Owner: vinayakjaiwant
--

ALTER TABLE ONLY public.guides ALTER COLUMN guide_id SET DEFAULT nextval('public.guides_guide_id_seq'::regclass);


--
-- TOC entry 3159 (class 2604 OID 16730)
-- Name: schedule schedule_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule ALTER COLUMN schedule_id SET DEFAULT nextval('public.newtable_schedule_id_seq'::regclass);


--
-- TOC entry 3160 (class 2604 OID 16731)
-- Name: schedule guide_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule ALTER COLUMN guide_id SET DEFAULT nextval('public.newtable_guide_id_seq'::regclass);


--
-- TOC entry 3161 (class 2604 OID 16732)
-- Name: schedule scholar_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule ALTER COLUMN scholar_id SET DEFAULT nextval('public.newtable_scholar_id_seq'::regclass);


--
-- TOC entry 3155 (class 2604 OID 16519)
-- Name: scholar scholar_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scholar ALTER COLUMN scholar_id SET DEFAULT nextval('public.scholar_scholar_id_seq'::regclass);


--
-- TOC entry 3158 (class 2604 OID 16565)
-- Name: scholar scholar_guide_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scholar ALTER COLUMN scholar_guide_id SET DEFAULT nextval('public.scholar_scholar_guide_id_seq'::regclass);


--
-- TOC entry 3321 (class 0 OID 16596)
-- Dependencies: 205
-- Data for Name: college; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.college VALUES (1, 'ACHARAYA INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (2, 'A.P.S COLLEGE OF ENGINEERING.');
INSERT INTO public.college VALUES (3, 'ALPHA COLLEGE OF ENGINEERING');
INSERT INTO public.college VALUES (4, 'AMC ENGINEERING COLLEGE');
INSERT INTO public.college VALUES (5, 'AMRUTHA INSTITUTE OF ENGINEERING AND MGMT. SCIENCES');
INSERT INTO public.college VALUES (6, 'ATRIA INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (7, 'NANDI INSTITUTE OF TECHNOLOGY MANAGEMENT SCIENCES');
INSERT INTO public.college VALUES (8, 'B.N.M.INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (9, 'B.T.L.INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (10, 'BANGALORE COLLEGE OF ENGINEERING AND TECHNOLOGY');
INSERT INTO public.college VALUES (11, 'BANGALORE INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (12, 'BASAVA ACADEMY OF ENGINEERING');
INSERT INTO public.college VALUES (13, 'BMS COLLEGE OF ENGINEERING');
INSERT INTO public.college VALUES (14, 'BMS EVENING COLLEGE OF ENGINEERING');
INSERT INTO public.college VALUES (15, 'BMS INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (16, 'BRINDAVAN COLLEGE OF ENGG');
INSERT INTO public.college VALUES (17, 'C.M.R INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (18, 'CAMBRIDGE INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (19, 'CHANNA BASAVESHWARA INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (20, 'CITY ENGINEERING COLLEGE');
INSERT INTO public.college VALUES (21, 'DAYANANDA SAGAR COLLEGE OF ENGINEERING');
INSERT INTO public.college VALUES (22, 'DON BOSCO INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (23, 'DR. T THIMAIAH INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (24, 'DR. AMBEDKAR INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (25, 'EAST POINT COLLEGE OF ENGG. FOR WOMEN');
INSERT INTO public.college VALUES (26, 'EAST POINT COLLEGE OF ENGINEERING AND TECHNOLOGY');
INSERT INTO public.college VALUES (27, 'EAST WEST INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (28, 'GHOUSIA COLLEGE OF ENGINEERING');
INSERT INTO public.college VALUES (29, 'GLOBAL ACADEMY OF TECHNOLOGY');
INSERT INTO public.college VALUES (30, 'GOVERNMENT S.K.S.J.T. INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (31, 'GOVERNMENT SKSJT EVENING COLLEGE');
INSERT INTO public.college VALUES (32, 'GOVERNMENT TOOL ROOM AND TRAINING CENTRE');
INSERT INTO public.college VALUES (33, 'GOVT. ENGINEERING COLLEGE RAMNAGAR');
INSERT INTO public.college VALUES (34, 'HKBK COLLEGE OF ENGINEERING');
INSERT INTO public.college VALUES (35, 'HMS INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (36, 'IMPACT COLLEGE OF ENGINEERING');
INSERT INTO public.college VALUES (37, 'ISLAMIAH INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (38, 'JNANA VIKAS INSTITUTE OF TENCNOLOGY,');
INSERT INTO public.college VALUES (39, 'JSS ACADEMY OF TECHNICIAL EDUCATION');
INSERT INTO public.college VALUES (40, 'K.S.INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (41, 'KALPATARU INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (42, 'KNS INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (43, 'M.S.ENGINEERING COLLEGE');
INSERT INTO public.college VALUES (44, 'M.S.RAMAIAH INSTITUTE OF TECHNIOLOGY');
INSERT INTO public.college VALUES (45, 'MVJ COLLEGE OF ENGINEERING');
INSERT INTO public.college VALUES (46, 'NAGARJUNA COLLEGE OF ENGINEERING AND TECHNOLOGY');
INSERT INTO public.college VALUES (47, 'NEW HORIZON COLLEGE OF ENGINEERING');
INSERT INTO public.college VALUES (48, 'NITTE MEENAKSHI INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (49, 'OXFORD COLLEGE OF ENGINEERING');
INSERT INTO public.college VALUES (50, 'PES INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (51, 'PES SCHOOL OF ENGINEERING');
INSERT INTO public.college VALUES (52, 'R R INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (53, 'R.L.JALAPPA INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (54, 'R.V.COLLEGE OF ENGINEERING');
INSERT INTO public.college VALUES (55, 'RAJARAJESWARI COLLEGE OF ENGINEERING');
INSERT INTO public.college VALUES (56, 'RAJIV GANDHI INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (57, 'REVA INSTITUTE OF  TECHNOLOGY & MANAGEMENT');
INSERT INTO public.college VALUES (58, 'RNS INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (59, 'S.J.C INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (60, 'SAI VIDYA INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (61, 'SAMBHRAM INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (62, 'SAPTHAGIRI COLLEGE OF ENGINEERING');
INSERT INTO public.college VALUES (63, 'SCT INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (64, 'SEA COLLEGE OF ENGINEERING AND TECHNOLOGY');
INSERT INTO public.college VALUES (65, 'SHIRDI SAI ENGINEERING COLLEGE');
INSERT INTO public.college VALUES (66, 'SHRIDEVI INSTITUTE OF ENGINEERING AND TECHNOLOGY');
INSERT INTO public.college VALUES (67, 'SIDDAGANGA INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (68, 'SIR M. VISVESVARAYA INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (69, 'SJB INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (70, 'DR. SRI SRI SRI SHIVKUMAR MAHASWAMY, COLLEGE OF ENGG.');
INSERT INTO public.college VALUES (71, 'SRI BELIMATHA MAHA SAHAMSTHANA INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (72, 'SRI KRISHNA INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (73, 'SRI REVANASIDDESHWARA INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (74, 'SRI VENKATESHWARA COLLEGE OF ENGINEERING');
INSERT INTO public.college VALUES (75, 'T. JOHN INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (76, 'VEMANA INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (77, 'VIVEKANANDA INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (78, 'YELLAMMA DASAPPA INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (79, 'SRI KRISHNA SCHOOL OF ENGINEERING MANAGEMENT');
INSERT INTO public.college VALUES (80, 'ACHARYS NRV SCHOOL OF ARCHITECTURE');
INSERT INTO public.college VALUES (81, 'ACS COLLEGE OF ENGINEERING');
INSERT INTO public.college VALUES (82, 'AKSHAYA INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (83, 'C BYEREGOWDA INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (84, 'P N S  INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (85, 'SRI BASAVESHWARA INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (86, 'VIJAYA VITTALA INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (87, 'SHASHIB COLLEGE OF ENGINEERING');
INSERT INTO public.college VALUES (88, 'ACHUTHA INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (89, 'SAMPOORNA INSTITUTE OF TECHNOLOGY  RESEARCH');
INSERT INTO public.college VALUES (90, 'K.S SCHOOL OF ENGG & MGMT');
INSERT INTO public.college VALUES (91, 'GOPALAN COLLEGE OF ENGINEERING  MANAGEMENT');
INSERT INTO public.college VALUES (92, 'BANGALORE TECHNOLOGICAL INSTITUTE');
INSERT INTO public.college VALUES (93, 'JYOTHY INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (94, 'DAYANANDA SAGAR ACADEMY OF TECHNOLOGY AND MGMT.');
INSERT INTO public.college VALUES (95, 'SHRI PILLAPPA COLLEGE OF ENGINEERING');
INSERT INTO public.college VALUES (96, 'ADARSHA INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (97, 'SRI VIDYA VINYAKA INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (98, 'IMPACT SCHOOL OF ARCHITECTURE');
INSERT INTO public.college VALUES (99, 'ANJUMAN  INSTITUTE OF TECHNOLOGY & MANAGEMENT');
INSERT INTO public.college VALUES (100, 'B.V.BHOOMARADDI COLLEGE OF ENGINEERING AND TECHNOLOGY');
INSERT INTO public.college VALUES (101, 'BASAVESHWARA ENGINERING COLLEGE');
INSERT INTO public.college VALUES (102, 'BLDEAS COLLEGE OF ENGINEERING');
INSERT INTO public.college VALUES (103, 'GOVT. ENGINEERING COLLEGE HAVERI');
INSERT INTO public.college VALUES (104, 'HIRASUGAR INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (105, 'KLE COLLEGE OF ENG. AND TECHNOLOGY CHIKODI');
INSERT INTO public.college VALUES (106, 'KLE INSTITUTE OF TECH HUBLI');
INSERT INTO public.college VALUES (107, 'KLE DR M. S. SHESHGIRI COLLEGE OF ENGINEERING AND TECHNOLOGY');
INSERT INTO public.college VALUES (108, 'KLS GOGTE INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (109, 'MALIK SANDAL INSTITUTE OF ART AND ARCHITECTURE');
INSERT INTO public.college VALUES (110, 'MARATHA MANDALS ENGINEERING COLLEGE');
INSERT INTO public.college VALUES (111, 'RURAL ENGINEERING COLLEGE, HULKOTI');
INSERT INTO public.college VALUES (112, 'S G BALEKUNDRI INST. OF TECH.');
INSERT INTO public.college VALUES (113, 'S.T.J. INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (114, 'SDM COLLEGE OF ENGINEERING AND TECHNOLOGY');
INSERT INTO public.college VALUES (115, 'SECAB INSTITUTE OF ENGINEERING AND TECHNOLOGY');
INSERT INTO public.college VALUES (116, 'SMT. KAMALA AND SRI VENKAPPA M. AGADI COLLEGE OF ENGINEERING AND TECHNOLOGY');
INSERT INTO public.college VALUES (117, 'SRI TONTADARAYA COLLEGE OF ENGINEERING');
INSERT INTO public.college VALUES (118, 'VISHWANATHA RAO DESHPANDE RURAL INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (119, 'GOVT. ENGINEERING COLLEGE HUVINHADAGALI');
INSERT INTO public.college VALUES (120, 'GOVERNMENT ENGINEERING COLLEGE KARWAR');
INSERT INTO public.college VALUES (121, 'SHAIKH COLLEGE OF ENGINEERING AND TECHNOLOGY');
INSERT INTO public.college VALUES (122, 'JSS ACADEMY OF TECHNICAL EDUCATION');
INSERT INTO public.college VALUES (123, 'ANGADI INSTITUTE OF TECHNOLOGY AND MGMT.');
INSERT INTO public.college VALUES (124, 'JAIN COLLEGE OF ENGINEERING');
INSERT INTO public.college VALUES (125, 'V S M’S INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (126, 'AGM RURAL COLLEGE OF ENGINEERING & TECHNOLOGY');
INSERT INTO public.college VALUES (127, 'GRIJABAI SAIL INSTITUTE OF TECHNOLOGY KARWAR');
INSERT INTO public.college VALUES (128, 'BILURU GURUBASAVA MAHASWAMIJI INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (129, 'APPA INSTITUTE OF ENGINEERING AND TECHNOLOGY');
INSERT INTO public.college VALUES (130, 'BASAVAKALYAN ENGINEERING COLLEGE');
INSERT INTO public.college VALUES (131, 'BELLARY ENGINEERING COLLEGE');
INSERT INTO public.college VALUES (132, 'GOVT. ENGINEERING COLLEGE RAICHUR');
INSERT INTO public.college VALUES (133, 'GURU NANAK DEV ENGINEERING COLLEGE');
INSERT INTO public.college VALUES (134, 'K.C.T. ENGINEERING COLLEGE');
INSERT INTO public.college VALUES (135, 'KHAJA BANDA NAWAZ COLLEGE OF ENGINEERING');
INSERT INTO public.college VALUES (136, 'NAVODAYA INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (137, 'POOJYA DODAPPAPPA COLLEGE OF ENGINEERING');
INSERT INTO public.college VALUES (138, 'PROUDADEVARAYA INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (139, 'RAO BAHADDUR Y MAHABALESHWARAPPA ENGG COLLEGE');
INSERT INTO public.college VALUES (140, 'BHEEMANNA KHANDRE INSTITUTE OF TECHNOLOGY, BHALKI');
INSERT INTO public.college VALUES (141, 'SLN COLLEGE OF ENGINEERING');
INSERT INTO public.college VALUES (142, 'VEERAPPA NISTY ENGINEERING COLLEGE');
INSERT INTO public.college VALUES (143, 'LINGARAJ APPA ENGINEERING COLLEGE');
INSERT INTO public.college VALUES (144, 'GODUTAI ENGINEERING COLLEGE FOR WOMEN');
INSERT INTO public.college VALUES (145, 'SHETTY INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (146, 'ADICHUNCHANAGIRI INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (147, 'ALVAS INST. OF ENGG. AND TECHNOLOGY');
INSERT INTO public.college VALUES (148, 'B.G.S.INSTITUTE OF TECHONOLOGY');
INSERT INTO public.college VALUES (149, 'BAHUBALI COLLEGE OF ENGINEERING');
INSERT INTO public.college VALUES (150, 'BAPUJI INSTITUTE OF ENGINEERING AND TECHNOLOGY');
INSERT INTO public.college VALUES (151, 'BEARYS INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (152, 'CANARA ENGINEERING COLLEGE');
INSERT INTO public.college VALUES (153, 'COORG INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (154, 'DR. M V SHETTY INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (155, 'GOVT. ENGINEERING COLLEGE CHAMARAJANAGARA');
INSERT INTO public.college VALUES (156, 'GOVT. ENGINEERING COLLEGE HASSAN');
INSERT INTO public.college VALUES (157, 'GOVT. ENGINEERING COLLEGE KUSHAL NAGAR');
INSERT INTO public.college VALUES (158, 'GOVT. ENGINEERING COLLEGE MANDYA');
INSERT INTO public.college VALUES (159, 'GOVT. TOOL ROOM AND TRAINING CENTRE');
INSERT INTO public.college VALUES (160, 'GSSS INSTITUTE OF ENGINEERING AND TECHNOLOGY FOR WOMEN');
INSERT INTO public.college VALUES (161, 'JAWAHARLAL NEHRU NATIONAL COLLEGE OF ENGINERING');
INSERT INTO public.college VALUES (162, 'K.V.G. COLLEGE OF ENGINEERING');
INSERT INTO public.college VALUES (163, 'KARAVALI INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (164, 'MAHARAJA INSTITUTE OF TECH');
INSERT INTO public.college VALUES (165, 'MALNAD COLLEGE OF ENGINEERING');
INSERT INTO public.college VALUES (166, 'MANGALORE INSTITUTE OF TECHNOLOGY AND ENGINEERING');
INSERT INTO public.college VALUES (167, 'MOODLAKATTE INSTITUTE OF TECHONOLOGY');
INSERT INTO public.college VALUES (168, 'NATIONAL INSTITUTE OF ENGG. EVENING');
INSERT INTO public.college VALUES (169, 'NATIONAL INSTITUTE OF ENGINEERING');
INSERT INTO public.college VALUES (170, 'NIE INST. OF TECHNOLOGY');
INSERT INTO public.college VALUES (171, 'NMAM INSTITUTE OF TECHONOLOGY');
INSERT INTO public.college VALUES (172, 'P.A.COLLEGE OF ENGINEERING');
INSERT INTO public.college VALUES (173, 'P.E.S COLLEGE OF ENGINEERING');
INSERT INTO public.college VALUES (174, 'PES INSITUTE OF TECHNOLOGY AND MGMT.');
INSERT INTO public.college VALUES (175, 'RAJEEV INST. OF TECHNOLOGY');
INSERT INTO public.college VALUES (176, 'SAHYADRI COLLEGE OF ENGINEERING & MANAGEMENT, MANGALORE');
INSERT INTO public.college VALUES (177, 'SHREE DEVI INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (178, 'SJM INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (179, 'SRI DHARMASTHAL MANJUNATHESHWAR INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (180, 'SRI JAYACHAMARAJENDRA COLLEGE OF ENGINEERING');
INSERT INTO public.college VALUES (181, 'SRI JAYACHAMRAJENDRA COLLEGE OFF ENGG. EVENING');
INSERT INTO public.college VALUES (182, 'GM.INSTITUTE OF TECHONOLOGY');
INSERT INTO public.college VALUES (183, 'SRINIVAS INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (184, 'ST.JOSPEH ENGINEERING COLLEGE');
INSERT INTO public.college VALUES (185, 'VIDYA VARDHAKA COLLEGE OF ENGINERING');
INSERT INTO public.college VALUES (186, 'VIDYA VIKAS INSTITUTE OF ENGINEERING AND TECHNOLOGY');
INSERT INTO public.college VALUES (187, 'VIVEKANANDA COLLEGE OF ENGINEERING AND TECHNOLOGY');
INSERT INTO public.college VALUES (188, 'EKALAVYA INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (189, 'PRASANNA ENGINEERING AND TECHNOLOGY');
INSERT INTO public.college VALUES (190, 'SRINIVAS SCHOOL OF ENGINEERING');
INSERT INTO public.college VALUES (191, 'YAGACHI INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (192, 'SHRI MADHWA VADIRAJA INSTITUTE OF TECHNOLOGY & MANAGEMENT');
INSERT INTO public.college VALUES (193, 'ACADEMY FOR TECHNICAL AND MANAGEMENT EXCELLENCE');
INSERT INTO public.college VALUES (194, 'UBDT ENGINEERING  COLLEGE DAVANAGERE ( CONSTITUENT COLLEGE OF VTU )');
INSERT INTO public.college VALUES (195, 'G MADEGOWDA INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (196, 'JAIN INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (197, 'MANGALORE MARINE COLLEGE & TECHNOLOGY');
INSERT INTO public.college VALUES (198, 'ADITHYA ACADEMY OF ARCHITECTURE & DESGIN');
INSERT INTO public.college VALUES (199, 'BGS SCHOOL OF ARCHITECTURE & PLANNING');
INSERT INTO public.college VALUES (200, 'K S SCHOOL OF ARCHITECTURE');
INSERT INTO public.college VALUES (201, 'SRI VINAYAKA INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (202, 'EAST WEST COLLEGE OF ENGG');
INSERT INTO public.college VALUES (203, 'R V COLLEGE OF ARCHITECTURE');
INSERT INTO public.college VALUES (204, 'BMS SCHOOL OF ARCHITECTURE');
INSERT INTO public.college VALUES (205, 'GOPALAN SCHOOL OF ARCHITECTURE & PLANNING');
INSERT INTO public.college VALUES (206, 'R.R. SCHOOL OF ARCHITECTURE');
INSERT INTO public.college VALUES (207, 'BEST SCHOOL OF ARCHITECTURE');
INSERT INTO public.college VALUES (208, 'CAUVERY INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (209, 'MYSORE SCHOOL OF ARCHITECTURE');
INSERT INTO public.college VALUES (210, 'BEARYS ENVIRONMENT ARCHITECTURE DESIGN SCHOOL MANGALORE');
INSERT INTO public.college VALUES (211, 'CENTRE FOR ARCHITECTURE');
INSERT INTO public.college VALUES (212, 'MYSURU ROYAL INSTITUTE OF TECHNOLOGY');
INSERT INTO public.college VALUES (213, 'MYSURU COLLEGE OF ENGG & MGMT');


--
-- TOC entry 3325 (class 0 OID 16703)
-- Dependencies: 209
-- Data for Name: department; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.department VALUES (1, 'Department of Architecture');
INSERT INTO public.department VALUES (2, 'Department of Chemical Engineering');
INSERT INTO public.department VALUES (3, 'Department of Chemistry');
INSERT INTO public.department VALUES (4, 'Department of Civil Engineering');
INSERT INTO public.department VALUES (5, 'Department of Computer Applications');
INSERT INTO public.department VALUES (6, 'Department of Computer Science and Engineering');
INSERT INTO public.department VALUES (7, 'Department of Electrical and Electronics Engineering');
INSERT INTO public.department VALUES (8, 'Department of Electronics and Communication Engineering');
INSERT INTO public.department VALUES (9, 'Department of Humanities');
INSERT INTO public.department VALUES (10, 'Department of Instrumentation and Control Engineering');
INSERT INTO public.department VALUES (11, 'Department of Management Studies');
INSERT INTO public.department VALUES (12, 'Department of Mathematics');
INSERT INTO public.department VALUES (13, 'Department of Mechanical Engineering');
INSERT INTO public.department VALUES (14, 'Department of Metallurgical and Materials Engineering');
INSERT INTO public.department VALUES (15, 'Department of Physics');
INSERT INTO public.department VALUES (16, 'Department of Production Engineering');


--
-- TOC entry 3317 (class 0 OID 16442)
-- Dependencies: 201
-- Data for Name: guides; Type: TABLE DATA; Schema: public; Owner: vinayakjaiwant
--

INSERT INTO public.guides VALUES (17, 'Vinayak Jaiwant', 'vjaiwantx@gmail.com', '6360139215', '$2b$12$uTg1b.uqECqwFMWjc3gfGOnfbZFka1.YMyKfpDitkIKB2.e4wr5Me', false, '2KL17CS104', true, 107, 6);
INSERT INTO public.guides VALUES (25, 'Prachi Patil', 'patilprachi1711@gmail.com', '9686112740', '$2b$12$ybLlWiG9BZzU9dWzPC3G3uWb4O.NQlaP5G4kc8T6hyMO72bvVm9q2', false, '2KL17EE025', true, 107, 7);
INSERT INTO public.guides VALUES (26, 'Yash Vidhate', 'www.yashvid@gmail.com', '8830728828', '$2b$12$7E.b7himfPVy7ezLc9oEfebxoF.0WnM5TM/dOLEuCBRS7f9/HVnva', false, '2KL17ME102', true, 107, 13);


--
-- TOC entry 3329 (class 0 OID 16727)
-- Dependencies: 213
-- Data for Name: schedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.schedule VALUES (35, 17, 31, 'Thesis Submission', '2021-08-20', '10:32:00+05:30', '', true, NULL);
INSERT INTO public.schedule VALUES (36, 17, 31, 'Meeting #1', '2021-08-13', '10:30:00+05:30', '', true, NULL);
INSERT INTO public.schedule VALUES (37, 17, 31, 'Meeting #1', '2021-08-11', '12:31:00+05:30', '', true, NULL);
INSERT INTO public.schedule VALUES (38, 17, 31, 'Meeting #2', '2021-08-12', '11:33:00+05:30', '', true, NULL);
INSERT INTO public.schedule VALUES (39, 17, 31, 'Meeting #2', '2021-08-07', '12:33:00+05:30', '', true, NULL);
INSERT INTO public.schedule VALUES (40, 17, 31, 'Thesis Submission', '2021-08-07', '13:35:00+05:30', '', true, NULL);
INSERT INTO public.schedule VALUES (41, 17, 31, 'Meeting #1', '2021-08-17', '10:38:00+05:30', '', true, NULL);
INSERT INTO public.schedule VALUES (42, 17, 31, 'Thesis Submission', '2021-08-12', '10:41:00+05:30', '', true, NULL);
INSERT INTO public.schedule VALUES (43, 17, 31, 'Thesis Correction', '2021-08-12', '13:42:00+05:30', '', true, NULL);
INSERT INTO public.schedule VALUES (44, 17, 31, 'Follow-up Meeting regarding your thesis submissions', '2021-08-06', '10:48:00+05:30', '', true, NULL);
INSERT INTO public.schedule VALUES (45, 17, 31, 'Formalities', '2021-08-04', '13:46:00+05:30', '', true, NULL);
INSERT INTO public.schedule VALUES (51, 26, 39, 'Abstract Submission', '2021-08-14', '15:33:00+05:30', 'Please join the below link ASAP:
https://meet.google.com/jpk-aofr-rdi', false, NULL);
INSERT INTO public.schedule VALUES (48, 17, 31, 'Thesis Correction', '2021-08-20', '12:14:00+05:30', 'Your thesis needs to be corrected.', false, NULL);
INSERT INTO public.schedule VALUES (50, 26, 39, 'Follow-up Meeting regarding your thesis submissions', '2021-08-19', '16:10:00+05:30', 'Follow up Meeting
', false, NULL);
INSERT INTO public.schedule VALUES (49, 17, 37, 'Thesis Submission', '2021-08-27', '15:27:00+05:30', 'Your thesis needs to be submitted.', true, NULL);
INSERT INTO public.schedule VALUES (47, 17, 31, 'Meeting #1', '2021-08-05', '10:53:00+05:30', 'Can we have a meeting ASAP?
', true, NULL);
INSERT INTO public.schedule VALUES (46, 17, 31, 'Details needed', '2021-09-02', '10:50:00+05:30', 'Hello we needed your details.', true, NULL);


--
-- TOC entry 3319 (class 0 OID 16516)
-- Dependencies: 203
-- Data for Name: scholar; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.scholar VALUES (31, 'Vinayak Jaiwant', 'vjaiwantx@gmail.com', '$2b$12$4qn/V6IR/neentEcy3Q2jelFDlxnHDQ7ecbU1MAhoEjd2X9eq6RkG', '9999999999', '2KL17CS104', true, false, 17, 3, 1);
INSERT INTO public.scholar VALUES (37, 'Yash Vidhate', 'www.yashvid@gmail.com', '$2b$12$C2Wwokg6J4r5ZG9siHEubOiyAJETXz8hTrNXRobrR/f2Sw7Rucgw.', '8830728828', '2KL17ME102', true, false, 17, 107, 13);
INSERT INTO public.scholar VALUES (39, 'John Doe', 'vjaiwantx@outlook.com', '$2b$12$C2Wwokg6J4r5ZG9siHEubOqeZMM4ocY/yVs11GFmcrGCxa7Rz9cem', '6360139215', '2MM16ME99', true, false, 26, 107, 6);


--
-- TOC entry 3345 (class 0 OID 0)
-- Dependencies: 206
-- Name: college_college_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.college_college_id_seq', 1, false);


--
-- TOC entry 3346 (class 0 OID 0)
-- Dependencies: 208
-- Name: guides_guide_college_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vinayakjaiwant
--

SELECT pg_catalog.setval('public.guides_guide_college_id_seq', 1, false);


--
-- TOC entry 3347 (class 0 OID 0)
-- Dependencies: 200
-- Name: guides_guide_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vinayakjaiwant
--

SELECT pg_catalog.setval('public.guides_guide_id_seq', 26, true);


--
-- TOC entry 3348 (class 0 OID 0)
-- Dependencies: 211
-- Name: newtable_guide_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.newtable_guide_id_seq', 1, false);


--
-- TOC entry 3349 (class 0 OID 0)
-- Dependencies: 210
-- Name: newtable_schedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.newtable_schedule_id_seq', 51, true);


--
-- TOC entry 3350 (class 0 OID 0)
-- Dependencies: 212
-- Name: newtable_scholar_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.newtable_scholar_id_seq', 1, false);


--
-- TOC entry 3351 (class 0 OID 0)
-- Dependencies: 207
-- Name: scholar_scholar_college_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.scholar_scholar_college_id_seq', 1, false);


--
-- TOC entry 3352 (class 0 OID 0)
-- Dependencies: 204
-- Name: scholar_scholar_guide_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.scholar_scholar_guide_id_seq', 3, true);


--
-- TOC entry 3353 (class 0 OID 0)
-- Dependencies: 202
-- Name: scholar_scholar_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.scholar_scholar_id_seq', 39, true);


--
-- TOC entry 3172 (class 2606 OID 16687)
-- Name: college college_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.college
    ADD CONSTRAINT college_pk PRIMARY KEY (college_id);


--
-- TOC entry 3174 (class 2606 OID 16622)
-- Name: college college_un; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.college
    ADD CONSTRAINT college_un UNIQUE (college_name);


--
-- TOC entry 3176 (class 2606 OID 16710)
-- Name: department department_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_pk PRIMARY KEY (department_id);


--
-- TOC entry 3164 (class 2606 OID 16450)
-- Name: guides guides_pk; Type: CONSTRAINT; Schema: public; Owner: vinayakjaiwant
--

ALTER TABLE ONLY public.guides
    ADD CONSTRAINT guides_pk PRIMARY KEY (guide_id);


--
-- TOC entry 3166 (class 2606 OID 16580)
-- Name: guides guides_un; Type: CONSTRAINT; Schema: public; Owner: vinayakjaiwant
--

ALTER TABLE ONLY public.guides
    ADD CONSTRAINT guides_un UNIQUE (guide_name, guide_email, guide_phone, guide_password);


--
-- TOC entry 3178 (class 2606 OID 16747)
-- Name: schedule schedule_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT schedule_pk PRIMARY KEY (schedule_id);


--
-- TOC entry 3168 (class 2606 OID 16532)
-- Name: scholar scholar_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scholar
    ADD CONSTRAINT scholar_pk PRIMARY KEY (scholar_id);


--
-- TOC entry 3170 (class 2606 OID 16646)
-- Name: scholar scholar_un; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scholar
    ADD CONSTRAINT scholar_un UNIQUE (scholar_name, scholar_email, scholar_password, scholar_phone, scholar_usn);


--
-- TOC entry 3179 (class 2606 OID 16693)
-- Name: guides guides_fk; Type: FK CONSTRAINT; Schema: public; Owner: vinayakjaiwant
--

ALTER TABLE ONLY public.guides
    ADD CONSTRAINT guides_fk FOREIGN KEY (guide_college_id) REFERENCES public.college(college_id);


--
-- TOC entry 3180 (class 2606 OID 16711)
-- Name: guides guides_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: vinayakjaiwant
--

ALTER TABLE ONLY public.guides
    ADD CONSTRAINT guides_fk_1 FOREIGN KEY (guide_department_id) REFERENCES public.department(department_id);


--
-- TOC entry 3184 (class 2606 OID 16736)
-- Name: schedule schedule_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT schedule_fk FOREIGN KEY (scholar_id) REFERENCES public.scholar(scholar_id);


--
-- TOC entry 3185 (class 2606 OID 16741)
-- Name: schedule schedule_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT schedule_fk_1 FOREIGN KEY (guide_id) REFERENCES public.guides(guide_id);


--
-- TOC entry 3181 (class 2606 OID 16647)
-- Name: scholar scholar_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scholar
    ADD CONSTRAINT scholar_fk FOREIGN KEY (scholar_guide_id) REFERENCES public.guides(guide_id);


--
-- TOC entry 3182 (class 2606 OID 16698)
-- Name: scholar scholar_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scholar
    ADD CONSTRAINT scholar_fk_1 FOREIGN KEY (scholar_college_id) REFERENCES public.college(college_id);


--
-- TOC entry 3183 (class 2606 OID 16716)
-- Name: scholar scholar_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scholar
    ADD CONSTRAINT scholar_fk_2 FOREIGN KEY (scholar_department_id) REFERENCES public.department(department_id);


-- Completed on 2021-08-14 19:29:00 IST

--
-- PostgreSQL database dump complete
--

