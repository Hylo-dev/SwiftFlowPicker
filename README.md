<h1 align="center">SegmentedFlowPicker</h1>

<div align="center">

![GitHub last commit](https://img.shields.io/github/last-commit/Hylo-dev/SwiftFlowPicker?style=for-the-badge&labelColor=101418&color=9ccbfb)
![GitHub Repo stars](https://img.shields.io/github/stars/Hylo-dev/SwiftFlowPicker?style=for-the-badge&labelColor=101418&color=b9c8da)
![GitHub license](https://img.shields.io/github/license/Hylo-dev/SwiftFlowPicker?style=for-the-badge&labelColor=101418&color=b9fbc0)
<br>
![Swift Package Manager](https://img.shields.io/badge/SwiftPM-Compatible-brightgreen?style=for-the-badge&labelColor=101418&color=d3bfe6)
![Platform](https://img.shields.io/badge/Platform-macOS%2026.0%2B-blue?style=for-the-badge&labelColor=101418&color=ffb4a2)

</div>

> [!NOTE]
> A modern, customizable segmented picker for macOS 26.0+ featuring a sliding selection indicator.

---

`SegmentedFlowPicker` is a SwiftUI component that offers a stylized alternative to the native `Picker`. It features a sleek, animated selection indicator that uses the new `.glassEffect` modifier, and allows for custom views (like icons or text) to be used as the content for each segment.

## Preview

<p align="center">
  <img src="https://github.com/user-attachments/assets/2dc9eb33-53e1-4521-a285-31f38a0fd2d7" alt="Demo di SegmentedFlowPicker" width="450">
</p>

## Features

- **Sliding Selection Animation**: The selected item indicator smoothly animates to its new position.
- **Custom Segment Content**: Use any SwiftUI `View` (like `Image` or `Text`) for each segment's label.
- **Simple Customization**: Easily change the selection indicator's color.

## Requirements

- **macOS 26.0+** (Tahoe) or later (due to the use of `.glassEffect`)

## Installation

You can add `SegmentedFlowPicker` to your project using Swift Package Manager.

1.  In Xcode, select **File > Add Packages...**
2.  Enter the repository URL: `https://github.com/hylo-dev/SegmentedFlowPicker.git`
3.  Choose the "Up to Next Major" version rule and click "Add Package".

## Usage

Here the code for the ide `Aste-RISC` (the video above)

First import the package:
``` swift
import FlowPicker
```

Then create an enum for the picker entries like this:
```swift
enum InformationNavigation: String, CaseIterable, Equatable {
 case tableRegisters = "tablecells"
 case stack          = "square.stack.3d.up"
}
```

And create the `SegmentedFlowPicker` like so:
```swift
SegmentedFlowPicker(
  selectedSection: self.$informationAreaViewModel.selectedSection
) { section in
  Image(systemName: section.rawValue)
}
```

## Customization

You can customize the picker's appearance using view modifiers:

* `.buttonFocusedColor(_ color: Color)`: Sets the tint color of the sliding glass indicator.

## Project Status

> [!NOTE]
> This component is in its early stages.

## Contributing

Contributions are welcome! Please feel free to open an issue to discuss a new feature or submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
