//
//  Client.swift
//  
//
//  Created by Fabrício Sperotto Sffair on 2022-05-23.
//

import Client

protocol SeriesFetching {
    func getSeries(at page: Int, containing searchString: String) async throws -> [Series]
}

class ClientService: ClientServicable, SeriesFetching {
    
    var clientRequester: ClientRequestable
    
    init(clientRequester: ClientRequestable = ClientRequester()) {
        self.clientRequester = clientRequester
    }
    
    func getSeries(at page: Int, containing searchString: String) async throws -> [Series] {
        let endpoint = Endpoint.getSeries(page)
        let req = endpoint.createClientRequest()
        return try await clientRequester.request(req)
    }
}
