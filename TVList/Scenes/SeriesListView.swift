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
                ForEach(viewModel.series.indices, id: \.self) { index in
                    let serie = viewModel.series[index]
                    HStack {
                        AsyncImage(url: URL(string: serie.image.medium)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxHeight: 80)
                        } placeholder: {
                            Image(systemName: "photo")
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
