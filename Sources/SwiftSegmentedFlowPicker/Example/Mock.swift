import SwiftUI

// This file contains SwiftUI Previews for demonstrating different configurations
// and content types for the SegmentedFlowPicker component.

// MARK: - SegmentedFlowPicker Previews

fileprivate enum Bases: String, CaseIterable {
	case dec = "dec"
	case bin = "bin"
	case hex = "hex"
	case oct = "oct"
}

@available(macOS 26.0, *)
#Preview("Text Segments (Number Bases)") {
	@Previewable @State var selectedBase: Bases = .dec
	
	ZStack {
		Color.black.opacity(0.8).ignoresSafeArea()
		
		VStack(spacing: 15) {
			Text("Text-Based Segments")
				.font(.title3)
				.fontWeight(.semibold)
				.foregroundColor(.white)
					
			SegmentedFlowPicker(selectedSection: $selectedBase) { base in
				Text(base.rawValue)
					.font(.body)
			}
			.buttonFocusedColor(.blue)
			.glassEffect()
			.frame(width: 500, height: 200)
			
		}
	}
	.frame(width: 500, height: 250)
}

/// Enum per i segmenti con icone (SF Symbols)
fileprivate enum Tab: String, CaseIterable {
	case home     = "house"
	case profile  = "person"
	case settings = "gear"
}

@available(macOS 26.0, *)
#Preview("Icon Segments (SF Symbols)") {
	
	// 1. Definisce lo stato per il segmento selezionato.
	@Previewable @State var selectedTab: Tab = .home
	
	// 2. Imposta un ambiente di anteprima.
	ZStack {
		Color.black.opacity(0.8).ignoresSafeArea()
		
		VStack(spacing: 15) {
			Text("Icon-Based Segments")
				.font(.title3)
				.fontWeight(.semibold)
				.foregroundColor(.white)
			
			Text("Mostra l'uso con SF Symbols e una forma personalizzata.")
				.font(.caption)
				.foregroundColor(.secondary)
			
			// 3. Istanzia il SegmentedFlowPicker.
			SegmentedFlowPicker(selectedSection: $selectedTab) { tab in
				// 4. Fornisce il contenuto (un'Image).
				Image(systemName: tab.rawValue)
			}
			.buttonFocusedColor(.purple) // 5. Applica un colore per la selezione.
			.glassEffect()               // 6. Abilita l'effetto vetro.
			.clipShape(Capsule())        // 7. Applica una forma personalizzata (Capsule).
			.frame(width: 200)           // 8. Dà al picker una larghezza definita.
			
		}
	}
	.frame(width: 500, height: 250) // Dimensioni della finestra di preview
}
