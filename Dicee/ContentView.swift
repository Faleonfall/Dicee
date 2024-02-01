//
//  ContentView.swift
//  Dicee
//
//  Created by Volodymyr Kryvytskyi on 09.09.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State var leftDiceNumber = 1
    @State var rightDiceNumber = 1
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Image("diceeLogo")
                Spacer()
                HStack {
                    DiceView(n: leftDiceNumber)
                    DiceView(n: rightDiceNumber)
                }
                .padding(.horizontal)
                Spacer()
                
                Button(
                    action: {
                        leftDiceNumber = Int.random(in: 1...6)
                        rightDiceNumber = Int.random(in: 1...6)
                    },
                    
                    label: {
                        Text("Roll")
                            .font(.system(size: 50))
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
                        
                    })
                
                .background(Color(red: 0.557, green: 0.161, blue: 0.149)) // #8e2926
                .cornerRadius(5)
                .padding(.bottom, 10)
            }
        }
    }
}

struct DiceView: View {
    let n: Int
    
    var body: some View {
        Image("dice\(n)")
            .resizable()
            .aspectRatio(1,  contentMode: .fit)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
