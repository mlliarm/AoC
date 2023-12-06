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
fn =. < '/home/milia/Documents/dev/AoC/AoC/2023/Day05/input.txt'
data =. readfile fn
NB. data

dlf =. toJ data
(# data) = +/ dlf = data NB. proof that data is dlf.

NB. Keys of each table
s1 =. 'seed-to-soil map:'
s2 =. 'soil-to-fertilizer map:'
s3 =. 'fertilizer-to-water map:'
s4 =. 'water-to-light map:'
s5 =. 'light-to-temperature map:'
s6 =. 'temperature-to-humidity map:'
s7 =. 'humidity-to-location map:'

NB. Data exploration & preparation
NB. # data
NB. $ data

barr =. split data NB. Boxed array of data
barr

NB. $ barr

key_indexes=. barr index s1; s2; s3; s4; s5; s6; s7
key_indexes

ix0 =. 0 { key_indexes
ix1 =. 1 { key_indexes
ix2 =. 2 { key_indexes
ix3 =. 3 { key_indexes
ix4 =. 4 { key_indexes
ix5 =. 5 { key_indexes
ix6 =. 6 { key_indexes

dix0 =. ix0
dix1 =. ix1 - ix0
dix2 =. ix2 - ix1
dix3 =. ix3 - ix2
dix4 =. ix4 - ix3
dix5 =. ix5 - ix4
dix6 =. ix6 - ix5
dix7 =. ($ barr) - ix6
dix0; dix1; dix2; dix3; dix4; dix5; dix6; dix7


(ix0 + i. dix1) { barr
(ix1 + i. dix2) { barr
(ix2 + i. dix3) { barr
(ix3 + i. dix4) { barr
(ix4 + i. dix5) { barr
(ix5 + i. dix6) { barr
(ix6 + i. dix7) { barr

NB. Some other calc
colN =. # > split data

Narr =. i. colN
Narr





