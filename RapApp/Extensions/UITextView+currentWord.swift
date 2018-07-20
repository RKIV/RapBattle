//
//  UITextView+currentWord.swift
//  RapApp
//
//  Created by Michael Hayashi on 7/20/18.
//  Copyright © 2018 Michael Hayashi. All rights reserved.
//

import Foundation
import UIKit

extension UITextView{
    var currentWord : String? {
        
        let beginning = beginningOfDocument
        
        if let start = position(from: beginning, offset: selectedRange.location),
            let end = position(from: start, offset: selectedRange.length) {
            
            let textRange = tokenizer.rangeEnclosingPosition(end, with: .word, inDirection: 1)
            
            if let textRange = textRange {
                return text(in: textRange)
            }
        }
        return nil
    }
}
