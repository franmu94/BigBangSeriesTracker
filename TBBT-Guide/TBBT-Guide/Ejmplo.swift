//
//  Ejmplo.swift
//  TBBT-Guide
//
//  Created by Fran Malo on 11/9/24.
//

import SwiftUI

struct Ejmplo: View {
    @State var showBackGound = false
    var body: some View {
            Form {
                Image("12107")
                    .resizable()
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    //.padding()
                    .background {
                        Color(.gray.opacity(0.4))
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    //.listRowBackground(Color.clear)
                    .onDisappear {
                        showBackGound = true
                    }
                Section(header: Text("Información Personal")) {
                    TextField("Nombre", text: .constant(""))
                    TextField("Correo Electrónico", text: .constant(""))
                }
                .onDisappear {
                    showBackGound = true
                }
                
                Section(header: Text("Detalles")) {
                    TextField("Dirección", text: .constant(""))
                    TextField("Teléfono", text: .constant(""))
                }
                .listRowBackground(Color(.gray).opacity(0.8))
            }
        
            .scrollContentBackground(.hidden)
             .background {
                 HStack (alignment: .top){
                     if showBackGound {
                         Image("12107") // Nombre de la imagen en los assets
                             .resizable()
                             .scaledToFit()
                         //.ignoresSafeArea()
                     }
                 }
          
             }
    }
}

#Preview {
    Ejmplo()
}
