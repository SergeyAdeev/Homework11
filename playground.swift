import Foundation
struct Element {
    let index: Int
    let symbol: Character
}

struct Stack {
    private var items: [Element] = []
    
    func peek() -> Element {
        guard let topElement = items.first else { fatalError("This stack is empty.") }
        return topElement
    }
    
    mutating func pop() -> Element {
        return items.removeFirst()
    }
  
    mutating func push(_ element: Element) {
        items.insert(element, at: 0)
    }
    
    func isEmpty() -> Bool {
        if (items.isEmpty){
            return true
        } else {
            return false
        }
    }
}

private var stack = Stack()

func compareBrackets(currentClosingBracket: Character, lastOpeningBracket: Character) -> Bool {
    if (currentClosingBracket == ")" && lastOpeningBracket == "(" ||
        currentClosingBracket == "]" && lastOpeningBracket == "[" ||
        currentClosingBracket == "}" && lastOpeningBracket == "{") {
            return true
        } else {
            return false
        }
}

func checkLastBracket(character: Character) -> Bool {
    let lastOpeningBracket = stack.peek().symbol
    return compareBrackets(currentClosingBracket: character, lastOpeningBracket: lastOpeningBracket)
}

func checkBrackets(string: String) -> Int {
    var index = 0
    for character in string {
        index += 1
        if (character == "(" || character == "[" || character == "{") {
            stack.push(Element(index: index, symbol: character))
        }
        if (character == ")" || character == "]" || character == "}") {
            if(checkLastBracket(character: character)) {
                stack.pop()
            } else {
                return index
            }
        }
    }
    
    if(!stack.isEmpty()) {
        return stack.peek().index
    } else {
        return -1
    }
}

print(checkBrackets(string: "foo(bar[i)"))