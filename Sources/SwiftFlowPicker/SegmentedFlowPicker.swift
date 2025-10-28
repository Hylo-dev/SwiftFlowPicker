// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

@available(iOS 26.0, *)
@available(macOS 26.0, *)
public struct SegmentedFlowPicker<T: RawRepresentable & CaseIterable & Equatable & Hashable, Content: View>: View where T.RawValue == String {
	
	@Binding private var selectedSection: T
	private let content: (T) -> Content
	
	private var selectionColor : Color    = .accentColor
	private var backgroundColor: Color	  = .clear
	private var shapeButton	   : AnyShape = AnyShape(.rect(cornerRadius: 10))
		
	private let allCases: [T]
	
	// Inizializzatore con closure che restituisce una view per ogni case
	public init(
		selectedSection: Binding<T>,
		@ViewBuilder content: @escaping (T) -> Content
	) {
		self._selectedSection = selectedSection
		self.allCases = Array(T.allCases)
		self.content = content
	}
	
	public var body: some View {
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
						AnyShape(self.shapeButton)
							.glassEffect(
								.regular.tint(self.selectionColor).interactive()
							)
							.frame(width: buttonsProxy.size.width / CGFloat(allCases.count), height: 23)
							.offset(
								x: buttonsProxy.size.width / CGFloat(allCases.count) * CGFloat(currentIndex)
							)
							.padding(.top, 7)
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
			content(allCases[index])
				.frame(width: 15, height: 15)
				.padding(.vertical, 4)
				.padding(.horizontal, 8)
				.frame(maxWidth: .infinity)
				.foregroundColor(
					selectedSection == allCases[index]
						? .white
						: .primary
				)
				.contentShape(Rectangle())
			
		}
		.buttonStyle(.plain)
	}
	
	public func buttonFocusedColor(_ color: Color) -> Self {
		var view = self
		view.selectionColor = color
		return view
	}
	
	public func backgroundColor(_ color: Color) -> Self {
		var view = self
		view.backgroundColor = color
		return view
	}
	
	public func clipShape<S: Shape>(_ shape: S) -> Self {
		var view = self
		view.shapeButton = AnyShape(shape)
		return view
	}
}
