//
//  AnyShape.swift
//  FlowPicker
//
//  Created by Eliomar Alejandro Rodriguez Ferrer on 28/10/25.
//

import SwiftUI

@available(iOS 26.0, *)
@available(macOS 26.0, *)
struct AnyShape: Shape {
	private let _path: @Sendable (CGRect) -> Path
	
	init<S: Shape>(_ shape: S) {
		self._path = { rect in shape.path(in: rect) }
	}
	
	func path(in rect: CGRect) -> Path {
		_path(rect)
	}
}
