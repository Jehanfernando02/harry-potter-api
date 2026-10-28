//
//  ContentView.swift
//  HarryPotterApp
//
//  Created by Jehan Fernando on 2026-10-28.
//

import SwiftUI

struct ContentView: View {
    
        @State private var books: [HarryPotterModel] = []
        
        var body: some View {
            NavigationStack {
                Group {
                    if books.isEmpty {
                        ProgressView()
                    } else {
                        List {
                            ForEach(books) { book in
                                VStack {
                                    Text(book.title)
                                    Text(book.authorName)
                                    Text(String(book.firstPublishYear))
                                   
                                }
                            }
                        }
                    }
                }
                .navigationTitle("HarryPotter Books")
                .task {
                    await fetchBookData()
                }
            }
            
        }
        
        func fetchBookData() async {
            guard let url = URL(string: "https://openlibrary.org/search.json?q=harry+potter") else { return }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            do {
                let (data, urlResponse) = try await URLSession.shared.data(for: request)
                
                guard let httpResponse = urlResponse as? HTTPURLResponse else { return }
                print("pass")
                
                guard (200...299).contains(httpResponse.statusCode) else { return }
                print("pass")
                
               
                books = try JSONDecoder().decode([HarryPotterModel].self, from: data)
                print("pass")
                
              
                
            } catch {
                print("something went wrong, please try again:\(error)")
            }
        }
    }



