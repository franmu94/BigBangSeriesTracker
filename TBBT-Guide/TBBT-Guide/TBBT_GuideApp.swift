//
//  TBBT_GuideApp.swift
//  TBBT-Guide
//
//  Created by Fran Malo on 21/8/24.
//

import SwiftUI

@main
struct TBBT_GuideApp: App {
    @State var viewModel = EpisodesListViewModel()
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environment(viewModel)
        }
    }
}
