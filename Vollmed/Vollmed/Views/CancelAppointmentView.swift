//
//  CancelAppointmentView.swift
//  Vollmed
//
//  Created by Bruno Henrique Ferraz da Silva on 24/06/25.
//

import SwiftUI

struct CancelAppointmentView: View {
    
    var appointmentId: String
    var service = WebService()
    var isCanceled: Bool = false
    @State private var reasonToCancel: String = ""
    @State private var showAlert: Bool = false
    @State private var isCancelAppointment: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    func cancelAppointment() async {
        do {
            if try await service.cancelAppointment(appointmentId: appointmentId, reasonToCancel: reasonToCancel) {
                print("Consulta cancelada com sucesso !")
                isCancelAppointment = true
            }
            
        } catch {
            print("Erro ao cancelar consulta: \(error)")
            isCancelAppointment = false
           
        }
        showAlert = true
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Conte-nos o motivo do cancelamento da sua consulta")
                .font(.title3)
                .bold()
                .foregroundStyle(.accent)
                .padding(.top)
                .multilineTextAlignment(.center)
            
            TextEditor(text: $reasonToCancel)
                .padding()
                .font(.title3)
                .foregroundStyle(.accent)
                .scrollContentBackground(.hidden)
                .background(Color(.lightBlue).opacity(0.15))
                .cornerRadius(16)
                .frame(maxHeight: 300)
            
            Button {
                Task {
                    await cancelAppointment()
                }
            } label: {
                ButtonView(text: "Cancelar Consulta", buttonType: .cancel)
            }
            .alert(isCancelAppointment ? "Sucesso" : "Ops, algo deu errado", isPresented: $showAlert, presenting: isCancelAppointment) { isScheduled in
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("OK")
                }
            } message: { isSchedule in
                if isSchedule {
                    Text("A consulta foi cancelada com sucesso !")
                } else {
                    Text("Houve um erro ao cancelar a consulta. Tente novamente mais tarde.")
                }
            }

        }
        .padding()
        .navigationTitle(Text("Cancelar Consulta"))
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    CancelAppointmentView(appointmentId: "123")
}
