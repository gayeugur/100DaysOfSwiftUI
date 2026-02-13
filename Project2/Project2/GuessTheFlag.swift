//
//  ContentView.swift
//  Project2
//
//  Created by gayeugur on 4.01.2024.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Game State
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    @State private var countries = [
        "Estonia", "France", "Germany", "Ireland",
        "Italy", "Nigeria", "Poland", "Spain",
        "UK", "Ukraine", "US"
    ].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var selectedCountry = ""
    
    private let maxScore = 8
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            backgroundGradient
            
            VStack {
                Spacer()
                
                titleSection
                
                flagSection
                
                Spacer()
                Spacer()
                
                scoreSection
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: nextQuestion)
        } message: {
            Text(alertMessage)
        }
    }
}

// MARK: - UI Components

extension ContentView {
    
    var backgroundGradient: some View {
        RadialGradient(
            colors: [
                Color(red: 0.15, green: 0.20, blue: 0.45),
                Color(red: 0.35, green: 0.15, blue: 0.60)
            ],
            center: .top,
            startRadius: 100,
            endRadius: 600
        )
        .ignoresSafeArea()
    }

    var titleSection: some View {
        Text("Guess the Flag")
            .bigBlueTitle()
    }
    
    var flagSection: some View {
        VStack(spacing: 15) {
            
            VStack {
                Text("Tap the flag of")
                    .foregroundStyle(.secondary)
                    .font(.subheadline.weight(.heavy))
                
                Text(countries[correctAnswer])
                    .font(.largeTitle.weight(.semibold))
            }
            
            ForEach(0..<3) { number in
                Button {
                    flagTapped(number)
                } label: {
                    Image(countries[number])
                        .clipShape(.capsule)
                        .shadow(radius: 5)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(.regularMaterial)
        .clipShape(.rect(cornerRadius: 20))
    }
    
    var scoreSection: some View {
        Text("Score: \(score)")
            .foregroundStyle(.white)
            .font(.title.bold())
    }
    
    var alertMessage: String {
        if scoreTitle == "Wrong" {
            return "Wrong! That’s the flag of \(selectedCountry).\nYour score is \(score)"
        } else if scoreTitle == "Game Over" {
            return "You reached \(maxScore) points! Game restarted."
        } else {
            return "Your score is \(score)"
        }
    }
}

// MARK: - Game Logic

extension ContentView {
    
    func flagTapped(_ number: Int) {
        selectedCountry = countries[number]
        
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong"
            score -= 1
        }
        
        if score == maxScore {
            scoreTitle = "Game Over"
            score = 0
        }
        
        showingScore = true
    }
    
    func nextQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}


struct BigBlueTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .foregroundStyle(.blue)
    }
}

extension View {
    func bigBlueTitle() -> some View {
        modifier(BigBlueTitle())
    }
}

#Preview {
    ContentView()
}
