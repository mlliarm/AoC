def input_file(inputfile: str) -> list:
    with open('input.txt') as f:
        words = list()
        for line in f:
            words.append(line)
    return words

def calibrate(word: str) -> int:
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
