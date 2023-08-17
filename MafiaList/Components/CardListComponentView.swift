//
//  CardListComponentView.swift
//  MafiaList
//
//  Created by Phincon on 8/14/23.
//

import SwiftUI

struct CardListComponentView: View {
    
    @State var titleGame: String = "Game 1"
    @State var releaseDate: String = "10 September 2023"
    @State var rating: Double = 4.5
    @State var imageUrl: String = ""
    @State private var image: UIImage?
    var cardPressed: () -> Void
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            if let image = image {
                
                Image(uiImage: image)
                    .resizable()
                    .frame(height: 250)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(20)
                
            } else {
                Text("Loading...")
            }
            
            VStack(spacing: 5) {
                
                HStack {
                    Text(titleGame).font(.title).bold()
                    Spacer()
                }
                .padding(.horizontal, 15)
                .padding(.top, 15)
                
                HStack {
                    Text("Released: \(releaseDate)").font(.subheadline)
                    Spacer()
                }
                .padding(.horizontal, 15)
                
                HStack(spacing: 5) {
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .foregroundColor(colorAsset.yellowRating)
                    Text(String(format: "%.2f", rating)).font(.subheadline)
                    Spacer()
                }
                .padding(.horizontal, 15)
                .padding(.bottom, 15)
                
            }
            .background(colorAsset.white)
            .cornerRadius(20)
            .padding(10)
            
        }
        .background(colorAsset.lightGreyBackground)
        .cornerRadius(20)
        .padding(.horizontal)
        .padding(.vertical, 10)
        .onAppear {
            loadImage()
        }
        .onTapGesture {
            cardPressed()
        }
        
    }
    
    private func loadImage() {
        
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

struct CardListComponentView_Previews: PreviewProvider {
    static var previews: some View {
        CardListComponentView() {}
    }
}
