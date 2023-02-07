(deffunction menu())

(deftemplate food
    (slot name)
    (slot price)
    (slot type)
    (slot based_calories)
    )

(deftemplate recommended_food
    (slot name)
    (slot price)
    (slot type)
    (slot based_calories)
    )

(defglobal ?*temp* = 1)
(defglobal ?*total_food* = 0)

; High Calories : More than 500 
; Normal Calories : 400 - 500
; Low Calories : 0 - 400

(defrule high-calories
	(high-c)
    (food (name ?name) (price ?price) (type ?type) (based_calories ?based_calories))
    (test (> ?based_calories 500))
    =>
    (assert (recommended_food (name ?name ) (price ?price) (type ?type) (based_calories ?based_calories)))    
)

(defrule normal-calories
	(normal-c)
    (food (name ?name) (price ?price) (type ?type) (based_calories ?based_calories))
    (test (and (< ?based_calories 500) (> ?based_calories 400))
    =>
    (assert (recommended_food (name ?name ) (price ?price) (type ?type) (based_calories ?based_calories)))    
)

(defrule low-calories
	(low-c)
    (food (name ?name) (price ?price) (type ?type) (based_calories ?based_calories))
    (test (< ?based_calories 400))
    =>
    (assert (recommended_food (name ?name ) (price ?price) (type ?type) (based_calories ?based_calories)))    
)
    

(defquery get_recommended_food
    (recommended_food (name ?a) (price ?b) (type ?c) (based_calories ?c))
)
    

(defrule start_recommendation
	(start-recommendation ?weight ?tall)
    =>
    (bind ?bmi ?weight / ?tall * ?tall)
    (if (< ?bmi 18.5)
        then (assert(high-c))
      elif (and (< ?bmi 24.9) (> ?bmi 18.5))
        then (assert(normal-c))
        )    
      else (assert(low-c))
)

(deffacts foods
    (food (name "Fried Chicken") (price 30000) (type "Fried") (based_calories 300))
    (food (name "Beef Steak") (price 150000) (type "Grill") (based_calories 600))
    (food (name "Onigiri") (price 30000) (type "Steam") (based_calories 250))
    )


(defrule print-food 
    (print-food-fact)
    (food (name ?name) (price ?price) (type ?type) (based_calories ?based_calories))
    => 
    (printout t ?*temp*". Name : " ?name " | Price : " ?price " | Type : " ?type " | Based Calories : " ?based_calories crlf crlf)
    (++ ?*temp*)
    )

(deffunction print_header()
    (printout t "-----------------------------------" crlf)
    )

(deffunction print_food()
    (assert (print-food-fact))
    (bind ?*temp* 1)
    (run)
    (bind ?*total_food* ?*temp*)
    (retract-string "(print-food-fact)")
  
)

(deffunction view_food()
    (printout t "Food List : " crlf)
    (print_food)
    (print_header)
    (printout t "Wanna go back ? [press enter] ")
    (readline)
    (menu)
    )

(deffunction add_food()
    (bind ?price -1)
    (bind ?name "")
    (bind ?type "")
    (bind ?based_calories 0)
    
    	(while (or(< ?price 0) (> ?price 10000) )
    		(printout t "Input food price (must be between 0 - 10000) : ")
    		(bind ?price (read))    
        )
    
    	(while (or(< (str-length ?name) 5) (> (str-length ?name) 30) )
    		(printout t "Input food name (length must be between 5 - 30 characters) : ")
    		(bind ?name (readline))    
        )
    
    	(while (and (neq ?type "Fried") (neq ?type "Steam") (neq ?type "Roast") )
    		(printout t "Input food type (must be 'Fried' or 'Steam' or 'Roast') : ")
    		(bind ?type (readline))    
        )

        (while (or(< ?based_calories 100) (> ?based_calories 1000) )
    		(printout t "Input food based calories (must be between 100 - 1000) : ")
    		(bind ?based_calories (read))    
        )
    
    	(assert (food (name ?name) (price ?price) (type ?type) (based_calories ?based_calories)))
    	(++ ?*total_food*)
    	(menu)
    )

(deffunction update_food()
    (printout t "Update Food")
    (print_header)
    (print_food)
    (print_header)
    (printout t "Choose Index [0 to back] : ")
    (bind ?option -1)
    (while (or (< ?option 0) (> ?option ?*total_food*))
        (printout t ">> ")
	    (bind ?option (read))
	)
    
    (if (eq ?option 0) then
        (menu)
	)
    
  	(retract ?option)
    (menu)
    
    (bind ?price -1)
    (bind ?name "")
    (bind ?type "")
    (bind ?based_calories 0)
    
    	(while (or(< ?price 0) (> ?price 10000) )
    		(printout t "Input food price (must be between 0 - 10000) : ")
    		(bind ?price (read))    
        )
    
    	(while (or(< (str-length ?name) 5) (> (str-length ?name) 30) )
    		(printout t "Input food name (length must be between 5 - 30 characters) : ")
    		(bind ?name (readline))    
        )
    
    	(while (and (neq ?type "Fried") (neq ?type "Steam") (neq ?type "Roast") )
    		(printout t "Input food type (must be 'Fried' or 'Steam' or 'Roast') : ")
    		(bind ?type (readline))    
        )

        (while (or(< ?based_calories 100) (> ?based_calories 1000) )
    		(printout t "Input food based calories (must be between 100 - 1000) : ")
    		(bind ?based_calories (read))    
        )
    
    (modify ?option (name ?name) (price ?price) (type ?type) (based_calories ?based_calories))
    (menu)
)



(deffunction delete_food()
    (printout t "Delete Food")
    (print_header)
    (print_food)
    (print_header)
    (printout t "Choose Index [0 to back] : ")
    (bind ?option -1)
    (while (or (< ?option 0) (> ?option ?*total_food*))
        (printout t ">> ")
	    (bind ?option (read))
	)
    
    (if (eq ?option 0) then
        (menu)
	)
  	(retract ?option)
    (-- ?*total_food*)
    (menu)
    )




(deffunction recomendation()
    (printout t "Recomendation Food" crlf)
        
    ; (new app.Recommendation)
    (printout t "Weight : ")
    (bind ?weight -1)
    (bind ?tall -1)
    (while (or (< ?weight 10) (> ?weight 150))
        (printout t "Please input your weight : ")
	    (bind ?weight (read))
	)
    (while (or (< ?tall 10) (> ?tall 250))
        (printout t "Please input your tall :  ")
	    (bind ?tall (read))
	)
        
    (start-recommendation ?weight ?tall)
    (facts)
        (printout t "Wanna go back ? [press enter]")
        (readline)
        (menu)
    )

(deffunction exit_menu()
    (printout t "Bye bye")
    )

(deffunction cls()
    (for (bind ?i 0) (< ?i 50) (++ ?i))
    	(printout t crlf)
    )


(deffunction menu()
    (cls)
    (print_header)
    (printout t "|        Good Restaurant          |" crlf)
    (print_header)
    (printout t "1. View food" crlf)
    (printout t "2. Add food" crlf)
    (printout t "3. Update food" crlf)
    (printout t "4. Delete food" crlf)
    (printout t "5. Recomendation Food" crlf)
    (printout t "6. Exit" crlf)
    
    (bind ?option -1)
    (while (or (< ?option 1) (> ?option 6))
        (printout t ">> ")
	    (bind ?option (read))
	)
    
    (if (eq ?option 1) then
        (view_food)
     elif (eq ?option 2)then
        (add_food)
     elif (eq ?option 3)then
        (update_food)
     elif (eq ?option 4)then
        (delete_food)
     elif (eq ?option 5)then
        (recomendation)
     elif (eq ?option 6)then
        (exit_menu)
        )
)

(menu)
