--
-- PostgreSQL database dump
--

-- Dumped from database version 16.9
-- Dumped by pg_dump version 17.5

-- Started on 2025-08-18 02:47:25

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- TOC entry 221 (class 1259 OID 16530)
-- Name: ClosedGBRInvestment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ClosedGBRInvestment" (
    name character varying,
    market character varying,
    funding_total_usd character varying,
    status character varying,
    country_code character varying(3),
    state_code character varying(2),
    city character varying,
    funding_rounds integer,
    founded_at date,
    founded_month character varying,
    founded_quarter character varying,
    founded_year integer,
    first_funding_at date,
    last_funding_at date,
    seed bigint,
    venture bigint,
    equity_crowdfunding bigint,
    undisclosed bigint,
    convertible_note bigint,
    debt_financing bigint,
    angel bigint,
    "grant" bigint,
    private_equity bigint,
    post_ipo_equity bigint,
    post_ipo_debt bigint,
    secondary_market bigint,
    product_crowdfunding bigint,
    round_a bigint,
    round_b bigint,
    round_c bigint,
    round_d bigint,
    round_e bigint,
    round_f bigint,
    round_g bigint,
    round_h bigint
);


ALTER TABLE public."ClosedGBRInvestment" OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16614)
-- Name: GBRInvestments2000; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."GBRInvestments2000" (
    name character varying,
    market character varying,
    funding_total_usd bigint,
    status character varying,
    country_code character varying(3),
    state_code character varying(2),
    city character varying,
    funding_rounds integer,
    founded_at date,
    founded_month integer,
    founded_quarter character varying(2),
    founded_year integer,
    first_funding_at date,
    last_funding_at date,
    seed numeric,
    venture numeric,
    equity_crowdfunding bigint,
    undisclosed bigint,
    convertible_note bigint,
    debt_financing bigint,
    angel bigint,
    "grant" bigint,
    private_equity bigint,
    post_ipo_equity bigint,
    post_ipo_debt bigint,
    secondary_market bigint,
    product_crowdfunding bigint,
    round_a bigint,
    round_b numeric,
    round_c bigint,
    round_d bigint,
    round_e bigint,
    round_f bigint,
    round_g bigint,
    round_h bigint
);


ALTER TABLE public."GBRInvestments2000" OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16523)
-- Name: GBRInvestments2010; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."GBRInvestments2010" (
    name character varying,
    market character varying,
    funding_total_usd character varying,
    status character varying,
    country_code character varying(3),
    state_code character varying(2),
    city character varying,
    funding_rounds integer,
    founded_at date,
    founded_month character varying,
    founded_quarter character varying,
    founded_year integer,
    first_funding_at date,
    last_funding_at date,
    seed numeric,
    venture numeric,
    equity_crowdfunding bigint,
    undisclosed bigint,
    convertible_note bigint,
    debt_financing bigint,
    angel bigint,
    "grant" bigint,
    private_equity bigint,
    post_ipo_equity bigint,
    post_ipo_debt bigint,
    secondary_market bigint,
    product_crowdfunding bigint,
    round_a bigint,
    round_b bigint,
    round_c bigint,
    round_d bigint,
    round_e bigint,
    round_f bigint,
    round_g bigint,
    round_h bigint
);


ALTER TABLE public."GBRInvestments2010" OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16476)
-- Name: Investments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Investments" (
    permalink character varying,
    name character varying,
    homepage_url character varying,
    category_list character varying,
    market character varying,
    funding_total_usd bigint,
    status character varying,
    country_code character varying(3),
    state_code character varying(2),
    region character varying,
    city character varying,
    funding_rounds integer,
    founded_at date,
    founded_month integer,
    founded_quarter character varying(2),
    founded_year integer,
    first_funding_at date,
    last_funding_at date,
    seed bigint,
    venture bigint,
    equity_crowdfunding bigint,
    undisclosed bigint,
    convertible_note bigint,
    debt_financing bigint,
    angel bigint,
    "grant" bigint,
    private_equity bigint,
    post_ipo_equity bigint,
    post_ipo_debt bigint,
    secondary_market bigint,
    product_crowdfunding bigint,
    round_a bigint,
    round_b bigint,
    round_c bigint,
    round_d bigint,
    round_e bigint,
    round_f bigint,
    round_g bigint,
    round_h bigint
);


ALTER TABLE public."Investments" OWNER TO postgres;

-- Completed on 2025-08-18 02:47:26

--
-- PostgreSQL database dump complete
--

