//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

// 自动引用计数http://wiki.jikexueyuan.com/project/swift/chapter2/16_Automatic_Reference_Counting.html
//下面的例子展示了自动引用计数的工作机制。例子以一个简单的Person类开始，并定义了一个叫name的常量属性：
class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

var reference1: Person?
var reference2: Person?
var reference3: Person?
reference1 = Person(name: "John Appleseed")
reference2 = reference1
reference3 = reference1

reference1 = nil
reference2 = nil
reference3 = nil

//
//类实例之间的循环强引用
//在上面的例子中，ARC 会跟踪你所新创建的Person实例的引用数量，并且会在Person实例不再被需要时销毁它。
//
//然而，我们可能会写出一个类实例的强引用数永远不能变成0的代码。如果两个类实例互相持有对方的强引用，因而每个实例都让对方一直存在，就是这种情况。这就是所谓的循环强引用。
//
//你可以通过定义类之间的关系为弱引用或无主引用，以替代强引用，从而解决循环强引用的问题。具体的过程在解决类实例之间的循环强引用中有描述。不管怎样，在你学习怎样解决循环强引用之前，很有必要了解一下它是怎样产生的。
//
//下面展示了一个不经意产生循环强引用的例子。例子定义了两个类：PersonBold和Apartment，用来建模公寓和它其中的居民：
class PersonBold {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { print("\(name) is being deinitialized") }
}

class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    var tenant: PersonBold?
    deinit { print("Apartment \(unit) is being deinitialized") }
}
var john: PersonBold?
var unit4A: Apartment?
//现在你可以创建特定的Person和Apartment实例并将赋值给john和unit4A变量：

john = PersonBold(name: "John Appleseed")
unit4A = Apartment(unit: "4A")

// 发生了强引用循环
john!.apartment = unit4A
unit4A!.tenant = john

// 实例不能被ARC销毁
john = nil
unit4A = nil

//解决实例之间的循环强引用
//Swift 提供了两种办法用来解决你在使用类的属性时所遇到的循环强引用问题：弱引用（weak reference）和无主引用（unowned reference）。
//
//弱引用和无主引用允许循环引用中的一个实例引用另外一个实例而不保持强引用。这样实例能够互相引用而不产生循环强引用。
//
//对于生命周期中会变为nil的实例使用弱引用。相反地，对于初始化赋值后再也不会被赋值为nil的实例，使用无主引用。
//
//
//弱引用
//
//弱引用不会对其引用的实例保持强引用，因而不会阻止 ARC 销毁被引用的实例。这个特性阻止了引用变为循环强引用。声明属性或者变量时，在前面加上weak关键字表明这是一个弱引用。
//
//在实例的生命周期中，如果某些时候引用没有值，那么弱引用可以避免循环强引用。如果引用总是有值，则可以使用无主引用，在无主引用中有描述。在上面Apartment的例子中，一个公寓的生命周期中，有时是没有“居民”的，因此适合使用弱引用来解决循环强引用。
//
//注意
//弱引用必须被声明为变量，表明其值能在运行时被修改。弱引用不能被声明为常量。
//因为弱引用可以没有值，你必须将每一个弱引用声明为可选类型。在 Swift 中，推荐使用可选类型描述可能没有值的类型。
//
//因为弱引用不会保持所引用的实例，即使引用存在，实例也有可能被销毁。因此，ARC 会在引用的实例被销毁后自动将其赋值为nil。你可以像其他可选值一样，检查弱引用的值是否存在，你将永远不会访问已销毁的实例的引用。
//
//下面的例子跟上面Person和Apartment的例子一致，但是有一个重要的区别。这一次，Apartment的tenant属性被声明为弱引用：
//
class Person1 {
    let name: String
    init(name: String) { self.name = name }
    var apartment: ApartmentWeek?
    deinit { print("\(name) is being deinitialized") }
}
class ApartmentWeek {
    let unit: String
    init(unit: String) { self.unit = unit }
    weak var tenant: Person1?
    deinit { print("Apartment \(unit) is being deinitialized") }
}
//然后跟之前一样，建立两个变量（john和unit4A）之间的强引用，并关联两个实例：

var john1: Person1?
var unit4Aweek: ApartmentWeek?

john1 = Person1(name: "John Appleseed")
unit4Aweek = ApartmentWeek(unit: "4A")

john1!.apartment = unit4Aweek
unit4Aweek!.tenant = john1
//Person实例依然保持对Apartment实例的强引用，但是Apartment实例只持有对Person实例的弱引用。这意味着当你断开john变量所保持的强引用时，再也没有指向Person实例的强引用了：
//由于再也没有指向Person实例的强引用，该实例会被销毁：

john1 = nil
// 打印 “John1 Appleseed is being deinitialized”
unit4Aweek = nil

//无主引用
//
//和弱引用类似，无主引用不会牢牢保持住引用的实例。和弱引用不同的是，无主引用是永远有值的。因此，无主引用总是被定义为非可选类型（non-optional type）。你可以在声明属性或者变量时，在前面加上关键字unowned表示这是一个无主引用。
//
//由于无主引用是非可选类型，你不需要在使用它的时候将它展开。无主引用总是可以被直接访问。不过 ARC 无法在实例被销毁后将无主引用设为nil，因为非可选类型的变量不允许被赋值为nil。

//下面的例子定义了两个类，Customer和CreditCard，模拟了银行客户和客户的信用卡。这两个类中，每一个都将另外一个类的实例作为自身的属性。这种关系可能会造成循环强引用。
//
//Customer和CreditCard之间的关系与前面弱引用例子中Apartment和Person的关系略微不同。在这个数据模型中，一个客户可能有或者没有信用卡，但是一张信用卡总是关联着一个客户。为了表示这种关系，Customer类有一个可选类型的card属性，但是CreditCard类有一个非可选类型的customer属性。
//
//此外，只能通过将一个number值和customer实例传递给CreditCard构造函数的方式来创建CreditCard实例。这样可以确保当创建CreditCard实例时总是有一个customer实例与之关联。
//
//由于信用卡总是关联着一个客户，因此将customer属性定义为无主引用，用以避免循环强引用：

class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit { print("\(name) is being deinitialized") }
}
class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit { print("Card #\(number) is being deinitialized") }
}
//注意
//CreditCard类的number属性被定义为UInt64类型而不是Int类型，以确保number属性的存储量在 32 位和 64 位系统上都能足够容纳 16 位的卡号。
//下面的代码片段定义了一个叫john的可选类型Customer变量，用来保存某个特定客户的引用。由于是可选类型，所以变量被初始化为nil：

var john2: Customer?
//现在你可以创建Customer类的实例，用它初始化CreditCard实例，并将新创建的CreditCard实例赋值为客户的card属性：

john2 = Customer(name: "John Appleseed")
john2!.card = CreditCard(number: 1234_5678_9012_3456, customer: john2!)
//Customer实例持有对CreditCard实例的强引用，而CreditCard实例持有对Customer实例的无主引用。
//
//由于customer的无主引用，当你断开john变量持有的强引用时，再也没有指向Customer实例的强引用了：
//
//
//
//由于再也没有指向Customer实例的强引用，该实例被销毁了。其后，再也没有指向CreditCard实例的强引用，该实例也随之被销毁了：

john2 = nil

//无主引用以及隐式解析可选属性
//
//上面弱引用和无主引用的例子涵盖了两种常用的需要打破循环强引用的场景。
//
//Person和Apartment的例子展示了两个属性的值都允许为nil，并会潜在的产生循环强引用。这种场景最适合用弱引用来解决。
//
//Customer和CreditCard的例子展示了一个属性的值允许为nil，而另一个属性的值不允许为nil，这也可能会产生循环强引用。这种场景最适合通过无主引用来解决。
//
//然而，存在着第三种场景，在这种场景中，两个属性都必须有值，并且初始化完成后永远不会为nil。在这种场景中，需要一个类使用无主属性，而另外一个类使用隐式解析可选属性。
//这使两个属性在初始化完成后能被直接访问（不需要可选展开），同时避免了循环引用。这一节将为你展示如何建立这种关系。
//
//下面的例子定义了两个类，Country和City，每个类将另外一个类的实例保存为属性。在这个模型中，每个国家必须有首都，每个城市必须属于一个国家。为了实现这种关系，Country类拥有一个capitalCity属性，而City类有一个country属性：

class Country {
    let name: String
    var capitalCity: City!
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
}
class City {
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}
//为了建立两个类的依赖关系，City的构造函数接受一个Country实例作为参数，并且将实例保存到country属性。
//
//Country的构造函数调用了City的构造函数。然而，只有Country的实例完全初始化后，Country的构造函数才能把self传给City的构造函数。（在两段式构造过程中有具体描述）
//
//为了满足这种需求，通过在类型结尾处加上感叹号（City!）的方式，将Country的capitalCity属性声明为隐式解析可选类型的属性。这意味着像其他可选类型一样，capitalCity属性的默认值为nil，但是不需要展开它的值就能访问它。（在隐式解析可选类型中有描述）
//
//由于capitalCity默认值为nil，一旦Country的实例在构造函数中给name属性赋值后，整个初始化过程就完成了。这意味着一旦name属性被赋值后，Country的构造函数就能引用并传递隐式的self。Country的构造函数在赋值capitalCity时，就能将self作为参数传递给City的构造函数。
//
//以上的意义在于你可以通过一条语句同时创建Country和City的实例，而不产生循环强引用，并且capitalCity的属性能被直接访问，而不需要通过感叹号来展开它的可选值：

var country = Country(name: "Canada", capitalName: "Ottawa")
print("\(country.name)'s capital city is called \(country.capitalCity.name)")
// 打印 “Canada's capital city is called Ottawa”
//在上面的例子中，使用隐式解析可选值意味着满足了类的构造函数的两个构造阶段的要求。capitalCity属性在初始化完成后，能像非可选值一样使用和存取，同时还避免了循环强引用。



// 可选绑定
let possibleNumber = "123"
// actualNumber 是局部变量，不能在外部使用
if let actualNumber = Int(possibleNumber) {
    print("\'\(possibleNumber)\' has an integer value of \(actualNumber)")
} else {
    print("\'\(possibleNumber)\' could not be converted to an integer")
}
//print(actualNumber) // 编译错误，提示actualNumber没有被定义
//这段代码可以被理解为：
//
//“如果Int(possibleNumber)返回的可选Int包含一个值，创建一个叫做actualNumber的新常量并将可选包含的值赋给它。”
//
//你可以包含多个可选绑定在if语句中，并使用where子句做布尔值判断。

if let firstNumber = Int("4"), secondNumber = Int("42") where firstNumber < secondNumber {
    print("\(firstNumber) < \(secondNumber)")
}
// prints "4 < 42"
//隐式解析可选类型
//
//如上所述，可选类型暗示了常量或者变量可以“没有值”。可选可以通过if语句来判断是否有值，如果有值的话可以通过可选绑定来解析值。
//
//有时候在程序架构中，第一次被赋值之后，可以确定一个可选类型_总会_有值。在这种情况下，每次都要判断和解析可选值是非常低效的，因为可以确定它总会有值。
//
//这种类型的可选状态被定义为隐式解析可选类型（implicitly unwrapped optionals）。把想要用作可选的类型的后面的问号（String?）改成感叹号（String!）来声明一个隐式解析可选类型。
//
//当可选类型被第一次赋值之后就可以确定之后一直有值的时候，隐式解析可选类型非常有用。隐式解析可选类型主要被用在 Swift 中类的构造过程中，请参考无主引用以及隐式解析可选属性。
//
//一个隐式解析可选类型其实就是一个普通的可选类型，但是可以被当做非可选类型来使用，并不需要每次都使用解析来获取可选值。下面的例子展示了可选类型String和隐式解析可选类型String之间的区别：

let possibleString: String? = "An optional string."
let forcedString: String = possibleString! // 需要惊叹号来获取值

let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString  // 不需要感叹号
//你可以把隐式解析可选类型当做一个可以自动解析的可选类型。你要做的只是声明的时候把感叹号放到类型的结尾，而不是每次取值的可选名字的结尾。



//闭包引起的循环强引用
//前面我们看到了循环强引用是在两个类实例属性互相保持对方的强引用时产生的，还知道了如何用弱引用和无主引用来打破这些循环强引用。
//
//循环强引用还会发生在当你将一个闭包赋值给类实例的某个属性，并且这个闭包体中又使用了这个类实例时。这个闭包体中可能访问了实例的某个属性，例如self.someProperty，或者闭包中调用了实例的某个方法，例如self.someMethod()。这两种情况都导致了闭包“捕获”self，从而产生了循环强引用。
//
//循环强引用的产生，是因为闭包和类相似，都是引用类型。当你把一个闭包赋值给某个属性时，你是将这个闭包的引用赋值给了属性。实质上，这跟之前的问题是一样的——两个强引用让彼此一直有效。但是，和两个类实例不同，这次一个是类实例，另一个是闭包。
//
//Swift 提供了一种优雅的方法来解决这个问题，称之为闭包捕获列表（closuer capture list）。同样的，在学习如何用闭包捕获列表破坏循环强引用之前，先来了解一下这里的循环强引用是如何产生的，这对我们很有帮助。
//
//下面的例子为你展示了当一个闭包引用了self后是如何产生一个循环强引用的。例子中定义了一个叫HTMLElement的类，用一种简单的模型表示 HTML 文档中的一个单独的元素：

class HTMLElement {
    
    let name: String
    let text: String?
    
    lazy var asHTML: Void -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
    
}
//HTMLElement类定义了一个name属性来表示这个元素的名称，例如代表段落的“p”，或者代表换行的“br”。HTMLElement还定义了一个可选属性text，用来设置 HTML 元素呈现的文本。
//
//除了上面的两个属性，HTMLElement还定义了一个lazy属性asHTML。这个属性引用了一个将name和text组合成 HTML 字符串片段的闭包。该属性是Void -> String类型，或者可以理解为“一个没有参数，返回String的函数”。
//
//默认情况下，闭包赋值给了asHTML属性，这个闭包返回一个代表 HTML 标签的字符串。如果text值存在，该标签就包含可选值text；如果text不存在，该标签就不包含文本。对于段落元素，根据text是“some text”还是nil，闭包会返回"<p>some text</p>"或者"<p />"。
//
//可以像实例方法那样去命名、使用asHTML属性。然而，由于asHTML是闭包而不是实例方法，如果你想改变特定 HTML 元素的处理方式的话，可以用自定义的闭包来取代默认值。
//
//例如，可以将一个闭包赋值给asHTML属性，这个闭包能在text属性是nil时使用默认文本，这是为了避免返回一个空的 HTML 标签：

let heading = HTMLElement(name: "h1")
let defaultText = "some default text"
heading.asHTML = {
    return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
}
print(heading.asHTML())
// 打印 “<h1>some default text</h1>”
//注意
//asHTML声明为lazy属性，因为只有当元素确实需要被处理为 HTML 输出的字符串时，才需要使用asHTML。也就是说，在默认的闭包中可以使用self，因为只有当初始化完成以及self确实存在后，才能访问lazy属性。
//HTMLElement类只提供了一个构造函数，通过name和text（如果有的话）参数来初始化一个新元素。该类也定义了一个析构函数，当HTMLElement实例被销毁时，打印一条消息。
//
//下面的代码展示了如何用HTMLElement类创建实例并打印消息：

var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML())
// 打印 “hello, world”
