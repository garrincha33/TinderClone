
/*
 Stacks
 LIFO - last in first out, stacks are simple arrays
 with a rule around them that you can only remove the last item
 swift knows how much memory to allocate, it uses a stack pointer
 its a way of allocating memory
 */
import Foundation

struct Stack<Element> {
    private var array = [Element]() //making private to avoid type change
    //lets create a count
    var count: Int { array.count} //pass it down from the array nothing else todo
    var isEmpty: Bool { array.isEmpty } // again pass it down from the array nothing else todo
    //make a dedicated initilizer that an accepts an existing array into our stack
    //so we dont have to do this by hand, just copy in the items
    init(_ items: [Element]) {
        self.array = items
    }
    init() { } //also create an empty initiziler
    //no way of seeing the last item without poppig it off so create a peek function
    //just access the last item in the array, peek at the item pass it down from the array
    func peek() -> Element? {
        array.last
    }
    //popular functions for a stack push and pop
    mutating func push(_ element: Element) {
        array.append(element)
    }
    mutating func pop() -> Element? { //optional is safer here as the array might be empty
        array.popLast()
    }
}
//exporessable by array literal, allows us to assign an array what looks like
//an array directly to a stack, with no conversion costs
extension Stack: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Element...) {
        self.array = elements
    }
}
//you can also hide the values of your stack by creating a custom print statement using
extension Stack: CustomDebugStringConvertible {
    var debugDescription: String {
        var result = "["
        var first = true //first item parsed
        for item in array { //access the items if already at first then fine first is accessed
            if first {
                first = false
            } else {
                result += ", " //after first item accesed add a comma
            }
            debugPrint(item, terminator: "", to: &result) //use debug print to collate results
        }
        result += "]" //close off with a bracket and return results
        return result
    }
}

//conditional conformance introduced in swift 4.1
//you could implement a the sequence protcol but stacks are not really meant to be looped over
//lets use equatable, hasable and codeable (coded and decoded)

extension Stack: Equatable where Element: Equatable { }
extension Stack: Hashable where Element: Hashable { }
extension Stack: Decodable where Element: Decodable { }
extension Stack: Encodable where Element: Encodable { }
//we can now do the following

//equatable
let stackA = Stack([1,2,3])
let stackB = Stack([1,2,3])
print(stackA == stackB)

print(stackA)

var numbers = Stack<Int>()
//you can pass in an array directly which makes it easier to use on your stack
var numberArray: Stack = [1,2,3,4,5] //this isnt actually an array, but looks like one using above extension
print(numberArray)



//create a stack
struct AnotherStack<Element> {
    private var array = [Element]()
    
    var count: Int {array.count}
    var isEmpty: Bool {array.isEmpty}

    //initialzers
    init(_ items: [Element]) {
        self.array = items
    }
    init(){}
    //mutating functions
    
    mutating func pop() -> Element? {
        array.popLast()
    }
    
    mutating func push(_ element: Element) {
        array.append(element)
    }
    
    mutating func peek() -> Element? {
        array.last
    }
}

//extension AnotherStack: ExpressibleByNilLiteral {
//    init(arrayLitteral elements: Element...) {
//        self.array = elements
//    }
//}

extension AnotherStack: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Element...) {
        self.array = elements
    }
}

var numbersa = AnotherStack<Int>()
//you can pass in an array directly which makes it easier to use on your stack
var numberArrayy: AnotherStack = [1,2,3,4,5] //this isnt actually an array, but looks like one using above extension
print(numberArrayy)
