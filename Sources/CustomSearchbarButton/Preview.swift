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
                .searchbarMenuButton(image: UIImage(systemName: "star")!, menu: createMenu(), mode: .always)
            }

        } else {
            // Fallback on earlier versions
        }
    }

    func createMenu() -> UIMenu {
        let usersItem = UIAction(title: "Users", image: UIImage(systemName: "person.fill")) { (action) in

            print("Users action was tapped")
        }

        let addUserItem = UIAction(title: "Add User", image: UIImage(systemName: "person.badge.plus")) { (action) in

            print("Add User action was tapped")
        }

        let removeUserItem = UIAction(title: "Remove User", image: UIImage(systemName: "person.fill.xmark.rtl")) { (action) in
            print("Remove User action was tapped")
        }

        let menu = UIMenu(title: "My Menu", options: .displayInline, children: [usersItem , addUserItem , removeUserItem])

        return menu
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
