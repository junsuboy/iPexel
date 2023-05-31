//
//  MainTabView.swift
//  iPexel
//
//  Created by mobile_ on 2023/05/31.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            SearchMainView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                .toolbar(.visible, for: .tabBar)
                .toolbarBackground(Color.white, for: .tabBar)
            PopularMainView()
                .tabItem {
                    Image(systemName: "flame")
                    Text("Popular")
                }
                .badge(1)
                .toolbar(.visible, for: .tabBar)
                .toolbarBackground(Color.white, for: .tabBar)
        }
        .font(.headline)
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
