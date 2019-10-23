//
//  ContentView.swift
//  RPS
//
//  Created by kirsty darbyshire on 18/10/2019.
//  Copyright © 2019 nocto. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let winningMove = ["Rock":"Paper", "Paper":"Scissors", "Scissors":"Rock"]
    
    @State private var moves = ["Rock", "Paper", "Scissors"].shuffled()
    @State private var shouldWin = Bool.random()
    @State private var action = Int.random(in: 0...2)
    @State private var score = 0
    @State private var rounds = 0
    
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.yellow, .purple, .yellow]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                HStack {
                    Text(shouldWin ? "Win" : "Lose")
                    Text("against")
                    Text(moves[action])
                }
                .padding()
                .font(.title)
                .foregroundColor(.white)
                .background(Bool.random() ?
                    LinearGradient(gradient: Gradient(colors: [.blue, .green]), startPoint: .top, endPoint: .bottom) :
                    LinearGradient(gradient: Gradient(colors: [.orange, .red]), startPoint: .top, endPoint: .bottom))
                    .clipShape(Capsule())
                .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                Spacer()
                VStack {
                    ForEach(moves, id: \.self) { move in
                        Button(action: {
                            self.buttonTapped(move)
                        }) {
                            Text(move)
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .fontWeight(.heavy)
                                .padding()
                                .background(LinearGradient(gradient: Gradient(colors: [.orange, .yellow]), startPoint: .top, endPoint: .bottom))
                                
                                .shadow(radius: 5.0)
                                .clipShape(Capsule())
                                 .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                                .padding()
                           
                        }
                    }
                }
                Spacer()
                HStack {
                    Spacer()
                    Text("Score: \(score)/\(rounds)")
                    .padding()
                        .foregroundColor(.white)
                        .font(.title)
                }
            }
        }
    }
    
    func buttonTapped(_ move: String) {
        print("tapped \(move)")
        if shouldWin {
            if winningMove[moves[action]] == move {
                print("yes, \(move) wins against \(moves[action])")
                score += 1
            }
            else {
                print("no, \(move) doesn't win against \(moves[action]), should have picked \(String(describing: winningMove[moves[action]]))")
                score -= 1
            }
        } else {
            if winningMove[moves[action]] != move && moves[action] != move {
                print("yes, \(move) loses against \(moves[action])")
                score += 1
            }
            else {
                print("no, \(move) doesn't lose against \(moves[action]), should have picked ??")
                score -= 1
            }
        }
        rounds += 1
        moves.shuffle()
        action = Int.random(in: 0...2)
        shouldWin = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
