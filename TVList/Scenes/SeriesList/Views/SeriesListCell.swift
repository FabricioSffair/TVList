//
//  SeriesListCell.swift
//  TVList
//
//  Created by Fabrício Sperotto Sffair on 2022-05-25.
//

import SwiftUI

struct SeriesListCell: View {
    
    let serie: Series
    
    var body: some View {
        GeometryReader { geoProxy in
            VStack(alignment: .leading, spacing: 6) {
                AsyncImage(url: URL(string: serie.image?.medium ?? ""), content: { image in
                    image
                        .antialiased(true)
                        .resizable()
                        .scaledToFill()
                        .frame(width: geoProxy.size.width, height: geoProxy.size.height * 2 / 3)
                        .clipped()
                        
                }, placeholder: {
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(1.0, contentMode: .fit)
                })

                SeriesListInfoView(
                    title: serie.name,
                    rating: serie.rating,
                    summary: serie.summary,
                    schedule: serie.schedule
                )
                    .padding(.vertical)
                    .frame(height: geoProxy.size.height / 3)
            }
            .background {
                Color(UIColor.secondarySystemBackground)
            }
        }
    }
}


struct SeriesListCell_Previews: PreviewProvider {
    static var previews: some View {
        SeriesListCell(
            serie: .init(
                id: 1,
                url: "",
                name: "test",
                type: "Test",
                language: "test",
                genres: [],
                status: "Ended",
                runtime: 60,
                averageRunTime: 55,
                premiered: Date.distantPast,
                ended: Date(),
                schedule: .init(time: "22:00", days: ["Monday"]),
                rating: .init(average: 6.5),
                weight: 5,
                network: nil,
                image: Series.SeriesImage.init(medium: "", original: nil),
                summary: "Test summary"
            )
        )
    }
}
