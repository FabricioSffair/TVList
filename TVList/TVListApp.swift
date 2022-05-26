//
//  TVListApp.swift
//  TVList
//
//  Created by Fabrício Sperotto Sffair on 2022-05-20.
//

import SwiftUI

@main
struct TVListApp: App {
    var body: some Scene {
        WindowGroup {
            SeriesListView(viewModel: SeriesListViewModel())
        }
    }
}
