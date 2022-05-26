//
//  Dependencies.swift
//  TVList
//
//  Created by Fabrício Sperotto Sffair on 2022-05-23.
//

import Foundation

extension Dependencies: SeriesListDependencyInjectable, SeriesDetailDependencyInjectable {}

class Dependencies {
    
    static let shared: Dependencies = .init()
    
    var seriesRepository: SeriesRepositoryObservable = SeriesRepository(remote: ClientService(), localDatabase: FakeProvider())
}


struct FakeProvider: SeriesPersisting {
    func getEpisodes(from series: Series) async throws -> [Episode] {
        []
    }
    
    func searchSeries(containing searchString: String) async throws -> [SearchResult] {
        []
    }
    
    func getSeries(at page: Int) async throws -> [Series] {
        []
    }
}
