//
//  ListGameView.swift
//  MafiaList
//
//  Created by Phincon on 8/14/23.
//

import SwiftUI

struct ListGameView: View {
    
    @State private var idGame: Int = 0
    @State private var isModalPresented: Bool = false
    @State private var inputSearch: String = ""
    @State private var searchTimer: Timer?
    @ObservedObject private var listGameVm = ListGameViewModel()
    
    var body: some View {
        
        NavigationView {
            
            ScrollView(showsIndicators: false) {
                
                VStack {
                    SearchBarComponentView(hint: "Search Here...", setValue: $inputSearch)
                    ForEach(listGameVm.listGameResult.results) { game in
                        CardListComponentView(titleGame: game.name, releaseDate: game.released, rating: game.rating, imageUrl: game.backgroundImage) {
                            self.idGame = game.id
                            self.isModalPresented = true
                        }
                    }
                }
                
            }
            .listStyle(PlainListStyle())
            .navigationTitle("List Game")
            
        }
        .onAppear() {
            listGameVm.getGameList()
        }
        .onChange(of: inputSearch) { search in
            searchTimer?.invalidate()
            searchTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                listGameVm.getGameList(search: search)
            }
        }
        .sheet(isPresented: $isModalPresented) {
            DetailGameView(idGame: self.$idGame)
        }
        
    }
    
}

struct ListGameView_Previews: PreviewProvider {
    static var previews: some View {
        ListGameView()
    }
}
