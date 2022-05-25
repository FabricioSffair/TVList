//
//  ContentView.swift
//  TVList
//
//  Created by Fabrício Sperotto Sffair on 2022-05-20.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = SeriesListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.filteredSeries.indices, id: \.self) { index in
                    let serie = viewModel.filteredSeries[index]
                    HStack {
                        AsyncImage(url: URL(string: serie.image?.medium ?? "")) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 80)
                        } placeholder: {
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 80)
                        }
                        Text(serie.name)
                    }
                    .onAppear {
                        viewModel.loadMoreIfNeeded(index)
                    }
                }
            }
            .refreshable {
                viewModel.refresh()
            }
            .padding()
            .onAppear {
                viewModel.refresh()
            }
            .navigationTitle("TVMaze Series")
        }
        .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
        .onSubmit(of: .search) {
            viewModel.search()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
