//
//  SeriesListInfoView.swift
//  TVList
//
//  Created by Fabrício Sperotto Sffair on 2022-05-25.
//

import SwiftUI

struct SeriesListInfoView: View {
    
    let title: String
    let rating: Series.Rating?
    let summary: String?
    let schedule: Series.Schedule?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title3)
                .bold()
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(2)
                .minimumScaleFactor(0.8)
                .multilineTextAlignment(.leading)
                .clipped()
            Text(schedule?.toString() ?? "No schedule found")
                .font(.footnote)
            HStack(spacing: 4) {
                if let rating = rating?.average {
                    Text("\(Image(systemName: "star"))")
                        .font(.system(size: 12))
                    Text(String(format: "%.1f", rating))
                        .font(.system(size: 12))
                }
            }
        }
        .clipped()
        .padding(.horizontal, 6)
    }
}


struct SeriesListInfoView_Previews: PreviewProvider {
    static var previews: some View {
        SeriesListInfoView(title: "Squid Game", rating: .init(average: 6.5), summary: "Hundreds of cash-strapped contestants accept an invitation to compete in children's games for a tempting prize, but the stakes are deadly.", schedule: Series.Schedule.init(time: "22:00", days: ["Monday, Wednesday"]))
    }
}

