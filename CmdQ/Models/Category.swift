//
//  Category.swift
//  CmdQ
//
//  Created by Samuel Aarón Flores Montemayor on 10/05/25.
//

import Foundation

struct Category: Identifiable, Decodable {
    let id: Int
    let title: String
    let iconName: String
}
