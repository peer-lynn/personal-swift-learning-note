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

// 类类型构造器代理分为横向代理和向上代理，横向代理只能发生在同一类内部，这种构造器称为便利构造器。向上代理发生在继承的情况下，在子类构造过程中，要先调用父类构造器初始化父类的存储属性，这种构造器成为指定构造器
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

// 构造器调用规则：1，指定构造器必须调用其直接父类的指定构造器；2，便利构造器必须调用同一类中定义的其他构造器；3，便利构造器必须最终以调用一个指定构造器结束
// 构造器继承 swift中的子类构造器的来源有两种: 自己编写和从父类继承。并不是所有构造器都能自动继承下来，能够从父类继承下来的构造器是有条件的，1，如果子类没有定义任何指定构造器，它将自动继承所有父类的指定构造器，2，如果子类提供了所有父类指定构造器的实现，无论是从条件1继承过来的，还是通过自己编写实现的，它都将自动继承所有父类的便利构造器

// 重写
// swift中的重写包括属性重写，方法重写和下标重写，不论是那一类重写都需要在原来的定义前加上override
// 属性重写: 一方面可以重写getter 和setter 访问器，另一方面可以重写属性观察者
class Person1{
    var name : String
    var age: Int
    
    func description() -> String{
        return "\(name) 年龄是： \(age)"
    }
    
    init(name: String, age : Int){
        self.name = name
        self.age = age
    }
}

class Student1: Person1 {
    var school : String
    
    // 从属性重写可见，子类本身并不存储数据，数据是存在父类的存储属性中的
    override var age : Int{
        get{
            return super.age
        }
        
        set{
            super.age = newValue < 8 ? 8 : newValue
        }
        //属性观察者不能和getter setter 访问器同时重写，另外常量属性和计算属性都不能重写观察者
//        willSet{
//            print("年龄新值： \(newValue)")
//        }
    }
    
    convenience init(){
        self.init(name : "Tony", age: 18, school : "清华大学")
    }
    
    init(name : String, age: Int, school: String){
        self.school = school
        super.init(name: name, age: age)
    }
}

// 方法重写： 我们可以在子类中重写从父类继承来的实例方法和静态方法（在静态方法中不能访问实例属性）
// 下标重写， 也是重写下标的getter 和 setter 访问器

// 类型检查与转换
// is 和 as
// is 可以判断一个实例是否是某个类的类型， 如果是目标类型则返回true， 否则返回FALSE
// as? 操作符将元素转换为某个类型，如果转换成功，则把元素赋值给类变量，如果失败，则把nil赋值给变量
// Any 和 AnyObject
// AnyObject 可以表示任何类的实例 
// Any 可以表示任何类型，包括基本数据类型


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

