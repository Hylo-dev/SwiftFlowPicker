import SwiftUI

/// A customizable segmented picker control with a sliding glass effect indicator.
///
/// `SegmentedFlowPicker` provides a modern, animated segmented control where each segment
/// can display custom content. The selected segment is highlighted with a sliding glass
/// effect background that smoothly animates between selections.
///
/// - Parameters:
///   - T: An enum type that conforms to `RawRepresentable`, `CaseIterable`, `Equatable`, and `Hashable`
///        with a `String` raw value. This represents the available segments.
///   - Content: The type of view that each segment will display.
///
/// Example usage:
/// ```swift
/// enum Tab: String, CaseIterable {
///     case home, profile, settings
/// }
///
/// @State private var selectedTab: Tab = .home
///
/// SegmentedFlowPicker(selectedSection: $selectedTab) { tab in
///     Image(systemName: tab.iconName)
/// }
/// .buttonFocusedColor(.blue)
/// .clipShape(RoundedRectangle(cornerRadius: 12))
/// ```
@available(macOS 26.0, *)
public struct SegmentedFlowPicker<T: RawRepresentable & CaseIterable & Equatable & Hashable, Content: View>: View where T.RawValue == String {

	/// Binding to the currently selected segment
	@Binding private var selectedSection: T
	
	/// Closure that generates the view content for each segment
	private let content: (T) -> Content

	/// The color of the sliding selection indicator (default: accent color)
	private var selectionColor: Color? = nil
	
	/// The background color of the picker (default: clear)
	private var backgroundColor: Color = .clear
	
	/// The shape used for the selection indicator button (default: rounded rectangle with 10pt radius)
	private var shapeButton: AnyShape = AnyShape(.rect(cornerRadius: 15))

	/// Array of all available cases from the generic enum type
	private let allCases: [T]

	/// Creates a new segmented flow picker with custom content for each segment.
	///
	/// - Parameters:
	///   - selectedSection: A binding to the currently selected segment value
	///   - content: A view builder closure that returns the view to display for each segment case
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
			// Horizontal stack containing all segment buttons
			HStack {
				ForEach(allCases.indices, id: \.self) { index in
					buttonNavigation(index).tag(allCases[index])
				}
			}
			.frame(maxWidth: .infinity, alignment: .leading)
			.background(
				// Animated sliding indicator background
				GeometryReader { buttonsProxy in
					AnyShape(self.shapeButton)
						.glassEffect(
							self.selectionColor == nil ?
								.regular.interactive() :
								.regular.tint(self.selectionColor).interactive()
						)
						.frame(width: buttonsProxy.size.width / CGFloat(allCases.count), height: 27)
						.offset(
							x: buttonsProxy.size.width / CGFloat(allCases.count) * CGFloat(currentIndex)
						)
				}
			)
			.background(
				AnyShape(self.shapeButton)
					.fill(self.backgroundColor)
					.frame(maxWidth: .infinity)
			)
			.padding(.horizontal)
		}
		.frame(height: 27)
	}

	/// Computes the index of the currently selected segment
	///
	/// - Returns: The index of the selected segment, or 0 if not found
	private var currentIndex: Int {
		allCases.firstIndex(of: selectedSection) ?? 0
	}

	/// Creates a button for a specific segment at the given index.
	///
	/// - Parameter index: The index of the segment in the `allCases` array
	/// - Returns: A button view configured for the specified segment
	@ViewBuilder
	private func buttonNavigation(_ index: Int) -> some View {
		Button {
			withAnimation() {
				self.selectedSection = allCases[index]
			}
		} label: {
			content(allCases[index])
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

	/// Sets the color of the selection indicator.
	///
	/// - Parameter color: The color to use for the focused/selected segment indicator
	/// - Returns: A modified copy of the picker with the specified selection color
	public func buttonFocusedColor(_ color: Color) -> Self {
		var view = self
		view.selectionColor = color
		return view
	}

	/// Sets the background color of the entire picker.
	///
	/// - Parameter color: The background color for the picker
	/// - Returns: A modified copy of the picker with the specified background color
	public func backgroundColor(_ color: Color) -> Self {
		var view = self
		view.backgroundColor = color
		return view
	}

	/// Sets a custom shape for the selection indicator.
	///
	/// - Parameter shape: The shape to use for the selection indicator background
	/// - Returns: A modified copy of the picker with the specified shape
	public func clipShape<S: Shape>(_ shape: S) -> Self {
		var view = self
		view.shapeButton = AnyShape(shape)
		return view
	}
}
