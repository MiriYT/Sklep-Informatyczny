--
-- PostgreSQL database dump
--



-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

-- Started on 2025-11-12 08:28:12

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

--
-- TOC entry 5 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--



ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 4974 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 220 (class 1259 OID 16477)
-- Name: klienci; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.klienci (
    idklienta integer NOT NULL,
    imie character varying(25),
    nazwisko character varying(25),
    telefon character varying(25)
);


ALTER TABLE public.klienci OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16476)
-- Name: klienci_idklienta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.klienci_idklienta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.klienci_idklienta_seq OWNER TO postgres;

--
-- TOC entry 4977 (class 0 OID 0)
-- Dependencies: 219
-- Name: klienci_idklienta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.klienci_idklienta_seq OWNED BY public.klienci.idklienta;


--
-- TOC entry 224 (class 1259 OID 16493)
-- Name: produkty; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.produkty (
    idproduktu integer NOT NULL,
    nazwa character varying(100),
    rok_produkcji character(4),
    cena numeric(10,2),
    dostepnosc character varying(20),
    CONSTRAINT produkty_dostepnosc_check CHECK (((dostepnosc)::text = ANY ((ARRAY['dostępne'::character varying, 'niedostępne'::character varying])::text[])))
);


ALTER TABLE public.produkty OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16501)
-- Name: recenzje; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recenzje (
    idklienta integer,
    idproduktu integer,
    ocena character(1),
    komentarz character varying(255)
);


ALTER TABLE public.recenzje OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16545)
-- Name: klienci_ktorzy_dali_ocene_5; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.klienci_ktorzy_dali_ocene_5 AS
 SELECT k.idklienta,
    k.imie,
    k.nazwisko,
    k.telefon,
    p.nazwa,
    p.cena,
    r.komentarz
   FROM ((public.klienci k
     JOIN public.recenzje r ON ((k.idklienta = r.idklienta)))
     JOIN public.produkty p ON ((p.idproduktu = r.idproduktu)))
  WHERE (r.ocena = '5'::bpchar);


ALTER VIEW public.klienci_ktorzy_dali_ocene_5 OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16485)
-- Name: pracownicy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pracownicy (
    idpracownika integer NOT NULL,
    imie character varying(25),
    nazwisko character varying(25),
    specjalizacja character varying(50),
    login character varying(25)
);


ALTER TABLE public.pracownicy OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16484)
-- Name: pracownicy_idpracownika_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pracownicy_idpracownika_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pracownicy_idpracownika_seq OWNER TO postgres;

--
-- TOC entry 4982 (class 0 OID 0)
-- Dependencies: 221
-- Name: pracownicy_idpracownika_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pracownicy_idpracownika_seq OWNED BY public.pracownicy.idpracownika;


--
-- TOC entry 226 (class 1259 OID 16514)
-- Name: serwis; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.serwis (
    idpracownika integer,
    idproduktu integer,
    nazwa_produktu character varying(255),
    rozpoczecie date,
    zakonczenie date,
    kwota_brutto_pln numeric(10,2)
);


ALTER TABLE public.serwis OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16550)
-- Name: pracownik_od_komputerow; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.pracownik_od_komputerow AS
 SELECT pr.idpracownika,
    pr.imie,
    pr.nazwisko,
    s.nazwa_produktu
   FROM (public.pracownicy pr
     JOIN public.serwis s ON ((pr.idpracownika = s.idpracownika)))
  WHERE ((pr.specjalizacja)::text = 'komputery'::text);


ALTER VIEW public.pracownik_od_komputerow OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16492)
-- Name: produkty_idproduktu_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.produkty_idproduktu_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.produkty_idproduktu_seq OWNER TO postgres;

--
-- TOC entry 4985 (class 0 OID 0)
-- Dependencies: 223
-- Name: produkty_idproduktu_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.produkty_idproduktu_seq OWNED BY public.produkty.idproduktu;


--
-- TOC entry 231 (class 1259 OID 16554)
-- Name: slabe_opinie; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.slabe_opinie AS
 SELECT idklienta,
    idproduktu,
    ocena,
    komentarz
   FROM public.recenzje r
  WHERE (ocena <= '3'::bpchar);


ALTER VIEW public.slabe_opinie OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16528)
-- Name: zamowienia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.zamowienia (
    idzamowienia integer NOT NULL,
    idklienta integer,
    idproduktu integer,
    data_zamowienia date
);


ALTER TABLE public.zamowienia OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16527)
-- Name: zamowienia_idzamowienia_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.zamowienia_idzamowienia_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.zamowienia_idzamowienia_seq OWNER TO postgres;

--
-- TOC entry 4988 (class 0 OID 0)
-- Dependencies: 227
-- Name: zamowienia_idzamowienia_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.zamowienia_idzamowienia_seq OWNED BY public.zamowienia.idzamowienia;


--
-- TOC entry 4790 (class 2604 OID 16480)
-- Name: klienci idklienta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.klienci ALTER COLUMN idklienta SET DEFAULT nextval('public.klienci_idklienta_seq'::regclass);


--
-- TOC entry 4791 (class 2604 OID 16488)
-- Name: pracownicy idpracownika; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pracownicy ALTER COLUMN idpracownika SET DEFAULT nextval('public.pracownicy_idpracownika_seq'::regclass);


--
-- TOC entry 4792 (class 2604 OID 16496)
-- Name: produkty idproduktu; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produkty ALTER COLUMN idproduktu SET DEFAULT nextval('public.produkty_idproduktu_seq'::regclass);


--
-- TOC entry 4793 (class 2604 OID 16531)
-- Name: zamowienia idzamowienia; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.zamowienia ALTER COLUMN idzamowienia SET DEFAULT nextval('public.zamowienia_idzamowienia_seq'::regclass);


--
-- TOC entry 4960 (class 0 OID 16477)
-- Dependencies: 220
-- Data for Name: klienci; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.klienci VALUES (1, 'Jan', 'Kowalski', '123456789');
INSERT INTO public.klienci VALUES (2, 'Anna', 'Nowak', '987654321');
INSERT INTO public.klienci VALUES (3, 'Piotr', 'Zielinski', '456789123');
INSERT INTO public.klienci VALUES (4, 'Maria', 'Wiśniewska', '321654987');
INSERT INTO public.klienci VALUES (5, 'Tomasz', 'Szymański', '741258963');
INSERT INTO public.klienci VALUES (6, 'Karolina', 'Lewandowska', '852963741');
INSERT INTO public.klienci VALUES (7, 'Marek', 'Kamiński', '369258147');


--
-- TOC entry 4962 (class 0 OID 16485)
-- Dependencies: 222
-- Data for Name: pracownicy; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.pracownicy VALUES (1, 'Piotr', 'Wiśniewski', 'telefony', 'p.wisniewski');
INSERT INTO public.pracownicy VALUES (2, 'Katarzyna', 'Zalewska', 'komputery', 'k.zalewska');
INSERT INTO public.pracownicy VALUES (3, 'Marek', 'Nowakowski', 'rtv', 'm.nowakowski');
INSERT INTO public.pracownicy VALUES (4, 'Adam', 'Szczepan', 'konsole', 'a.szczepan');
INSERT INTO public.pracownicy VALUES (5, 'Ewa', 'Stolarz', 'telefony', 'e.stolarz');
INSERT INTO public.pracownicy VALUES (6, 'Tomasz', 'Kowalczyk', 'komputery', 't.kowalczyk');
INSERT INTO public.pracownicy VALUES (7, 'Barbara', 'Wójcik', 'rtv', 'b.wojcik');


--
-- TOC entry 4964 (class 0 OID 16493)
-- Dependencies: 224
-- Data for Name: produkty; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.produkty VALUES (1, 'iPhone 13', '2021', 4999.99, 'dostępne');
INSERT INTO public.produkty VALUES (2, 'Dell XPS 13', '2022', 5499.00, 'dostępne');
INSERT INTO public.produkty VALUES (3, 'Samsung QLED TV', '2023', 3499.99, 'dostępne');
INSERT INTO public.produkty VALUES (4, 'PS5', '2021', 2499.00, 'dostępne');
INSERT INTO public.produkty VALUES (5, 'Samsung Galaxy S21', '2021', 3799.99, 'dostępne');
INSERT INTO public.produkty VALUES (6, 'Lenovo ThinkPad', '2023', 4999.00, 'dostępne');
INSERT INTO public.produkty VALUES (7, 'LG OLED TV', '2023', 4999.99, 'niedostępne');


--
-- TOC entry 4965 (class 0 OID 16501)
-- Dependencies: 225
-- Data for Name: recenzje; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.recenzje VALUES (1, 1, '5', 'Świetny telefon, bardzo szybki!');
INSERT INTO public.recenzje VALUES (2, 2, '4', 'Bardzo dobra jakość, ale mógłby być tańszy');
INSERT INTO public.recenzje VALUES (3, 3, '5', 'Fantastyczny obraz, uwielbiam ten telewizor!');
INSERT INTO public.recenzje VALUES (4, 4, '3', 'Działa dobrze, ale trochę za głośno w trybie gamingowym');
INSERT INTO public.recenzje VALUES (5, 5, '5', 'Bardzo zadowolony, szybki i niezawodny!');
INSERT INTO public.recenzje VALUES (6, 6, '4', 'Dobry laptop, ale ma mało portów USB');
INSERT INTO public.recenzje VALUES (7, 7, '5', 'Jakość obrazu jest niesamowita, polecam!');


--
-- TOC entry 4966 (class 0 OID 16514)
-- Dependencies: 226
-- Data for Name: serwis; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.serwis VALUES (1, 1, 'iPhone 13', '2025-10-01', '2025-10-05', 150.00);
INSERT INTO public.serwis VALUES (2, 2, 'Dell XPS 13', '2025-10-02', '2025-10-06', 200.00);
INSERT INTO public.serwis VALUES (3, 3, 'Samsung QLED TV', '2025-10-03', '2025-10-07', 300.00);
INSERT INTO public.serwis VALUES (4, 4, 'PS5', '2025-10-04', '2025-10-08', 100.00);
INSERT INTO public.serwis VALUES (5, 5, 'Samsung Galaxy S21', '2025-10-05', '2025-10-09', 120.00);
INSERT INTO public.serwis VALUES (6, 6, 'Lenovo ThinkPad', '2025-10-06', '2025-10-10', 250.00);
INSERT INTO public.serwis VALUES (7, 7, 'LG OLED TV', '2025-10-07', '2025-10-11', 400.00);


--
-- TOC entry 4968 (class 0 OID 16528)
-- Dependencies: 228
-- Data for Name: zamowienia; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.zamowienia VALUES (1, 1, 1, '2025-11-01');
INSERT INTO public.zamowienia VALUES (2, 2, 2, '2025-11-02');
INSERT INTO public.zamowienia VALUES (3, 3, 3, '2025-11-03');
INSERT INTO public.zamowienia VALUES (4, 4, 4, '2025-11-04');
INSERT INTO public.zamowienia VALUES (5, 5, 5, '2025-11-05');
INSERT INTO public.zamowienia VALUES (6, 6, 6, '2025-11-06');
INSERT INTO public.zamowienia VALUES (7, 7, 7, '2025-11-07');


--
-- TOC entry 4989 (class 0 OID 0)
-- Dependencies: 219
-- Name: klienci_idklienta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.klienci_idklienta_seq', 1, false);


--
-- TOC entry 4990 (class 0 OID 0)
-- Dependencies: 221
-- Name: pracownicy_idpracownika_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pracownicy_idpracownika_seq', 1, false);


--
-- TOC entry 4991 (class 0 OID 0)
-- Dependencies: 223
-- Name: produkty_idproduktu_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.produkty_idproduktu_seq', 1, false);


--
-- TOC entry 4992 (class 0 OID 0)
-- Dependencies: 227
-- Name: zamowienia_idzamowienia_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.zamowienia_idzamowienia_seq', 1, false);


--
-- TOC entry 4796 (class 2606 OID 16483)
-- Name: klienci klienci_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.klienci
    ADD CONSTRAINT klienci_pkey PRIMARY KEY (idklienta);


--
-- TOC entry 4798 (class 2606 OID 16491)
-- Name: pracownicy pracownicy_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pracownicy
    ADD CONSTRAINT pracownicy_pkey PRIMARY KEY (idpracownika);


--
-- TOC entry 4800 (class 2606 OID 16500)
-- Name: produkty produkty_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produkty
    ADD CONSTRAINT produkty_pkey PRIMARY KEY (idproduktu);


--
-- TOC entry 4802 (class 2606 OID 16534)
-- Name: zamowienia zamowienia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT zamowienia_pkey PRIMARY KEY (idzamowienia);


--
-- TOC entry 4803 (class 2606 OID 16504)
-- Name: recenzje recenzje_idklienta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recenzje
    ADD CONSTRAINT recenzje_idklienta_fkey FOREIGN KEY (idklienta) REFERENCES public.klienci(idklienta) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4804 (class 2606 OID 16509)
-- Name: recenzje recenzje_idproduktu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recenzje
    ADD CONSTRAINT recenzje_idproduktu_fkey FOREIGN KEY (idproduktu) REFERENCES public.produkty(idproduktu) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4805 (class 2606 OID 16517)
-- Name: serwis serwis_idpracownika_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serwis
    ADD CONSTRAINT serwis_idpracownika_fkey FOREIGN KEY (idpracownika) REFERENCES public.pracownicy(idpracownika) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4806 (class 2606 OID 16522)
-- Name: serwis serwis_idproduktu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serwis
    ADD CONSTRAINT serwis_idproduktu_fkey FOREIGN KEY (idproduktu) REFERENCES public.produkty(idproduktu) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4807 (class 2606 OID 16535)
-- Name: zamowienia zamowienia_idklienta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT zamowienia_idklienta_fkey FOREIGN KEY (idklienta) REFERENCES public.klienci(idklienta) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4808 (class 2606 OID 16540)
-- Name: zamowienia zamowienia_idproduktu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT zamowienia_idproduktu_fkey FOREIGN KEY (idproduktu) REFERENCES public.produkty(idproduktu) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4975 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- TOC entry 4976 (class 0 OID 0)
-- Dependencies: 220
-- Name: TABLE klienci; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.klienci TO worker;


--
-- TOC entry 4978 (class 0 OID 0)
-- Dependencies: 224
-- Name: TABLE produkty; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.produkty TO client;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.produkty TO worker;


--
-- TOC entry 4979 (class 0 OID 0)
-- Dependencies: 225
-- Name: TABLE recenzje; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,UPDATE ON TABLE public.recenzje TO client;
GRANT SELECT ON TABLE public.recenzje TO worker;


--
-- TOC entry 4980 (class 0 OID 0)
-- Dependencies: 229
-- Name: TABLE klienci_ktorzy_dali_ocene_5; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.klienci_ktorzy_dali_ocene_5 TO worker;
GRANT SELECT ON TABLE public.klienci_ktorzy_dali_ocene_5 TO client;


--
-- TOC entry 4981 (class 0 OID 0)
-- Dependencies: 222
-- Name: TABLE pracownicy; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.pracownicy TO worker;


--
-- TOC entry 4983 (class 0 OID 0)
-- Dependencies: 226
-- Name: TABLE serwis; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.serwis TO worker;


--
-- TOC entry 4984 (class 0 OID 0)
-- Dependencies: 230
-- Name: TABLE pracownik_od_komputerow; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pracownik_od_komputerow TO worker;


--
-- TOC entry 4986 (class 0 OID 0)
-- Dependencies: 231
-- Name: TABLE slabe_opinie; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.slabe_opinie TO client;
GRANT SELECT ON TABLE public.slabe_opinie TO worker;


--
-- TOC entry 4987 (class 0 OID 0)
-- Dependencies: 228
-- Name: TABLE zamowienia; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT ON TABLE public.zamowienia TO worker;


-- Completed on 2025-11-12 08:28:12

--
-- PostgreSQL database dump complete
--

