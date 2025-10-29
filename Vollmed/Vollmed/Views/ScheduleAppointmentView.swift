//
//  ScheduleAppointmentView.swift
//  Vollmed
//
//  Created by Bruno Henrique Ferraz da Silva on 17/06/25.
//

import SwiftUI

struct ScheduleAppointmentView: View {
    
    let service = WebService()
    var specialistID: String
    var isRescheduleView: Bool
    var appoitmentId: String?
    var authManager = AuthenticationManager.shared
    @State private var selectedDate = Date()
    @State private var showAlert: Bool = false
    @State private var isAppointmentScheduled: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    
    init(specialistId: String, isRescheduleView: Bool = false, appointmentId: String? = nil) {
        self.specialistID = specialistId
        self.isRescheduleView = isRescheduleView
        self.appoitmentId = appointmentId
    }
    
    
    func rescheduledAppointment() async {
        
        guard let appoitmentId else {
            print("Houve um erro ao obter o ID da consulta")
            return
        }
       
        do {
            if let _ = try await service.rescheduledAppointment(appointmentId: appoitmentId, date: selectedDate.convertToString()){
                isAppointmentScheduled = true
                
            } else {
                isAppointmentScheduled = false
            }
            
        } catch {
            print("Ocorreu um erro ao reagendar a consulta: \(error)")
            isAppointmentScheduled = false
        }
        showAlert = true
        
    }
    
    
    
    func scheduleAppointment() async {
        guard let patientId = authManager.patientId else { return }

        do {
            if let _ = try await service.scheduleAppointment(epecialistId: specialistID, patientId: patientId, date: selectedDate.convertToString()){
                isAppointmentScheduled = true
            }else {
             isAppointmentScheduled = false
            }
            
        } catch {
            print("Ocorreu um erro ao agendar a consulta: \(error)")
            isAppointmentScheduled = false
        }
        showAlert = true
    }
    
    
    var body: some View {
        VStack {
            Text(isRescheduleView ? "Reagendar Consulta" :  "Agendar Consulta")
                .font(.title)
            Text("Selecione a data e o horário da \n consulta")
                .font(.title3)
                .bold()
                .foregroundStyle(.accent)
                .multilineTextAlignment(.center)
                .padding(.top)
            
            DatePicker("Escolha a data da \n consulta", selection: $selectedDate, in: Date()...)
                .padding()
                .datePickerStyle(.graphical)
                .onAppear {
                    UIDatePicker.appearance().minuteInterval = 15
                }
                .alert(isAppointmentScheduled ? "Sucesso" : "Ops, algo deu errado", isPresented: $showAlert, presenting: isAppointmentScheduled) { isScheduled in
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("OK")
                    }
                } message: { isSchedule in
                    if isSchedule {
                        Text("A consulta foi \(isRescheduleView ? "reagendada" : "agendada") com sucesso")
                    } else {
                        Text("Houve um erro ao \(isRescheduleView ? "reagendar" : "agendar") a consulta. Tente novamente mais tarde.")
                    }
                }
            Button {
                Task {
                    if isRescheduleView {
                        await rescheduledAppointment()
                    } else {
                        await scheduleAppointment()
                    }
                }
            } label: {
                ButtonView(text: isRescheduleView ? "Reagendar Consulta" :  "Agendar Consulta")
            }
        }
        .padding()
    }
}

#Preview {
    ScheduleAppointmentView(specialistId: "1")
}
