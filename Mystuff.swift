//
//  MyStuffView.swift
//  finditapp
//

import SwiftUI

struct MyStuffView: View {
    private let pageBackground = Color(.systemGroupedBackground)
    
    var body: some View {
        Text("Your stuff")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(pageBackground)
            .navigationTitle("My stuff")
    }
}

#Preview {
    NavigationStack {
        MyStuffView()
    }
}
