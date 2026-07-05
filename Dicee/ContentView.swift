import SwiftUI

struct ContentView: View {
    @State private var leftDiceNumber = 1
    @State private var rightDiceNumber = 1
    // Drives the tumble animation and the haptic; one bump per roll.
    @State private var rollCount = 0
    // .compact vertical size class means landscape on iPhone, .regular means portrait.
    @Environment(\.verticalSizeClass) private var verticalSizeClass

    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea()

            VStack {
                Image("diceeLogo")
                    // 10 in landscape, 50 in portrait.
                    .padding(.top, verticalSizeClass == .compact ? 10 : 50)

                Spacer()

                HStack {
                    // In-plane spin (Z axis) so the dice roll without foreshortening.
                    // Counter-rotating directions so the pair doesn't spin identically.
                    DiceView(number: leftDiceNumber)
                        .rotationEffect(.degrees(Double(rollCount) * 360))
                    DiceView(number: rightDiceNumber)
                        .rotationEffect(.degrees(Double(rollCount) * -360))
                }
                .padding(.horizontal)

                Spacer()

                Button(action: roll) {
                    Label("Roll", systemImage: "dice.fill")
                        .font(.title2.weight(.bold))
                        .foregroundStyle(.white)
                        .padding(.vertical, 14)
                        .padding(.horizontal, 44)
                        // Brand red #8e2926
                        .background(Color(red: 0.557, green: 0.161, blue: 0.149), in: .capsule)
                        .shadow(color: .black.opacity(0.35), radius: 10, y: 5)
                }
                .buttonStyle(.pressable)
                .padding(.bottom, 24)
            }
        }
        .sensoryFeedback(.impact(weight: .medium), trigger: rollCount)
    }

    // Independently rerolls both dice to a random face in 1...6 and springs the tumble.
    private func roll() {
        withAnimation(.spring(response: 0.55, dampingFraction: 0.55)) {
            leftDiceNumber = Int.random(in: 1...6)
            rightDiceNumber = Int.random(in: 1...6)
            rollCount += 1
        }
    }
}

// Scales the button down slightly while pressed for tactile feedback.
struct PressableButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.94 : 1)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == PressableButtonStyle {
    static var pressable: PressableButtonStyle { PressableButtonStyle() }
}

#Preview {
    ContentView()
}
