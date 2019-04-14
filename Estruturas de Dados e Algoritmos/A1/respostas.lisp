

;; https://common-lisp.net/project/cl-heap/
(ql:quickload :cl-heap)

(defmacro while ((test &optional (result nil)) &body body)
  `(do ()
       ((not ,test) ,result)
     ,@body))




(defparameter *aluno* '(nome-completo "Matheus Henrique Popst de Campos"
			email-na-lista "www.matheus.matheus@gmail.com"))



;;; QUESTAO 1

;; se sua resposta for f1 < f2 < f3 < f4 < f5 < f6, você deve
;; responder como abaixo. Ajuste a ordem dos números de acordo com sua
;; resposta.

(defun question-1 ()
  (list 3 2 6 1 4 5))


;;; QUESTAO 2

;; vc deve completar a resposta abaixo com as expressões adequadas
;; para termos o resultado pedido para cada algorítmo. O caso do
;; algoritmo 4 é um pouco mais delicado, vc ira precisar da função
;; auxiliar.

;(defun nlogn (guess  &optional (err (expt 3 -100)))
  ;0)

(defun nlogn () 0)
(defun question-2 ()
  (list :a1 (floor (sqrt (* (expt 10 10) (* 60 60))))
	:a2 (floor (expt  (* (expt 10 10) (* 60 60)) (/ 1 3)))
	:a3 (* 60 (expt 10 4))
	:a4 (nlogn)
	:a5 (floor (log (* (expt 10 10) (* 60 60))))
	:a6 (floor (log (log (* (expt 10 10) (* 60 60)))))))


;;; QUESTAO 3

;; complete com a expressão correta da resposta. Se a resposta for
;; O(n^{log_2 10}) vc iria responder:

(defun question-3 (n)
  (expt n (log 3 2)))


;;; QUESTAO 4

;; complexidade : expressao em função de k e n.

(defun merge-1 (list1 list2 &optional (res nil))
  (cond ((null list1)
         (append (reverse res) list2))
        ((null list2)
	 (append (reverse res) list1))
        (t (if (<= (car list1) (car list2))
               (merge-1 (cdr list1) list2 (cons (car list1) res))
	       (merge-1 list1 (cdr list2) (cons (car list2) res))))))

(defun question-4-a (list-of-lists)
  (if (<= (length list-of-lists) 2) 
    (merge-1 (car list-of-lists) (cdr list-of-lists))
    (merge-1 (merge-1 (pop list-of-lists) (pop list-of-lists))
             (question-4-a list-of-lists))))
    

(defun question-4-b (k n)
  (* n k))

(defun linear-k-merge (lists)
  "Encontre o menor dos k itens (um de cada uma das listas
  ordenadas). Mova o menor para a lista de respostas e substitua-o
  pelo vizinho (o próximo elemento menor) na lista de origem de onde
  ele veio. Novamente, existem k itens, dentre os quais o menor deve
  ser selecionado. (Quando uma lista esgota, o último item movido não
  tem substituição, então, em seguida, encontramos o menor número em
  menos de k itens.)"
  "<your-code-here>")


(defun heap-merge (lists)
  "k itens (um de cada lista das listas ordenadas) são mantidos em um
   heap (sob disciplina: root = smallest - veja a página sobre o
   cl-heap). Mova o menor item para a lista de respostas, substitua o
   item movido no heap por seu menor vizinho na lista de origem da
   qual ele veio. Quando uma lista esgota, o último item movido não é
   substituído e a atualização do heap não é necessária e teremos
   menos k itens."
  "<your code using heap>")


(defun dc-merge (lists)
  "Recursivamente junte as primeiras k/2 listas e junte recursivamente
   as últimas k/2 listas. Em seguida, MERGE os dois resultados. Se k =
   2 então apenas um MERGE é necessário; se k = 1, apenas devolva a
   entrada."
  "<your divide-conquer code>")


;;; QUESTAO 5

(defun dijkstra (graph-as-lists s)
  (list ))


;;; QUESTAO 6

(defun paths (graph-as-lists u v)
3)


;;; QUESTAO 7

;; vamos assumir que a rua é uma reta. As posições das casas são dadas
;; por números reais representando a distância da origem. A entrada é
;; uma lista de números e sua resposta será uma lista de numeros reais
;; representando a posição das antenas e o tamanho desta lista,
;; obviamente, indica quantas antenas forma necessárias.


;;Aqui eu tentei implementar o algortimo que pensei, mas depois pensei que seria o caso do algoritmo guloso da Bruxa de Blair e então até desanimei de implementá-lo.

(defun questao-7-a (casas &optional (adb casas) (aux -1))
  (setf casas (merge-sort-rec casas))
  (if (= (length casas) (length adb)) (setf adb (merge-sort-rec adb)))
  (loop for antena in adb collect (list 
                                   (apply '+ (loop for casa in casas collect 
                                         (if (< (abs (- antena casa)) 4) 1 0)))
                                   antena)))

(defun  merge-sort-rec (list)
  (let ((nem (list-length list)))
    (if (> nem 1) 
        (my-merge (merge-sort-rec (subseq list 0 (floor (/ nem 2)))) (merge-sort-rec (subseq list (floor (/ nem 2)))))
        list)))

(defun my-merge (list1 list2)
    (cond ((= (length list1) 0) list2)
          ((= (length list2) 0) list1)
          ((<= (car list1) (car list2)) (cons (car list1) (my-merge (cdr list1) list2)))
(T (cons (car list2) (my-merge list1 (cdr list2))))))

;; abaixo, n é o(qu número de casas

(defun questao-7-b (n)
 (* n n n))


;; QUESTAO 8

(defun is-an-implication (clause)
    (and (equal (length clause) 2) (not (equal (type-of (car clause)) (type-of (car '(z)))))))

(defun not-in-the-list (list1 symbol)
    (if (equal (length (set-difference (list symbol) list1)) 0) nil T))

(defun in-the-list (list1 symbol) (not (not-in-the-list list1 symbol)))

(defun analizador-de-implicacoes (imp sip)
    (let ((resp nil))
    (progn (if (in-the-list sip (cadr imp)) (setq resp t)) ;se Q é verdade
    (loop for x in (car imp) do
          (if (not-in-the-list sip x) ;se algum x é falso
          (setq resp t))))
         resp))
(defun ana-pnc (pnc sip)
    (let ((resp t))
    (loop for x in pnc do
          (if (in-the-list sip x) (setq resp nil)))
    resp))

(defun questao-8 (list-of-clauses)
(let ((imps (list )) (pnc (list )) (symbols-in-negative (list )) (symbols-in-positive (list )) (aux '()))
;primeira parte: colocar as variáveis na negativa
(loop for clause in list-of-clauses do ;para cada clausula
(if (is-an-implication clause) ;é uma implicação?
       (progn                  ;SIM!
           (loop for symbol in (car clause) do ;para cada elemento do antecedente
                 (if (not-in-the-list symbols-in-negative symbol) ;se ainda não foi adicionado
                      (push symbol symbols-in-negative))) ;adiciona o antecedente
                 (if (not-in-the-list symbols-in-negative (car (cdr clause))) ;para o predicado, se não foi adicionado
                      (push (car (cdr clause)) symbols-in-negative)) ;adiciona o predicado
           (push clause imps)) ;adiciona a cláusula na lista de implicações
       (progn                  ;NÃO É UMA IMPLICAÇÃO!
           (loop for symbol in clause do 
                 (if (not-in-the-list symbols-in-negative symbol)
                      (push symbol symbols-in-negative)))
           (push clause pnc))))         
;segunda parte: analisar as implicações
(loop while (> (length imps) 0) do ;enquanto ainda houverem implicações
      (progn
      (setf aux (pop imps)) ;tira uma implicação
      (setf symbols-in-negative (remove (car (cdr aux)) symbols-in-negative)) ;muda o valor do predicado
      (push (cadr aux) symbols-in-positive))) ;muda o valor do predicado pt.2
;terceira parte: verificar as pnc
(setf aux 1)
(loop for pncx in pnc do 
      (if (not (ana-pnc pncx symbols-in-positive)) (setf aux 0)))
;chegamos até aqui? então retornar a rapaziada
(if (= aux 0) nil (nconc (loop for x in symbols-in-positive collect (list x 1))
       (loop for x in symbols-in-negative collect (list x 0))))))
