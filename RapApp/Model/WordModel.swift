//
//  Words.swift
//  RapApp
//
//  Created by Robert Keller on 7/16/18.
//  Copyright © 2018 Michael Hayashi. All rights reserved.
//

import UIKit

struct Word: Codable {
    var word: String
    var score: Int
    var numSyllables: Int
}
