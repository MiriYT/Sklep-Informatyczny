--
-- PostgreSQL database dump
--
-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

-- Started on 2025-12-12 12:52:51

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
SET row_security = on;

--
-- TOC entry 5 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 4974 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 225 (class 1259 OID 25309)
-- Name: klienci_idklienta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.klienci_idklienta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.klienci_idklienta_seq OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 219 (class 1259 OID 25286)
-- Name: klienci; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.klienci (
    idklienta integer DEFAULT nextval('public.klienci_idklienta_seq'::regclass) NOT NULL,
    imie character varying(25),
    nazwisko character varying(25),
    telefon character varying(25)
);


ALTER TABLE public.klienci OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 25311)
-- Name: produkty_idproduktu_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.produkty_idproduktu_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.produkty_idproduktu_seq OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 25294)
-- Name: produkty; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.produkty (
    idproduktu integer DEFAULT nextval('public.produkty_idproduktu_seq'::regclass) NOT NULL,
    nazwa character varying(100),
    rok_produkcji character(4),
    cena numeric(10,2),
    dostepnosc character varying(20),
    CONSTRAINT produkty_dostepnosc_check CHECK (((dostepnosc)::text = ANY ((ARRAY['dostępne'::character varying, 'niedostępne'::character varying])::text[])))
);


ALTER TABLE public.produkty OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 25299)
-- Name: recenzje; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recenzje (
    idklienta integer,
    idproduktu integer,
    ocena integer,
    komentarz character varying(255)
);


ALTER TABLE public.recenzje OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 25317)
-- Name: klienci_ktorzy_dali_ocene_5; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.klienci_ktorzy_dali_ocene_5 AS
 SELECT k.imie,
    k.nazwisko,
    p.nazwa,
    r.ocena,
    r.komentarz
   FROM ((public.klienci k
     JOIN public.recenzje r ON ((k.idklienta = r.idklienta)))
     JOIN public.produkty p ON ((p.idproduktu = r.idproduktu)))
  WHERE (r.ocena = 5);


ALTER VIEW public.klienci_ktorzy_dali_ocene_5 OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 25310)
-- Name: pracownicy_idpracownika_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pracownicy_idpracownika_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pracownicy_idpracownika_seq OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 25290)
-- Name: pracownicy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pracownicy (
    idpracownika integer DEFAULT nextval('public.pracownicy_idpracownika_seq'::regclass) NOT NULL,
    imie character varying(25),
    nazwisko character varying(25),
    specjalizacja character varying(50),
    login character varying(25)
);


ALTER TABLE public.pracownicy OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 25302)
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
-- TOC entry 231 (class 1259 OID 25325)
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
-- TOC entry 230 (class 1259 OID 25321)
-- Name: slabe_opinie; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.slabe_opinie AS
 SELECT k.imie,
    k.nazwisko,
    p.nazwa,
    r.ocena,
    r.komentarz
   FROM ((public.klienci k
     JOIN public.recenzje r ON ((k.idklienta = r.idklienta)))
     JOIN public.produkty p ON ((p.idproduktu = r.idproduktu)))
  WHERE (r.ocena <= 3);


ALTER VIEW public.slabe_opinie OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 25312)
-- Name: zamowienia_idzamowienia_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.zamowienia_idzamowienia_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.zamowienia_idzamowienia_seq OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 25305)
-- Name: zamowienia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.zamowienia (
    idzamowienia integer DEFAULT nextval('public.zamowienia_idzamowienia_seq'::regclass) NOT NULL,
    idklienta integer,
    idproduktu integer,
    data_zamowienia date
);


ALTER TABLE public.zamowienia OWNER TO postgres;

--
-- TOC entry 4959 (class 0 OID 25286)
-- Dependencies: 219
-- Data for Name: klienci; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.klienci (idklienta, imie, nazwisko, telefon) VALUES (1, 'Jan', 'Kowalski', '123456789');
INSERT INTO public.klienci (idklienta, imie, nazwisko, telefon) VALUES (2, 'Anna', 'Nowak', '987654321');
INSERT INTO public.klienci (idklienta, imie, nazwisko, telefon) VALUES (3, 'Piotr', 'Zielinski', '456789123');
INSERT INTO public.klienci (idklienta, imie, nazwisko, telefon) VALUES (4, 'Maria', 'Wiśniewska', '321654987');
INSERT INTO public.klienci (idklienta, imie, nazwisko, telefon) VALUES (5, 'Tomasz', 'Szymański', '741258963');
INSERT INTO public.klienci (idklienta, imie, nazwisko, telefon) VALUES (6, 'Karolina', 'Lewandowska', '852963741');
INSERT INTO public.klienci (idklienta, imie, nazwisko, telefon) VALUES (7, 'Marek', 'Kamiński', '369258147');
INSERT INTO public.klienci (idklienta, imie, nazwisko, telefon) VALUES (8, 'Kamil', 'Bartosz', '600111222');
INSERT INTO public.klienci (idklienta, imie, nazwisko, telefon) VALUES (9, 'Wiktoria', 'Pirlo', '456123789');


--
-- TOC entry 4960 (class 0 OID 25290)
-- Dependencies: 220
-- Data for Name: pracownicy; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.pracownicy (idpracownika, imie, nazwisko, specjalizacja, login) VALUES (1, 'Piotr', 'Wiśniewski', 'telefony', 'p.wisniewski');
INSERT INTO public.pracownicy (idpracownika, imie, nazwisko, specjalizacja, login) VALUES (2, 'Katarzyna', 'Zalewska', 'komputery', 'k.zalewska');
INSERT INTO public.pracownicy (idpracownika, imie, nazwisko, specjalizacja, login) VALUES (3, 'Marek', 'Nowakowski', 'rtv', 'm.nowakowski');
INSERT INTO public.pracownicy (idpracownika, imie, nazwisko, specjalizacja, login) VALUES (4, 'Adam', 'Szczepan', 'konsole', 'a.szczepan');
INSERT INTO public.pracownicy (idpracownika, imie, nazwisko, specjalizacja, login) VALUES (5, 'Ewa', 'Stolarz', 'telefony', 'e.stolarz');
INSERT INTO public.pracownicy (idpracownika, imie, nazwisko, specjalizacja, login) VALUES (6, 'Tomasz', 'Kowalczyk', 'komputery', 't.kowalczyk');
INSERT INTO public.pracownicy (idpracownika, imie, nazwisko, specjalizacja, login) VALUES (7, 'Barbara', 'Wójcik', 'rtv', 'b.wojcik');


--
-- TOC entry 4961 (class 0 OID 25294)
-- Dependencies: 221
-- Data for Name: produkty; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.produkty (idproduktu, nazwa, rok_produkcji, cena, dostepnosc) VALUES (1, 'iPhone 13', '2021', 4999.99, 'dostępne');
INSERT INTO public.produkty (idproduktu, nazwa, rok_produkcji, cena, dostepnosc) VALUES (2, 'Dell XPS 13', '2022', 5499.00, 'dostępne');
INSERT INTO public.produkty (idproduktu, nazwa, rok_produkcji, cena, dostepnosc) VALUES (3, 'Samsung QLED TV', '2023', 3499.99, 'dostępne');
INSERT INTO public.produkty (idproduktu, nazwa, rok_produkcji, cena, dostepnosc) VALUES (4, 'PS5', '2021', 2499.00, 'dostępne');
INSERT INTO public.produkty (idproduktu, nazwa, rok_produkcji, cena, dostepnosc) VALUES (5, 'Samsung Galaxy S21', '2021', 3799.99, 'dostępne');
INSERT INTO public.produkty (idproduktu, nazwa, rok_produkcji, cena, dostepnosc) VALUES (6, 'Lenovo ThinkPad', '2023', 4999.00, 'dostępne');
INSERT INTO public.produkty (idproduktu, nazwa, rok_produkcji, cena, dostepnosc) VALUES (7, 'LG OLED TV', '2023', 4999.99, 'niedostępne');
INSERT INTO public.produkty (idproduktu, nazwa, rok_produkcji, cena, dostepnosc) VALUES (8, 'HyperPC Ultra X', '2024', 8999.99, 'dostępne');
INSERT INTO public.produkty (idproduktu, nazwa, rok_produkcji, cena, dostepnosc) VALUES (9, 'iPhone 15 Pro', '2023', 5700.99, 'niedostępne');
INSERT INTO public.produkty (idproduktu, nazwa, rok_produkcji, cena, dostepnosc) VALUES (10, 'PS4', '2013', 1000.00, 'dostępne');


--
-- TOC entry 4962 (class 0 OID 25299)
-- Dependencies: 222
-- Data for Name: recenzje; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.recenzje (idklienta, idproduktu, ocena, komentarz) VALUES (1, 1, 5, 'Świetny telefon, bardzo szybki!');
INSERT INTO public.recenzje (idklienta, idproduktu, ocena, komentarz) VALUES (2, 2, 4, 'Bardzo dobra jakość, ale mógłby być tańszy');
INSERT INTO public.recenzje (idklienta, idproduktu, ocena, komentarz) VALUES (3, 3, 5, 'Fantastyczny obraz, uwielbiam ten telewizor!');
INSERT INTO public.recenzje (idklienta, idproduktu, ocena, komentarz) VALUES (4, 4, 3, 'Działa dobrze, ale trochę za głośno w trybie gamingowym');
INSERT INTO public.recenzje (idklienta, idproduktu, ocena, komentarz) VALUES (5, 5, 5, 'Bardzo zadowolony, szybki i niezawodny!');
INSERT INTO public.recenzje (idklienta, idproduktu, ocena, komentarz) VALUES (6, 6, 4, 'Dobry laptop, ale ma mało portów USB');
INSERT INTO public.recenzje (idklienta, idproduktu, ocena, komentarz) VALUES (7, 7, 5, 'Jakość obrazu jest niesamowita, polecam!');
INSERT INTO public.recenzje (idklienta, idproduktu, ocena, komentarz) VALUES (8, 8, 2, 'lekko porysowany ale działa oraz słaba bateria');
INSERT INTO public.recenzje (idklienta, idproduktu, ocena, komentarz) VALUES (1, 9, 5, 'Wszystko działa prawidłowo, szybka dostawa oraz super obsługa przez telefon');
INSERT INTO public.recenzje (idklienta, idproduktu, ocena, komentarz) VALUES (3, 2, 3, 'Laptop działa ale cena za duża');
INSERT INTO public.recenzje (idklienta, idproduktu, ocena, komentarz) VALUES (9, 10, 5, 'Super konsola, pomimo lat nadal się super sprawuje');


--
-- TOC entry 4963 (class 0 OID 25302)
-- Dependencies: 223
-- Data for Name: serwis; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.serwis (idpracownika, idproduktu, nazwa_produktu, rozpoczecie, zakonczenie, kwota_brutto_pln) VALUES (1, 1, 'iPhone 13', '2025-10-01', '2025-10-05', 150.00);
INSERT INTO public.serwis (idpracownika, idproduktu, nazwa_produktu, rozpoczecie, zakonczenie, kwota_brutto_pln) VALUES (2, 2, 'Dell XPS 13', '2025-10-02', '2025-10-06', 200.00);
INSERT INTO public.serwis (idpracownika, idproduktu, nazwa_produktu, rozpoczecie, zakonczenie, kwota_brutto_pln) VALUES (3, 3, 'Samsung QLED TV', '2025-10-03', '2025-10-07', 300.00);
INSERT INTO public.serwis (idpracownika, idproduktu, nazwa_produktu, rozpoczecie, zakonczenie, kwota_brutto_pln) VALUES (4, 4, 'PS5', '2025-10-04', '2025-10-08', 100.00);
INSERT INTO public.serwis (idpracownika, idproduktu, nazwa_produktu, rozpoczecie, zakonczenie, kwota_brutto_pln) VALUES (5, 5, 'Samsung Galaxy S21', '2025-10-05', '2025-10-09', 120.00);
INSERT INTO public.serwis (idpracownika, idproduktu, nazwa_produktu, rozpoczecie, zakonczenie, kwota_brutto_pln) VALUES (6, 6, 'Lenovo ThinkPad', '2025-10-06', '2025-10-10', 250.00);
INSERT INTO public.serwis (idpracownika, idproduktu, nazwa_produktu, rozpoczecie, zakonczenie, kwota_brutto_pln) VALUES (7, 7, 'LG OLED TV', '2025-10-07', '2025-10-11', 400.00);


--
-- TOC entry 4964 (class 0 OID 25305)
-- Dependencies: 224
-- Data for Name: zamowienia; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.zamowienia (idzamowienia, idklienta, idproduktu, data_zamowienia) VALUES (1, 1, 1, '2025-11-01');
INSERT INTO public.zamowienia (idzamowienia, idklienta, idproduktu, data_zamowienia) VALUES (2, 2, 2, '2025-11-02');
INSERT INTO public.zamowienia (idzamowienia, idklienta, idproduktu, data_zamowienia) VALUES (3, 3, 3, '2025-11-03');
INSERT INTO public.zamowienia (idzamowienia, idklienta, idproduktu, data_zamowienia) VALUES (4, 4, 4, '2025-11-04');
INSERT INTO public.zamowienia (idzamowienia, idklienta, idproduktu, data_zamowienia) VALUES (5, 5, 5, '2025-11-05');
INSERT INTO public.zamowienia (idzamowienia, idklienta, idproduktu, data_zamowienia) VALUES (6, 6, 6, '2025-11-06');
INSERT INTO public.zamowienia (idzamowienia, idklienta, idproduktu, data_zamowienia) VALUES (7, 7, 7, '2025-11-07');
INSERT INTO public.zamowienia (idzamowienia, idklienta, idproduktu, data_zamowienia) VALUES (8, 8, 8, '2025-11-21');
INSERT INTO public.zamowienia (idzamowienia, idklienta, idproduktu, data_zamowienia) VALUES (9, 6, 10, '2025-12-02');
INSERT INTO public.zamowienia (idzamowienia, idklienta, idproduktu, data_zamowienia) VALUES (10, 9, 10, '2025-12-23');


--
-- TOC entry 4983 (class 0 OID 0)
-- Dependencies: 225
-- Name: klienci_idklienta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.klienci_idklienta_seq', 9, true);


--
-- TOC entry 4984 (class 0 OID 0)
-- Dependencies: 226
-- Name: pracownicy_idpracownika_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pracownicy_idpracownika_seq', 7, true);


--
-- TOC entry 4985 (class 0 OID 0)
-- Dependencies: 227
-- Name: produkty_idproduktu_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.produkty_idproduktu_seq', 10, true);


--
-- TOC entry 4986 (class 0 OID 0)
-- Dependencies: 228
-- Name: zamowienia_idzamowienia_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.zamowienia_idzamowienia_seq', 10, true);


--
-- TOC entry 4796 (class 2606 OID 25330)
-- Name: klienci klienci_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.klienci
    ADD CONSTRAINT klienci_pkey PRIMARY KEY (idklienta);


--
-- TOC entry 4798 (class 2606 OID 25332)
-- Name: pracownicy pracownicy_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pracownicy
    ADD CONSTRAINT pracownicy_pkey PRIMARY KEY (idpracownika);


--
-- TOC entry 4800 (class 2606 OID 25334)
-- Name: produkty produkty_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produkty
    ADD CONSTRAINT produkty_pkey PRIMARY KEY (idproduktu);


--
-- TOC entry 4802 (class 2606 OID 25336)
-- Name: zamowienia zamowienia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT zamowienia_pkey PRIMARY KEY (idzamowienia);


--
-- TOC entry 4803 (class 2606 OID 25337)
-- Name: recenzje recenzje_idklienta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recenzje
    ADD CONSTRAINT recenzje_idklienta_fkey FOREIGN KEY (idklienta) REFERENCES public.klienci(idklienta) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4804 (class 2606 OID 25342)
-- Name: recenzje recenzje_idproduktu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recenzje
    ADD CONSTRAINT recenzje_idproduktu_fkey FOREIGN KEY (idproduktu) REFERENCES public.produkty(idproduktu) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4805 (class 2606 OID 25347)
-- Name: serwis serwis_idpracownika_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serwis
    ADD CONSTRAINT serwis_idpracownika_fkey FOREIGN KEY (idpracownika) REFERENCES public.pracownicy(idpracownika) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4806 (class 2606 OID 25352)
-- Name: serwis serwis_idproduktu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serwis
    ADD CONSTRAINT serwis_idproduktu_fkey FOREIGN KEY (idproduktu) REFERENCES public.produkty(idproduktu) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4807 (class 2606 OID 25357)
-- Name: zamowienia zamowienia_idklienta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT zamowienia_idklienta_fkey FOREIGN KEY (idklienta) REFERENCES public.klienci(idklienta) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4808 (class 2606 OID 25362)
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
-- Dependencies: 219
-- Name: TABLE klienci; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.klienci TO worker;


--
-- TOC entry 4977 (class 0 OID 0)
-- Dependencies: 221
-- Name: TABLE produkty; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.produkty TO client;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.produkty TO worker;


--
-- TOC entry 4978 (class 0 OID 0)
-- Dependencies: 222
-- Name: TABLE recenzje; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,UPDATE ON TABLE public.recenzje TO client;
GRANT SELECT ON TABLE public.recenzje TO worker;


--
-- TOC entry 4979 (class 0 OID 0)
-- Dependencies: 220
-- Name: TABLE pracownicy; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.pracownicy TO worker;


--
-- TOC entry 4980 (class 0 OID 0)
-- Dependencies: 223
-- Name: TABLE serwis; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.serwis TO worker;


--
-- TOC entry 4981 (class 0 OID 0)
-- Dependencies: 231
-- Name: TABLE pracownik_od_komputerow; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pracownik_od_komputerow TO worker;


--
-- TOC entry 4982 (class 0 OID 0)
-- Dependencies: 224
-- Name: TABLE zamowienia; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT ON TABLE public.zamowienia TO worker;


-- Completed on 2025-12-12 12:52:51

--
-- PostgreSQL database dump complete
--

