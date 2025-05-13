//
//  SearchBar.swift
//  CmdQ
//
//  Created by Samuel Aarón Flores Montemayor on 10/05/25.
//
import SwiftUI

struct SearchView: View {
    var body: some View {
        VStack {
            HeaderView(title: "Search")
            Spacer()
            Text("Search Content")
            Spacer()
        }
    }
}

#Preview {
    SearchView()
}
