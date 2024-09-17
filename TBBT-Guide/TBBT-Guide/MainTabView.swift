//
//  MainTabView.swift
//  TBBT-Guide
//
//  Created by Fran Malo on 17/9/24.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            EpisodeList()
                .tabItem {
                    Label("Episode List", systemImage:  "list.dash")
                }
            FavoriteGrid()
                .tabItem {
                    Label("Favorites", systemImage:  "heart.fill")
                }
        }
    }
}

#Preview {
    MainTabView()
        .environment(EpisodesListViewModel())

}
