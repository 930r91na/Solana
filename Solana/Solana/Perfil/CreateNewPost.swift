//
//  CreateNewPost.swift
//  Solana
//
//  Created by Andrea Lima Blanca on 27/08/23.
//

import SwiftUI
import PhotosUI
import Firebase
import FirebaseStorage

struct CreateNewPost: View {
    var onPost: (Post)->()
    @State private var postText: String = ""
    @State private var postImageData: Data?
    @AppStorage("user_profile_url") private var profileURL: URL?
    @AppStorage("user_name") private var userName: String = ""
    @AppStorage("user_UID") private var userUID: String = ""
    @Environment(\.dismiss) private var dismiss
    @State private var isLoading: Bool = false
    @State private var errorMessage: String = ""
    @State private var showError: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var photoItem: PhotosPickerItem?
    @FocusState private var showKeyboard: Bool
    var body: some View {
        VStack(spacing: 10) {
                    HStack {
                        Menu {
                            Button("Cancelar", role: .destructive) {
                                dismiss()
                            }
                        } label: {
                            Text("Cancelar")
                                .font(.headline)
                                .foregroundColor(.gray)
                        }
                        .hAlign(.leading)
                        
                        Spacer()
                        
                        Button(action: createPost) {
                            Text("Publicar")
                                .font(.headline)
                                .foregroundColor(postText.isEmpty ? .gray : .white)
                                .padding(.horizontal, 15)
                                .padding(.vertical, 8)
                                .background(postText.isEmpty ? Color.gray.opacity(0.3) : Color.blue)
                                .cornerRadius(20)
                        }
                        .disabled(postText.isEmpty)
                    }
                    .padding(.horizontal, 15)
                    .padding(.vertical, 10)
                    .background(Color.white)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 15) {
                            Text("Cuéntanos algo")
                                .font(.title)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.trailing)
                                .padding(.trailing, 120.0)
                            TextEditor( text: $postText)
                                .padding(10)
                                .cornerRadius(10)
                                .frame(minHeight: 40)

                            
                            if let postImageData, let image = UIImage(data: postImageData) {
                                Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(height: 220)
                                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                    .overlay(alignment: .topTrailing) {
                                        Button {
                                            withAnimation(.easeInOut(duration: 0.25)) {
                                                self.postImageData = nil
                                            }
                                        } label: {
                                            Image(systemName: "trash")
                                                .padding(10)
                                                .background(Color.white.opacity(0.7))
                                                .clipShape(Circle())
                                        }
                                    }
                            }
                        }
                        .padding(15)
                    }
                    
                    Divider()
                    
                    HStack {
                        Button {
                            showImagePicker.toggle()
                        } label: {
                            Image(systemName: "photo.on.rectangle")
                                .font(.title2)
                                .foregroundColor(.blue)
                        }
                        .hAlign(.leading)
                        
                        Spacer()
                        
                        Button("Listo") {
                            showKeyboard = false
                        }
                        .opacity(showKeyboard ? 1 : 0)
                        .animation(.easeInOut(duration: 0.15), value: showKeyboard)
                    }
                    .padding(.horizontal, 15)
                    .padding(.vertical, 10)
                }
                .background(Color.gray.opacity(0.05))
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                .padding(10)
        .vAlign(.top)
        .photosPicker(isPresented: $showImagePicker, selection: $photoItem)
        .onChange(of: photoItem) { newValue in
            if let newValue{
                Task{
                    if let rawImageData = try? await newValue.loadTransferable(type: Data.self),let image = UIImage(data: rawImageData),let compressedImageData = image.jpegData(compressionQuality: 0.5){
                        await MainActor.run(body: {
                            postImageData = compressedImageData
                            photoItem = nil
                        })
                    }
                }
            }
        }
        .alert(errorMessage, isPresented: $showError, actions: {})
        .overlay {
            capaCarga(show: $isLoading)
        }
    }
    func createPost(){
        isLoading = true
        showKeyboard = false
        Task{
            do{
                guard let profileURL = profileURL else{return}
                let imageReferenceID = "\(userUID)\(Date())"
                let storageRef = Storage.storage().reference().child("Post_Images").child(imageReferenceID)
                if let postImageData{
                    let _ = try await storageRef.putDataAsync(postImageData)
                    let downloadURL = try await storageRef.downloadURL()
                    let post = Post(text: postText, imageURL: downloadURL, imageReferenceID: imageReferenceID, userName: userName, userUID: userUID, userProfileURL: profileURL)
                    try await createDocumentAtFirebase(post)
                }else{
                    let post = Post(text: postText, userName: userName, userUID: userUID, userProfileURL: profileURL)
                    try await createDocumentAtFirebase(post)
                }
            }catch{
                await setError(error)
            }
        }
    }
    
    func createDocumentAtFirebase(_ post: Post)async throws{
        let doc = Firestore.firestore().collection("Posts").document()
        let _ = try doc.setData(from: post, completion: { error in
            if error == nil{
                isLoading = false
                var updatedPost = post
                updatedPost.id = doc.documentID
                onPost(updatedPost)
                dismiss()
            }
        })
    }
    func setError(_ error: Error)async{
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            showError.toggle()
        })
    }
}

struct CreateNewPost_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewPost{_ in
            
        }
    }
}

