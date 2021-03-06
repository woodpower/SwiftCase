//: Playground - noun: a place where people can play

import UIKit

///////////////////////////////////  基本数据类型  ////////////////////////////

// 重要事说3变，变量使用前必须初始化
// 1、常量：只能初始化一次的变量 let，不需要修改的变量都用let修饰
// 2、变量：可以多次初始化 var
let a = 0 // 推断出Int类型
let b = 1_000 // 1000 可读性高
//a = b // 编译错误，常量不能再次赋值

// 隐式初始化2个变量 编译器推导出Int类型
var score = 99
score = 60
//score = 0.1 // 编译错误，已经指定score是Int类型，不能再给它赋Double类型

// 显式初始化 明确指定数据类型 Int在Swift中是结构体
let maxNumber: Int = 100000
var minNumber: Int = Int(INT8_MIN)

// 一行中声明多个变量 默认Double类型
var xPos = 1.0, yPos = 0.0, zPos = 0.0
let myHeight: Double = 1.79

// 获取结构体属性
Int.max // Int默认是Int64
Int.min
Int32.max
Int64.max
UInt8.max
UInt8.min

var f1: Float = 0.0001
let f2 = 0.0002

// 安全类型转换：运算符两边类型要一致
let first: UInt8 = 12
let second: UInt16 = 12
let result = UInt16(first) + second
let result2 = first - UInt8(second)

// OC: CGFloat -> Float
let red: CGFloat = 112 / 255.0
let green: CGFloat = 221 / 255.0
let blue: CGFloat = 88 / 255.0
UIColor(red: red, green: green, blue: blue, alpha: 0.9)






//////////////////////////  Bool String/Character Tuple  ////////////////////////

// Bool true/false
let isCool = true
var isSmall: Bool = true
isSmall = false

// Swift励志要干掉C语法
if !isSmall {
    print("I'm smaller")
}
if isCool {
    print("Swift is cool")
}

// String/Character字符和字符串
var hello = "Hi Swift playground"
let reply: String = "Hi well done"

// 只声明未初始化，必须指定类型，此时这个变量不要使用
var say: String
say = "I want to say something, but..."
var char1: Character = "a"
var char2: Character = "好"
char1 = "👌"
char2 = "\u{1F61E}"
var emoji = "\u{1F60E}\u{1F600}\u{1F60A}"

for t in emoji.characters {
    print(t)
}

let name = "小伍", age = 20, height = 1.82
print("姓名:\(name) 年龄:\(age) 身高:\(height) m")
// 字符串拼接
let hi = "hello", space = " ", world = "world"
var sentence = hi + space + world
sentence += space + sentence


/*
 * 元组Tuple: 用逗号分隔的包含多个相同/不同类型的数据类型(数据结构)
 * 1.声明并初始化元组; 明确元组的分量的个数, 每个元组的分量的类型是什么
 * 2.获取元组分量值: 使用点语法, 从0开始
 * 3.指定元组分量的名字, 使得获取分量的语义性更加明确
 * 4.元组解包Unwrap: if语句
 * 5.元组比较(不太常用)
 */
// 隐式声明一个描述二维坐标系的点的变量
var point2D = (5, 10) // (Int, Int)
var point3D = (1, 0.2, 5) // (Int, Double, Int)

// 404: statuscode状态码(NSHTTPUrlResponse);
let httpResponse = (404, "Page Not Found")
// errorCode errorMsg
let errorDomain: (Int, String) = (0, "Success")
let error1 = httpResponse // 推导出类型
// 取出分量值 从0开始
error1.0
error1.1

var loginResult = (false, "Tom")
loginResult.0 = true

// 元组解包
let (isLogin, username) = loginResult
if isLogin {
    print("\(name) login")
}

// _ 下划线表示忽略值
let (isLogin2, _) = loginResult
if isLogin2 {
    print("login success")
}

// 比较元组大小
let point1 = (2, 1)
let point2 = (1, 2)
point1 > point2


/*
 * 运算符的分类方式一:
 * 1.一元运算符Unary: !(特殊) -负号; ?问号; ??; ++; --
 * 2.二元运算符Binary: + - * / % = == > <
 * 3.三元(三目)运算符Ternary: a ? b : c
 */

/*
 * 运算符的分类方式二:
 * 1.赋值运算符/算数运算符: = + - * / %
 * 2.比较运算符: == > < != <= >=
 * 3.逻辑运算符: && ||
 * 4.区间运算符Range(新增语法): 0...10; 0..<10
 --> 例如: 闭区间: [0, 10]; 开区间 [0, 10);
    ++ -- 使用+=和-=替换
 */

let batteryCapacity = 19
let batteryColor = batteryCapacity < 20 ? UIColor.yellow : UIColor.green

/*
 * 区间运算符:
 * 1.闭区间语法: x...y; 描述的是包含x和y的闭区间
 * 2.开区间语法: x..<y; 描述的是包含x, 不包含y的开区间
 */
// for in循环结合使用; C语言风格的for循环
// let index: Int
for index in 5...10 {
    print("index=\(index)")
}
for index in 5..<10 {
    print("index=\(index)")
}

// Any：包含class、struct、func等一切类型  AnyObject：包含class，OC中的id类型
let course = ["Objective-C", "Swift", "Java", "Javascript"]
// 遍历数组时index是下标
for index in 0..<course.count {
    print("\(index) -- \(course[index])")
}

// Any类型没有count方法，所以要强转AnyObject遍历，但实际是Any类型遍历时报错，所以数组中类型需一致
//let course2: Any = ["Objective-C", "Swift", "Java", "Javascript", 1]
































