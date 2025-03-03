
// Manages app logic using MVVM, connecting Views to Models (e.g., handling user interactions and predictions).



//✔ Variables & Properties:
//
//✅ var selectedScents: [String] → Clear & descriptive
//❌ var ss: [String] → Avoid abbreviations


//✔ Functions:
//
//✅ func fetchPerfumes() -> [Perfume] → Meaningful function names
//❌ func getData() -> [Perfume] → Too vague


//✔ Structs & Classes:
//
//✅ struct Perfume → PascalCase for models
//✅ class PerfumeViewModel → ViewModels should be separate classes


//✔ SwiftUI Views:
//
//✅ struct HomeView: View
//✅ struct RecommendationView: View
//❌ struct Screen1: View → Avoid generic names


//✔ MVVM Pattern:
//
//Models → Perfume.swift (Data structure)
//ViewModels → PerfumeViewModel.swift (Logic & data handling)
//Views → HomeView.swift (UI representation)



//Navigation Between Pages in SwiftUI

//Using `NavigationStack` (iOS 16+)**


//```swift
//import SwiftUI
//
//struct HomeView: View {
//    @State private var showRecommendations = false
//
//    var body: some View {
//        NavigationStack {
//            VStack {
//                Button("Go to Recommendations") {
//                    showRecommendations = true
//                }
//                .navigationDestination(isPresented: $showRecommendations) {
//                    RecommendationView()
//                }
//            }
//            .navigationTitle("Home")
//        }
//    }
//}
//```
//
//---
//



// `NavigationLink`


//```swift
//import SwiftUI
//
//struct HomeView: View {
//    var body: some View {
//        NavigationStack {
//            VStack {
//                NavigationLink("Go to Recommendations", destination: RecommendationView())
//            }
//            .navigationTitle("Home")
//        }
//    }
//}
//```
//
//---
//



// `NavigationPath` for Dynamic Navigation

//```swift
//import SwiftUI
//
//struct ContentView: View {
//    @State private var path = NavigationPath()
//
//    var body: some View {
//        NavigationStack(path: $path) {
//            VStack {
//                Button("Go to Recommendations") {
//                    path.append("recommendation")
//                }
//            }
//            .navigationDestination(for: String.self) { value in
//                if value == "recommendation" {
//                    RecommendationView()
//                }
//            }
//            .navigationTitle("Home")
//        }
//    }
//}
//```
//
