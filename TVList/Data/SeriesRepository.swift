//
//  SeriesRepository.swift
//  TVList
//
//  Created by Fabrício Sperotto Sffair on 2022-05-23.
//

import Combine
import Foundation

protocol SeriesPersisting: SeriesFetching, SeriesUpdating {}
protocol SeriesUpdating { }

protocol SeriesRepositoryOperations {
    func getSeries(at page: Int)
    func searchSeries(containing searchString: String)
    func getEpisodes(from series: Series)
}

protocol SeriesRepositoryObservable: SeriesRepositoryOperations {
    var errorPublisher: CurrentValueSubject<Error?, Never> { get }
    var seriesPublisher: PassthroughSubject<[Series], Never> { get }
    var episodesPublisher: PassthroughSubject<[Episode], Never> { get }
}


class SeriesRepository: SeriesRepositoryObservable {

    private(set) var seriesPublisher: PassthroughSubject<[Series], Never> = .init()
    private(set) var errorPublisher: CurrentValueSubject<Error?, Never> = .init(nil)
    private(set) var episodesPublisher: PassthroughSubject<[Episode], Never> = .init()
    
    var remote: SeriesFetching
    var localDatabase: SeriesPersisting
    
    init(remote: SeriesFetching, localDatabase: SeriesPersisting) {
        self.remote = remote
        self.localDatabase = localDatabase
        Task {
            guard let series = try? await localDatabase.getSeries(at: 0) else { return }
            seriesPublisher.send(series)
        }
    }
    
    func getSeries(at page: Int) {
        Task(priority: .background) {
            do {
                let series = try await remote.getSeries(at: page)
                seriesPublisher.send(series)
            } catch {
                errorPublisher.send(error)
            }
        }
    }
    
    func searchSeries(containing searchString: String) {
        Task(priority: .background) {
            do {
                let searchResult = try await remote.searchSeries(containing: searchString)
                seriesPublisher.send(searchResult.sorted(by: { $0.score > $1.score }).map({ $0.show }))
            } catch {
                errorPublisher.send(error)
            }
        }
    }
    
    func getEpisodes(from series: Series) {
        Task(priority: .background) {
            do {
                let episodes = try await remote.getEpisodes(from: series)
                episodesPublisher.send(episodes)
            } catch {
                errorPublisher.send(error)
            }
        }
    }
    
}
