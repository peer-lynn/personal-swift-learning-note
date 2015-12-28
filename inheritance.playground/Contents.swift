//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

// 继承 和 初始化
// swift的继承和其他的很像
class Person{
    var name :String = "laoyang"
    var age : Int = 40
    
    var descrip : String{
        return "\(name) 的年龄是 \(age)"
    }
    
    init(name : String, age:Int){
        self.name = name
        self.age = age
    }
}

class Student : Person {
    var school: String = ""
    
    override var age : Int{
        willSet{
            print("学生的年龄新值： \(newValue)")
        }
        
        didSet{
            print("学生的年龄旧值： \(oldValue)")
        }
    }
    
    // 便利构造器，也叫引用类型构造器横向代理
    convenience init(){
        self.init(name:"Tony", age: 18, school: "qinghua university")
        
    }
    
    init(name:String, age:Int, school:String){
        self.school = school
        super.init(name: name, age: age)
    }
}

// 初始化
// 为存储属性设置初始值，存储属性一般在定义的时候初始化，如果不能确定初始值，可以采用可选类型属性
// 构造器的主要作用就是初始化存储属性，在init（）构造器中初始化存储属性后就不需要在定义他们时初始化
// 存储属性如果在构造器和定义时都没有初始化，会发生编译错误

struct Fahrenheit {
    var temperature:Double
    init(){
        temperature = 32.0
    }
}

var f = Fahrenheit()
print("The default temperature is \(f.temperature) Fahrenheit")
// 更好的方式
struct Fahrenheit1 {
    var temperature = 32.0
}

// 构造器代理
// 值类型构造器代理（结构和枚举）self.init
struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    init() {}
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        // 值类型构造器代理
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

// 类类型构造器代理
//“A simple way to remember this is:
//
//Designated initializers must always delegate up.
//Convenience initializers must always delegate across.
class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}
let namedMeat = Food(name: "Bacon")


class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}

// 失败初始化器
struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty { return nil }
        self.species = species
    }
}


let someCreature = Animal(species: "Giraffe")
// someCreature is of type Animal?, not Animal

if let giraffe = someCreature {
    print("An animal was initialized with a species of \(giraffe.species)")
}
// prints "An animal was initialized with a species of Giraffe”

let anonymousCreature = Animal(species: "")
// anonymousCreature is of type Animal?, not Animal

if anonymousCreature == nil {
    print("The anonymous creature could not be initialized")
}
// prints "The anonymous creature could not be initialized"

// 枚举类失败构造器
enum TemperatureUnit {
    case Kelvin, Celsius, Fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .Kelvin
        case "C":
            self = .Celsius
        case "F":
            self = .Fahrenheit
        default:
            return nil
        }
    }
}

let fahrenheitUnit = TemperatureUnit(symbol: "F")
if fahrenheitUnit != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}
// prints "This is a defined temperature unit, so initialization succeeded."

let unknownUnit = TemperatureUnit(symbol: "X")
if unknownUnit == nil {
    print("This is not a defined temperature unit, so initialization failed.")
}
// prints "This is not a defined temperature unit, so initialization failed.”


