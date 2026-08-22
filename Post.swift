//
//  Post.swift
//  finditapp
//

import SwiftUI


typealias Post2View = PostView

struct PostView: View {
    @Binding var posts: [LostFoundPost]
    @State private var isShowingNewPost = false
    @State private var draftPost = LostFoundPost.newDefaultPost(number: 1)
    
    var body: some View {
        NavigationStack {
            List {
                ForEach($posts) { $post in
                    NavigationLink {
                        LostFoundPostDetailView(post: $post)
                    } label: {
                        LostFoundPostRow(post: post)
                    }
                }
                .onDelete(perform: deletePost)
            }
            .navigationTitle("Post/Found Items")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        startNewPost()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isShowingNewPost) {
                NavigationStack {
                    LostFoundPostForm(post: $draftPost)
                        .navigationTitle("New Found Item")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancel") {
                                    isShowingNewPost = false
                                }
                            }
                            
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Save") {
                                    saveNewPost()
                                }
                                .disabled(draftPost.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                            }
                        }
                }
            }
        }
    }
    
    private func startNewPost() {
        draftPost = LostFoundPost.newDefaultPost(number: posts.count + 1)
        isShowingNewPost = true
    }
    
    private func saveNewPost() {
        withAnimation {
            posts.append(draftPost)
        }
        
        isShowingNewPost = false
    }
    
    private func deletePost(indexSet: IndexSet) {
        posts.remove(atOffsets: indexSet)
    }
}

struct LostFoundPostRow: View {
    let post: LostFoundPost
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(post.title)
                .font(.headline)
            
            Text(post.description)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineLimit(1)
            
            HStack(spacing: 6) {
                Text(post.category)
                Text("•")
                Text(post.foundLocation)
                Text("•")
                Text(post.foundDate.formatted(date: .abbreviated, time: .omitted))
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
        .padding(.vertical, 6)
    }
}

struct LostFoundPostDetailView: View {
    @Binding var post: LostFoundPost
    
    var body: some View {
        LostFoundPostForm(post: $post)
            .navigationTitle("Details")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct LostFoundPostForm: View {
    @Binding var post: LostFoundPost
    
    private let categories = ["Bottle", "Stationery", "Electronics", "Clothing", "Household", "Sporting Goods", "Other"]
    
    var body: some View {
        Form {
            Section("Item Details") {
                TextField("Title", text: $post.title)
                    .textInputAutocapitalization(.sentences)
                Picker("Category", selection: $post.category) {
                    ForEach(categories, id: \.self) { category in
                        Text(category).tag(category)
                    }
                }
            }
            
            Section("Where and When") {
                TextField("Where it was found", text: $post.foundLocation)
                    .textInputAutocapitalization(.words)
                DatePicker("Date found", selection: $post.foundDate, displayedComponents: .date)
            }
            
            Section("Description") {
                TextField("Description", text: $post.description, axis: .vertical)
                    .lineLimit(4, reservesSpace: true)
                    .textInputAutocapitalization(.sentences)
            }
        }
    }
}

struct LostFoundPost: Identifiable {
    let id = UUID()
    var title: String
    var category: String
    var foundLocation: String
    var foundDate: Date
    var description: String
    
    static func newDefaultPost(number: Int) -> LostFoundPost {
        LostFoundPost(
            title: "New Found Item \(number)",
            category: "Other",
            foundLocation: "Unknown location",
            foundDate: .now,
            description: "Add a short description so the owner can identify it."
        )
    }
}

#Preview {
    PostPreview()
}

private struct PostPreview: View {
    @State private var posts: [LostFoundPost] = []
    
    var body: some View {
        PostView(posts: $posts)
    }
}
