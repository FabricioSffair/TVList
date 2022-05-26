//
//  SeriesImageView.swift
//  TVList
//
//  Created by Fabrício Sperotto Sffair on 2022-05-25.
//

import Foundation
import SwiftUI

struct SeriesImageView: View {
    
    let image: String?
    
    var body: some View {
        AsyncImage(url: URL(string: image ?? ""), content: { image in
            image
                .antialiased(true)
                .resizable()
                .scaledToFill()
                .clipped()
        }, placeholder: {
            Image(systemName: "photo")
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
        })
    }
    
}
