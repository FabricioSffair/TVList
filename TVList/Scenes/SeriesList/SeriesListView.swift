//
//  ContentView.swift
//  TVList
//
//  Created by Fabrício Sperotto Sffair on 2022-05-20.
//

import Kingfisher
import SwiftUI

protocol SeriesListViewModelObservable: ObservableObject {
    var filteredSeries: [Series] { get }
    var searchText: String { get set }
    var showErrorMessage: Bool { get set }
    var errorMessage: String { get }
    func loadMoreIfNeeded(_ index: Int)
    func search()
    func refresh()
}

struct SeriesListView<ViewModel: SeriesListViewModelObservable>: View {
    
    @StateObject var viewModel: ViewModel
    
    @State var gridItems = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                GeometryReader { geoProxy in
                    ScrollView {
                        LazyVGrid(columns: gridItems, spacing: 16) {
                            ForEach(viewModel.filteredSeries.indices, id: \.self) { index in
                                let series = viewModel.filteredSeries[index]
                                SeriesListCell(serie: series)
                                    .frame(minHeight: 280)
                                    .cornerRadius(10)
                                    .onAppear {
                                        viewModel.loadMoreIfNeeded(index)
                                    }
                            }
                            .refreshable {
                                viewModel.refresh()
                            }
                        }
                    }
                }
                .padding()
                .onAppear {
                    viewModel.refresh()
                }
                .toast(message: viewModel.errorMessage, isShowing: $viewModel.showErrorMessage)
                .navigationTitle("TVMaze Series")
            }
        }
        .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
        .onSubmit(of: .search) {
            viewModel.search()
        }
        .onRotate { orientation in
            switch orientation {
            case .landscapeLeft, .landscapeRight:
                gridItems = [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ]
            default:
                gridItems = [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ]
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SeriesListInfoView(title: "Squid Game", rating: .init(average: 6.5), summary: "Hundreds of cash-strapped contestants accept an invitation to compete in children's games for a tempting prize, but the stakes are deadly.", schedule: Series.Schedule.init(time: "22:00", days: ["Monday, Wednesday"]))
    }
}

