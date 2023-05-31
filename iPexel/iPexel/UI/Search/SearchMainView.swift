//
//  SearchMainView.swift
//  iPexel
//
//  Created by mobile_ on 2023/05/31.
//

import SwiftUI

struct SearchMainView: View {
    
    @State var tabNumber = 0
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            SearchTabBarView(currentTab: $tabNumber)
            switch tabNumber {
            case 0:
                ImageSearchView()
            case 1:
                Text("Video!")
            default:
                EmptyView()
            }
            Spacer()
        }
    }
}

struct SearchMainView_Previews: PreviewProvider {
    static var previews: some View {
        SearchMainView()
    }
}


struct SearchTabBarView: View {
    @Binding var currentTab: Int
    @Namespace var namespace
    var tabBarOptions: [String] = ["Image", "Video"]
    
    var body: some View {
        HStack(spacing: 20) {
            Spacer()
            
            ForEach(tabBarOptions.indices, id: \.self) { index in
                let title = tabBarOptions[index]
                SearchTabBarItem(currentTab: $currentTab,
                           namespace: namespace, title: title,
                           tab: index)
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .background(Color.white)
        .frame(height: 40)
    }
}


struct SearchTabBarItem: View {
    @Binding var currentTab: Int
    let namespace: Namespace.ID
    
    var title: String
    var tab: Int
    
    var body: some View {
        Button {
            currentTab = tab
        } label: {
            VStack {
                Spacer()
                Text(title)
                if currentTab == tab {
                    Color.black
                        .frame(height: 2)
                        .matchedGeometryEffect(id: "underline",
                                               in: namespace.self)
                } else {
                    Color.clear.frame(height: 2)
                }
            }
            .animation(.spring(), value: currentTab)
        }
        .buttonStyle(.plain)
    }
}
