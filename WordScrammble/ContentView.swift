//
//  ContentView.swift
//  WordScrammble
//
//  Created by Sarvad shetty on 12/5/19.
//  Copyright © 2019 Sarvad shetty. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWord = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var score = 0
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your Word:", text: $newWord, onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()
                
                List(usedWord, id: \.self){
                    Image(systemName: "\($0.count).circle")
                    Text($0)
                }
                
                Text("Your score is: \(score)")
            }
            .navigationBarTitle(rootWord)
            .onAppear(perform: startGame)
            .alert(isPresented: $showingError) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
            .navigationBarItems(trailing: Button("Restart Game") {
                self.startGame()
            })
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        //check if word is empty
        guard  answer.count > 0 else {
            return
        }
        
        //extra validation
        guard isOriginalWord(word: answer) else {
            wordError(title: "Word already used", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know")
            return
        }
        
        guard isRealWord(word: answer) else {
            wordError(title: errorTitle, message: errorMessage)
            return
        }
        
        score += 1 * (answer.count)
        
        usedWord.insert(answer, at: 0)
        //append would add to the end of the list
        newWord = ""
    }
    
    func startGame() {
        if let startWordsUrl = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsUrl) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                newWord = ""
                score = 0
                return
            }
        }
        fatalError("Could'nt load start.txt")
    }
    
    func isOriginalWord(word: String) -> Bool {
        return !usedWord.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter){
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isRealWord(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledWord = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        //check word length making sure its above 3
        guard word.count > 3 else {
            errorTitle = "Word count is less than 3"
            errorMessage = "write something bigger"
            return false
        }
        
        //compare start word with input word
        if word == rootWord {
            errorTitle = "Same as root"
            errorMessage = "make up something else"
            return false
        }
        
        errorTitle = "Word not possible"
        errorMessage = "That isnt a real word"
        
        return misspelledWord.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
