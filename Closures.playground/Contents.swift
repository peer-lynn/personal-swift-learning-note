//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//: 重点学习闭包（closures）
//:闭包是自包含的函数代码块，可以在代码中被传递和使用。Swift 中的闭包与 C 和 Objective-C 中的代码块（blocks）以及其他一些编程语言中的匿名函数比较相似。

//:闭包可以捕获和存储其所在上下文中任意常量和变量的引用。这就是所谓的闭合并包裹着这些常量和变量，俗称闭包。Swift 会为您管理在捕获过程中涉及到的所有内存操作。

/*:
在函数章节中介绍的全局和嵌套函数实际上也是特殊的闭包，闭包采取如下三种形式之一：
* 全局函数是一个有名字但不会捕获任何值的闭包
* 嵌套函数是一个有名字并可以捕获其封闭函数域内值的闭包
* 闭包表达式是一个利用轻量级语法所写的可以捕获其上下文中变量或常量值的匿名闭包
*/

/*:
Swift 的闭包表达式拥有简洁的风格，并鼓励在常见场景中进行语法优化，主要优化如下：
* 利用上下文推断参数和返回值类型
* 隐式返回单表达式闭包，即单表达式闭包可以省略return关键字
* 参数名称缩写
* 尾随（Trailing）闭包语法
*/

/*:闭包表达式语法（Closure Expression Syntax）

闭包表达式语法有如下一般形式：
    
    { (parameters) -> returnType in
        statements
    }
*/

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
var reversed = names.sort({ (s1: String, s2: String) -> Bool in
return s1 > s2
})

reversed = names.sort( { (s1: String, s2: String) -> Bool in return s1 > s2 } )

/*:
根据上下文推断类型（Inferring Type From Context）

因为排序闭包函数是作为sort(_:)方法的参数传入的，Swift 可以推断其参数和返回值的类型。sort(_:)方法被一个字符串数组调用，因此其参数必须是(String, String) -> Bool类型的函数。这意味着(String, String)和Bool类型并不需要作为闭包表达式定义的一部分。因为所有的类型都可以被正确推断，返回箭头（->）和围绕在参数周围的括号也可以被省略：
*/
reversed = names.sort( { s1, s2 in return s1 > s2 } )
/*:
实际上任何情况下，通过内联闭包表达式构造的闭包作为参数传递给函数或方法时，都可以推断出闭包的参数和返回值类型。 这意味着闭包作为函数或者方法的参数时，您几乎不需要利用完整格式构造内联闭包。

尽管如此，您仍然可以明确写出有着完整格式的闭包。如果完整格式的闭包能够提高代码的可读性，则可以采用完整格式的闭包。而在sort(_:)方法这个例子里，闭包的目的就是排序。由于这个闭包是为了处理字符串数组的排序，因此读者能够推测出这个闭包是用于字符串处理的。
*/

/*:
单表达式闭包隐式返回（Implicit Return From Single-Expression Clossures）

单行表达式闭包可以通过省略return关键字来隐式返回单行表达式的结果，如上版本的例子可以改写为：
*/
reversed = names.sort( { s1, s2 in s1 > s2 } )
/*:在这个例子中，sort(_:)方法的第二个参数函数类型明确了闭包必须返回一个Bool类型值。因为闭包函数体只包含了一个单一表达式（s1 > s2），该表达式返回Bool类型值，因此这里没有歧义，return关键字可以省略。
*/

/*:参数名称缩写（Shorthand Argument Names）

Swift 自动为内联闭包提供了参数名称缩写功能，您可以直接通过$0，$1，$2来顺序调用闭包的参数，以此类推。

如果您在闭包表达式中使用参数名称缩写，您可以在闭包参数列表中省略对其的定义，并且对应参数名称缩写的类型会通过函数类型进行推断。in关键字也同样可以被省略，因为此时闭包表达式完全由闭包函数体构成：
*/
reversed = names.sort( { $0 > $1 } )
/*: 在这个例子中，$0和$1表示闭包中第一个和第二个String类型的参数。

运算符函数（Operator Functions）

实际上还有一种更简短的方式来撰写上面例子中的闭包表达式。Swift 的String类型定义了关于大于号（>）的字符串实现，其作为一个函数接受两个String类型的参数并返回Bool类型的值。而这正好与sort(_:)方法的第二个参数需要的函数类型相符合。因此，您可以简单地传递一个大于号，Swift 可以自动推断出您想使用大于号的字符串函数实现：
*/
reversed = names.sort(>)

//: 尾随闭包（Trailing Closures）
//: 如果您需要将一个很长的闭包表达式作为最后一个参数传递给函数，可以使用尾随闭包来增强函数的可读性。尾随闭包是一个书写在函数括号之后的闭包表达式，函数支持将其作为最后一个参数调用：
/*:
func someFunctionThatTakesAClosure(closure: () -> Void) {
// 函数体部分
}

// 以下是不使用尾随闭包进行函数调用
someFunctionThatTakesAClosure({
// 闭包主体部分
})

// 以下是使用尾随闭包进行函数调用
someFunctionThatTakesAClosure() {
// 闭包主体部分
}
*/

/*:
在闭包表达式语法一节中作为sort(_:)方法参数的字符串排序闭包可以改写为：
*/
reversed = names.sort() { $0 > $1 }
/*:如果函数只需要闭包表达式一个参数，当您使用尾随闭包时，您甚至可以把()省略掉：
*/
reversed = names.sort { $0 > $1 }

//:当闭包非常长以至于不能在一行中进行书写时，尾随闭包变得非常有用。举例来说，Swift 的Array类型有一个map(_:)方法，其获取一个闭包表达式作为其唯一参数。该闭包函数会为数组中的每一个元素调用一次，并返回该元素所映射的值。具体的映射方式和返回值类型由闭包来指定。

//:当提供给数组的闭包应用于每个数组元素后，map(_:)方法将返回一个新的数组，数组中包含了与原数组中的元素一一对应的映射后的值。

//:下例介绍了如何在map(_:)方法中使用尾随闭包将Int类型数组[16, 58, 510]转换为包含对应String类型的值的数组["OneSix", "FiveEight", "FiveOneZero"]：
var digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
digitNames[0] = "O"
print(digitNames[6])
digitNames[0] = "Zero"

let numbers = [16, 58, 510]
let strings = numbers.map(){
    (var number) -> String in
    var output = ""
    while number > 0{
        output = digitNames[number % 10]! + output
        number /= 10
    }
    return output
}

print(strings[0])

/*:
map(_:)为数组中每一个元素调用了闭包表达式。您不需要指定闭包的输入参数number的类型，因为可以通过要映射的数组类型进行推断。

在该例中，闭包number参数被声明为一个变量参数（变量的具体描述请参看常量参数和变量参数），因此可以在闭包函数体内对其进行修改，而不用再定义一个新的局部变量并将number的值赋值给它。闭包表达式指定了返回类型为String，以表明存储映射值的新数组类型为String。
*/

//: 注意
//: 字典digitNames下标后跟着一个叹号（!），因为字典下标返回一个可选值（optional value），表明该键不存在时会查找失败。在上例中，由于可以确定number % 10总是digitNames字典的有效下标，因此叹号可以用于强制解包 (force-unwrap) 存储在下标的可选类型的返回值中的String类型的值。



//: 捕获值（Capturing Values）
//: 闭包可以在其被定义的上下文中捕获常量或变量。即使定义这些常量和变量的原作用域已经不存在，闭包仍然可以在闭包函数体内引用和修改这些值。

//:Swift 中，可以捕获值的闭包的最简单形式是嵌套函数，也就是定义在其他函数的函数体内的函数。嵌套函数可以捕获其外部函数所有的参数以及定义的常量和变量。

func makeIncrement(forIncrement amount: Int) -> () ->Int{
    var total = 0
    func incrementor() -> Int{
        total += amount
        return total
    }
    
    return incrementor
}

let incrementor = makeIncrement(forIncrement: 7)
incrementor()
incrementor()

//:如果您创建了另一个incrementor，它会有属于它自己的一个全新、独立的total变量的引用：
let incrementByTwo = makeIncrement(forIncrement: 2)
incrementByTwo()
incrementByTwo()

incrementor()

//:闭包是引用类型（Closures Are Reference Types）
//:上面的例子中，incrementor和incrementByTwo是常量，但是这些常量指向的闭包仍然可以增加其捕获的变量的值。这是因为函数和闭包都是引用类型。

//:无论您将函数或闭包赋值给一个常量还是变量，您实际上都是将常量或变量的值设置为对应函数或闭包的引用。上面的例子中，指向闭包的引用incrementByTwo是一个常量，而并非闭包内容本身。

//:这也意味着如果您将闭包赋值给了两个不同的常量或变量，两个值都会指向同一个闭包：


//:非逃逸闭包(Nonescaping Closures)
//:当一个闭包作为参数传到一个函数中，但是这个闭包在函数返回之后才被执行，我们称该闭包从函数中逃逸。当你定义接受闭包作为参数的函数时，你可以在参数名之前标注@noescape，用来指明这个闭包是不允许“逃逸”出这个函数的。将闭包标注@noescape能使编译器知道这个闭包的生命周期（译者注：闭包只能在函数体中被执行，不能脱离函数体执行，所以编译器明确知道运行时的上下文），从而可以进行一些比较激进的优化。



//:自动闭包（Autoclosures）
//:自动闭包是一种自动创建的闭包，用于包装传递给函数作为参数的表达式。这种闭包不接受任何参数，当它被调用的时候，会返回被包装在其中的表达式的值。这种便利语法让你能够用一个普通的表达式来代替显式的闭包，从而省略闭包的花括号。

//:我们经常会调用一个接受闭包作为参数的函数，但是很少实现那样的函数。举个例子来说，assert(condition:message:file:line:)函数接受闭包作为它的condition参数和message参数；它的condition参数仅会在 debug 模式下被求值，它的message参数仅当condition参数为false时被计算求值。

//:自动闭包让你能够延迟求值，因为代码段不会被执行直到你调用这个闭包。延迟求值对于那些有副作用（Side Effect）和代价昂贵的代码来说是很有益处的，因为你能控制代码什么时候执行。下面的代码展示了闭包如何延时求值。
var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)

let customerProvider = { customersInLine.removeAtIndex(0)}
print(customersInLine.count)

let deleteCustomer = customerProvider()

print(customersInLine)

//: 注意：
//:customerProvider的类型不是String，而是() -> String


//:将闭包作为参数传递给函数时，你能获得同样的延时求值行为。

func serveCustomer(customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}
serveCustomer( { customersInLine.removeAtIndex(0) } )
// prints "Now serving Alex!"







