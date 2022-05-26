//
//  SeriesDetailViewModel.swift
//  TVList
//
//  Created by Fabrício Sperotto Sffair on 2022-05-25.
//

import Combine
import Foundation

protocol SeriesDetailDependencyInjectable {
    var seriesRepository: SeriesRepositoryObservable { get }
}

final class SeriesDetailViewModel: SeriesDetailViewModelObservable {
    
    @Published var isLoading = false
    @Published var episodes: [Episode] = []
    @Published var seasons: [Season] = []
    var series: Series
    private let seriesRepository: SeriesRepositoryObservable
    private var subscribers = Set<AnyCancellable>()
    
    init(dependencies: SeriesDetailDependencyInjectable, selectedSeries: Series) {
        series = selectedSeries
        seriesRepository = dependencies.seriesRepository
    }
    
    func onAppear() {
        subscribeToPublishers()
        loadEpisodes()
    }
    
    private func subscribeToPublishers() {
        seriesRepository.episodesPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] episodes in
                guard let self = self else { return }
                self.episodes = episodes
                var newSeasons = [Season]()
                episodes.forEach { episode in
                    if let index = newSeasons.firstIndex(where: { season in
                        season.id == episode.season
                    }) {
                        newSeasons[index].episodes.append(episode)
                    } else {
                        newSeasons.append(Season(id: episode.season, episodes: [episode]))
                    }
                }
                self.seasons = newSeasons
                self.isLoading = false
            }
            .store(in: &subscribers)
        seriesRepository.errorPublisher
            .sink { error in
                self.isLoading = false
                guard error != nil else { return }
                print(error)
            }
            .store(in: &subscribers)
    }
    
    private func loadEpisodes() {
        isLoading = true
        seriesRepository.getEpisodes(from: series)
    }
    
}
