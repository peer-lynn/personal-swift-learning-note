//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

// 扩展， 扩展可以给一个已存在的类，结构体，枚举或者协议类型添加新的功能。swift中的扩展可以1,添加计算属性和计算类属行；2，定义实例方法和类方法；3，提供新的构造器；4，定义下标；5，定义和使用新的内嵌类型；6，使已存在的类型遵守某个协议
// 扩展没有自己的名字
class Student{
    
}

protocol someProtocol{
    
}

// 扩展的语法
extension Student{
    
}

extension Student:someProtocol{
    
}

// 扩展计算属性： 扩展可以给指定的类型添加计算实例属性和计算类属性,但是不能添加存储属性，和给已经存在的属性添加属性观察者
// 扩展计算实例属性
extension Double{
    var km:Double{
        return self * 1000.0
    }
    
    var m: Double{
        return self
    }
    
    var cm:Double{
        return self/100
    }
    
    var mm: Double{
        return self / 1000.0
    }
    
    var ft : Double{
        return self/3.28084
    }
}

let oneInch = 25.4.mm
print("One inch is \(oneInch) meters")

let threeFeet = 3.ft
print("three feet is \(threeFeet) meters")

// 扩展构造器



// 协议 和JAVA中的接口类似
//  协议方法： 实例协议方法 和 静态协议方法（class）
// 变异方法：在结构体和枚举类型中，可以定义变异方法，而在类中没有这种方法，原因是结构体和枚举类型中的属性是不可以修改的，通过定义变异方法，可以再变异方法中修改这些属性。而类是引用类型，不需要变异方法就可以修改自己的属性
// 在协议中定义变异方法是，方法前面要mutating关键字。 类、结构体和枚举类型都可以实现变异方法，类实现变异方法时，前面不需要加mutating

// 实例协议属性
protocol Person{
    var firstName: String{ get set}
    var lastName: String{get set}
    var fullName: String{get}
}

class Worker: Person {
    var firstName : String = "Tom"
    var lastName : String = "Hony"
    
    var fullName : String = "thi"
}

class Employee : Person {
    var firstName : String = "chen"
    var lastName :String = "yan"
    var fullName : String {
        get{
            return "\(firstName) \(lastName)"
        }
    }
}

class Stud : Person{
    var firstName : String{
        get{
            return "\(self)"
        }
        set{
            
        }
    }
    var lastName : String{
        get{
            return "\(self)"
        }
        set{
            
        }
    }
    var fullName: String{
        get{
            return "\(self)"
        }
    }
}

// 协议可以要求起遵守者实现某些指定属性，包括实例属性和静态属性，在具体定义时，每一种属性都可以有只读和读写之分
// 对于协议的遵守这而言，实现属性石非常灵活的。无论是存储属性还是计算属性，只要能满足协议属性的要求，就可以通过编译。甚至是协议中只规定了只读属性，而遵守者提供了对该属性读写的实现，这也是被允许的。协议只规定了遵守者必须要做的事情，但没有规定不能做的事情。

// 静态协议属性： 加上static关键字，遵守者是类：关键字可以是是class或static，遵守者是结构体和枚举，关键字就是static
protocol Account{
    static var interestRate : Double{get}
    static func interestBy(amount : Double) -> Double
}

class ClassImp: Account {
    static var interestRate : Double {
        return 0.668
    }
    
    class func interestBy(amount: Double) -> Double {
        return ClassImp.interestRate * amount
    }
}

struct StructImp : Account {
    static var interestRate : Double = 0.668
    static func interestBy(amount: Double) -> Double {
        return StructImp.interestRate * amount
    }
}

enum EnumImp : Account {
    static var interestRate : Double = 0.668
    static func interestBy(amount: Double) -> Double {
        return StructImp.interestRate * amount
    }
}






