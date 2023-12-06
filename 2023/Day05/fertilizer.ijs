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
fn =. < '/home/milia/Documents/dev/AoC/AoC/2023/Day05/inputsmall.txt'
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

NB. Index of every key in the box-list
ix0 =. 0 { key_indexes
ix1 =. 1 { key_indexes
ix2 =. 2 { key_indexes
ix3 =. 3 { key_indexes
ix4 =. 4 { key_indexes
ix5 =. 5 { key_indexes
ix6 =. 6 { key_indexes

dix0 =. 0 { key_indexes
dix1 =. (1 { [ - 0 { ]) key_indexes
dix2 =. (2 { [ - 1 { ]) key_indexes
dix3 =. (3 { [ - 2 { ]) key_indexes
dix4 =. (4 { [ - 3 { ]) key_indexes
dix5 =. (5 { [ - 4 { ]) key_indexes
dix6 =. (6 { [ - 5 { ]) key_indexes
dix7 =. ($ barr) - ix6
NB. dix0; dix1; dix2; dix3; dix4; dix5; dix6; dix7

NB. Box-lists of the seeds data and every other key and its data.
seeds=. ;: > 0 { barr

ds1=. (ix0 + i. dix1) { barr
ds2=. (ix1 + i. dix2) { barr
ds3=. (ix2 + i. dix3) { barr
ds4=. (ix3 + i. dix4) { barr
ds5=. (ix4 + i. dix5) { barr
ds6=. (ix5 + i. dix6) { barr
ds7=. (ix6 + i. dix7) { barr

NB. Some other calc
NB. colN =. # > split data
NB.
NB. Narr =. i. colN
NB. Narr

NB. ==================Converting each map to a Nx2 array

NB. Seed to Soil
ds1

NB. Soil to Fertilizer

NB. Fertilizer to Water

NB. Water to Light

NB. Light to Temp

NB. Temp to Humidity

NB. Humidity to Location




