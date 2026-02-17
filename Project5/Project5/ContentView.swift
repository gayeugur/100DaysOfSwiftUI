//
//  ContentView.swift
//  Project5
//
//  Created by gayeugur on 5.01.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var rootWord = ""
    @State private var guessedWords: [String] = []
    @State private var newWord = ""
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    @State private var score = 0
    
    var body: some View {
        NavigationStack {
            List {
                
                Section {
                    Text("Score: \(score)")
                        .font(.headline)
                }
                
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                
                Section {
                    ForEach(guessedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onAppear(perform: startGame)
            .onSubmit(addGuess)
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK", role: .cancel) {
                    newWord = ""
                }
            } message: {
                Text(errorMessage)
            }
            .toolbar {
                Button("Restart") {
                    startGame()
                }
            }
        }
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start",
                                               withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.split(separator: "\n")
                rootWord = String(allWords.randomElement() ?? "silkworm")
                guessedWords.removeAll()
                score = 0
                newWord = ""
                return
            }
        }
        fatalError("Could not load start.txt from bundle.")
    }
    
    func addGuess(){
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else { return }
        
        guard answer != rootWord else {
            setError(title: "Same word",
                     message: "You can't use the start word itself!")
            return
        }
        
        guard answer.count >= 3 else {
            setError(title: "Too short",
                     message: "Word must be at least 3 letters.")
            return
        }
        
        guard isOriginal(word: answer) else {
            setError(title: "Word used already",
                     message: "Be more original!")
            return
        }
        
        guard isPossible(word: answer) else {
            setError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }
        
        guard isReal(word: answer) else {
            setError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        withAnimation {
            guessedWords.insert(answer, at: 0)
        }
        newWord = ""
        score += answer.count
    }
    
    // Checks if the word has been guessed before.
    func isOriginal(word: String) -> Bool {
        !guessedWords.contains(word)
    }
    
    // Checks if the word can be formed using the letters in rootWord.
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    // Checks if the word is a genuine English word
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word,
                                                            range: range,
                                                            startingAt: 0,
                                                            wrap: false,
                                                            language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func setError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

#Preview {
    ContentView()
}
