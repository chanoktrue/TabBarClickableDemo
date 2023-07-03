//
//  ContentView.swift
//  TabBarClicableDemo
//
//  Created by Thongchai Subsaidee on 3/7/23.
//

import SwiftUI

enum Tab: CaseIterable {
    case red, yellow, blue
    var title: String {String(describing: self).capitalized}
}

struct ContentView: View {
    
    @Namespace private var animation
    @State private var selectedTab: Tab = .red
    
    func view(tab: Tab) -> some View {
            switch tab {
                case .red: return Color.red.ignoresSafeArea().id(tab)
                case .yellow: return Color.yellow.ignoresSafeArea().id(tab)
                case .blue: return Color.blue.ignoresSafeArea().id(tab)
            }
        }

    
    var body: some View {
            TabView(selection: $selectedTab) {
                ForEach(Tab.allCases, id: \.self, content: view(tab:))
            }
            .overlay(
                HStack {
                    ForEach(Tab.allCases, id: \.self) { tab in
                        Button { selectedTab = tab } label: { Text(String(describing: tab).capitalized).frame(maxWidth: .infinity) }
                            .foregroundColor(tab == selectedTab ? .white : .gray)
                            .fontWeight(tab == selectedTab ? .bold : .regular)
                            .padding()
                            .background {
                                if tab == selectedTab {
                                    Capsule().fill(.green)
                                        .matchedGeometryEffect(id: "SELECTED", in: animation)
                                }
                            }
                    }
                }
                .frame(maxWidth: .infinity).padding(4)
                .background(Capsule().fill(.white)).padding()
            )
            .tabViewStyle(.page(indexDisplayMode:.never))
            .animation(.default, value: selectedTab) 
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
