//: Playground - noun: a place where people can play

import UIKit
// 枚举和结构体

// 枚举
// 在swift中枚举，结构体也都有面向对象特性
//“enum SomeEnumeration {
//    // enumeration definition goes here
//}”
// 每个枚举定义都定义了一个新的类型，像swift中的其他类型一样，枚举类型也是已大写字母开头
enum CompassPoint {
    case North
    case South
    case East
    case West
}

enum Planet {
    case Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}


var directionToHead = CompassPoint.West
directionToHead = .East

directionToHead = .South
switch directionToHead {
case .North:
    print("Lots of planets have a north")
case .South:
    print("Watch out for penguins")
case .East:
    print("Where the sun rises")
case .West:
    print("Where the skies are blue")
}
// prints "Watch out for penguins”

// 枚举类型使用switch语句时可以不使用default语句, 这样就必须详尽地列举出每个成员，没有列举全或者超出了都不会编译
// 如果不想每个都列举就要加上default语句
let somePlanet = Planet.Earth
switch somePlanet {
case .Earth:
    print("Mostly harmless")
default:
    print("Not a safe place for humans")
}
// prints "Mostly harmless"

// 原始值和相关值
// 原始值可以是字符，字符串类型，或者任何基本数据类型， 每个枚举类的原始值都必须是唯一的
enum ASCIIControlCharacter: Character {
    case Tab = "\t"
    case LineFeed = "\n"
    case CarriageReturn = "\r"
}
// 将Int作为原始值的时候，只要确认一个，其它会被隐式赋值
enum Planet1: Int {
    case Mercury = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}
// 如果将String作为原始值，每个成员的值会被隐式赋值为他们的名字
enum Compasspoint:String{
    case North, South, East, West
}
Compasspoint.East
// 可以通过枚举成员的rawValue属性得到成员的原始值
let earthOrder = Planet1.Earth.rawValue

let sunsetDirection = Compasspoint.West.rawValue

// 通过原始值对常量或者变量进行初始化
let possiblePlanet = Planet1(rawValue: 7)
// 初始化的结果可能为nil
let positionToFind = 9
if let somePlanet = Planet1(rawValue: positionToFind) {
    switch somePlanet {
    case .Earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans")
    }
} else {
    print("There isn't a planet at position \(positionToFind)")
}


enum Barcode {
    case UPCA(Int, Int, Int, Int)
    case QRCode(String)
}
var productBarcode = Barcode.UPCA(8, 85909, 51226, 3)
productBarcode = .QRCode("ABCDEFGHIJKLMNOP")
switch productBarcode {
case .UPCA(let numberSystem, let manufacturer, let product, let check):
    print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check).")
case .QRCode(let productCode):
    print("QR code: \(productCode).")
}
// prints "QR code: ABCDEFGHIJKLMNOP."

// 递归枚举
// 一个包含算术表达式的递归枚举
indirect enum ArithmeticExpression {
    case Number(Int)
    case Addition(ArithmeticExpression, ArithmeticExpression)
    case Multiplication(ArithmeticExpression, ArithmeticExpression)
}

// 结构体
// swift 的结构体除了可以定义一组相关的成员变量，还可以定义成员方法，被看作是一个轻量级的类
// swift 的类和结构体非常相似，都具有定义和使用成员、方法、下标和构造器等面向对象特性，但是结构体不具有继承性，也不具有运行时强制类型转换、使用析构器和使用引用计等能力
// 类和结构体
struct Resolution {
    var width = 0
    var height = 0
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}
// 类和结构体的实例
let someResolution = Resolution()
let someVideoMode = VideoMode()

// 枚举和结构体都是值类型，想让它向引用类型一样使用，需要加上output关键字


// 可选类型和可选链
// 有时候我们使用一个变量或者常量，它保存的值可能有也有可能没有，例如：
func divide(n1: Int, n2: Int) -> Double?{
    if(n2 == 2){
        return nil
    }
    return Double(n1)/Double(n2)
}
let result : Double? = divide(100, n2: 200)
print(result)

// 在第二个参数为0的情况下，函数返回nil，所以函数返回值要么有，要么为nil，为了接受这种不确定的返回值，我们许啊哟在类型后面加上？， 表示该类型是可选类型

// 1.可选绑定：可选类型在if或while语句中赋值并进行判断的写法，叫做可选绑定
if let result2 : Double? = divide(100, n2: 0){
    print("Success.")
    
}else{
    print("failure.")
}

// 强制拆封
// 如果我们能确定可选类型一定有值，那么在读取它的时候，可以在可选类型的后面加一个感叹号（！）来获取该值
let result3 :Double? = divide(100, n2: 200)
print(result3!)

// 隐式拆封, 在常量或者变量声明的时候，数据类型Double后面跟的事感叹号（！）而不是问号（？），在拆封的时候后面不加（！），这就是隐式拆封
let result4: Double! = divide(100, n2: 200)
print(result4)

