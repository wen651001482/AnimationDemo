//
//  CGAffineViewController.swift
//  01-CoreAnimation
//
//  Created by wenjie on 2021/3/17.
//

import UIKit

class CGAffineViewController: UIViewController {
	
	public var  transformTypes: TransformTypes = .translation
	
	private let tranformView: UIView = {
		let tranformView:UIView = UIView(frame: CGRect(x: 100, y: 300, width: 100, height: 100))
		tranformView.backgroundColor = UIColor.red
		return tranformView
	}()
	
	init(transformTypes: TransformTypes) {
		self.transformTypes = transformTypes
		super.init(nibName: nil, bundle: nil)
		title = "\(transformTypes.direction)"
		view.backgroundColor = UIColor.white
		view.addSubview(tranformView)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		UIView.animate(withDuration: 1.5, delay: 0.5, options: UIView.AnimationOptions.curveLinear, animations: {
			switch self.transformTypes{
			case .translation:
				// 移动
				self.tranformView.transform = CGAffineTransform.init(translationX: 60, y: 200)
			case .transScale:
				// 缩放
				self.tranformView.transform = CGAffineTransform.init(scaleX: 2, y: 2)
			case .transRotationAngle:
				// 旋转
				self.tranformView.transform = CGAffineTransform.init(rotationAngle: 1)
			case .transInverted:
				// 反转
				self.tranformView.transform = CGAffineTransform.init(translationX: 0, y: 200)
				self.tranformView.transform  = self.tranformView.transform.inverted()
			case .transConcatenating:
				// 组合
				self.tranformView.transform = CGAffineTransform.init(rotationAngle: 0.5)
				self.tranformView.transform = self.tranformView.transform.concatenating(CGAffineTransform.init(scaleX: 1.5, y: 1.5))
			}
		}) { (completion: Bool) in
		}
	}
	
}

public enum TransformTypes: String, CaseIterable {
	case translation
	case transScale
	case transRotationAngle
	case transInverted
	case transConcatenating
	
	var direction: String {
		switch self {
		case .translation:
			return "移动"
		case .transScale:
			return "缩放"
		case .transRotationAngle:
			return "旋转"
		case .transInverted:
			return "反转"
		case .transConcatenating:
			return "组合"
			
		}
	}
}
