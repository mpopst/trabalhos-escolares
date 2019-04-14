(defun back-pack (valores pesos capacidade)
  (if (equal capacidade 0) 0
      (if (equal (length valores) 0) 0
	   (reduce #'max  (loop for i from 0 to (1- (length pesos)) collect
			     (+ (back-pack (loop for x in valores and y in pesos when (<= y (nth i pesos)) collect x)
					   (loop for y in pesos when (<= y (nth i pesos)) collect y)
					   (- capacidade (nth i pesos))) (nth i valores)))))))  
