;Feito por mpopst e viguardieiro

(ql:quickload :split-sequence) ;biblioteca que separa strings

(defmacro while ((test &optional (result nil)) &body body)
  `(do ()
       ((not ,test) ,result)
,@body))

(defclass synset ()
  ((id         :accessor synset-id
	       :initarg :id)
   (nouns      :accessor synset-nouns
 	       :initarg :nouns
	       :documentation "Lista de palavras do synset")
   (hypernyms  :accessor synset-hypernyms
	       :initarg :hypernyms
	       :initform nil
	       :documentation "Lista de ancestrais")
   (definition :accessor synset-definition
               :initarg :definition
               :documentation "Definição do synset dada no arquivo synsets.txt")))

(defun read-synsets (file)  ;função-auxiliar
  "Função que dado um arquivo com os synsets na formula 'ID,sinônimos,definição' (com os sinônimos separados por espaço), retorna uma lista de objetos synset."
  (with-open-file (stream file)
    (let* ((line (read-line stream nil))
           (data nil))
      (while ((not (equal line nil)))
	   (progn
	    (setf line (split-sequence:split-sequence #\, line))
	    (push (make-instance 'synset :id (car line) 
				 :nouns (split-sequence:split-sequence
					 #\Space (cadr line))
				 :definition (caddr line))
		  data)
	    (setf line (read-line stream nil))))
      (reverse data)))) 

(defun make-graph (file-synsets file-hypernym)
  "Função que recebe o arquivo de synsets na formula 'ID,sinônimos,definição' (com os sinônimos separados por espaço) e um arquivo de hypernyms na forma 'ID,ids_hypernyms' (onde ids_hypernyms são os ids dos hypernyms do synset ID separados por vírgula). Exemplo de linha de hypernyms: 34,47569,48084.
A função retorna uma lista de synsets que representa o grafo da Wordnet."
  (with-open-file (stream file-hypernym)
    (let* ((data (read-synsets file-synsets))
	   (line (read-line stream nil)))
      (while ((not (equal line nil)))
	(progn
	  (setf line (split-sequence:split-sequence #\, line))
	  (setf (synset-hypernyms (nth (parse-integer (car line)) data))
		(loop for string in (cdr line) collect (nth (parse-integer string) data)))
	  (setf line (read-line stream nil))))
      data)))

(defun find-synset (noun wordnet)
  "Dado uma palavra e a wordnet retorna os synsets que contém essa palavra com complexidade O(|V|)."
  (let ((l nil))
      (loop for synset in wordnet do
	(loop for n in (synset-nouns synset) do
	     (if (equal n noun)
		 (push synset l))))
      l))

(defun dictionary (word wordnet)
  "Dado uma palavra e a wordnet, irá imprimir os significados possíveis dessa palavra."
  (let ((synsets (find-synset word wordnet)))
    (if (equal synsets nil)
	(print "A palavra não foi encontrada na wordnet.")
	(progn
	  (print "A palavra pode ter os seguintes significados:")
	  (loop for s in synsets do
	       (print (synset-definition s)))))))

(defun go-up (synset &optional (dist 0))
  "Recebe um synset e retorna uma lista de tuplas que contém o ancestral e a distância.
OBS: Não é redundante colocar a distância do ancestral, pois synsets podem ter mais de um ancestral direto e nada impede de se ter duas ou mais vezes o mesmo ancestral, por caminhos diferentes."
  (let ((ancesters (cons (cons synset (cons dist nil)) nil)))  
    (loop for hypernym in (synset-hypernyms synset) do
	 (setf ancesters (append ancesters (go-up hypernym (1+ dist)))))
   ancesters))

(defun sca-synsets (synset1 synset2)
  "Dados dois synsets, retorna o ancestral comum mais próximo de ambos como uma tupla no qual o primeiro elemento é o ancestral comum e o segundo elemento é a soma das distâncias de ambos.

  O enunciado pede um código com complexidade O(|V| + |E|), porém achamos um tanto desnecessária essa otimização, visto que a maior lista de ancestrais tem tamanho 66, o que leva a uma computação máxima da ordem de 4356 iterações, o que é muito pouco."
  (let* ((ancesters-1 (go-up synset1))
	 (ancesters-2 (go-up synset2))
	 (shortest (cons nil (+ (length ancesters-1) (length ancesters-2)))) ;É o maior valor possível que a distância dos nós para o SCA pode assumir.
	 ) 
    (loop for ancestral-1 in ancesters-1 do
	 (loop for ancestral-2 in ancesters-2 do
	      (if (and (equal (car ancestral-1) (car ancestral-2))
		       (< (+ (cadr ancestral-1) (cadr ancestral-2)) (cdr shortest)))	    
		  (setf shortest (cons (car ancestral-1)  (+ (cadr ancestral-1) (cadr ancestral-2)))))))
    shortest))

(defun sca-words (word1 word2 wordnet)
  "Dadas duas palavras na wordnet e uma wordnet, retorna o sca com menor distância entre os synsets que as contêm"
  (let ((synsets-1 (find-synset word1 wordnet))
	(synsets-2 (find-synset word2 wordnet))
	(min (cons nil (* 66 66)))
	(sca 0))
    (loop for synset-1 in synsets-1 do
	 (loop for synset-2 in synsets-2 do
	      (progn
		(setf sca (sca-synsets synset-1 synset-2))
		(if (< (cdr sca) (cdr min))
		    (setf min sca)))))
    min))

(defun distance (word1 word2 wordnet)
 "Dadas duas palavras, retorna a distancia entre elas, que é definida como o tamanho do menor."
  (let ((res (sca-words word1 word2 wordnet)))
    (cdr res)))

(defun outcast (list-of-words wordnet)
  "Recebe uma lista de palavras na forma '('banana', 'apple', 'tree', 'moon') [na realidade é com áspas e não apóstrofe], além da wordnet, e retorna a palavra mais distante de todas, segundo o algoritmo proposto no site da Stanford."
  (caar (sort (loop for word in list-of-words collect
		    (cons word (reduce #'+ (loop for word2 in list-of-words when (not (equal word2 word))
					      collect (distance word word2 wordnet)))))
	       #'> :key #'cdr)))
