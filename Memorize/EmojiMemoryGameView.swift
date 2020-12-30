//
//  ContentView.swift
//  Memorize

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGameViewModel
    
    var body: some View {
        VStack {
            Grid(items: viewModel.cards) { card in
                    CardView(card: card).onTapGesture {
                        withAnimation(.linear(duration: 0.7)) {
                            viewModel.choose(card: card)
                        }
                    }.padding(5)
                }
            .padding()
            .foregroundColor(Color.orange)
            Button(action: {
                withAnimation(.easeInOut) {
                    // withAnimation explicitly animates UI changes caused by viewModel.resetGame()
                    viewModel.resetGame()
                }
            }, label: {
                Text(NSLocalizedString("new_game", comment: ""))
            })
        }
    }
        
}

struct CardView: View {
    
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            body(for: geometry.size)
        }
    }
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90), clockwise: true)
                            .onAppear {
                                startBonusTimeAnimation()
                            }
                    } else {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90), clockwise: true)
                    }
                }.padding(5).opacity(0.4)
                Text(card.content)
                    .font(Font.system(size: fontSize(for:size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)
        }
    }
    
    // MARK: - Drawing constants
    
    private func fontSize(for size: CGSize) -> CGFloat {
        return min(size.width, size.height)*0.7
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = EmojiMemoryGameViewModel()
        vm.choose(card: vm.cards[0])
        return EmojiMemoryGameView(viewModel: vm)
    }
}
