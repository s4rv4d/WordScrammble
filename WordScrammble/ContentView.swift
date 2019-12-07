//
//  ContentView.swift
//  WordScrammble
//
//  Created by Sarvad shetty on 12/5/19.
//  Copyright © 2019 Sarvad shetty. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let sWCharacters = ["Chewbaca","Luke","Leia"]
    
    
    var body: some View {
        
        
        let word = "swift"
        let checker = UITextChecker()
////
////         Swift uses a very clever, very advanced way of working with strings, which allows it to use complex characters such as emoji in exactly the same way that it uses the English alphabet. However, Objective-C does not use this method of storing letters, which means we need to ask Swift to create an Objective-C string range using the entire length of all our characters, like this:
////
////        let range = NSRange(location: 0, length: word.utf16.count)
////        UTF-16 is what’s called a character encoding – a way of storing letters in a string. We use it here so that Objective-C can understand how Swift’s strings are stored; it’s a nice bridging format for us to connect the two.
        
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        let allGoodRange = misspelledRange.location == NSNotFound
        
        
//        let input = "a b c"
//        let letters = input.components(separatedBy: " ")
//        let input2 = """
//                        a
//                        b
//                        c
//                     """
//        let letters2 = input2.components(separatedBy: "\n")
//        let letter = letters2.randomElement()
//        let trimmed = letter?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        return Text("Hello World!")
//        if let fileUrl = Bundle.main.url(forResource: "some", withExtension: "txt")  {
//               //file found
//            if let fileContent = try? String(contentsOf: fileUrl){
//                //loaded file into string
//            }
//           }
////        List {
////            Section(header: Text("Static row 1")) {
////                Text("St 1")
////                Text("St 2")
////            }
////            Section(header: Text("Dynamic row 1")) {
////                ForEach(0..<12) {
////                    Text("Dy \($0)")
////                }
////            }
////            Section(header: Text("Static row 2")) {
////                Text("St 3")
////                Text("St 4")
////            }
////        }.listStyle(GroupedListStyle())
//
////        List(0 ..< 5) {
////            Text("\($0)")
////        }
//
//        return List(sWCharacters, id: \.self){
//            Text($0)
            
//        }
        
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
