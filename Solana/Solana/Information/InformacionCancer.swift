//
//  InformacionCancer.swift
//  Solana
//
//  Created by Andrea Lima Blanca on 28/08/23.
//
import SwiftUI

struct InformacionCancer: View {
    // Data
    let cancers = ["Mama", "Próstata", "Pulmón"]
    
    let definitions = [
        "Mama": "El cáncer de mama es uno de los tipos de cáncer más diagnosticados en mujeres. Se origina cuando las células en el seno comienzan a crecer de manera descontrolada. Los síntomas pueden incluir un bulto en el seno, cambios en la forma o tamaño del seno, o secreción del pezón.",
        "Pulmón": "El cáncer de pulmón es uno de los tipos..."
    ]
    
    let details = [
        "Mama": [
            "Síntomas": "Los síntomas del cáncer de mama son: Bulto o engrosamiento en el seno o cerca de él, cambio en el tamaño, forma o apariencia del seno, secreción del pezón que no sea leche materna, que podría ser sangrienta, cambio en la apariencia de la piel del seno (arrugada, hundida, o con aspecto de cáscara de naranja) y dolor en el seno.",
            "Riesgos": "Algunos riesgos del cáncer de mama son: Ser mujer, tener edad avanzada, historia familiar de cáncer de mama o de ovario, exposición prolongada a estrógenos (incluso por terapia de reemplazo hormonal), menstruación temprana o menopausia tardía o no haber tenido hijos o tener el primero después de los 30 años.",
            "Tratamiento": "El cáncer de mama se puede tratar de las siguientes maneras: Cirugía para extirpar el tumor, radioterapia, terapia hormonal, quimioterapia, terapia dirigida o inmunoterapia"
        ],
        "Próstata": [
            "Síntomas": "Los síntomas del cáncer de próstata son:...",
            "Riesgos": "Algunos riesgos del cáncer de próstata son:...",
            "Tratamiento": "El cáncer de próstata se puede tratar..."
        ],
        "Pulmón": [
            "Síntomas": "Los síntomas del cáncer de pulmón son:...",
            "Riesgos": "Algunos riesgos del cáncer de pulmón son:...",
            "Tratamiento": "El cáncer de pulmón se puede tratar..."
        ]
    ]
    
    // State
    @State private var selectedCancer = "Mama"
    @State private var showingDetailPopup = false
    @State private var selectedDetail = ""
    
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer(minLength: 50)
            
            // Title
            Text("Información sobre el Cáncer")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .frame(width: 400, height: 100)
            // Dropdown
            Text("¿Sobre qué tipo de cáncer quieres saber?")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .frame(width: 400, height: 100)
            Picker("Selecciona un cáncer:", selection: $selectedCancer) {
                ForEach(cancers, id: \.self) {
                    Text($0)
                        .foregroundColor(.black)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()
            .frame(width: 250)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            .shadow(color: .gray, radius: 5, x: 0, y: 5)
            
            // Buttons
            VStack(spacing: 10) {
                ForEach(["Síntomas", "Riesgos", "Tratamiento"], id: \.self) { detail in
                    Button(action: {
                        withAnimation {
                            selectedDetail = detail
                            showingDetailPopup = true
                        }
                    }) {
                        Text(detail)
                            .padding(.horizontal, 30)
                            .padding(.vertical, 15)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .shadow(color: .gray, radius: 5, x: 0, y: 5)
                    }
                }
            }
            
            Spacer()
            
        }.padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.white]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
        .sheet(isPresented: $showingDetailPopup) {
            
            VStack(spacing: 20) {
                Text(selectedDetail)
                    .font(.headline)
                    .padding()
                Text(details[selectedCancer]?[selectedDetail] ?? "")
                    .padding()
                    .font(.body)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: .gray, radius: 5, x: 0, y: 5)
                
                Spacer()
            }.padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.white]), startPoint: .top, endPoint: .bottom))
        }
    }
}

struct InformacionCancer_Previews: PreviewProvider {
    static var previews: some View {
        InformacionCancer()
    }
}
