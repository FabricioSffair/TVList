//
//  SeriesRepository.swift
//  TVList
//
//  Created by Fabrício Sperotto Sffair on 2022-05-23.
//

import Combine

protocol SeriesPersisting: SeriesFetching, SeriesUpdating {}
protocol SeriesUpdating { }

protocol SeriesRepositoryOperations {
    func getSeries(at page: Int, containing searchString: String)
}

protocol SeriesRepositoryObservable: SeriesRepositoryOperations {
    var errorPublisher: CurrentValueSubject<Error?, Never> { get }
    var seriesPublisher: PassthroughSubject<[Series], Never> { get }
}

class SeriesRepository: SeriesRepositoryObservable {

    private(set) var seriesPublisher: PassthroughSubject<[Series], Never> = .init()
    private(set) var errorPublisher: CurrentValueSubject<Error?, Never> = .init(nil)
    
    var remote: SeriesFetching
    var localDatabase: SeriesPersisting
    
    init(remote: SeriesFetching, localDatabase: SeriesPersisting) {
        self.remote = remote
        self.localDatabase = localDatabase
        Task {
            guard let series = try? await localDatabase.getSeries(at: 0, containing: "") else { return }
            seriesPublisher.send(series)
        }
    }
    
    func getSeries(at page: Int, containing searchString: String) {
        Task(priority: .background) {
            do {
                let series = try await remote.getSeries(at: page, containing: searchString)
                seriesPublisher.send(series)
            } catch {
                errorPublisher.send(error)
            }
        }
    }
    
}