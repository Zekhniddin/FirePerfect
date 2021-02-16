//
//  SignInScreen.swift
//  FirePerfect
//
//  Created by Зехниддин on 16/02/21.
//

import SwiftUI

struct SignInScreen: View {
    @EnvironmentObject var session: SessionStore
    
    @State private var email = ""
    @State private var password = ""
    @State private var isLoading = false
    @State private var showingSignUpScreen = false
    
    func doSignIn() {
        isLoading = true
        SessionStore().signIn(email: email, password: password) { (res, err) in
            isLoading = false
            if err != nil {
                print("Check email or password")
                return
            }
            print("User signed in")
            session.listen()
        }
    }
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Text("Welcome Back")
                    .foregroundColor(.red)
                    .font(.system(size: 30))
                TextField("Email", text: $email)
                    .frame(height: 50)
                    .padding(.leading, 10)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(25)
                
                SecureField("Password", text: $password)
                    .frame(height: 50)
                    .padding(.leading, 10)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(25)
                Button(action: {
                    doSignIn()
                }) {
                    Spacer()
                    Text("Sign In").foregroundColor(.white)
                    Spacer()
                }
                .frame(height: 50)
                .background(Color.red)
                .cornerRadius(25)
                Spacer()
                VStack {
                    Spacer()
                    HStack {
                        Text("Don't have an account?")
                        Button(action: {
                            self.showingSignUpScreen.toggle()
                        }) {
                            Text("Sign Up").foregroundColor(.red)
                        }
                        .sheet(isPresented: $showingSignUpScreen) {
                            SignUpScreen()
                        }
                    }
                }.frame(maxWidth: .infinity, maxHeight: 200)
            }.padding()
            
            if isLoading {
                ProgressView()
            }
        }
    }
}

struct SignInScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignInScreen()
    }
}
