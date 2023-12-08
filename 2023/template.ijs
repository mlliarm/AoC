load'debug/dissect'

NB. ====================== Useful verbs

str2box_cm =. {{,. /:~ dltb each ',' cut y}} NB. Break string into boxes per comma
str2box_sc =. {{,. /:~ dltb each ';' cut y}} NB. Break string into boxes per semicolon
str2box_cl =. {{,. /:~ dltb each ':' cut y}} NB. Break string into boxes per colon
str2box_nl =. {{,. /:~ dltb each '\n' cut y}}
str2box_sp =. {{,. /:~ dltb each ' ' cut y}}
strjoin=: #@[ }. <@[ ;@,. ]
strsplit=: #@[ }.each [ (E. <;.1 ]) ,
split =. {{ cutopen y }}
unbox =. {{ > x { y }}
rm_empty_boxes =. {{ x -. a: }}
index =. {{ 
	list_of_boxes =. x
	key =. y	  
	list_of_boxes i. key
	}}

NB. ===============================  Reading data
readfile =: 1!:1
fn =. < './input.txt'
data =. readfile fn
