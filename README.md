# Sklep-Informatyczny
Baza danych dla sklepu informatycznego<br>
<br>
Tabela klienci która zbiera podstawowe informacje o klientach wraz z kontaktem(telefon);<br> 
Tabela produkty która ma informacje o produktach które firma oferuje; <br>
Tabela recenzje która posiada oceny oraz komentarze klientów na temat produktów; <br>
Tabela pracownicy zbiera informacje o pracownikach m.in ich specjalizacje, login;<br>
Tabela serwis która pokazuje który pracownik naprawia dany przedmiot wraz z cenną brutto; <br>
Tabela zamowienia na podstawie id pokazuje jaki produkt został zamówiony przez danego klienta;<br>
<br>
Widok klienci_ktorzy_dali_ocene_5 pokazuje jacy klienci dali ocene =5; <br>
Widok pracownik_od_komputerow pokazuje pracowników którzy zajmują się naprawą komputerów; <br>
Widok slabe_opinie pokazuje oceny klientów <=3; <br>
<br>
Baza posiada trzech użytkowników: <br>
worker-Pracownik który może usuwać, tworzyc, edytować oraz kasować dane aczkolwiek zależy od wymagań tabeli; <br>
client- większość tabel może przeglądać za wyjątkiem takich z danymi wrażliwymi(np: pracownicy) oraz ma możliwość wpisywania recenzji; <br>
postgres-może wszystko, jest administratorem bazy; <br>
<br>
Baza idealnie może wpasować się w sklep informatyczny, jest elastyczna poprzez prostotę, relacje oraz sens tabel. <br>
Utworzenie strony HTML do której podepniemy możliwość logowania się oraz wprowadzania danych daje idealnie połączenie dla interesantów jak i samych pracowników do klarownego wprowadzania danych.<br>
<br>
UPDATE
<br>
Została dodana strona w języku php która pokazuje przykładowe możliwości takiej bazy oraz jej przydatnośc do jakiegoś prostego sklepu informatycznego, można ją rozbudować dzięki przypisanym typom danych.<br>
Strona nie posiada wybitnego css jednak celem było pokazanie poprawności składni php która to pobiera bądź przesyła dane z bazy Postgres.<br>
Dla 100% że wszystko zadziała baze należy otworzyc w postgres(PgAdmin4) i nazwać "Sklep_informatyczny".<br>
<br>
UPDATE
<br>
Został dodany film w którym pokazana jest baza w postgresql zainstalowana na konsolowym debianie, następnie widać na graficznym systemie jak backup wykonywany jest z maszyny na maszyne, film ma na celu pokazanie<br>
jak proste jest zrobienie zabezpieczenia. W przypadku kiedy serwer padnie mamy backup z dnia poprzedniego(w moim przykładzie), a gdy padnie maszyna służąca za backup mamy serwer z którego jak najszybciej trzeba zrobić zapis.<br>
Można tą metodą iść w nieszkończoność i na kilku komputerach zrobić Backup jednak mi chodziło o praktyczne pokazanie. W nagraniu zapomniałem o pokazaniu komendy "crontab -e", jednak jej zasada jest prosta na samym dole wpisujemy: <br>
"0 22 * * * /home/administrator/Pulpit/backup_sklep.sh > /home/administrator/Pulpit/Backup_debug.log 2>&1" dzięki temu codziennie o 22:00 będzie uruchamiany skrypt "backup_sklep.sh", a w przypadku błędy dostaniemy informacje do pliku "Backup_debug.log".<br>
