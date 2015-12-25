//: Playground - noun: a place where people can play

import UIKit
//swift学习：第一天

// 定义常量， 使用let关键字
let _HELLO = "HELLO"
let PI = 3.14159

var al: Int = 10; var a3:Int = 20

// 变量的定义：可自己指定类型
var num1:Int = 800006
var num2:Int
num2 = num1 % 10000

var a:String = "123"
var b:String = "123"
a = b
// 不能使用 “===”
print(a == b)

var fruits: Array<String>
fruits = ["apple", "purple", "banana"]

for fruit in fruits{
    print(fruit)
}

// 定义数组
var studentList: [String] = ["张三", "李四", "王武", "周黎明"]
print(studentList)

// 数组的使用
studentList.append("柳永")

studentList += ["lynn",  "Lisa"]

studentList.insert("韩梅梅", atIndex: 2)

studentList.insert("刘备", atIndex: 0)

studentList.removeAtIndex(0)

print(studentList)

for stu in studentList{
    print(stu)
}

// 字典
var students = [100: "Mary", 101: "July"]

var student1 = Dictionary<Int, String>()

students[103] = "Liu"

print(students)

students[102] = "Mary"

var dismisStudent = students.removeValueForKey(100)

print(dismisStudent)

students[101] = nil
print(students)

for studentId in students.values{
    print("studnetId: \(studentId)")
}

for student in students{
    print(student)
}

student1 = students

print(student1 == students)



var all = ["lily", "mary", "Coll"]

var bell = all
var c = all

all[0] = "Liu"
all
bell
all[0...2] = ["Lisa", "Babana", "Kitty", "Mendy"]
all

// 使用enumerate方法，这个方法返回一个包含了每一项的下标和值的元组（tuple）
for(index, value) in all.enumerate(){
    print("item \(index + 1): \(value)")
}


var ages = ["zhangsan": 23]
var copyages = ages
copyages["zhangsan"] = 24
print(ages["zhangsan"])


class Employee{
    var name: String
    var salary: Double
    init (n: String){
        name = n
        salary = 0
    }
}

// 变量
var employees: Dictionary<String, Employee> = Dictionary<String, Employee>()
var emp1 = Employee(n: "Mary")
var emp2 = Employee(n: "July")

let emp3 = Employee(n: "Lisa")

employees["124-121"] = emp1
employees["124-122"] = emp2
employees["124-123"] = emp3

var copyEmps = employees
let copyEmp : Employee! = copyEmps["124-122"]
copyEmp.name = "Steve Jobs"
let emp : Employee! = employees["124-122"]
print(emp.name)

func increment(inout value: Double, amount: Double = 1.0){
    value += amount
}

var value: Double = 10
increment(&value)
increment(&value, amount: 100.0)
print(value)


// 函数
// 外部参数名： swift调用时默认省略第一个参数名，并把第二个和随后的内部参数名作为外部参数名，如果不想
// 让第二个和随后的外部参数名，可使用下划线取消显示
//函数类型：每个函数都有一个类型
//函数类型和其他数据类型一样，可以声明变量或常量，也可以作为其他函数的参数或者返回值使用

// 定义长方形面积计算函数
func rectangleArea(width: Double, height: Double) -> Double{
    let area = width * height
    return area
}

//定义计算三角形面积函数
func triangleArea(bottom:Double, _ height:Double) ->Double{
    let area = bottom * height/2
    return area
}

// 这两个函数的函数类型都是(Double, Double) -> Double

// 定义一个计算面积的函数
func getArea(type: String) -> (Double, Double) -> Double{
    var returnFunction: (Double, Double) -> Double
    switch(type){
        case "rect":
        returnFunction = rectangleArea
        case "tria":
        returnFunction = triangleArea
    default:
        returnFunction = rectangleArea
    }
    
    return returnFunction
}

// 获得计算三角形面积的函数
var function: (Double, Double)->Double = getArea("tria")

print("底10 高15，三角形面积：\(function(10,15))")

function = getArea("rect")
print("长10 宽15，长方形面积：\(function(10, 15))")

var function1 = triangleArea
function1(12, 10)


//
func makeCoffee(type type : String = "卡布奇诺") ->String{
    return "制作一杯\(type)咖啡!"
}

makeCoffee()
makeCoffee(type: "拿铁")

// 函数重载
func oubpunNum(value: Int8){
    
}

func outpunNum(value:Double){
    print("print numble\(value)")
}

func outpunNum(value : Double, integg : Int8) -> Double{
    return value;
}

outpunNum(1.2, integg: 1)

var b1  = outpunNum(10)
var b2 = outpunNum(10, integg: 2)

// 函数类型作为返回值使用
func stepBackward(input :Int) -> Int{
    return input - 1
}

func stepForward(num :Int) -> Int{
    return num + 1
}

func chooseStepFunction(backwards: Bool) -> (Int) -> Int{
    return backwards ? stepBackward : stepForward
}

var currentValue = 3
let moveNearerToZero = chooseStepFunction(currentValue > 0)
print("Counting to zero:")
// Counting to zero:
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}
print(currentValue)

// 范型函数
func isEqual<T : Comparable> (a:T, b:T) -> Bool{
    return a==b
}

var str1 = "abc1"
var str2 = "abc1"
print(isEqual(str1, b: str2))

var d1 = 2.0
var d2 = 2.0
print(isEqual(d1, b: d2))




