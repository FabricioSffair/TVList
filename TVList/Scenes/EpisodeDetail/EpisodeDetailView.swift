//
//  EpisodeDetailView.swift
//  TVList
//
//  Created by Fabrício Sperotto Sffair on 2022-05-25.
//

import Foundation
import SwiftUI

protocol EpisodeDetailViewModelObservable: ObservableObject {
    var episode: Episode { get }
    func onAppear()
}

struct EpisodeDetailView<ViewModel: EpisodeDetailViewModelObservable>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        GeometryReader { geoProxy in
            List {
                Section {
                    VStack(alignment: .leading, spacing: 12) {
                        SeriesImageView(image: viewModel.episode.image?.original)
                        Text("Season \(viewModel.episode.season)")
                        Text((viewModel.episode.summary).trimHTMLTags() ?? "")
                            .font(.body)
                        
                    }
                    .padding(.bottom)
                } header: {
                    if let episodeNumber = viewModel.episode.number{
                        Text("Episode \(episodeNumber) - \(viewModel.episode.name)")
                            .font(.title)
                            .bold()
                    } else {
                        Text(viewModel.episode.name)
                            .font(.title)
                            .bold()
                    }
                }
            }
        }
    }
}
