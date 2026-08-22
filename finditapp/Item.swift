//
//  Item.swift
//  finditapp
//
//  Created by Son Tung Le on 18/8/26.
//

import Foundation

struct Item: Identifiable {
    let id = UUID()
    let title: String
    let category: String

    var bottle: Bool {
        category == "Bottle"
    }

    var stationery: Bool {
        category == "Stationery"
    }

    var electronics: Bool {
        category == "Electronics"
    }

    var clothing: Bool {
        category == "Clothing"
    }

    var other: Bool {
        category == "Other"
    }
}
