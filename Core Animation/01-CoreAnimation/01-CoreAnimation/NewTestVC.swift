//
//  NewTestVC.swift
//  01-CoreAnimation
//
//  Created by wenjie on 2021/3/18.
//

import UIKit

class NewTestVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

		self.view.backgroundColor = UIColor.white
		
		var a1 = "333"
		
		var b1 = "c666cc"
		
//		swap(&a1, &b1)
		swapValue(&a1, &b1)
		
		debugPrint(a1, b1)
		
		/**泛型函数赋值给变量*/
		var n1 = 10
		var n2 = 20
		var fn: (inout Int, inout Int) -> () = swapValue
		fn(&n1, &n2)
		
		debugPrint(n1, n2)
		
		func test<T1, T2>(_ t1: T1, _ t2: T2) { }
		var fc: (Int, Double) -> ()  = test
		
		let pro = SubProperty<Int>()
		
		pro.elements = [333, 222, 111]
		pro.push(666)
		
		debugPrint("泛型子类 \(pro.dddccc)")
		
		
		let score0 = Score.point(10)
		let score1 = Score<Int>.point(10)
		let score2 = Score<Double>.point(10.1)

		let score3 = Score<Int>.grade("C")
		debugPrint("断点")
    }
	
	func swapValue<F>(_ a: inout F, _ b: inout F) {
		(a, b) = (b, a)
	}

}

/**#####泛型类型
结构体、类、枚举也可以增加泛型定义*/
class Property<TA> {
	
	var elements: [TA] = []
	
	func push(_ element: TA) { elements.append(element)}
	
	func pop() -> TA { elements.removeLast() }
	
	func top() -> TA { elements.last! }
	
	func  size() -> Int { elements.count }
	
}

class SubProperty<ED>: Property<ED> {
	
	var dddccc = [ED]()
	
	override func push(_ element: ED) {
		super.push(element)
		
		dddccc.append(contentsOf: elements)
	}
}

struct Stack<E> {
	var elements = [E]()
	
	// struct中修改内部属性的值的时候需要加上mutating
	mutating func push(_ element: E) { elements.append(element) }
	mutating func pop() -> E { elements.removeLast() }
	func top() -> E { elements.last! }
	func size() -> Int { elements.count }
}

enum Score<T> {
	case point(T)
	case grade(String)
}

/**#####关联类型 Associated Type
协议中实现泛型无法像类、结构体、枚举那样，只能用associatedtype
*/
protocol Stackable {
	associatedtype Element //关联类型（可以理解泛型）
	associatedtype Element2 //关联类型2
	associatedtype Element3 //关联类型3
	
	mutating func push(_ element: Element)
	mutating func pop() -> Element3
	mutating func top() -> Element2
	mutating func create() -> Self
	func top() -> Element
	func size() -> Int
	init()
}
extension Stackable {
	mutating func create() -> Self {
		return type(of: self).init()
	}
}
// 具体应用中的实现：声明一个类StringStack，遵循Stackable协议，设置真实关联类型为String类型。
class StringStack: Stackable {
	
	typealias Element = String
	
	typealias Element2 = Int
	
	typealias Element3 = CGFloat
	
	required init() { }
	
	func push(_ element: String) {

	}
	
	func pop() -> CGFloat {
		return 22
	}
	
	func top() -> Int {
		return 11
	}
	
	func top() -> String {
		return "1"
	}
	
	func size() -> Int {
		return 1
	}
	
}

