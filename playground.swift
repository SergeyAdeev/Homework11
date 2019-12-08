import Foundation
struct Element {
    let index: Int
    let symbol: Character
}

struct Stack {
    private var items: [Element] = []
    
    func peek() -> Element {
        guard let topElement = items.last else { fatalError("This stack is empty.") }
        return topElement
    }
    
    mutating func pop() -> Element {
        return items.removeLast()
    }
  
    mutating func push(_ element: Element) {
        items.insert(element, at: items.count)
    }
    
    func isEmpty() -> Bool {
        if (items.isEmpty){
            return true
        } else {
            return false
        }
    }

    mutating func clear() {
        while(!(items.isEmpty)) {
            items.removeLast()
        }
    }
}

var stack = Stack()

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
    if stack.isEmpty() {
        return false
    } else {
        let lastOpeningBracket = stack.peek().symbol
        return compareBrackets(currentClosingBracket: character, lastOpeningBracket: lastOpeningBracket)
    }
}

func checkBrackets(string: String) -> Int {
    stack.clear()    
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
                stack.clear()
                return index
            }
        }
    }
    
    if(!stack.isEmpty()) {
        return stack.peek().index
    } else {
        return -1
    }
    return index
}

print(checkBrackets(string: "[]")) // -1
print(checkBrackets(string: "{}[]")) // -1
print(checkBrackets(string: "{")) // 1
print(checkBrackets(string: "{[}")) // 3
print(checkBrackets(string: "foo(bar)")) // -1
print(checkBrackets(string: "foo(bar[i)")) // 10
print(checkBrackets(string: "foo(bar[i])]")) // 12
print(checkBrackets(string: ")]")) // 1
print(checkBrackets(string: "foo(()")) // 4
