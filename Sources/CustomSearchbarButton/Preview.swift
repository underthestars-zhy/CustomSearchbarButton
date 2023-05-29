//
//  Preview.swift
//  
//
//  Created by 朱浩宇 on 2023/5/29.
//

import SwiftUI

struct SwiftUIView: View {
    @State var text = ""
    @State var change = false

    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                List(1..<10, id: \.self) { id in
                    Text("\(change ? "\(id)" : "HI")")
                }
                .searchable(text: $text)
                .navigationTitle("Search")
                .searchbarButton(image: UIImage(systemName: "star")!, type: .bookmark, visibility: .visible) {
                    change.toggle()
                }
            }

        } else {
            // Fallback on earlier versions
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}

struct SwiftUIView2_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
