//
//  RegistrationView.swift
//  Solana
//
//  Created by Andrea Lima Blanca on 27/08/23.
//

import SwiftUI
import PhotosUI
import Firebase
import FirebaseFirestore
import FirebaseStorage


struct RegistrationView: View {
    @State private var navigateToWalkthrough = false
    @State private var navigateToLogIn = false
    @State var userProfilePic: Data?
    @State var nombreCompleto: String = ""
    @State var userBioLink: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @AppStorage("user_profile_url") var profileURL: URL?
    @State private var selectedGender: String = "Masculino"
    let genderOptions = ["Masculino", "Femenino", "Otro", "Prefiero no decir"]
    @State private var selectedAge: Int = 18
    let ageRange = Array(18...100)
    @State private var checked = false
    @State private var selectedState: String = "Puebla"
    let stateOptions = [
        "Aguascalientes",
        "Baja California",
        "Baja California Sur",
        "Campeche",
        "Chiapas",
        "Chihuahua",
        "Coahuila",
        "Colima",
        "Durango",
        "Guanajuato",
        "Guerrero",
        "Hidalgo",
        "Jalisco",
        "Estado de México",
        "Michoacán",
        "Morelos",
        "Nayarit",
        "Nuevo León",
        "Oaxaca",
        "Puebla",
        "Querétaro",
        "Quintana Roo",
        "San Luis Potosí",
        "Sinaloa",
        "Sonora",
        "Tabasco",
        "Tamaulipas",
        "Tlaxcala",
        "Veracruz",
        "Yucatán",
        "Zacatecas"
    ]
    @Environment (\.dismiss) var dismiss
    @State var showImagePicker: Bool = false
    @State var photoItem: PhotosPickerItem?
    @State var showError: Bool = false
    @State var errorMessage: String = ""
    @State var isLoading: Bool = false
    @AppStorage ("log_status") var logstatus: Bool = false
    @AppStorage ("user_name") var userNameStored: String = ""
    @AppStorage ("user_UID") var userUID: String = ""
    var body: some View {
        NavigationView{
            VStack (spacing:10){
                NavigationLink(destination: WalkthroughScreen(), isActive: $navigateToWalkthrough) { EmptyView() }
                NavigationLink(destination: LogInScreen(), isActive: $navigateToLogIn) { EmptyView() }
                Text("¿Aún no tienes cuenta?")
                    .font(.title.bold())
                    .hAlign(.leading)
                Text("Regístrate")
                    .font(.largeTitle.bold())
                    .hAlign(.leading)
                ViewThatFits{
                    ScrollView(.vertical, showsIndicators: false){
                        HelperView()
                    }
                    HelperView()
                }
                HStack{
                    Text("¿Ya tienes cuenta?")
                        .foregroundColor(.gray)
                    Button("Entra ahora"){
                        navigateToLogIn=true
                    }
                    .foregroundColor(Color("figma"))
                    
                }
                .vAlign(.bottom)
            }
            .vAlign(.top)
            .padding(15)
            .overlay(content:{
                capaCarga(show: $isLoading)
            })
            .photosPicker(isPresented: $showImagePicker, selection: $photoItem)
            .onChange(of: photoItem){newValue in
                if let newValue{
                    Task{
                        do{
                            guard let imageData = try await newValue.loadTransferable(type: Data.self) else{return}
                            await MainActor.run(body:{
                                userProfilePic = imageData
                            })
                        } catch{}
                    }
                }
            }
            .alert(errorMessage, isPresented: $showError, actions: {})
        }
    }
    @ViewBuilder
    func HelperView()->some View{
        VStack(spacing: 12){
            ZStack{
                if let userProfilePic, let image = UIImage(data: userProfilePic){
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
            }
            .frame(width: 85, height: 85)
            .clipShape(Circle())
            .contentShape(Circle())
            .onTapGesture {
                showImagePicker.toggle()
            }
            .padding(.top, 25)
            TextField("Nombre completo", text: $nombreCompleto)
                .textContentType(.emailAddress)
                .border(2, Color("figma").opacity(0.5))
                .padding(.top, 25)
            TextField("Correo electrónico", text: $email)
                .textContentType(.emailAddress)
                .autocapitalization(.none)
                .border(2, Color("figma").opacity(0.5))
            SecureField("Contraseña", text: $password)
                .textContentType(.emailAddress)
                .border(2, Color("figma").opacity(0.5))
            HStack {
                Picker("Género", selection: $selectedGender) {
                    ForEach(genderOptions, id: \.self) {
                        gender in
                        Text(gender).tag(gender)
                    }
                    
                }
                .pickerStyle(MenuPickerStyle())
                .border(2, Color("figma").opacity(0.5))
                Picker("Edad", selection: $selectedAge) {
                    ForEach(ageRange, id: \.self) {
                        age in
                        Text("\(age) años").tag(age)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .border(2, Color("figma").opacity(0.5))
            }
            Picker("¿De dónde eres?", selection: $selectedState) {
                ForEach(stateOptions, id: \.self) {
                    states in
                    Text(states).tag(states)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .border(2, Color("figma").opacity(0.5))
            HStack {
                iOSCheckboxToggleStyle(checked: $checked)
                VStack{
                    Text("Estoy de acuerdo con los")
                    NavigationLink("términos y condiciones", destination: TerminosCondiciones())
                }.padding()
            }
            Button(action: registerUser){
                Text ("Regístrate")
                    .foregroundColor(.white)
                    .hAlign(.center)
                    .fillView(Color("figma"))
            }
            .disableWithOpacity(nombreCompleto=="" || email=="" || password=="" || userProfilePic==nil || checked==false)
            .padding(15)
        }
    }
    func registerUser(){
        isLoading = true
        closeKeyboard()
        Task{
            do{
                try await Auth.auth().createUser(withEmail: email, password: password)
                guard let userUID = Auth.auth().currentUser?.uid else{return}
                guard let imageData = userProfilePic else {return}
                let storageRef = Storage.storage().reference().child("Profile_Images").child(userUID)
                let _ = try await storageRef.putDataAsync(imageData)
                let downloadURL = try await storageRef.downloadURL()
                let user = User(userNombreCompleto: nombreCompleto, userEmail: email, userGender: selectedGender, userAge: selectedAge, userState: selectedState, userUID: userUID, userProfileURL: downloadURL, userBioLink: userBioLink)
                let _ = try Firestore.firestore().collection("User").document(userUID).setData(from: user, completion: {
                    error in
                    if error == nil{
                        print("Guardado exitosamente")
                        userNameStored=nombreCompleto
                        self.userUID=userUID
                        profileURL = downloadURL
                        logstatus=true
                        navigateToWalkthrough = true
                    }
                })
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

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
