//
//  ContentView.swift
//  Project3-Challenge
//
//  Created by gayeugur on 4.01.2024.
//

import SwiftUI

struct ContentView: View {
       let moves = ["Rock", "Paper", "Scissors"]
       @State private var appMove = Int.random(in: 0..<3)
       @State private var shouldWin = Bool.random()
       @State private var showingAlert = false
       
       var body: some View {
           VStack {
               Text("Rock, Paper, Scissors")
                   .font(.title)
                   .padding()
               
               Text("App's move: \(moves[appMove])")
                   .font(.headline)
                   .padding()
               
               Text("You \(shouldWin ? "win" : "lose")!")
                   .font(.headline)
                   .padding()
               
               HStack {
                   ForEach(0..<3) { number in
                       Button(action: {
                           self.checkResult(userMove: number)
                       }) {
                           Text(self.moves[number])
                               .padding()
                               .background(Color.blue)
                               .foregroundColor(.white)
                               .cornerRadius(10)
                       }
                   }
               }
           }
           .alert(isPresented: $showingAlert) {
               Alert(title: Text("Result"), message: Text("You \(shouldWin ? "win" : "lose")!"),
                     dismissButton: .default(Text("OK")))
           }
       }
       
       func checkResult(userMove: Int) {
           let win = (appMove + 1) % 3 == userMove
           let lose = (userMove + 1) % 3 == appMove
           
           if shouldWin && win {
               showingAlert = true
           } else if !shouldWin && lose {
               showingAlert = true
           } else {
               showingAlert = false
           }
           
           appMove = Int.random(in: 0..<3)
           shouldWin = Bool.random()
       }
   }

   struct ContentView_Previews: PreviewProvider {
       static var previews: some View {
           ContentView()
       }
   }
