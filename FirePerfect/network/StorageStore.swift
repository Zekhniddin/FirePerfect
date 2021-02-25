
import Foundation
import SwiftUI
import Firebase
import FirebaseStorage

class StorageStore: ObservableObject {
    let storageRef = Storage.storage().reference()
    
    func uploadImage(_ image: UIImage, completion: @escaping (URL?) -> Void) {
        let imageRef = storageRef.child("images/" + timeString() + ".jpg")
        
        guard let imageDate = image.jpegData(compressionQuality: 0.1) else {
            return completion(nil)
        }
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        imageRef.putData(imageDate, metadata: metadata) { [self] (metadata, error) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            imageRef.downloadURL { (url, error) in
                if let error = error {
                    assertionFailure(error.localizedDescription)
                    return completion(nil)
                }
                completion(url)
            }
        }
    }
    
    func timeString() -> String {
        let now = Date()
        let formatter = ISO8601DateFormatter()
        let datetime = formatter.string(from: now)
        print(datetime)
        return datetime
    }
}
