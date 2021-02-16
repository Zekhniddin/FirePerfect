//
//  HomeScreen.swift
//  FirePerfect
//
//  Created by Зехниддин on 16/02/21.
//

import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject var session: SessionStore
    
    @State private var isLoading = false
    
    func doSignOut() {
        isLoading = true
        if SessionStore().signOut() {
            isLoading = false
            session.listen()
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                if let email = session.session?.email {
                    Text("Welcome \(email)")
                }
                
                if isLoading {
                    ProgressView()
                }
            }
            .navigationBarItems(trailing:
                                    HStack {
                                        Image("ic_add")
                                        Button(action: {
                                            doSignOut()
                                        }) {
                                            Image("ic_exit")
                                        }
                                    })
            .navigationBarTitle("Posts", displayMode: .inline)
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
