import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            Week1View()
                .tabItem {
                    Label("Week 1", systemImage: "1.circle")
                }
            
            Week2View()
                .tabItem {
                    Label("Week 2", systemImage: "2.circle")
                }
        }
    }
}
