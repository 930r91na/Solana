//
//  LogInScreen.swift
//  Solana
//
//  Created by Andrea Lima Blanca on 18/08/23.
//
import SwiftUI
import PhotosUI
import Firebase
import FirebaseFirestore
import FirebaseStorage


struct LogInScreen: View {
    // Estos serán los datos que el usuario debe ingresar
    @State private var navigateToSocial = false
    @State var email: String = ""
    @State var password: String = ""
    @State var createAccount: Bool = false
    @State var showError: Bool = false
    @State var errorMessage: String = ""
    @State var isLoading: Bool = false
    @AppStorage ("log_status") var logstatus: Bool = false
    @AppStorage ("user_name") var userNameStored: String = ""
    @AppStorage ("user_UID") var userUID: String = ""
    @AppStorage("user_profile_url") var profileURL: URL?
    var body: some View {
        NavigationView{
            VStack (spacing:10){
                NavigationLink(destination: SocialView(), isActive: $navigateToSocial) { EmptyView() }
                Text("Bienvenido a Solana")
                    .font(.largeTitle.bold())
                    .hAlign(.leading)
                Image("logo")
                VStack(spacing: 12){
                    TextField("Correo electrónico", text: $email)
                        .textContentType(.emailAddress)
                        .border(2, Color("figma").opacity(0.5))
                        .padding(.top, 25)
                        .autocapitalization(.none)
                    SecureField("Contraseña", text: $password)
                        .textContentType(.emailAddress)
                        .border(2, Color("figma").opacity(0.5))
                    Button("Olvidé mi contraseña", action: resetPassword)
                        .font(.callout)
                        .padding(.top, 20)
                        .foregroundColor(Color("figma"))
                    
                    Button(action: loginUser){
                        Text ("Iniciar sesión")
                            .foregroundColor(.white)
                            .hAlign(.center)
                            .fillView(Color("figma"))
                    }
                    .padding(15)
                }
                HStack{
                    Text("¿Aún no tienes una cuenta?")
                        .foregroundColor(.gray)
                    Button("Regístrate ahora"){
                        createAccount.toggle()
                    }
                    .foregroundColor(Color("figma"))
                    
                }
                .vAlign(.bottom)
            }
            .vAlign(.top)
            .padding(15)
            .overlay(content: {
                capaCarga(show:$isLoading)
            })
            .fullScreenCover(isPresented: $createAccount){
                RegistrationView()
            }
            .alert(errorMessage, isPresented: $showError, actions:{})
            .navigationBarBackButtonHidden(true)
        } .navigationBarBackButtonHidden(true)
    }
    func loginUser(){
        isLoading=true
        closeKeyboard()
        Task{
            do{
                try await Auth.auth().signIn(withEmail:email, password: password)
                print("User Found")
                try await fetchUser()
            }catch{
                await setError(error)
            }
        }
    }
    func fetchUser()async throws{
        guard let userID = Auth.auth().currentUser?.uid else{return}
        let user = try await Firestore.firestore().collection("User").document(userID).getDocument(as: User.self)
        await MainActor.run(body:{
            userUID=userID
            userNameStored = user.userNombreCompleto
            profileURL = user.userProfileURL
            logstatus=true
            navigateToSocial = true
        })
    }
    func resetPassword(){
        Task{
            do{
                try await Auth.auth().sendPasswordReset(withEmail: email)
                print("Link Sent")
            }catch{
                await setError(error)
            }
        }
    }
    func setError(_ error: Error) async {
        await MainActor.run(body:{
            errorMessage = error.localizedDescription
            showError.toggle()
            isLoading=false
        })
    }
}



struct LogInScreen_Previews: PreviewProvider {
    static var previews: some View {
        LogInScreen()
    }
}
