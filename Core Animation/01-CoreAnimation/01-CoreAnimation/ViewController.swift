//
//  ViewController.swift
//  01-CoreAnimation
//
//  Created by wenjie on 2021/3/16.
//

import UIKit

class ViewController: UIViewController {
	
	lazy var blueLayer = CALayer()
	lazy var v: UIView = {
		let v = UIView()
		v.backgroundColor = .red
		v.frame = CGRect.init(x: UIScreen.main.bounds.size.width / 2 - 100 , y: UIScreen.main.bounds.size.height / 2 - 100, width: 200, height: 200)
		return v
	}()
	
	lazy var redV: UIView = {
		let v = UIView()
		v.backgroundColor = .red
		v.frame = CGRect.init(x: 100 , y: 100, width: 200, height: 200)
		return v
	}()

	lazy var greenV: UIView = {
		let v = UIView()
		v.backgroundColor = .green
		v.frame = CGRect.init(x: 50 , y: 50, width: 150, height: 150)
		return v
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		let tap = UITapGestureRecognizer(target: self, action: #selector(zPosition))
		self.v.addGestureRecognizer(tap)
		
		self.view.addSubview(self.v)
		self.view.addSubview(self.greenV)
		self.view.addSubview(self.redV)
		
		
		caLayer()
	}
	
	func caLayer() {
		let blueLayer = CALayer()
		blueLayer.frame = CGRect.init(x: 50, y: 50, width: 100, height: 100)
		blueLayer.backgroundColor = UIColor.blue.cgColor
		blueLayer.delegate = self
		self.blueLayer = blueLayer
		self.v.layer.addSublayer(blueLayer)
		
		blueLayer.display() // CALayer会请求它的代理给他一个寄宿图来显示
		
//		let image = UIImage(named: "cesuanxiangqing_renwutu_moren")
//		self.v.layer.contentsGravity = .resizeAspectFill  // 设置图层的拉伸 平铺 压缩
//		self.v.layer.contents = image?.cgImage
	}
	
	/// zPosition 改变视图层级
	@objc func zPosition() {
		self.greenV.layer.zPosition = self.greenV.layer.zPosition == 1.0 ? 0.0 : 1.0
	}
	
	func creatTransform() {
		
		var transform = CGAffineTransform.identity
		// scale by 50%
		transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
		// rotate by 30 degrees
		transform = CGAffineTransform.init(rotationAngle: 30.0)
		//translate by 200 points
		transform = CGAffineTransform.init(translationX: 200, y: 0)
		   //apply transform to layer
		self.v.layer.setAffineTransform(transform)

	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		//得到在主view中的position
		guard var point = touches.first?.location(in: self.view) else { return }
		/*
		//转换到v.layer的位置
		point = self.v.layer.convert(point, from: self.view.layer)
		if self.v.layer.contains(point) {
			point = self.blueLayer.convert(point, from: self.v.layer)
			if self.blueLayer.contains(point) {
				print("点击了蓝色")
			} else {
				print("点击了红色")
			}
		} */
		
		/**-hitTest: 方法同样接受一个 CGPoint 类型参数，而不是 BOOL 类型，它返回图层本身，或者包含这个坐标点的叶子节点图层。这意味着不再需要像使用 - containsPoint: 那样，人工地在每个子图层变换或者测试点击的坐标。如果这个点在最外面图层的范围之外，则返回nil。*/
		let layer = self.v.layer.hitTest(point)
		if layer == blueLayer {
			self.creatTransform()
		} else {
			self.v.layer.affineTransform()
		}
	}
}
extension ViewController: CALayerDelegate {
	
	func draw(_ layer: CALayer, in ctx: CGContext) {
		ctx.setLineWidth(10)
		ctx.setStrokeColor(UIColor.red.cgColor)
		ctx.strokeEllipse(in: layer.bounds)
	}
}

