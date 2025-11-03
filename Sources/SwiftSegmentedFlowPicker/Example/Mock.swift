//
//  Mock.swift
//  FileSpotlight
//
//  Created by Eliomar Alejandro Rodriguez Ferrer on 28/10/25.
//

import SwiftUI


enum Bases: String, CaseIterable {
	case bin = "bin"
	case dec = "dec"
	case hex = "hex"
	case oct = "oct"
}
@available(macOS 26.0, *)
#Preview("String Components Segmented Flow Picker") {
	@Previewable @State var selectedBase: Bases = .oct

	VStack {
		SegmentedFlowPicker(selectedSection: $selectedBase) { base in
			Text(base.rawValue)
		}
		.buttonFocusedColor(.blue)
		.glassEffect()
	}
	.frame(width: 900, height: 200)
}


enum Tab: String, CaseIterable {
	case home     = "house"
	case profile  = "person"
	case settings = "gear"
}
@available(macOS 26.0, *)
#Preview("Icon Components Segmented Flow Picker") {
	@Previewable @State var selectedTab: Tab = .home
	
	SegmentedFlowPicker(selectedSection: $selectedTab) { tab in
		Image(systemName: tab.rawValue)
	}
	.buttonFocusedColor(.blue)
	.clipShape(RoundedRectangle(cornerRadius: 10))
	.glassEffect()
}
