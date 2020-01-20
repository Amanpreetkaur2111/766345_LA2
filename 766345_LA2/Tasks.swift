//
//  Tasks.swift
//  766345_LA2
//
//  Created by Amanpreet Kaur on 2020-01-20.
//  Copyright © 2020 Amanpreet Kaur. All rights reserved.
//

import Foundation
 
class Task {
    
    internal init(tasks: String, days: Int) {
        self.tasks = tasks
        self.days = days
    }
    
    
    var tasks: String
    var days: Int
}
