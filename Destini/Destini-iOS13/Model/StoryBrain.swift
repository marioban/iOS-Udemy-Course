//
//  StoryBrain.swift
//  Destini-iOS13
//
//  Created by Angela Yu on 08/08/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation


struct StoryBrain {
    let storybrain = [
    Story(title: "You see a fork in the road.", choice1: "Take a left.", choice2: "Take a right."),
    Story(title: "You see a tiger", choice1: "Shout for help", choice2: "Play dead"),
    Story(title: "You find a treasure chest", choice1: "Open it", choice2: "Check for traps")]
    
    
    var nextQuestion = 0
    var userChoice: String
    
    mutating func nextStory(userChoice:String) -> String {
        let left = storybrain[nextQuestion].choice1
        let right = storybrain[nextQuestion].choice2
        
        if  userChoice == left{
            nextQuestion+=1
        } else {
            nextQuestion+=2
        }
        return userChoice
    }
}
