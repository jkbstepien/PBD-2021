USE library;

-- ĆWICZENIE 1

-- 1. Napisz polecenie select, za pomocą którego uzyskasz tytuł i numer książki.
SELECT title, title_no AS BookNumber
  FROM title

-- 2. Napisz polecenie, które wybiera tytuł o numerze 10.
SELECT title
  FROM title
  WHERE title_no = 10

-- 3. Napisz polecenie select, za pomocą którego uzyskasz numer książki (nr tytułu)  i
-- autora z tablicy title dla wszystkich książek, których autorem jest Charles
-- Dickens lub Jane Austen.
SELECT title_no AS BookNumber, author
  FROM title
  WHERE author LIKE 'Charles Dickens'
     OR author LIKE 'Jane Austen'

-- ĆWICZENIE 2

-- 1. Napisz polecenie, które wybiera numer tytułu i tytuł dla wszystkich  książek,
-- których tytuły zawierających słowo „adventure”.
SELECT title_no, title
  FROM title
  WHERE title LIKE '%adventure%'

-- 2. Napisz polecenie, które wybiera numer czytelnika, oraz zapłaconą karę.
SELECT member_no, fine_paid
  FROM loanhist
  WHERE fine_paid IS NOT NULL

-- 3. Napisz polecenie, które wybiera wszystkie unikalne pary miast i stanów z tablicy
-- adult.
SELECT DISTINCT city, state
  FROM adult
  ORDER BY city

-- 4. Napisz polecenie, które wybiera wszystkie tytuły z tablicy title i wyświetla je w
-- porządku alfabetycznym.
SELECT title
  FROM title
  ORDER BY title

-- ĆWICZENIE 3

-- 1. Napisz polecenie, które:
-- a) wybiera numer członka biblioteki (member_no), isbn książki (isbn) i watrość
-- naliczonej kary (fine_assessed) z tablicy loanhist dla wszystkich wypożyczeń
-- dla których naliczono karę (wartość nie NULL w kolumnie fine_assessed).
-- b)stwórz kolumnę wyliczeniową zawierającą podwojoną wartość kolumny
-- fine_assessed.
-- c) stwórz alias ‘double fine’ dla tej kolumny.
SELECT member_no, isbn, fine_assessed, (fine_assessed * 2) AS double_fine
  FROM loanhist
  WHERE fine_assessed IS NOT NULL

-- ĆWICZENIE 4

-- 1. Napisz polecenie, które
-- a) generuje pojedynczą kolumnę, która zawiera kolumny: firstname (imię członka biblioteki),
-- middleinitial (inicjał drugiego imienia) i lastname(nazwisko) z tablicy member dla wszystkich
-- członków biblioteki, którzy nazywają się Anderson.
-- b) nazwij tak powstałą kolumnę email_name (użyj aliasu email_name dla kolumny)
-- c) zmodyfikuj polecenie, tak by zwróciło „listę proponowanych loginów e-mail”  utworzonych przez
-- połączenie imienia członka biblioteki, z inicjałem drugiego imienia i pierwszymi dwoma literami nazwiska
-- (wszystko małymi małymi literami).
-- c.1) Wykorzystaj funkcję SUBSTRING do uzyskania części kolumny
-- znakowej oraz LOWER do zwrócenia wyniku małymi literami.
-- Wykorzystaj operator (+) do połączenia stringów.
SELECT firstname + ', ' + middleinitial + ', ' + lastname AS email_name
  FROM member
  WHERE lastname LIKE 'Anderson'

SELECT LOWER(firstname +
             middleinitial +
             SUBSTRING(lastname, 1, 2) +
             '@library.com')
    AS example_email
  FROM member
  WHERE lastname LIKE 'Anderson'

-- ĆWICZENIE 5

-- 1. Napisz polecenie, które wybiera title i title_no z tablicy title.
-- a) Wynikiem powinna być pojedyncza kolumna o formacie jak w przykładzie
-- poniżej:
--     The title is: Poems, title number 7
-- b) Czyli zapytanie powinno zwracać pojedynczą kolumnę w oparciu o
-- wyrażenie, które łączy 4 elementy:
--     stała znakowa ‘The title is:’
--     wartość kolumny  title
--     stała znakowa ‘title number’
--     wartość kolumny title_no
SELECT ('The title is: ' +
        title +
        ' number ' +
        REPLACE(STR(title_no), ' ', ''))
    AS description
  FROM title