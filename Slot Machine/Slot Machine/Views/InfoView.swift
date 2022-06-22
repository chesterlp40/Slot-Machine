//
//  InfoView.swift
//  Slot Machine
//
//  Created by Ezequiel Rasgido on 21/06/2022.
//

import SwiftUI

struct InfoView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            LogoView()
            
            Spacer()
            
            Form {
                Section(header: Text("About the application")) {
                    FormRowView(
                        firstItem: "Application",
                        lastItem: "Slot Machine"
                    )
                    FormRowView(
                        firstItem: "Platforms",
                        lastItem: "iPhone, iPad, Mac"
                    )
                    FormRowView(
                        firstItem: "Developer",
                        lastItem: "Ezequiel Rasgido"
                    )
                    FormRowView(
                        firstItem: "Designer",
                        lastItem: "Ezequiel Rasgido"
                    )
                    FormRowView(
                        firstItem: "Music",
                        lastItem: "Dan Lebowitz"
                    )
                    FormRowView(
                        firstItem: "Copyright",
                        lastItem: "© 2022 All rights reserved."
                    )
                    FormRowView(
                        firstItem: "Version",
                        lastItem: "1.0.0"
                    )
                }
            }
            .font(.system(.body, design: .rounded))
        }
        .padding(.top, 40)
        .overlay(
            Button(action: {
                audioPlayer?.stop()
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark.circle")
                    .font(.title)
            }
                .onAppear {
                    playSound(
                        sound: "background-music",
                        type: "mp3"
                    )
                }
                .padding(.top, 30)
                .padding(.trailing, 20)
                .tint(.secondary),
                alignment: .topTrailing
        )
    }
}

struct FormRowView: View {
    var firstItem: String
    var lastItem: String
    
    var body: some View {
        HStack {
            Text(firstItem).foregroundColor(.gray)
            Spacer()
            Text(lastItem)
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
