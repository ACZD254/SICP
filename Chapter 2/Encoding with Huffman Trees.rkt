#lang sicp
#|Encoding with Huffman Trees
@Author - Soumitra Pandit
@Date - 28th September 2023

I am interested in finishing the decoding for this system.
So now, lets assume that I have something that is going to give me a Huffman tree
Now, how do I traverse it?
And How do I convert texts into the codes?
Should be pretty straight forward, right?

Lets see.
I also feel the need to break things down into their components
And have some semblance of libraries.

|#


#| Let briefly revise what we've learnt about binary trees.
Okay, done.|#

#| Now, let me create something beautiful.|#

;(define (encode message tree)
  ;takes in a message
  ;and a tree
  ;and produces a list of bits
  ;Pretty cool
;The question that we should be asking is about tree traversal. Because that's what the question
;really is.
;Okay, so let me think.
;If we start with the top branch, the symbol is going to be there.
;Oh wait, I have to traverse the entire tree.


(define (found-symbol? symbol list-of-symbols)
  (cond ((null? list-of-symbols) false)
        ((equal? (car list-of-symbols) symbol) true)
        (else (found-symbol? symbol (cdr list-of-symbols)))))


;Tests for found-symbol?

(found-symbol? 'c '(a b c d e))

(found-symbol? 'f '(a b c d e))

(found-symbol? '() '(a b c d e))

;Seems to be working.

;Now, onto the second part of the program.
;Once we find a symbol, we want to return 1

(define (correct-node? symbol node)
  (if (found-symbol? symbol (extract-symbol (value node)))
      1
      0))

;To test this, we'd need constructors and selectors for node, so lets get them here.

;--------------------------------------------------------------------------------------------

;Node
(define (node value left-node right-node)
  (list value left-node right-node))

(define (value node)
  (car node))

(define (left-node node)
  (cadr node))

(define (right-node node)
  (caddr node))

(define (is-leaf? node)
  (and (null? (right-node node))
       (null? (left-node node))))

;Huffman Complexes
(define (huffman-complex symbols weight)
  (list symbols weight))

(define (extract-symbol huffman-complex)
  (car huffman-complex))

(define (extract-weight huffman-complex)
  (cadr huffman-complex))

(define (combine-symbols complex1 complex2)
  (append (extract-symbol complex1) (extract-symbol complex2)))

(define (add-weights complex1 complex2)
  (+ (extract-weight complex1) (extract-weight complex2)))

(define (combine-huffman-complexes complex1 complex2)
  (huffman-complex (combine-symbols complex1 complex2) (add-weights complex1 complex2)))


;Huffman Node
;A Huffman Node is a special case of a node in which the value is a Huffman Complex

(define (create-huffman-node symbols weight left-node right-node)
  (node (huffman-complex symbols weight) left-node right-node))

(define (huffman-complex-of huffman-node)
  (value huffman-node))

(define (combine-huffman-nodes huffman-node1 huffman-node2)
  (create-huffman-node (combine-symbols (huffman-complex-of huffman-node1) (huffman-complex-of huffman-node2))
                       (add-weights (huffman-complex-of huffman-node1) (huffman-complex-of huffman-node2))
                       huffman-node1
                       huffman-node2))
;---------------------------------------------------------------------------------------------------------------

;Testing

(correct-node? 'a (create-huffman-node '(c a b b a g e) 20 '() '()))


;Okay, this seems to be working.
;Now, let me write the basic logic.

(define (accumulate op base-value seq)
  (if (null? seq)
      base-value
      (op (car seq) (accumulate (cdr seq)))))


;I am trying to rememeber where I left this off and why and I am hit in the face with a barrage of functions.
;I should start documenting better.
;And That DOES NOT mean writing banter-like comments that I can chuckle at later. No, I need something actually
;meaningful.
;Important comments shall henceforth be separated from other comments by a Tag.
;Impertinent Comments would have no special delineators. Where as boxed comments would be pertinent.


;-----------------------------------------------------------------------------------------------------------------
;Function Explanation:
#|
Building Functions Additively.
We already have creaeted something that checks if the node has the correct symbol.
Now, we want to take that output and create a Huffman Encoding
|#

;I need a function that will take a single symbol and traverse the tree to look for it.

;Lets Break it down.
;SO what are we doing?
;We are going to each tree
;If symbol found and tree not node

;And then I want the answers to "Bubble UP".
;This is going to be slightly involved.







