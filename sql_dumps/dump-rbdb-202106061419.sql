--
-- PostgreSQL database dump
--

-- Dumped from database version 13.3
-- Dumped by pg_dump version 13.3

-- Started on 2021-06-06 14:19:52 IST

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
-- TOC entry 3256 (class 0 OID 0)
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
    guide_name character varying(50),
    guide_email character varying,
    guide_phone character varying(10)
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
-- TOC entry 3257 (class 0 OID 0)
-- Dependencies: 200
-- Name: guides_guide_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vinayakjaiwant
--

ALTER SEQUENCE public.guides_guide_id_seq OWNED BY public.guides.guide_id;


--
-- TOC entry 3116 (class 2604 OID 16445)
-- Name: guides guide_id; Type: DEFAULT; Schema: public; Owner: vinayakjaiwant
--

ALTER TABLE ONLY public.guides ALTER COLUMN guide_id SET DEFAULT nextval('public.guides_guide_id_seq'::regclass);


--
-- TOC entry 3250 (class 0 OID 16442)
-- Dependencies: 201
-- Data for Name: guides; Type: TABLE DATA; Schema: public; Owner: vinayakjaiwant
--

INSERT INTO public.guides VALUES (1, 'ABC', 'abc@example.com', '994343455');
INSERT INTO public.guides VALUES (2, 'CDE', 'cde@example.com', '993343455');


--
-- TOC entry 3258 (class 0 OID 0)
-- Dependencies: 200
-- Name: guides_guide_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vinayakjaiwant
--

SELECT pg_catalog.setval('public.guides_guide_id_seq', 3, true);


--
-- TOC entry 3118 (class 2606 OID 16450)
-- Name: guides guides_pk; Type: CONSTRAINT; Schema: public; Owner: vinayakjaiwant
--

ALTER TABLE ONLY public.guides
    ADD CONSTRAINT guides_pk PRIMARY KEY (guide_id);


-- Completed on 2021-06-06 14:19:52 IST

--
-- PostgreSQL database dump complete
--

