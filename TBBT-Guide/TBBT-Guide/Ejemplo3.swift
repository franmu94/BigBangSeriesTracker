import SwiftUI

struct ejemplo3: View {
    @State private var stickyImage = false
    @State var showFirstImage = true
    @State private var scrollOffset: CGFloat = 0.0
    
    func calculateValue(scrollOffset: Double, minValue: Double) -> Double {
        // Limita scrollOffset entre 20 y 60
        let clampedOffset = max(20, min(60, scrollOffset))
        
        // Interpolación lineal
        let normalizedValue = (clampedOffset - 20) / (60 - 20) // Normalizamos entre 0 y 1
        
        // Ajustamos el valor a un rango de minValue a 1.0
        let result = minValue + normalizedValue * (1.0 - minValue)
        
        // Aseguramos los límites de salida
        return max(minValue, min(1.0, result))
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            // Fondo del formulario
            if true {
                Image("12107")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 312)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .animation(.easeInOut, value: stickyImage)
                    .opacity(calculateValue(scrollOffset: scrollOffset, minValue: 0.25)) // Ajustar opacidad según el scroll
                    .blur(radius: 1)
                    .ignoresSafeArea(edges: .top) // Ignora la Safe Area solo en la parte superior
            }
            Form {
                Section {
                    // Imagen que se va a pegar arriba
                    GeometryReader { geo in
                        VStack { // Usamos VStack para ayudar con el centrado
                            Image("12107")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 312)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .opacity(showFirstImage ? 1.0 : 0.0)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .onAppear {
                                    // Calcular desplazamiento inicial
                                    scrollOffset = geo.frame(in: .global).minY
                                }
                                .onChange(of: geo.frame(in: .global).minY) { newValue in
                                    scrollOffset = newValue
                                    if Int(scrollOffset) % 1 == 0 {
                                        print(scrollOffset)
                                    }
                                    if newValue <= 58 {
                                        stickyImage = true
                                        showFirstImage = false
                                    } else {
                                        stickyImage = false
                                        showFirstImage = true
                                    }
                                }
                        }
                    }
                    .frame(height: 165)
                    .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0) // Asegura la Safe Area superior
                }
                .listRowBackground(Color.clear)
                
                // Sección de formulario
                Section(header: Text("Información Personal")) {
                    TextField("Nombre", text: .constant(""))
                    TextField("Correo Electrónico", text: .constant(""))
                }
                .listRowBackground(Color(.gray).opacity(0.8))

                Section(header: Text("Detalles")) {
                    TextField("Dirección", text: .constant(""))
                    TextField("Teléfono", text: .constant(""))
                }
                .listRowBackground(Color(.gray).opacity(0.8))

                // Secciones adicionales
                Section(header: Text("Información Personal")) {
                    TextField("Nombre", text: .constant(""))
                    TextField("Correo Electrónico", text: .constant(""))
                }
                .listRowBackground(Color(.gray).opacity(0.8))

                Section(header: Text("Detalles")) {
                    TextField("Dirección", text: .constant(""))
                    TextField("Teléfono", text: .constant(""))
                }
                .listRowBackground(Color(.gray).opacity(0.8))

                // Más secciones (repetidas como en tu código)
                Section(header: Text("Información Personal")) {
                    TextField("Nombre", text: .constant(""))
                    TextField("Correo Electrónico", text: .constant(""))
                }
                .listRowBackground(Color(.gray).opacity(0.8))

                Section(header: Text("Detalles")) {
                    TextField("Dirección", text: .constant(""))
                    TextField("Teléfono", text: .constant(""))
                }
                .listRowBackground(Color(.gray).opacity(0.8))
            }
            .scrollContentBackground(.hidden)
        }
    }
}

#Preview {
    ejemplo3()
}


//asdaedfed
//prueba
