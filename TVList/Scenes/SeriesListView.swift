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
                ForEach(viewModel.series) { serie in
                    Text(serie.name)
                        .onAppear {
                            
                        }
                }
            }
            .refreshable {
                viewModel.refresh()
            }
            .padding()
            .onAppear {
                viewModel.loadMoreIfNeeded()
            }
            .navigationTitle("A")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
