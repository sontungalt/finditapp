//
//  SettingsView.swift
//  finditapp
//

import SwiftUI

struct SettingsView: View {
    private let pageBackground = Color(.systemGroupedBackground)
    
    var body: some View {
        Text("Settings Screen Content")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(pageBackground)
            .navigationTitle("Settings")
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}
