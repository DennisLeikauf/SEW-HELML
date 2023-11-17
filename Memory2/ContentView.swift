//
//  ContentView.swift
//  Memory2
//
//  Created by Leikauf Dennis on 10.11.23.
//

import SwiftUI

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
        Group{
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                
                Text(content)
                    .font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }.onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
    
}

struct ContentView: View {
    let emojis: [String] = ["🎃", "👻", "🧌", "🕷️", "💀", "🦂", "🗿", "🦧", "👹", "🤡", "🧟‍♂️"]
    @State var cardCount = 4
    var body: some View {
        VStack{
            ScrollView{
                cards
            }
            cardCountAdjusters
        }
    }
    var cardCountAdjusters: some View {
        
        return HStack{
            cardRemover
            Spacer()
            cardAdder
        }
        .padding()
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View
    {
        let newVal: Int = cardCount + offset
        return Button(action: {
            if newVal > 0 && newVal <= emojis.count
            {
                cardCount += offset
            }
        }){
            Image(systemName: symbol)
        }.disabled(newVal <= 0 || newVal >= emojis.count)
        
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))])
        {
            // rectangle.stack.fill.badge.minus
            
            ForEach(0..<cardCount, id: \.self) { i in
                CardView(content: emojis[i], isFaceUp: true)
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }.foregroundColor(.orange)
        .padding()
    }
    
    var cardRemover: some View {
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.fill.badge.minus")
    }
    
    var cardAdder: some View{
        cardCountAdjuster(by: 1, symbol: "rectangle.stack.fill.badge.plus")
    }
}

#Preview {
    ContentView()
}
