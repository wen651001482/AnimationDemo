//
//  NewTest2.swift
//  01-CoreAnimation
//
//  Created by WJ-Jason on 2021/4/16.
//

import UIKit

class NewTest2 {

    
	
}


protocol Person {
	// 初始化方法
	init(map: String)
	
	//读写属性
	var name:String{get set}
	 
	//只读属性
	var age:Int{get}
	 
	//类型方法
	static func method1()
	 
	//实例方法
	func method2() -> Int
	 
	//可变方法
	mutating func method3()
}

class Son: Person {
	var name: String
	
	var age: Int
	
	static func method1() {
	}
	
	func method2() -> Int {
		return 1
	}
	
	func method3() {
		age = 18
	}
	
	var boy: String = ""
	
	required init(map: String) {
		name = "xiaoming"
		age = 15
	}
	
	func gosikou() {
		
	}
}

@objc protocol NewProtocol {
	func getNewWork()
	func setGuangzhou()
	@objc optional func orderMenuView(willSelect index: Int) -> Bool
	@objc optional func orderMenuView(DidSelect index: Int)
}

protocol goWeak: NewProtocol {
	
	var name: String { get }
	
	func testFind()
	
	func newBirthday(param: String) -> String
}

extension goWeak {
	/**
	在 OC 中有 @optional 关键字，但在 swift 中使用 optional 关键字时，会有警告，提示我们要使用@objc，这很不 swift。而且，被标记为@objc 的协议，只能被 class 实现，不能用于结构体和枚举。

	在 swift 中可选协议，可以使用扩展协议实现。具体来说分为两步

	在协议中定义方法
	扩展协议，在扩展协议中给出默认实现
	*/
	func testFind() {

	}
}

class Test1: goWeak {
	func newBirthday(param: String) -> String {
		return "is fire"
	}
	
	func getNewWork() {
		
	}
	
	func setGuangzhou() {
		
	}
	
	var name: String = "ttt"

}

	

