//
//  SignUpScreen.swift
//  FirePerfect
//
//  Created by Зехниддин on 16/02/21.
//

import SwiftUI

struct SignUpScreen: View {
    @Environment(\.presentationMode) var presentation
    
    @State private var fullname = ""
    @State private var email = ""
    @State private var password = ""
    @State private var isLoading = false
    
    func doSignUp() {
        isLoading = true
        SessionStore().signUp(email: email, password: password) { (res, err) in
            isLoading = false
            if err != nil {
                print("User not created")
                return
            }
            print("User created")
            presentation.wrappedValue.dismiss()
        }
    }
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Text("Create your account")
                    .foregroundColor(.red)
                    .font(.system(size: 30))
                TextField("Fullname", text: $fullname)
                    .frame(height: 50)
                    .padding(.leading, 10)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(25)
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
                    doSignUp()
                }) {
                    Spacer()
                    Text("Sign Up").foregroundColor(.white)
                    Spacer()
                }
                .frame(height: 50)
                .background(Color.red)
                .cornerRadius(25)
                Spacer()
                VStack {
                    Spacer()
                    HStack {
                        Text("Already have an account?")
                        Button(action: {
                            self.presentation.wrappedValue.dismiss()
                        }) {
                            Text("Sign In").foregroundColor(.red)
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

struct SignUpScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignUpScreen()
    }
}
