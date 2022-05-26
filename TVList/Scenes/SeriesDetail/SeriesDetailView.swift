//
//  SeriesDetailView.swift
//  TVList
//
//  Created by Fabrício Sperotto Sffair on 2022-05-25.
//

import Foundation
import SwiftUI

protocol SeriesDetailViewModelObservable: ObservableObject {
    var isLoading: Bool { get }
    var seasons: [Season] { get }
    var series: Series { get }
    func onAppear()
}

struct SeriesDetailView<ViewModel: SeriesDetailViewModelObservable>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        GeometryReader { geoProxy in
            List {
                Section {
                    VStack(alignment: .leading, spacing: 12) {
                        SeriesImageView(image: viewModel.series.image?.original)
                        Text((viewModel.series.summary ?? "").trimHTMLTags() ?? "")
                            .font(.body)
                        Text(viewModel.series.genresString)
                            .italic()
                            .font(.body)
                        Text(viewModel.series.schedule.toString())
                            .font(.footnote)
                        
                    }
                    .padding(.bottom)
                } header: {
                    Text(viewModel.series.name)
                        .font(.title)
                        .bold()
                }
                
                if viewModel.isLoading && viewModel.seasons.isEmpty {
                    ProgressView()
                } else {
                    ForEach(viewModel.seasons) { season in
                        Section("Season \(season.id)") {
                            ForEach(season.episodes) { episode in
                                NavigationLink(destination: EpisodeDetailView(viewModel: EpisodeDetailViewModel(selectedEpisode: episode))){
                                    HStack {
                                        if let number = episode.number {
                                            Text("\(number). ")
                                        }
                                        Text(episode.name)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .onAppear {
                viewModel.onAppear()
            }
        }
    }
}


