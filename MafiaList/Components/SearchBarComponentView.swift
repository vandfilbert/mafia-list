//
//  SearchBarComponentView.swift
//  MafiaList
//
//  Created by Phincon on 8/17/23.
//

import SwiftUI

struct SearchBarComponentView: View {

    var hint: String
    @Binding var setValue: String
    
    var body: some View {
        
        VStack(spacing: 5) {
            
            TextField(hint, text: $setValue)
                .font(.subheadline)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
        }
        .padding(15)
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(.gray, lineWidth: 2))
        .padding(.horizontal, 15)
        
    }
    
}
