//
//  Client.swift
//  
//
//  Created by Fabrício Sperotto Sffair on 2022-05-23.
//

import Client

protocol SeriesFetching {
    func getSeries(at page: Int) async throws -> [Series]
    func searchSeries(containing searchString: String) async throws -> [SearchResult]
    func getEpisodes(from series: Series) async throws -> [Episode]
}

class ClientService: ClientServicable, SeriesFetching {
    
    var clientRequester: ClientRequestable
    
    init(clientRequester: ClientRequestable = ClientRequester()) {
        self.clientRequester = clientRequester
    }
    
    func getSeries(at page: Int) async throws -> [Series] {
        let endpoint = Endpoint.getSeries(page)
        let req = endpoint.createClientRequest()
        return try await clientRequester.request(req)
    }
    
    func searchSeries(containing searchString: String) async throws -> [SearchResult] {
        let endpoint = Endpoint.searchSeries(searchString)
        let req = endpoint.createClientRequest()
        return try await clientRequester.request(req)
    }
    
    func getEpisodes(from series: Series) async throws -> [Episode] {
        let endpoint = Endpoint.getEpisodes(series.id)
        let req = endpoint.createClientRequest()
        return try await clientRequester.request(req)
    }
}
