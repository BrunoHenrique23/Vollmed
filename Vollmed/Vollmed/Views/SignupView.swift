//
//  SignupView.swift
//  Vollmed
//
//  Created by Bruno Henrique Ferraz da Silva on 24/06/25.
//

import SwiftUI

struct SignupView: View {
    
    let service = WebService()
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var cpf: String = ""
    @State private var phoneNumber: String = ""
    @State private var healthPlan: String = ""
    @State private var showAlert: Bool = false
    @State private var isPatientRegistered: Bool = false
    @Environment(\.presentationMode) var presentationMode
    let healhtPlanOptions: [String] = ["Amil", "Sul América", "Unimed", "Bradesco Saúde", "Happy Vida", "Notredame Intermédica", "Sao Francisco Saúde", "Golden Cross", "Medial Saúde","América Saúde", "Outro"]
    
    init() {
        self.healthPlan = healhtPlanOptions[0]
    }
    
    func register() async {
        let patient = Patient(id: nil, cpf: cpf, name: name, email: email, password: password, phoneNumber: phoneNumber, healthPlan: healthPlan)
        do {
            if let _ = try await service.registePatient(patient: patient) {
                isPatientRegistered = true
                print("Paciente foi cadastrado com sucesso")
            } else {
                isPatientRegistered = false
            }
            
        } catch {
            print("Ocorreu um erro ao cadastrar um paciente: \(error)")
            isPatientRegistered = false
        }
        showAlert = true
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16){
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 36.0, alignment: .center)
                    .padding(.vertical)
                
                Text("Olá, boas-vindas!")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.accent)
            Text("Por favor, preencha os dados abaixo para se cadastrar.")
                    .font(.title3)
                    .foregroundStyle(.gray)
                    .padding(.bottom)
                
             Text("Nome")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)
                
            TextField("Insira o seu nome completo", text: $name)
                    .padding(14)
                    .background(Color.gray.opacity(0.25))
                    .cornerRadius(15)
                    .autocorrectionDisabled()
                    .keyboardType(.emailAddress)
                
                Text("Email")
                       .font(.title3)
                       .bold()
                       .foregroundStyle(.accent)
                   
               TextField("Insira o seu email", text: $email)
                       .padding(14)
                       .background(Color.gray.opacity(0.25))
                       .cornerRadius(15)
                       .autocorrectionDisabled()
                       .keyboardType(.emailAddress)
                       .textInputAutocapitalization(.never)
                
                Text("CPF")
                       .font(.title3)
                       .bold()
                       .foregroundStyle(.accent)
                       
                   
               TextField("Insira o seu cpf", text: $cpf)
                       .padding(14)
                       .background(Color.gray.opacity(0.25))
                       .cornerRadius(15)
                       .keyboardType(.numberPad)
                
                Text("Telefone")
                       .font(.title3)
                       .bold()
                       .foregroundStyle(.accent)
                   
               TextField("Insira o seu telefone", text: $phoneNumber)
                       .padding(14)
                       .background(Color.gray.opacity(0.25))
                       .cornerRadius(15)
                       .keyboardType(.numberPad)
                
                Text("Senha")
                       .font(.title3)
                       .bold()
                       .foregroundStyle(.accent)
                   
               SecureField("Insira o sua senha", text: $password)
                       .padding(14)
                       .background(Color.gray.opacity(0.25))
                       .cornerRadius(15)
                
                Text("Selecione o seu plano de saúde")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)
                
                Picker("Plano de saúde", selection: $healthPlan) {
                    ForEach(healhtPlanOptions, id: \.self){
                        healthPlan in
                        Text(healthPlan)
                    }
                }
                
                Button {
                    Task{
                        await register()
                    }
                } label: {
                    ButtonView(text: "Cadastrar")
                }
                
                NavigationLink {
                    SigninView()
                } label: {
                    Text("Ja possui uma conta ? Faça o login")
                        .bold()
                        .foregroundStyle(.accent)
                        .frame(maxWidth: .infinity, alignment: .center)
                }

                
              }
        }
        .navigationBarBackButtonHidden(true)
        .padding()
        .alert(isPatientRegistered ? "Sucesso" : "Ops, algo deu errado", isPresented: $showAlert, presenting: $isPatientRegistered) { _ in
            Button {
                if isPatientRegistered {
                    presentationMode.wrappedValue.dismiss()
                } else {
                    print("Erro ao cadastrar")
                }
            } label: {
                Text("OK")
            }
        } message: { _ in
            if isPatientRegistered {
                Text("O paciente foi criado com sucesso")
            } else {
                Text("Houve um erro ao cadastrar o paciente. Tente novamente mais tarde.")
            }
        }

    }
}

#Preview {
    SignupView()
}
