//
//  Dependencies.swift
//  TVList
//
//  Created by Fabrício Sperotto Sffair on 2022-05-23.
//

import Foundation

extension Dependencies: SeriesListDependencyInjectable {}

class Dependencies {
    
    static let shared: Dependencies = .init()
    
    var seriesRepository: SeriesRepositoryObservable = SeriesRepository(remote: ClientService(), localDatabase: FakeProvider())
}


struct FakeProvider: SeriesPersisting {
    
    func getSeries(at page: Int, containing searchString: String) async throws -> [Series] {
        []
    }
}
