(deftemplate Game
 (slot name)
    (slot rating)
    (slot developer)
    (slot genre)
    (slot price)
)

(deffacts init-Game
 (Game (name "Genshin Impact ") (rating 4.4) (developer "Hoyoverse") (genre "RPG") (price 50000))   
    (Game (name "Mobile Legends") (rating 3.7) (developer "Moonton") (genre "Moba") (price 150000)) 
    (Game (name "Soul Knight") (rating 4.4) (developer "ChillyRoom") (genre "RPG") (price 100000)) 
    (Game (name "Dragon Hunters") (rating 4.5) (developer "TTHmobi") (genre "RPG") (price 75000))
    (Game (name "Line Play") (rating 3.8) (developer "Line Corporation") (genre "Social") (price 25000))  
    (Game (name "Audition 2") (rating 3.7) (developer "AU Dance") (genre "Music") (price 150000))  
    (Game (name "Astral Guardians") (rating 4.5) (developer "EyouGame") (genre "RPG") (price 100000))    
)

(reset)

(defquery getAllGames
 (Game (name ?name) (rating ?rating) (developer ?developer) (genre ?genre) (price ?price))    
)

(deffunction viewAllGames() 
    (new main.Query)
    (readline)
)

(deffunction addNewGame()
    (bind ?name "")
    (bind ?rating 0)
    (bind ?developer "")
    (bind ?genre "")
    (bind ?price 0)
    
    (while (< (str-length ?name) 3)
     do
        (printout t "Input New Game's Name : ")
        (bind ?name (readline))
    )
    (while (<= ?rating  0)
     do
        (printout t "Input New Game's Rating : ")
        (bind ?rating (readline))
    )
    (while (< (str-length ?developer ) 3)
     do
        (printout t "Input New Game's Developer : ")
        (bind ?developer (readline))
    )
    (while (< (str-length ?genre ) 3)
     do
        (printout t "Input New Game's Genre : ")
        (bind ?genre (readline))
    )
    (while (< ?price 10000)
     do
        (printout t "Input New Game's Price : ")
        (bind ?price (readline))
    )
    
    (assert (Game (name ?name) (rating ?rating) (developer ?developer) (genre ?genre) (price ?price)))
    (printout t ?name "Has been added to the database !" crlf)
    
    (readline)
)

(deffunction mainMenu()
    
    (bind ?menuInput -1)
    (while (neq ?menuInput 6)
        do
     (printout t "VAGames" crlf)
     (printout t "1. View All Games" crlf)
     (printout t "2. Add New Game" crlf)
     (printout t "3. Update Existing Game" crlf)
     (printout t "4. Delete Existing Game" crlf)
        (printout t "5. Find Recommended Game" crlf)
     (printout t "6. Exit" crlf)
        
  (bind ?menuInput (readline))
        
        (if (= ?menuInput 1) then (viewAllGames)
      elif (= ?menuInput 2) then (addNewGame)
      elif (= ?menuInput 3) then (printout t "Update")
      elif (= ?menuInput 4) then (printout t "Delete")
         elif (= ?menuInput 5) then (printout t "Recommendation")
         elif (= ?menuInput 6) then (break)
     )
    )
    
    (printout t "Thank you for using the app !" crlf)
)

(mainMenu)