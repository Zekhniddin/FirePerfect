//
//  HomeScreen.swift
//  FirePerfect
//
//  Created by Зехниддин on 16/02/21.
//

import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject var session: SessionStore
    
    @ObservedObject var database = RealtimeStore()
    
    @State private var isLoading = false
    
    func doSignOut() {
        isLoading = true
        if SessionStore().signOut() {
            isLoading = false
            session.listen()
        }
    }
    
    func apiContacts() {
        isLoading = true
        database.loadContacts {
            isLoading = false
            print(database.items.count)
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                
                List(database.items, id: \.self) {
                    ContactCell(contact: $0)
                }.listStyle(PlainListStyle())
                
                if isLoading {
                    ProgressView()
                }
            }
            .navigationBarItems(trailing:
                                    HStack {
                                        NavigationLink(destination: AddContactScreen()) {
                                            Image("ic_add")
                                        }
                                        Button(action: {
                                            doSignOut()
                                        }) {
                                            Image("ic_exit")
                                        }
                                    })
            .navigationBarTitle("Contacts", displayMode: .inline)
        }.onAppear {
            apiContacts()
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
