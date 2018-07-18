//
//  String+ContainsWhiteSpace.swift
//  RapApp
//
//  Created by Robert Keller on 7/18/18.
//  Copyright © 2018 Michael Hayashi. All rights reserved.
//

extension String {
    var containsWhitespace : Bool {
        return(self.rangeOfCharacter(from: .whitespacesAndNewlines) != nil)
    }
}
