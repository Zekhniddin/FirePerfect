//
//  ContactCell.swift
//  FirePerfect
//
//  Created by Зехниддин on 19/02/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContactCell: View {
    var contact: Contact
    
    var body: some View {
        HStack {
            if contact.imgUrl != nil {
                WebImage(url: URL(string: contact.imgUrl!)).resizable()
                    .frame(width: 100, height: 100)
            } else {
                Image("ic_picker").resizable()
                    .frame(width: 100, height: 100)
            }
            VStack(alignment: .leading, spacing: 8) {
                Text("\(contact.firstname!) \(contact.lastname!)").foregroundColor(.red).fontWeight(.bold)
                Text(contact.phone!)
            }.padding(10)
            Spacer()
        }
    }
}

struct ContactCell_Previews: PreviewProvider {
    static var previews: some View {
        ContactCell(contact: Contact(firstname: "Firstname", lastname: "Lastname", phone: "1234567"))
    }
}
