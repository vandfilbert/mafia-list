//
//  ContentView.swift
//  MafiaList
//
//  Created by Phincon on 8/14/23.
//

import SwiftUI

struct MainTabView: View {
    
    var body: some View {
        
        TabView {
            
            ListGameView()
                .tabItem {
                    Label("List Game", systemImage: "list.dash")
                }
            
            FavoriteView()
                .tabItem {
                    Label("Favorite Game", systemImage: "square.and.pencil")
                }
            
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
