from collections import OrderedDict
from typing import List, Dict, Tuple
from dataclasses import dataclass

cards = {
    "A": 13,
    "K": 12,
    "Q": 11,
    "J": 10,
    "T": 9,
    "9": 8,
    "8": 7,
    "7": 6,
    "6": 5,
    "5": 4,
    "4": 3,
    "3": 2,
    "2": 1,
}

types_of_hands = {
        "[5]":("Five of a kind",7),
         "[4, 1]":("Four of a kind",6),
         "[3, 2]":("Full house",5),
         "[3, 1, 1]":("Three of a kind",4),
         "[2, 2, 1]":("Two pair",3),
         "[2, 1, 1, 1]":("One pair",2),
         "[1, 1, 1, 1, 1]":("High card",1),
}

@dataclass
class Hand:
    name: str
    content: str
    bid: int
    multiplicity: OrderedDict
    rank: int
    
    def set_hand_multiplicity(self) -> None:
        c = check_freq(self.content)
        sod = dict_to_odict(c)
        self.multiplicity = sod
        
    # def set_hand_name_J(self) -> None:
    #     if 'J' in self.content:
    #         temp_hand_cont = self.content
    #         thc = sorted(temp_hand_cont, key=lambda x: cards[x], reverse=True)
    #         if self.content.index('J') == 0:
    #             ("".join(thc)).replace("J",thc[1])
    #         else:
    #             ("".join(thc)).replace("J",thc[0])
    #         multivals = list(dict_to_odict(check_freq(thc)).values())
    #         self.name = types_of_hands[str(multivals)]
    #     else:
    #         self.set_hand_name()
            
        
    def get_multi_values(self) -> list:
        return sorted(self.multiplicity.values(), reverse=True)
        
    def set_hand_name(self) -> None:
        self.name = types_of_hands[str(self.get_multi_values())]
        
      
@dataclass
class Deck:
    hands: List[Hand]

def check_freq(x: str) -> dict:
    freq = dict()
    for c in set(x):
       freq[c] = x.count(c)
    return freq

def dict_to_odict(d: dict) -> OrderedDict:
    return OrderedDict(sorted(d.items(), key=lambda x: x[1], reverse=True))

def input_file(inputfile: str) -> dict:
    with open(inputfile) as f:
        res = dict()
        for i,line in enumerate(f):
            line = line.replace("\n", "")
            line = line.split(" ")
            res[i] = line
    return res
        
def set_hand_name(h: Hand) -> None:
    multivals = str(h.get_multi_values())
    print(multivals)
    h.name = types_of_hands[str(multivals)]
    
def sort_hands(hands: List[Hand]) -> List[Hand]:
     return sorted(hands, key= lambda x: (
            x.name[1],
            cards[x.content[0]],
            cards[x.content[1]], 
            cards[x.content[2]],
            cards[x.content[3]],
            cards[x.content[4]]),reverse=False)

def total_winnings(sorted_hands: List[Hand]) -> int:
    sum = 0
    for i,h in enumerate(sorted_hands):
        h.rank = i+1
        print(h.name, h.content, h.bid, h.rank)
        sum += h.rank*h.bid
    return sum

def main():
    data = input_file("./input.txt")

    my_deck = list()
    for i,d in enumerate(data):
        my_deck.append(Hand("",data[i][0], int(data[i][1]),{},0))

    deck = Deck(my_deck)

    for h in deck.hands:
        h.set_hand_multiplicity()
        h.set_hand_name()
        
    hands = deck.hands

    # SOLUTION OF FIRST PART
    sorted_hands = sort_hands(hands)

    print(total_winnings(sorted_hands))
    
    # SOLUTION OF SECOND PART
    # h=Hand("","KTJJT",684,{},0)
    # h.set_hand_name_J()
    # print(h)

if __name__ == "__main__":
    main()
