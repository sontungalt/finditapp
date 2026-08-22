//
//  BrowseView.swift
//  finditapp
//

import SwiftUI

struct BrowseView: View {
    @Binding var posts: [LostFoundPost]
    @State private var selectedCategory = "All"
    
    private let categories = ["All", "Bottle", "Stationery", "Electronics", "Clothing", "Household", "Sporting Goods", "Other"]
    private let pageBackground = Color(.systemGroupedBackground)
    
    private var filteredPosts: [LostFoundPost] {
        if selectedCategory == "All" {
            return posts
        }
        
        return posts.filter { $0.category == selectedCategory }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(categories, id: \.self) { category in
                        Button {
                            selectedCategory = category
                        } label: {
                            Text(category)
                                .font(.system(size: 16, weight: .medium))
                                .foregroundStyle(selectedCategory == category ? .white : .secondary)
                                .padding(.horizontal, 18)
                                .padding(.vertical, 10)
                                .background {
                                    Capsule()
                                        .fill(selectedCategory == category ? Color.blue : Color.clear)
                                }
                                .overlay {
                                    Capsule()
                                        .stroke(Color.gray.opacity(selectedCategory == category ? 0 : 0.35), lineWidth: 1)
                                }
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 12)
            }
            .background(Color(.systemBackground))
            
            List(filteredPosts) { post in
                LostFoundPostRow(post: post)
            }
            .scrollContentBackground(.hidden)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(pageBackground)
        .navigationTitle("Browse")
    }
}

#Preview {
    NavigationStack {
        BrowseView(posts: .constant([
            LostFoundPost(
                title: "Blue Water Bottle",
                category: "Bottle",
                foundLocation: "Library",
                foundDate: .now,
                description: "Found on a study table."
            )
        ]))
    }
}
