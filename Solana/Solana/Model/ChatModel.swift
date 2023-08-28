//
//  ChatModel.swift
//  Solana
//
//  Created by Andrea Lima Blanca on 27/08/23.

import Foundation

struct Message {
    let text: String
    let isUser: Bool
}

enum ChatContext {
    case mainMenu
    case aboutCancer
    case copingStrategies
    case specificCancerType
}

class ChatModel: ObservableObject {
    @Published var messages: [Message] = [Message(text: "¡Hola! ¿En qué tema estás interesado?\n1. Saber más sobre el cáncer\n2. Estrategias de afrontamiento\n3. Tipo de cáncer específico", isUser: false)]
    
    private var currentContext: ChatContext = .mainMenu
    private var previousContext: ChatContext?

    func sendMessage(_ content: String) {
        messages.append(Message(text: content, isUser: true))
        
        let response = getResponse(to: content)
        messages.append(Message(text: response, isUser: false))
    }

    private func getResponse(to content: String) -> String {
        switch currentContext {
        case .mainMenu:
            switch content {
            case "1":
                previousContext = .mainMenu
                currentContext = .aboutCancer
                return "Puedes preguntar sobre:\n1. ¿Qué es el cáncer?\n2. Síntomas\n3. Causas\n4. Regresar al menú principal"
            case "2":
                previousContext = .mainMenu
                currentContext = .copingStrategies
                return "Afrontar el cáncer puede ser uno de los momentos más difíciles en la vida de alguien. Aquí hay algunas estrategias que pueden ayudar:\n1. Confrontación\n2. Planificación\n3. Autocontrol\n4. Regresar al menú principal"
            case "3":
                previousContext = .mainMenu
                currentContext = .specificCancerType
                return "Puedes preguntar sobre:\n1. Cáncer de mama\n2. Cáncer de hueso\n3. Cáncer de estómago\n4. Regresar al menú principal"
            default:
                return "Por favor, selecciona una de las opciones del menú."
            }

        case .aboutCancer:
            switch content {
            case "1":
                return "El cáncer es una enfermedad que ocurre cuando las células en el cuerpo comienzan a crecer sin control. Estas células pueden invadir tejidos cercanos y formar tumores."
            case "2":
                return "Los síntomas varían según el tipo de cáncer. Algunos síntomas comunes incluyen fatiga, bultos, cambios en la piel y pérdida de peso inexplicada."
            case "3":
                return "Las causas del cáncer son diversas y pueden incluir factores genéticos, exposición a sustancias químicas y otros factores ambientales, ciertas infecciones y más."
            case "4":
                currentContext = previousContext ?? .mainMenu
                return "¡Hola! ¿En qué tema estás interesado?\n1. Saber más sobre el cáncer\n2. Estrategias de afrontamiento\n3. Tipo de cáncer específico"
            default:
                return "Por favor, selecciona una de las opciones sobre el cáncer."
            }

        case .copingStrategies:
            switch content {
            case "1":
                return "La confrontación no es solo enfrentar la realidad del cáncer, sino también abrir tu corazón a tus seres queridos, compartir tus miedos y esperanzas, y buscar apoyo cuando lo necesites."
            case "2":
                return "Planificar tu camino durante y después del tratamiento te brinda un sentido de control. Es valioso tener un plan, pero también recuerda ser flexible y permitirte cambiarlo cuando lo necesites."
            case "3":
                return "El autocontrol implica aprender a manejar las emociones y el estrés. Meditar, escribir en un diario o simplemente tomar un momento para respirar profundamente puede hacer una gran diferencia."
            case "4":
                currentContext = previousContext ?? .mainMenu
                return "¡Hola! ¿En qué tema estás interesado?\n1. Saber más sobre el cáncer\n2. Estrategias de afrontamiento\n3. Tipo de cáncer específico"
            default:
                return "Por favor, selecciona una de las opciones sobre estrategias de afrontamiento."
            }

        case .specificCancerType:
            switch content {
            case "1":
                return """
                El cáncer de mama es un tipo de cáncer que comienza en las células del seno. Si bien ocurre principalmente en mujeres, también puede afectar a los hombres. La detección temprana mediante mamografías y autoexámenes regulares del seno puede mejorar significativamente las tasas de supervivencia.
                """
            case "2":
                return """
                El cáncer de hueso es un tipo raro de cáncer que comienza en las células del hueso. Puede comenzar en cualquier hueso del cuerpo, pero generalmente afecta los huesos largos en brazos y piernas. Los síntomas pueden incluir dolor óseo y hinchazón.
                """
            case "3":
                return """
                El cáncer de estómago, o cáncer gástrico, comienza en las células del estómago. Puede desarrollarse en cualquier parte del estómago y puede extenderse a otros órganos cercanos. Es importante prestar atención a los síntomas como la indigestión y el dolor de estómago, especialmente si persisten o empeoran.
                """
            case "4":
                currentContext = previousContext ?? .mainMenu
                return "¡Hola! ¿En qué tema estás interesado?\n1. Saber más sobre el cáncer\n2. Estrategias de afrontamiento\n3. Tipo de cáncer específico"
            default:
                return "Por favor, selecciona una de las opciones sobre los tipos específicos de cáncer."
            }
        }
    }
}
