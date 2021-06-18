--
-- PostgreSQL database dump
--

-- Dumped from database version 13.3
-- Dumped by pg_dump version 13.3

-- Started on 2021-06-18 22:39:07 IST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'LATIN1';
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
-- TOC entry 3272 (class 0 OID 0)
-- Dependencies: 3
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 201 (class 1259 OID 16442)
-- Name: guides; Type: TABLE; Schema: public; Owner: vinayakjaiwant
--

CREATE TABLE public.guides (
    guide_id bigint NOT NULL,
    guide_name character varying(50) NOT NULL,
    guide_email character varying NOT NULL,
    guide_phone character varying(10) NOT NULL,
    guide_password character varying(20) NOT NULL
);


ALTER TABLE public.guides OWNER TO vinayakjaiwant;

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
-- TOC entry 3273 (class 0 OID 0)
-- Dependencies: 200
-- Name: guides_guide_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vinayakjaiwant
--

ALTER SEQUENCE public.guides_guide_id_seq OWNED BY public.guides.guide_id;


--
-- TOC entry 203 (class 1259 OID 16516)
-- Name: scholar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scholar (
    scholar_id bigint NOT NULL,
    scholar_name character varying(50) NOT NULL,
    scholar_email character varying(50) NOT NULL,
    scholar_password character varying(20) NOT NULL,
    scholar_phone character varying(10) NOT NULL,
    scholar_guide_id bigint NOT NULL
);


ALTER TABLE public.scholar OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 16520)
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
-- TOC entry 3274 (class 0 OID 0)
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
-- TOC entry 3275 (class 0 OID 0)
-- Dependencies: 202
-- Name: scholar_scholar_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.scholar_scholar_id_seq OWNED BY public.scholar.scholar_id;


--
-- TOC entry 3124 (class 2604 OID 16445)
-- Name: guides guide_id; Type: DEFAULT; Schema: public; Owner: vinayakjaiwant
--

ALTER TABLE ONLY public.guides ALTER COLUMN guide_id SET DEFAULT nextval('public.guides_guide_id_seq'::regclass);


--
-- TOC entry 3125 (class 2604 OID 16519)
-- Name: scholar scholar_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scholar ALTER COLUMN scholar_id SET DEFAULT nextval('public.scholar_scholar_id_seq'::regclass);


--
-- TOC entry 3126 (class 2604 OID 16522)
-- Name: scholar scholar_guide_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scholar ALTER COLUMN scholar_guide_id SET DEFAULT nextval('public.scholar_scholar_guide_id_seq'::regclass);


--
-- TOC entry 3263 (class 0 OID 16442)
-- Dependencies: 201
-- Data for Name: guides; Type: TABLE DATA; Schema: public; Owner: vinayakjaiwant
--

INSERT INTO public.guides VALUES (2, 'CDE', 'cde@example.com', '993343455', 'opefjpew3');
INSERT INTO public.guides VALUES (4, 'ABC', 'abc@example.com', '993343455', 'abcd1234');


--
-- TOC entry 3265 (class 0 OID 16516)
-- Dependencies: 203
-- Data for Name: scholar; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.scholar VALUES (2, 'xcd', 'xcd@example.com', '993343444', 'adcve1234', 2);


--
-- TOC entry 3276 (class 0 OID 0)
-- Dependencies: 200
-- Name: guides_guide_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vinayakjaiwant
--

SELECT pg_catalog.setval('public.guides_guide_id_seq', 4, true);


--
-- TOC entry 3277 (class 0 OID 0)
-- Dependencies: 204
-- Name: scholar_scholar_guide_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.scholar_scholar_guide_id_seq', 1, false);


--
-- TOC entry 3278 (class 0 OID 0)
-- Dependencies: 202
-- Name: scholar_scholar_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.scholar_scholar_id_seq', 2, true);


--
-- TOC entry 3128 (class 2606 OID 16450)
-- Name: guides guides_pk; Type: CONSTRAINT; Schema: public; Owner: vinayakjaiwant
--

ALTER TABLE ONLY public.guides
    ADD CONSTRAINT guides_pk PRIMARY KEY (guide_id);


--
-- TOC entry 3130 (class 2606 OID 16532)
-- Name: scholar scholar_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scholar
    ADD CONSTRAINT scholar_pk PRIMARY KEY (scholar_id);


--
-- TOC entry 3131 (class 2606 OID 16526)
-- Name: scholar scholar_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scholar
    ADD CONSTRAINT scholar_fk FOREIGN KEY (scholar_guide_id) REFERENCES public.guides(guide_id) ON DELETE CASCADE;


-- Completed on 2021-06-18 22:39:07 IST

--
-- PostgreSQL database dump complete
--

