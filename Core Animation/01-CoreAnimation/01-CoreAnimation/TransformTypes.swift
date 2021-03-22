//
//  TransformTypes.swift
//  01-CoreAnimation
//
//  Created by wenjie on 2021/3/17.
//

import Foundation

public enum TransformTypes: String, CaseIterable {
	static var height: Float = 100
	
	case translation
	case transScale
	case transRotationAngle
	case transInverted
	case transConcatenating
	case three3D
	
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
		case .three3D:
			return "3D变换"
		}
	}
}
