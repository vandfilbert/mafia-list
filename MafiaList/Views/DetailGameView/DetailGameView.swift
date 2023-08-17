//
//  DetailGameView.swift
//  MafiaList
//
//  Created by Phincon on 8/16/23.
//

import SwiftUI

struct DetailGameView: View  {
    
    @Binding var idGame: Int
    @State private var image: UIImage?
    @StateObject private var detailGameVm = DetailGameViewModel()
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            ZStack {
                
                if let image = image {

                    Image(uiImage: image)
                        .resizable()
                        .frame(height: 300)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(20, corners: [.bottomLeft, .bottomRight])

                } else {
                    Text("Loading...")
                }
                
                VStack {
                    
                    Spacer()
                    HStack {
                        Text(detailGameVm.detailGame.nameOriginal).font(.largeTitle).bold()
                            .foregroundColor(.white)
                        Spacer()
                    }
                    HStack {
                        Text("Rating: \(String(format: "%.2f", detailGameVm.detailGame.rating))").font(.title3)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    
                }
                .padding(.horizontal)
                .frame(height: 250)
                
            }
            
            VStack(spacing: 10.0) {
                
                Text("Date Released: \(detailGameVm.detailGame.released)").font(.title3)
                HStack {
                    Text("Description:")
                    if detailGameVm.checkDataFavorite(idGame: String(idGame)) {
                        Image(systemName: "heart.fill")
                            .foregroundColor(Color.red)
                            .onTapGesture {
                                detailGameVm.deleteFavorite()
                                detailGameVm.getDetailGame(idGame: idGame)
                            }
                    } else {
                        Image(systemName: "heart")
                            .onTapGesture {
                                detailGameVm.saveGameToFavorite(game: detailGameVm.detailGame)
                                detailGameVm.getDetailGame(idGame: idGame)
                            }
                    }
                    Text("<- Make it Favorite")
                    Spacer()
                }
                HTMLTextView(htmlString: detailGameVm.detailGame.description)
                    
            }
            .padding(.horizontal, 15)
            
            Spacer()
            
        }
        .onAppear {
            detailGameVm.getDetailGame(idGame: idGame)
        }
        .onChange(of: detailGameVm.detailGame) { newValue in
            loadImage(newValue.backgroundImage)
        }
        
    }
    
    private func loadImage(_ imageUrl: String) {
        
        guard let imageUrl = URL(string: imageUrl) else {
            return
        }
        
        URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            if let imageData = data, let loadedImage = UIImage(data: imageData) {
                DispatchQueue.main.async {
                    self.image = loadedImage
                }
            }
        }.resume()
        
    }
    
}
