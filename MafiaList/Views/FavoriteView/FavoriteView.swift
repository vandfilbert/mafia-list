//
//  FavoriteView.swift
//  MafiaList
//
//  Created by Phincon on 8/14/23.
//

import SwiftUI

struct FavoriteView: View {
    
    @State private var idGame: Int = 0
    @State private var isModalPresented: Bool = false
    @State private var inputSearch: String = ""
    @State private var searchTimer: Timer?
    @ObservedObject private var favoriteGameVm = FavoriteViewModel()
    
    var body: some View {
        
        NavigationView {
            
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    SearchBarComponentView(hint: "Search Here...", setValue: $inputSearch)
                    ForEach(favoriteGameVm.resultGamesFavorite, id: \.self) { game in
                        CardListComponentView(titleGame: game.nameGame ?? "", releaseDate: game.releasedGame ?? "", rating: Double(game.ratingGame ?? "") ?? 0.0, imageUrl: game.imageGame ?? "") {
                            self.idGame = Int(game.idGame ?? "") ?? 0
                            self.isModalPresented = true
                        }
                    }
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("List Favorite Games")
            
        }
        .onAppear {
            favoriteGameVm.getFavoriteGames()
        }
        .onChange(of: inputSearch) { search in
            searchTimer?.invalidate()
            searchTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                if search.isEmpty {
                    favoriteGameVm.getFavoriteGames()
                } else {
                    favoriteGameVm.getFavoriteGameByName(nameGame: search)
                }
            }
        }
        .sheet(isPresented: $isModalPresented, onDismiss: {
            favoriteGameVm.getFavoriteGames()
        }) {
            DetailGameView(idGame: self.$idGame)
        }
        
    }
    
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
