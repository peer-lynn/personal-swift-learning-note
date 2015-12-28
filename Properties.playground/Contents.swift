//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

// 属性
// 存储属性， 计算属性
// 存储属性：类和结构体  延迟存储属性 lazy关键字
// 计算属性：类、结构体和枚举

// swift类在创建时每个属性需要给定默认值，否则初始化不成功
class Employee {
    // 存储属性
    var firstName : String = "Tony"
    var lastName :String = "Guan"
    var no : Int = 0
    
    // 计算属性
    var fullName : String{
        get{
            return firstName + "." + lastName
        }
        set(newFullName){
            var name = newFullName.componentsSeparatedByString(".")
            firstName = name[0]
            lastName = name[1]
        }
        // 另一个set写法，使用swift分配的默认的参数：newValue
//        set{
//            var name = newValue.componentsSeparatedByString(".")
//            firstName = name[0]
//            lastName = name[1]
//        }
    }
}

var emp = Employee()
// 自动调用get
print(emp.fullName)

// 自动调用set
emp.fullName = "Amenda.Lynn"
print(emp.fullName)

// 只读计算属性：只有getter访问器。没有setter访问器
// 只读计算属性不仅不写setter访问器，而且getter访问器也可以省略
class Employee1 {
    // 存储属性
    var firstName : String = "Tony"
    var lastName :String = "Guan"
    var no : Int = 0
    
    // 只读计算属性
    var fullName : String{
        return firstName + "." + lastName
    }
}

// 结构体和枚举中的计算属性
struct Department{
    var no:Int
    var name : String
    var fullName : String{
        return "Swift." + name + " .D "
    }
}

enum WeekDays : String{
    case Monday = "Mon."
    case Tuesday = "Tue."
    case Wednesday = "Wed."
    case Thursday = "Thu."
    case Friday = "Fri."
    
    var message : String{
        return "Today is " + self.rawValue
    }
}

var day = WeekDays.Monday
print(day.message)

// 属性观察者主要有以下两个: willSet:观察者在属性修改之前调用  didSet：观察者在属性修改之后调用
// 除了延迟存储属性，可以给任何一个存储属性添加一个属性观察者
// 另外也可以通过覆盖在子类中给任何一个继承的属性添加属性观察者，（不管是存储属性还是计算属性）
// 没有必要给没有覆盖的计算属性定义属性观察者，因为可以通过计算属性的setter访问器观察和相应变化
class EmployeeObserve {
    // 存储属性
    var firstName : String = "Tony"
    var lastName :String = "Guan"
    var salary : Int = 0 {
        willSet(newSalary){
            print("员工工资新值 + \(newSalary)")
        }
        didSet(oldSalary){
            print("员工工资旧值 + \(oldSalary)")
        }
    }
    var dept: Department?
}

struct department {
    var no : Int = 0{
        willSet{
            print("部门编号新值 + \(newValue)")
        }
        
        didSet{
            print("部门编号旧值 + \(oldValue)")
        }
    }
}

var empObserve = EmployeeObserve()
var salary = empObserve.salary
empObserve.salary = 100

var dep = department()
dep.no = 200



// 存储类属性和计算类属性语法
struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    
   }
}
enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6
    }
}
class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
        
    }
    
    // 计算类属性使用class关键字表示可以被子类覆盖
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}

// 在实例方法内修改值类型： 关键字： mutating
// mutating 关键字在他的定义允许修改属性：另外，注意不能通过调用mutating方法修改一个结构体的常量，因为他的属性值是不允许被改变的
struct Point {
    var x = 0.0, y = 0.0
    mutating func moveByX(deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}
var somePoint = Point(x: 1.0, y: 1.0)
somePoint.moveByX(2.0, y: 3.0)
print("The point is now at (\(somePoint.x), \(somePoint.y))")
// prints "The point is now at (3.0, 4.0)”

// 这个是不允许的
//let fixedPoint = Point(x: 3.0, y: 3.0)
//fixedPoint.moveByX(2.0, y: 3.0)


// 在matuting 方法内部赋值给self
struct Point2{
    var x = 0.0, y = 0.0
    mutating func moveByX(deltaX: Double, y deltaY:Double){
        self = Point2(x: x + deltaX, y: y + deltaY)
    }
}

// 枚举类型
enum TriStateSwitch {
    case Off, Low, High
    mutating func next() {
        switch self {
        case Off:
            self = Low
        case Low:
            self = High
        case High:
            self = Off
        }
    }
}
var ovenLight = TriStateSwitch.Low
ovenLight.next()
// ovenLight is now equal to .High
ovenLight.next()
// ovenLight is now equal to .Off
ovenLight.next()


// 下标: 类、结构体、枚举类型都可以定义下标通过关键字：subscript
//Subscript Syntax
//Subscripts enable you to query instances of a type by writing one or more values in square brackets after the instance name. Their syntax is similar to both instance method syntax and computed property syntax. You write subscript definitions with the subscript keyword, and specify one or more input parameters and a return type, in the same way as instance methods. Unlike instance methods, subscripts can be read-write or read-only. This behavior is communicated by a getter and setter in the same way as for computed properties:
class subcript{
subscript(index: Int) -> Int {
    get {
        // return an appropriate subscript value here
        return 1
    }
    set(newValue) {
        // perform a suitable setting action here
    }
    }
    
    //只读下标的语法
//    subscript(index: Int) -> Int {
//        // return an appropriate subscript value here
//    }
}
// swift中的字典， 通过下标实现访问和修改的栗子
var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
numberOfLegs["bird"] = 2

// 实现矩阵结构体
struct Metix{
    let rows: Int, columns:Int
    var grid: [Double]
    init(rows: Int, columns: Int){
        self.rows = rows
        self.columns = columns
        grid = Array(count: rows * columns, repeatedValue: 0.0)
    }
//
    func indexIsValidForRow(row: Int, column: Int) -> Bool{
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    subscript(row: Int, column: Int) -> Double{
        get{
            // 使用断言
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            // grid 是一维数组
            return grid[(row * columns) + columns]
        }
        
        set{
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            //
            grid[(row * columns) + column] = newValue
            
        }
    }
}
var matrix = Metix(rows: 2, columns: 2)
//var matrix = Metix()
print(matrix)
matrix[1,1] = 2.9
matrix[0,1] = 3.6
print(matrix)
