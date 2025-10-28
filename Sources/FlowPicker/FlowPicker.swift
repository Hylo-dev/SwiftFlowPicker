// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

@available(iOS 26.0, *)
@available(macOS 26.0, *)
struct FlowPicker
	   <T: RawRepresentable & CaseIterable & Equatable & Hashable>: View where T.RawValue == String {
	
	@Binding var selectedSection: T
	
	private var selectionColor : Color = .accentColor
	private var backgroundColor: Color = .clear
	private var shapeButton	   : AnyShape = AnyShape(.rect(cornerRadius: 10))
		
	private let allCases: [T]
	
	init(selectedSection: Binding<T>) {
		self._selectedSection = selectedSection
		self.allCases = Array(T.allCases)
	}
	
	var body: some View {
		GeometryReader { proxy in
			ZStack {
				HStack {
					ForEach(allCases.indices, id: \.self) { index in
						buttonNavigation(index).tag(allCases[index])
					}
				}
				.padding(.horizontal, 10)
				.padding(.vertical, 7)
				.frame(maxWidth: .infinity, alignment: .leading)
				.background(
					GeometryReader { buttonsProxy in
						Rectangle()
							.glassEffect(
								.regular.tint(self.selectionColor).interactive()
							)
							.frame(width: buttonsProxy.size.width / CGFloat(allCases.count), height: 23)
							.offset(
								x: buttonsProxy.size.width / CGFloat(allCases.count) * CGFloat(currentIndex)
							)
							.padding(.top, 7)
							.clipShape(self.shapeButton)
					}
				)
				.padding(.horizontal)
			}
		}
		.frame(height: 25)
	}
	
	private var currentIndex: Int {
		allCases.firstIndex(of: selectedSection) ?? 0
	}
	
	@ViewBuilder
	private func buttonNavigation(_ index: Int) -> some View {
		Button {
			withAnimation() {
				self.selectedSection = allCases[index]
			}
		} label: {
			Image(systemName: allCases[index].rawValue)
				.frame(width: 15, height: 15)
				.padding(.vertical, 4)
				.padding(.horizontal, 8)
				.frame(maxWidth: .infinity)
				.foregroundColor(
					selectedSection == allCases[index]
						? .white
						: .primary
				)
				.animation(.easeInOut(duration: 0.15), value: selectedSection)
				.contentShape(Rectangle())
		}
		.buttonStyle(.plain)
	}
	
	func buttonFocusedColor(_ color: Color) -> Self {
		var view = self
		view.selectionColor = color
		return view
	}
	
	func backgroundColor(_ color: Color) -> Self {
		var view = self
		view.backgroundColor = color
		return view
	}
	
	func clipShape<S: Shape>(_ shape: S) -> Self {
		var view = self
		view.shapeButton = AnyShape(shape)
		return view
	}
	
}
