//
//  NewCGAnimationVC.swift
//  01-CoreAnimation
//
//  Created by wenjie on 2021/3/17.
//

import UIKit

class NewCGAnimationVC: UIViewController {

	private var aTransformTypes:[TransformTypes] {
		return TransformTypes.allCases
	}
	
	private var aTransformDirection: [String] {
		return TransformTypes.allCases.map{$0.rawValue}
	}
	
	private lazy var pushBtn: UIButton = {
		let btn = UIButton()
		btn.setTitle("push", for: .normal)
		btn.frame = CGRect.init(x: 0, y: 0, width: 100, height: 50)
		btn.layer.cornerRadius = 5
		btn.backgroundColor = UIColor.green.withAlphaComponent(0.7)
		btn.addTarget(self, action: #selector(pushController), for: .touchUpInside)
		return btn
	}()
	
	private let tableview: UITableView = {
		let view = UITableView()
		view.tableFooterView = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		return view
	}()
	
	override func loadView() {
		super.loadView()
		TransformTypes.height = 222
		
		debugPrint("this height \(TransformTypes.height)")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: pushBtn)
		
		title = "CGAffineTransform"
		tableview.dataSource = self;
		tableview.delegate = self
		view.addSubview(tableview)
		tableview.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
		tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
	}
	
	@objc func pushController() {
		self.navigationController?.pushViewController(ViewController(), animated: true)
	}
	
}

extension NewCGAnimationVC: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return aTransformTypes.count;
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		cell.textLabel?.text = "\(aTransformTypes[indexPath.row].direction)"
		return cell
	}
}

extension NewCGAnimationVC: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let aTransformDirection = aTransformTypes[indexPath.row]
		showAffineViewController(aTransformTypes: aTransformDirection)
	}
	
	func showAffineViewController(aTransformTypes: TransformTypes) {
		let affineViewController = CGAffineViewController(transformTypes: aTransformTypes)
		show(affineViewController, sender: nil)
	}
}

