//
//  Category.swift
//  Ning-Expense
//
//  Created by Ning Huang on 16/10/20.
//

import Foundation
import UIKit

struct Category {
    var name: String
    var color: UIColor
    
    init(_ name: String, _ color: UIColor) {
        self.name = name
        self.color = color
    }
}

struct CategoryManager {
    var categories = [Category("Yellow", #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)), Category("Green", #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)), Category("Red", #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))]
    
    static let singletonCM = CategoryManager()
}
