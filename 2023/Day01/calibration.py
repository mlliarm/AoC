def input_file(inputfile: str) -> list:
    with open('input.txt') as f:
        words = list()
        for line in f:
            words.append(line)
    return words

def calibrate(word: str) -> int:
    '''
    nlist = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
    for i in range(len(word)):
        for n in nlist:
            wordi = word[i:len(n)+i]
            if wordi == "one":
                word = word.replace("one", "1")
            elif wordi == "two":
                word = word.replace("two","2")
            elif wordi == "three":
                word = word.replace("three", "3")
            elif wordi == "four":
                word = word.replace("four", "4")
            elif wordi == "five":
                word = word.replace("five", "5")
            elif wordi == "six":
                word = word.replace("six", "6")
            elif wordi == "seven":
                word = word.replace("seven", "7")
            elif wordi == "eight":
                word = word.replace("eight", "8")
            elif wordi == "nine":
                word = word.replace("nine", "9")
    '''
    nums = [s for s in list(word) if s.isdigit()]
    string = "".join(nums)
    return int(string[0]+string[-1])

def sum(inputlist: list) -> int:
    res = 0
    for x in inputlist:
        res += x
    return res

def main():
    wordList = input_file("input.txt")
    nums = [calibrate(w) for w in wordList]
    result = sum(nums)
    print(result)

if __name__ == "__main__":
    main()
