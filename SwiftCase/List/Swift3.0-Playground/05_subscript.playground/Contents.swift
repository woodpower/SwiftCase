//: Playground - noun: a place where people can play

import UIKit

/*
 * 本节主要内容:
 * 1.如何使用下标语法? 针对结构体自定义类型
 * 2.关键词subscript
 * 3.下标语法
 * 3.1 subscript(参数) -> 值类型  subscript(index: Int) -> Element
 */

var array = [1, 2, 3]
array[0]
var dict = ["name": "xiaowu", "age": "20"]
dict["name"]
dict["age"]

// 使用自定义结构体类型描述三维坐标系下的点 
// point["x"] point["y"] point["z"]
struct Vector3D {
    var x: Double
    var y: Double
    var z: Double
    // 添加下标语法
    subscript(index: String) -> Double? {
        get {
            // 获取属性值 模仿字典的访问方式
            switch index {
                case "x", "X": return 3 * x
                case "y", "Y": return 3 * y
                case "z", "Z": return 3 * z
                default: return nil
            }
        }
        set {
            // 设置属性值 newValue关键字指新值
            guard let newValue = newValue else {
                return
            }
            switch index {
                case "x", "X": x = newValue
                case "y", "Y": y = newValue
                case "z", "Z": z = newValue
                default: return
            }
        }
    }
    // 模仿数组的访问方式
    subscript(index: Int) -> Double? {
        get {
            switch index {
                case 0: return x
                case 1: return y
                case 2: return z
                default: return nil
            }
        }
        set {
            guard let newValue = newValue else {
                return
            }
            switch index {
                case 0: x = newValue
                case 1: y = newValue
                case 2: z = newValue
                default: return
            }
        }
    }
}
var vectorOne = Vector3D(x: 10.2, y: 3.8, z: 20.0)
vectorOne.x = 12
vectorOne["x"] = 21.3 // subscript用下标访问属性
vectorOne["X"] = 11.5
vectorOne["x"]
vectorOne[0] = 100.0
vectorOne[0]
vectorOne["x"]

// 使用下标语法访问二维数组
// grid[2, 3]

