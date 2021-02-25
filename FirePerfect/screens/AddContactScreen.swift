//
//  AddContactScreen.swift
//  FirePerfect
//
//  Created by Зехниддин on 19/02/21.
//

import SwiftUI

struct AddContactScreen: View {
    @Environment(\.presentationMode) var presentation
    
    @ObservedObject var database = RealtimeStore()
    @ObservedObject var storage = StorageStore()
    
    @State var defImage = UIImage(imageLiteralResourceName: "ic_picker")
    @State var pickedImage: UIImage? = nil
    @State var showImagePicker: Bool = false
    @State var firstname: String = ""
    @State var lastname: String = ""
    @State var phone: String = ""
    @State var isLoading = false
    
    func AddNewContact() {
        isLoading = true
        if pickedImage != nil {
            uploadImage()
        }
    }
    
    func uploadContact(urlString: String) {
        let contact = Contact(firstname: firstname, lastname: lastname, phone: phone, imgUrl: urlString)
        database.storeContact(contact: contact) { (success) in
            isLoading = false
            if success {
                print(success)
                self.presentation.wrappedValue.dismiss()
            }
        }
    }
    
    func uploadImage() {
        storage.uploadImage(pickedImage!, completion: { (downloadURL) in
            let urlString = downloadURL!.absoluteString
            print(urlString)
            uploadContact(urlString: urlString)
        })
    }
    
    var body: some View {
        ZStack {
            VStack {
                Button(action: {
                    self.showImagePicker.toggle()
                }) {
                    Image(uiImage: pickedImage ?? defImage).resizable()
                        .frame(width: 100, height: 100).scaledToFit()
                }
                .sheet(isPresented: $showImagePicker, onDismiss: {
                    self.showImagePicker = false
                }, content: {
                    ImagePicker(image: self.$pickedImage, isShown: $showImagePicker)
                })
                
                TextField("Firstname", text: $firstname)
                    .frame(height: 50)
                    .padding(.leading, 10)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                TextField("Lastname", text: $lastname)
                    .frame(height: 50)
                    .padding(.leading, 10)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                TextField("Phone", text: $phone)
                    .frame(height: 50)
                    .padding(.leading, 10)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                Button(action: {
                    uploadImage()
                }) {
                    Spacer()
                    Text("Add").foregroundColor(.white)
                    Spacer()
                }
                .frame(height: 45)
                .background(Color.red)
                .cornerRadius(8)
                Spacer()
            }.padding()
        }
        .navigationBarTitle("Add Contact", displayMode: .inline)
    }
}

struct AddContactScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddContactScreen()
    }
}
