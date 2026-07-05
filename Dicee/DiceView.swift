import SwiftUI

// A single die face. The number maps directly to the asset name dice1...dice6.
struct DiceView: View {
    let number: Int

    var body: some View {
        Image("dice\(number)")
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .padding()
    }
}

#Preview {
    DiceView(number: 1)
}
