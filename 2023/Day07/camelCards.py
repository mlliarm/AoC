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

j_cards = {
    "A": 13,
    "K": 12,
    "Q": 11,
    "T": 10,
    "9": 9,
    "8": 8,
    "7": 7,
    "6": 6,
    "5": 5,
    "4": 4,
    "3": 3,
    "2": 2,
    "J": 1,
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
        
    def set_hand_name_J(self) -> None:
        if 'J' in self.content:
            temp_hand_cont = self.content
            thc = sorted(temp_hand_cont, key=lambda x: cards[x], reverse=True)
            c = check_freq(self.content)           
            max_card = list(max(c, key=lambda x:c[x]))[0]
            if self.content != 'JJJJJ':
                c2 = removekey(c,max_card)
                second_max_card = list(max(c2, key=lambda x:c[x]))[0]
                if max_card != 'J':
                    thc = ("".join(thc)).replace("J",max_card)
                elif max_card == 'J':
                    thc = ("".join(thc)).replace("J",second_max_card)
            multivals = list(dict_to_odict(check_freq(thc)).values())
            self.name = types_of_hands[str(multivals)]
        else:
            self.set_hand_name()
            
        
    def get_multi_values(self) -> list:
        return sorted(self.multiplicity.values(), reverse=True)
        
    def set_hand_name(self) -> None:
        self.name = types_of_hands[str(self.get_multi_values())]
        
      
@dataclass
class Deck:
    hands: List[Hand]

def removekey(d: dict, key:str) -> dict:
    r = dict(d)
    del r[key]
    return r


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
    
def sort_hands(hands: List[Hand], cards: dict) -> List[Hand]:
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

    # SOLUTION OF FIRST PART
    for h in deck.hands:
        h.set_hand_multiplicity()
        h.set_hand_name()
        
    hands = deck.hands
    sorted_hands = sort_hands(hands, cards)
    print(total_winnings(sorted_hands))
    
    # SOLUTION OF SECOND PART
    for h in deck.hands:
        h.set_hand_multiplicity()
        h.set_hand_name_J()

    sorted_hands = sort_hands(deck.hands, j_cards)
    print(total_winnings(sorted_hands))

if __name__ == "__main__":
    main()
