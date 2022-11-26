//
//  Question.swift
//  Quizzler-iOS13
//
//  Created by ntubic on 19.11.2022..
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct Question {
    let question: String
    let answer: String
    
    init(question: String, answer: String) {
        self.question = question
        self.answer = answer
    }
}
