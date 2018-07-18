//
//  DatamuseAPIService.swift
//  RapApp
//
//  Created by Robert Keller on 7/16/18.
//  Copyright © 2018 Michael Hayashi. All rights reserved.
//

import Foundation

struct DatamuseAPIService{
    static func getRhymingSet(for word: String, done: @escaping (([Word]) -> Void)){
        let urlString = "https://api.datamuse.com/words?rel_rhy=\(word)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            guard let data = data else { return }
            //Implement JSON decoding and parsing
            do {
                //Decode retrived data with JSONDecoder and assing type of Article object
                var wordsData = try JSONDecoder().decode([Word].self, from: data)
                
                
                // range will be nil if no whitespace is found

                var indexesToRemove = [Int]()
                for (index, element) in wordsData.enumerated(){
                    if element.word.count <= 3 || element.word.containsWhitespace{
                        indexesToRemove.append(index)
                    }
                }
                
                for (index, element) in indexesToRemove.enumerated(){
                    wordsData.remove(at: element - index)
                }
                done(wordsData)
                //Get back to the main queue
                
            } catch let jsonError {
                print(jsonError)
            }
            
            
            }.resume()
    }
}


