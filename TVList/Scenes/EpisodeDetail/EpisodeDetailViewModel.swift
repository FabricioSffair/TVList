//
//  EpisodeDetailViewModel.swift
//  TVList
//
//  Created by Fabrício Sperotto Sffair on 2022-05-25.
//

import Foundation

final class EpisodeDetailViewModel: EpisodeDetailViewModelObservable {
    
    @Published var episode: Episode
    
    init(selectedEpisode: Episode) {
        episode = selectedEpisode
    }
    
    func onAppear() {
    }
    
}
