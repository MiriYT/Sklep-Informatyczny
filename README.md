# Sklep-Informatyczny
Baza danych dla sklepu informatycznego

Tabela klienci która zbiera podstawowe informacje o klientach wraz z kontaktem(telefon);
Tabela produkty która ma informacje o produktach które firma oferuje;
Tabela recenzje która posiada oceny oraz komentarze klientów na temat produktów;
Tabela pracownicy zbiera informacje o pracownikach m.in ich specjalizacje, login;
Tabela serwis która pokazuje który pracownik naprawia dany przedmiot wraz z cenną brutto;
Tabela zamowienia na podstawie id pokazuje jaki produkt został zamówiony przez danego klienta;

Widok klienci_ktorzy_dali_ocene_5 pokazuje jacy klienci dali ocene =5;
Widok pracownik_od_komputerow pokazuje pracowników którzy zajmują się naprawą komputerów;
Widok slabe_opinie pokazuje oceny klientów <=3;

Baza posiada trzech użytkowników:
worker-Pracownik który może usuwać, tworzyc, edytować oraz kasować dane aczkolwiek zależy od wymagań tabeli;
client- większość tabel może przeglądać za wyjątkiem takich z danymi wrażliwymi(np: pracownicy) oraz ma możliwość wpisywania recenzji;
postgres-może wszystko, jest administratorem bazy;

Baza idealnie może wpasować się w sklep informatyczny, jest elastyczna poprzez prostotę, relacje oraz sens tabel.
Utworzenie strony HTML do której podepniemy możliwość logowania się oraz wprowadzania danych daje idealnie połączenie dla interesantów jak i samych pracowników do klarownego wprowadzania danych.
