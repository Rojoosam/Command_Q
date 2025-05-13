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

extension Bundle {
    func decode<T: Decodable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("No encontré \(file) en Resources.")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("No pude cargar los datos de \(file).")
        }
        let decoder = JSONDecoder()
        guard let decoded = try? decoder.decode(T.self, from: data) else {
            fatalError("No pude decodificar \(file).")
        }
        return decoded
    }
}
