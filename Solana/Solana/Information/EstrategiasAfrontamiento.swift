//
//  EstrategiasAfrontamiento.swift
//  Solana
//
//  Created by Andrea Lima Blanca on 28/08/23.
//

import SwiftUI

struct EstrategiasAfrontamiento: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Estrategias de afrontamiento")
                        .font(.title)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 1)
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 400, height: 80)
                        .background(Color(red: 0.38, green: 0.48, blue: 1).opacity(0.5))
                        .overlay(
                            Text("Conoce cada una")
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .frame(width: 314, height: 25, alignment: .center)
                        )
                        .padding(.bottom, 20)
                    
                    botonEstrategia("Confrontación", destino: ConfrontacionView())
                    botonEstrategia("Planificación", destino: PlanificacionView())
                    botonEstrategia("Autocontrol", destino: AutocontrolView())
                    botonEstrategia("Distanciamiento", destino: DistanciamientoView())
                    botonEstrategia("Responsabilidad", destino: ResponsabilidadView())
                    botonEstrategia("Escape-Evitación", destino: EscapeEvitacionView())
                    botonEstrategia("Reevaluación Positiva", destino: ReevaluacionPositivaView())
                    botonEstrategia("Búsqueda de Apoyo Emocional", destino: BusquedaApoyoEmocionalView())
                }
                .padding()
            }
        }
    }
    
    func botonEstrategia(_ titulo: String, destino: some View) -> some View {
        NavigationLink(destination: destino) {
            Text(titulo)
                .font(.title)
                .frame(width: 250, height: 40)
                .padding()
                .background(Color("figma"))
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct ConfrontacionView: View {
    var body: some View { contenidoEstrategia("Confrontación") }
}

struct PlanificacionView: View {
    var body: some View { contenidoEstrategia("Planificación") }
}

struct AutocontrolView: View {
    var body: some View { contenidoEstrategia("Autocontrol") }
}

struct DistanciamientoView: View {
    var body: some View { ZStack {
        // Gradient Background
        LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.2), Color("figma")]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
        
        VStack(spacing: 30) {
            
            ScrollView{
                Image("ImageInfo2")
                    .resizable()
                    .frame(width: 300, height: 280)
                Text("Acompañamiento social y familiar")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .shadow(color: .gray, radius: 2, x: 0, y: 2)
                // Text content
                Text("""
                        Dependerá de la situación del paciente y sobretodo de la personalidad de este, ya que no todos tendrán la misma perspectiva y sobretodo se encuentran en el mismo contexto con respecto a las relaciones sociales de su vida. Sin embargo, si no existen alteraciones en esta estrategia puede causar múltiples beneficios, puesto que, el acompañamiento de familiares y seres queridos para el paciente llega a generar impacto significativo durante la evolución de la enfermedad provocando seguridad y confianza sobre los acontecimientos que se manifiesten.
                        """)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: .gray, radius: 5, x: 0, y: 5)
                .multilineTextAlignment(.leading)
            }
        }
        .padding(.horizontal, 20)
    } }
}

struct ResponsabilidadView: View {
    var body: some View {
        Text("")
    }
}

struct EscapeEvitacionView: View {
    var body: some View { contenidoEstrategia("Escape-Evitación") }
}

struct ReevaluacionPositivaView: View {
    var body: some View { contenidoEstrategia("Reevaluación Positiva") }
}

struct BusquedaApoyoEmocionalView: View {
    var body: some View { contenidoEstrategia("Búsqueda de Apoyo Emocional") }
}

func contenidoEstrategia(_ titulo: String) -> some View {
    VStack {
        Text("Contenido sobre \(titulo)")
            .padding()
            .background(Color.blue.opacity(0.1))
            .cornerRadius(15)
    }
    .navigationBarTitle(titulo, displayMode: .inline)
}

struct EstrategiasAfrontamiento_Previews: PreviewProvider {
    static var previews: some View {
        EstrategiasAfrontamiento()
    }
}
