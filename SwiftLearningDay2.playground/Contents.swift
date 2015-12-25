//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

// 闭包
// 支持闭包需要满足两个条件：
//一是要支持函数类型，函数能够作为参数或者返回值传递
//二是要支持函数嵌套

// 嵌套函数
func calculate(oprator: String) -> (Int, Int) -> Int{
    
    func add(n1: Int, n2: Int) -> Int{ return n1 + n2}
    func sub(n1: Int, n2: Int) -> Int{ return n1 - n2}
    
    var result : (Int, Int) -> Int
    switch(oprator){
        case "+":
        result = add
        case "-":
        result = sub
    default:
        result = add
    }
    
    return result
}

// 闭包写法
func calculate1(oprator: String) -> (Int, Int) -> Int{
    
    var result : (Int, Int) -> Int
    switch(oprator){
    case "+":
        result = {(n1: Int, n2: Int) -> Int in return n1 + n2}
    case "-":
        result = {(n1: Int, n2: Int) -> Int in return n1 - n2}
    default:
        result = {(n1: Int, n2: Int) -> Int in return n1 + n2}
    }
    
    return result
}

// 闭包是自包含的匿名函数代码块，可以作为表达式、函数参数和函数返回值
// 闭包表达是的运算结果是一种函数类型
// swift的闭包可以捕获和存储其所在上下文环境肿得常量和变量。

//Closure expression syntax has the following general form:
//
//{ (parameters) -> return type in
//    statements
//}


// 使用闭包返回值
// 闭包表达式本质上是函数类型，是有返回值的
// 闭包表达式不能赋值给c1，因为c1是int型的，二是要将闭包表达是的值赋值给c1,因此应该在后面加上圆括号并输入相应的参数，为闭包传递相应的参数。
let c1: Int = {(a:Int, b:Int) -> Int in return a+b}(10, 5)
print(c1)

// 使用尾随表达式的条件：最后一个参数是闭包表达式的可以使用闭包尾随表达式
let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]

// 系统定义的闭包使用
let strings = numbers.map {
    (var number) -> String in
    var output = ""
    while number > 0 {
        output = digitNames[number % 10]! + output
        number /= 10
    }
    return output
}
print(strings)

// 尾随闭包示例代码
func calculate(opr: String, funN: (Int, Int) -> Int){
    switch (opr){
        case "+":
        print("10+5 = \(funN(10, 5))")
        default:
        print("10 + 5 = \(funN(10,5))")
    }
}
calculate("+", funN: {(a: Int, b: Int) -> Int in return a+b})
// 尾随闭包是一个书写在函数括号之后的闭包表达式，函数支持将其作为最后一个参数调用
calculate("-") { (a, b) -> Int in return a-b}
calculate("-") { (a, b) -> Int in
    12 + 6
}
calculate("+") { (a, b) -> Int in
    10
}

// 捕获上下文的变量和常量
// 嵌套函数或闭包可以访问它所在的上下文的常量和变量，这个过程成为“捕获值”，即便是定义这些常量或者变量的原始作用域已经不存在，嵌套函数或闭包任然可以在函数体内或闭包体内引用和修改这些值

//这个函数包含一个嵌套函数，的返回值类型不是一个普通类型，而是一个函数，这个函数没有参数，返回值是Int类型
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int { // 捕获runningTotal 和 amount 的值
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

var incrementByTwelve = makeIncrementer(forIncrement: 12)
incrementByTwelve()
incrementByTwelve()
incrementByTwelve()

// 如果你重新创建一个 增值函数， 就会产生一个他自己全新的独有的引用
// incrementBySeven 和 incrementByTwelve 是 函数makeIncrementer的不同实例，他们的运行结果是相互独立的
var incrementBySeven = makeIncrementer(forIncrement: 7)
incrementBySeven()
// 这两个值不会相互影响
incrementByTwelve()
// 函数和闭包都是引用类型。不论什么时候你将一个函数或者闭包复制给一个变量或者常量，实际上都是将这个变量或者常量设置为了函数或者闭包的引用

// 这也意味着如果你将一个闭包传递给两个不同的常量或变量，那么他们指向同一个引用
var alsoIncrementBySeven = incrementBySeven
alsoIncrementBySeven()




