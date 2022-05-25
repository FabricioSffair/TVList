//
//  SeriesListViewModel.swift
//  TVList
//
//  Created by Fabrício Sperotto Sffair on 2022-05-23.
//

import Client
import Combine
import Foundation

protocol SeriesListDependencyInjectable {
    var seriesRepository: SeriesRepositoryObservable { get }
}

class SeriesListViewModel: ObservableObject {
    
    private let seriesRepository: SeriesRepositoryObservable
    private var subscribers = Set<AnyCancellable>()
    private var currentPage = 0
    private var hasMore = true
    
    @Published var isLoading = false
    @Published var searchText: String = ""
    @Published var series: [Series] = [] 
    
    init(dependencies: SeriesListDependencyInjectable = Dependencies.shared) {
        seriesRepository = dependencies.seriesRepository
        seriesRepository.seriesPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] series in
                guard let self = self else { return }
                self.isLoading = false
                self.hasMore = series.count > 0
                self.series = self.currentPage == 0 ? series : self.series + series
            }
            .store(in: &subscribers)
    }
    
    func loadMoreIfNeeded(_ index: Int = 0) {
        guard index >= series.count - 20, hasMore, !isLoading else {
            return
        }
        currentPage += 1
        getSeriesList()
    }
    
    func refresh() {
        currentPage = 0
        getSeriesList()
    }
    
    private func getSeriesList() {
        isLoading = true
        seriesRepository.getSeries(at: currentPage, containing: "")
    }
    
}

extension Date {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let stringValue = try? container.decode(String.self) {
            try self.init(stringValue, strategy: .dateTime)
        } else {
            try self.init(from: decoder)
        }
    }
}
