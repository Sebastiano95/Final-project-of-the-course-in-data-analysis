--ALTER TABLE information_data RENAME COLUMN user_uuid TO user_id   -- sistemazione di un nome scritto in modo sbagliato

--SELECT COUNT(DISTINCT user_id) AS unique_reader_count
--FROM information_data;
  
--Contiamo innanzitutto il numero dei lettori in base alll'id_user.
--Risultato = 242 lettori 


-- possiamo vedere in ordine discendente le recensioni totali raggruppate per categoria , al primo posto il meteo , per ultima l'arte   

/*SELECT category, SUM(stars) AS total_stars
FROM information_data
GROUP BY category
ORDER BY total_stars DESC */

-- Risultato : Weather: 963 ; sport: 531 ; finance:385 ; news:337 ; economy:333 ; lifestyle:240 ; art:194     



-- In questa query ho selezionato le categorie con il maggior numero numero di punti massimi (5) contandoli e ordinandoli in ordine discendente  

/*SELECT category, COUNT(*) AS max_star_count
FROM information_data
WHERE stars = (SELECT MAX(stars) FROM information_data)
GROUP BY category
ORDER BY max_star_count DESC */
-- Risultato= weather: 65 ; news: 26 ; economy:24 ; finance: 22 ; sport: 21 ; lifestyle: 20 ; art:10     

--Qui ho fatto lo stesso ma selezionando per punteggi minimi e contandoli   
/*SELECT category, COUNT(*) AS min_star_count
FROM information_data
WHERE stars = (SELECT MIN(stars) FROM information_data)
GROUP BY category
ORDER BY max_star_count DESC*/
 
-- Risultato= weather: 70 ; sport: 38 ; finance:32 ; economy:26  ; news:19 ; lifestyle: 12 ; art:9


/*SELECT category, COUNT(DISTINCT user_id) AS user_count
FROM information_data
GROUP BY category
ORDER BY user_count DESC
LIMIT 3; */
--Di questi 242 utenti nella classifica di lettura rispettivamente 180 leggono la catecoria weather , 132 sport e 102 finanza


/*SELECT category, length, consult_count
FROM (
    SELECT category, 
           length, 
           COUNT(*) AS consult_count,
           RANK() OVER (PARTITION BY category ORDER BY COUNT(*) DESC) AS rank
    FROM information_data
    GROUP BY category, length
) AS ranked_data
WHERE rank = 1
ORDER BY consult_count DESC
LIMIT 3; */
--  Risulta che il formato preferito dagli utenti è quello lungo con un numero nella top 3 di 146 utenti per weather , 
-- 76 per sport e 53 nella finanza

/*SELECT country, 
       category, 
      COUNT(*) AS category_count  -- category_count rappresenta il numero di volte che la specifica categoria viene consultata per paese 
FROM information_data
GROUP BY country, category
ORDER BY country, category_count DESC; */
-- Ho selezionato le categorie preferite raggruppate per paesi , per la rapprentazione vedere su pandas   

/*SELECT platform, 
       COUNT(*) AS platform_count
FROM information_data
GROUP BY platform
ORDER BY platform DESC ; */
-- Infine ho dato un occhiata il numero totale di volte per piattaforme utilizzate, al primo posto 
-- nonostante non me lo aspettassi il tablet: 424 volte usato , il pc: 339 e infine il cellulare: 236 


