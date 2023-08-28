//
//  iOSCheckToggleStyle.swift
//  Solana
//
//  Created by Andrea Lima Blanca on 20/08/23.
//

import SwiftUI

struct iOSCheckboxToggleStyle: View {
    @Binding var checked: Bool

        var body: some View {
            Image(systemName: checked ? "checkmark.square.fill" : "square")
                .foregroundColor(checked ? Color(UIColor.systemBlue) : Color.secondary)
                .onTapGesture {
                    self.checked.toggle()
                }
        }
    }


struct iOSCheckboxToggleStyle_Previews: PreviewProvider {
    struct ChecBoxViewHolder: View {
        @State var checked = false
        var body: some View{
            iOSCheckboxToggleStyle(checked: $checked)
        }
    }
        static var previews: some View {
        ChecBoxViewHolder()
    }
}

