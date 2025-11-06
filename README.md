# Sklep-Informatyczny
Baza danych dla sklepu informatycznego <br>
<br>
Tabela klienci która zbiera podstawowe informacje o klientach wraz z kontaktem(telefon); <br>
Tabela produkty która ma informacje o produktach które firma oferuje; <br>
Tabela recenzje która posiada oceny oraz komentarze klientów na temat produktów; <br>
Tabela pracownicy zbiera informacje o pracownikach m.in ich specjalizacje, login;<br>
Tabela serwis która pokazuje który pracownik naprawia dany przedmiot wraz z cenną brutto; <br>
Tabela zamowienia na podstawie id pokazuje jaki produkt został zamówiony przez danego klienta;<br>

Widok klienci_ktorzy_dali_ocene_5 pokazuje jacy klienci dali ocene =5; <br>
Widok pracownik_od_komputerow pokazuje pracowników którzy zajmują się naprawą komputerów; <br>
Widok slabe_opinie pokazuje oceny klientów <=3; <br>
<br>
Baza posiada trzech użytkowników:
worker-Pracownik który może usuwać, tworzyc, edytować oraz kasować dane aczkolwiek zależy od wymagań tabeli; <br>
client- większość tabel może przeglądać za wyjątkiem takich z danymi wrażliwymi(np: pracownicy) oraz ma możliwość wpisywania recenzji; <br>
postgres-może wszystko, jest administratorem bazy; <br>
<br>
Baza idealnie może wpasować się w sklep informatyczny, jest elastyczna poprzez prostotę, relacje oraz sens tabel. <br>
Utworzenie strony HTML do której podepniemy możliwość logowania się oraz wprowadzania danych daje idealnie połączenie dla interesantów jak i samych pracowników do klarownego wprowadzania danych.
