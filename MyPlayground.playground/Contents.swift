//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var optionalType : String?

//optionalType?.append("f")

optionalType = "hello, playgound"
optionalType!.uppercaseString

enum Size{
    case X, XL, S, M, XXL
    
}
print(Size.X)

enum Week: Int{
    case Monday = 1, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday
}

print(Week.Sunday)
print(Week.Sunday.rawValue)

enum Weekday: String{
    case Monday = "星期一", Tuesday = "星期二", Wednesday = "星期三", Thursday = "星期四", Friday = "星期五", Saturday = "星期六", Sunday = "星期日"
}

let i = Weekday.Friday.rawValue
if let day = Weekday.init(rawValue: i){
    switch day{
    case Weekday.Friday:
        print("周五")
    default:
        print("工作")
    }
}

// 函数
// 变量参数和输出参数
func sum(inout firstValue: Double, values: Double...) -> Double{
    
    for value in values{
        firstValue += value
    }
    return firstValue
}


var initValue: Double = 9
sum(&initValue, values: 2,3)
print(initValue)

func max(bigger: (Double, Double) -> Double, values : Double...) -> Double{
    var maxVaule = values[0]
    for var i = 1; i < values.count; i++ {
        maxVaule = bigger(maxVaule, values[i])
    }
    return maxVaule
}

func bigger(preValue: Double, lastValue: Double) -> Double{
    
    return preValue > lastValue ? preValue : lastValue
}

max(bigger, values: 1,22,4,3,87,44,54)
