//
//  MyAppointmentView.swift
//  Vollmed
//
//  Created by Bruno Henrique Ferraz da Silva on 23/06/25.
//

import SwiftUI

struct MyAppointmentView: View {
    
    let service = WebService()
    
    @State var appointments: [Appointment] = []
    @State private var errorMessage = ""
    @State private var isLoading = false
    var authManager = AuthenticationManager.shared
       
    func getAllAppointments() async {
        guard let patientId = authManager.patientId else { return }
        do {
            if let fetchedAppointments = try await service.getAllAppointmentsFromPatient(patientID: patientId) {
                DispatchQueue.main.async {
                    self.appointments = fetchedAppointments
                }
            }
        } catch {
            print("Erro ao buscar consultas: \(error)")
        }
    }

    
    var body: some View {
        ScrollView(showsIndicators: false) {
            Text("Minhas Consultas")
                .font(.title)
                .padding(.top)
            if appointments.isEmpty {
                VStack(spacing: 20) {
                    Text("Nenhuma consulta agendada.")
                        .font(.title3)
                        .bold()
                        .frame(maxHeight: 80)
                        .foregroundColor(.cancel)
                    Spacer()
                    Image(.health)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.top)
                }
              
            } else {
                ForEach(appointments){ appointment in
                    SpecialistCardView(specialist:          appointment.specialist, appointment: appointment)
                }
                .padding()
            }
        }
        .onAppear {
            Task {
                await getAllAppointments()
            }
        }
        
    }
       
}

#Preview {
    MyAppointmentView()
}
