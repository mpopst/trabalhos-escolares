(ql:quickload 'opticl)
(ql:quickload 'fare-memoization)

(defvar lenna (opticl:read-jpeg-file "lenna.jpg"))

(defun energy-calculation (image)  ;EU RETIREI TODAS AS RAÍZES QUADRADAS!!!
  (let* ((H (array-dimension image 0))
	(W (array-dimension image 1))
	(energy (make-array (list H W))))
    (progn (loop for x from 1 to (- W 2) do ;;parte do programa que, com um loop duplo, calcula o gradiente pra cada pixel interno
	  (loop for y from 1 to (- H 2) do
	       (setf (aref energy y x) (sqrt (+
					 (expt (- (aref image (1+ y) x 1) (aref image (1- y) x 1))  2)
					 (expt (- (aref image (1+ y) x 2) (aref image (1- y) x 2))  2)
					 (expt (- (aref image (1+ y) x 0) (aref image (1- y) x 0))  2)
					 (expt (- (aref image y (1+ x) 1) (aref image y (1- x) 1))  2)
					 (expt (- (aref image y (1+ x) 2) (aref image y (1- x) 2))  2)
					 (expt (- (aref image y (1+ x) 0) (aref image y (1- x) 0))  2)
					 )))))
     (loop for x from 1 to (- W 2) do ;; parte do algoritmo que calcula um dos casos extranhos, que são as bordas superiores e inferiores
	  (progn (setf (aref energy 0 x)  (sqrt (+
					    (expt (- (aref image (1+ 2) x 1) (aref image (1- 2) x 1))  2)
					    (expt (- (aref image (1+ 2) x 2) (aref image (1- 2) x 2))  2)
					    (expt (- (aref image (1+ 2) x 0) (aref image (1- 2) x 0))  2)
					    (expt (- (aref image 0 (1+ x) 1) (aref image 0 (1- x) 1))  2)
					    (expt (- (aref image 0 (1+ x) 2) (aref image 0 (1- x) 2))  2)
					    (expt (- (aref image 0 (1+ x) 0) (aref image 0 (1- x) 0))  2)
					    )))
	   (setf (aref energy (1- H) x)  (sqrt (+
					   (expt (- (aref image (- H 2) x 1) (aref image (- H 4) x 1))  2)
					   (expt (- (aref image (- H 2) x 2) (aref image (- H 4) x 2))  2)
					   (expt (- (aref image (- H 2) x 0) (aref image (- H 4) x 0))  2)
					   (expt (- (aref image (1- H) (1+ x) 1) (aref image (1- H) (1- x) 1))  2)
					   (expt (- (aref image (1- H) (1+ x) 2) (aref image (1- H) (1- x) 2))  2)
					   (expt (- (aref image (1- H) (1+ x) 0) (aref image (1- H) (1- x) 0))  2)
					   )))))
     (loop for y from 1 to (- H 2) do ;;bordas laterais
	 (progn (setf (aref energy y 0)  (sqrt (+
					   (expt (- (aref image (1+ y) 0 1) (aref image (1- y) 0 1))  2)
					   (expt (- (aref image (1+ y) 0 2) (aref image (1- y) 0 2))  2)
					   (expt (- (aref image (1+ y) 0 0) (aref image (1- y) 0 0))  2)
					   (expt (- (aref image y (1+ 2) 1) (aref image y (1- 2) 1))  2)
					   (expt (- (aref image y (1+ 2) 2) (aref image y (1- 2) 2))  2)
					   (expt (- (aref image y (1+ 2) 0) (aref image y (1- 2) 0))  2)
					   )))
		(setf (aref energy y (1- W))  (sqrt (+
						(expt (- (aref image (1+ y) (1- W) 1) (aref image (1- y) (1- W) 1))  2)
						(expt (- (aref image (1+ y) (1- W) 2) (aref image (1- y) (1- W) 2))  2)
						(expt (- (aref image (1+ y) (1- W) 0) (aref image (1- y) (1- W) 0))  2)
						(expt (- (aref image y (- W 2) 1) (aref image y (- W 4) 1))  2)
						(expt (- (aref image y (- W 2) 2) (aref image y (- W 4) 2))  2)
						(expt (- (aref image y (- W 2) 0) (aref image y (- W 4) 0))  2)
						)))))
     (setf (aref energy 0 0) (sqrt (+ (expt (- (aref image (1+ 0) 0 1) (aref image (+ 3 0) 0 1))  2)
				 (expt (- (aref image (1+ 0) 0 2) (aref image (+ 3 0) 0 2))  2)
				 (expt (- (aref image (1+ 0) 0 0) (aref image (+ 3 0) 0 0))  2)
				 (expt (- (aref image 0 (1+ 0) 1) (aref image 0 (+ 3 0) 1))  2)
				 (expt (- (aref image 0 (1+ 0) 2) (aref image 0 (+ 3 0) 2))  2)
				 (expt (- (aref image 0 (1+ 0) 0) (aref image 0 (+ 3 0) 0))  2)
				 )))
     (setf (aref energy 0 (1- W))  (sqrt (+
				     (expt (- (aref image (1+ 0) (1- W) 1) (aref image (+ 3 0) (1- W) 1))  2)
				     (expt (- (aref image (1+ 0) (1- W) 2) (aref image (+ 3 0) (1- W) 2))  2)
				     (expt (- (aref image (1+ 0) (1- W) 0) (aref image (+ 3 0) (1- W) 0))  2)
				     (expt (- (aref image 0 (- W 2) 1) (aref image 0 (- W 4) 1))  2)
				     (expt (- (aref image 0 (- W 2) 2) (aref image 0 (- W 4) 2))  2)
				     (expt (- (aref image 0 (- W 2) 0) (aref image 0 (- W 4) 0))  2)
				     )))
     (setf (aref energy (1- H) 0)  (sqrt (+
				     (expt (- (aref image (- H 2) 0 1) (aref image (- H 4) 0 1))  2)
				     (expt (- (aref image (- H 2) 0 2) (aref image (- H 4) 0 2))  2)
				     (expt (- (aref image (- H 2) 0 0) (aref image (- H 4) 0 0))  2)
				     (expt (- (aref image (1- H) (1+ 0) 1) (aref image (1- H) (+ 3 0) 1))  2)
				     (expt (- (aref image (1- H) (1+ 0) 2) (aref image (1- H) (+ 3 0) 2))  2)
				     (expt (- (aref image (1- H) (1+ 0) 0) (aref image (1- H) (+ 3 0) 0))  2)
				     )))
     (setf (aref energy (1- H) (1- W))  (sqrt (+
					  (expt (- (aref image (- H 2) (1- W) 1) (aref image (- H 4) (1- W) 1))  2)
					  (expt (- (aref image (- H 2) (1- W) 2) (aref image (- H 4) (1- W) 2))  2)
					  (expt (- (aref image (- H 2) (1- W) 0) (aref image (- H 4) (1- W) 0))  2)
					  (expt (- (aref image (1- H) (- W 2) 1) (aref image (1- H) (- W 4) 1))  2)
					  (expt (- (aref image (1- H) (- W 2) 2) (aref image (1- H) (- W 4) 2))  2)
					  (expt (- (aref image (1- H) (- W 2) 0) (aref image (1- H) (- W 4) 0))  2)
					  ))))
    energy))

(defun make-image (image)
  (let* ((H (array-dimension image 0))
	 (W (array-dimension image 1))
	 (gray-scale (make-array (list H W 3) :element-type '(unsigned-byte 8))))
    (loop for x from 0 to (1- W) do
	 (loop for y from 0 to (1- H) do
	      (progn (setf (aref gray-scale y x 0) (min 255 (round (aref image y x))))
	       (setf (aref gray-scale y x 1) (min 255 (round (aref image y x))))
	       (setf (aref gray-scale y x 2) (min 255 (round (aref image y x)))))))
    gray-scale))

(defun find-vertical-seam (image)
  (let* ((H (array-dimension image 0))
	  (W (array-dimension image 1))
	   (energy (energy-calculation image))
	  (dist (make-array (list H W) :initial-element (exp 14)))
	 (answer (list ))
	 (prev nil)
	 (aux nil))
    (loop for y from 0 to (1- W) do (setf (aref dist 0 y) (aref energy 0 y)))
    (loop for x from 1 to (1- H) do
	  (loop for y from 0 to (1- W) do
	       (setf (aref dist x y)
		     (cond ((equal y 0) (+ (aref energy x y) (min (aref dist (1- x) y) (aref dist (1- x) (1+ y)))))
			   ((equal y (1- W)) (+ (aref energy x y) (min (aref dist (1- x) y) (aref dist (1- x) (1- y)))))
			   (t (+ (aref energy x y) (min (aref dist (1- x) y) (aref dist (1- x) (1- y)) (aref dist (1- x) (1+ y)))))))))
    (setf aux (loop for x from 0 to (1- W) collect (aref dist (1- H) x)))
    (setf prev (position (reduce #'min aux) aux))
    (push prev answer)
    (loop for y from (- H 2) downto 0 do
	 (progn
	   (setf aux (loop for x from 0 to (1- W) collect (aref dist y x)))
	   (if (<= (1- prev) 0) (setf aux (list (exp 88) (nth prev aux) (nth (1+ prev) aux)))
	       (if (>= (1+ prev) (1- W)) (setf aux (list (nth (1- prev) aux) (nth prev aux) (exp 88)))
		   (setf aux (list (nth (1- prev) aux) (nth prev aux) (nth (1+ prev) aux)))))
	   (setf prev (+ prev (1- (position (reduce #'min aux) aux))))
	   (push prev answer)))
    answer))

(defun make-it-black (image vertical-seam)
  (loop for y from 0 to (1- (array-dimension image 0)) do (progn
							    (setf (aref image y (nth y vertical-seam) 0) 0)
							    (setf (aref image y (nth y vertical-seam) 1) 0)
							    (setf (aref image y (nth y vertical-seam) 2) 255)))
  image)

(defun reduce-horizontal (image qtd)
  (if (equal qtd 1) (aux-reduce-horizontal image qtd) (reduce-horizontal (aux-reduce-horizontal image qtd) (1- qtd))))

(defun aux-reduce-horizontal (image qtd)
  (let* ((vertical-seam (find-vertical-seam image))
	 (array-dimensions (array-dimensions image))
	 (answer nil)
	 (aux array-dimensions))
    (setf (nth 1 aux) (1- (nth 1 aux)))
    (setf answer (make-array aux :initial-element 0 :element-type '(unsigned-byte 8)))
    (loop for line from 0 to (1- (nth 0 array-dimensions)) do
	 (progn
	   (setf aux
		 (loop for pixel from 0 to (1- (nth 1 array-dimensions)) when (not (equal pixel (nth line vertical-seam))) collect
		      (loop for dim from 0 to 2 collect (aref image line pixel dim))))
	   (loop for pixel from 0 to (- (nth 1 array-dimensions) 2) do (progn
									(setf (aref answer line pixel 1) (nth 1 (nth pixel aux)))
									(setf (aref answer line pixel 2) (nth 2 (nth pixel aux)))
									(setf (aref answer line pixel 0) (nth 0 (nth pixel aux)))))))
    (print qtd)
    answer))
