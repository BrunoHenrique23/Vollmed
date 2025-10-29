//
//  SigninView.swift
//  Vollmed
//
//  Created by Bruno Henrique Ferraz da Silva on 24/06/25.
//

import SwiftUI

struct SigninView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert: Bool = false
    @State private var isLoading: Bool = false
    var authManager = AuthenticationManager.shared
    
    let service = WebService()
    
    func login() async {
        isLoading = true
        do {
            try await Task.sleep(for: .seconds(2))
            if let user = try await service.loginPatient(email: email, password: password){
                authManager.saveToken(token: user.token)
                authManager.savePatientId(id: user.id)
            } else {
                showAlert = true
            }
        } catch {
            print("Erro ao tentar logar: \(error)")
            showAlert = true
            isLoading = false
        }
    }
    
    
    var body: some View {
        
        if isLoading {
            ZStack {
                Rectangle()
                    .opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    AnimatedLoadingView()
                    Text("Entrando...")
                        .padding(.top)
                        .bold()
                        .foregroundStyle(.white)
                }
            }
        } else {
            VStack(alignment: .leading, spacing: 16) {
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 36, alignment: .center)
                
                Text("Olá")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.accent)
                    
                
                Text("Preencha para acessar sua conta.")
                    .font(.title3)
                    .foregroundStyle(.gray)
                    .padding(.bottom)
                
                Text("Email")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)
                
                TextField("Insira seu email", text: $email)
                    .padding(14)
                    .background(Color.gray.opacity(0.25))
                    .cornerRadius(15)
                    .autocorrectionDisabled()
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                
                Text("Senha")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)
                
                SecureField("Insira sua senha", text: $password)
                    .padding(14)
                    .background(Color.gray.opacity(0.25))
                    .cornerRadius(15)
            }
            .padding()
            
            Button {
                Task {
                   await login()
                }
            } label: {
                ButtonView(text: "Entrar")
                    .padding()
            }
            
            NavigationLink {
                SignupView()
            } label: {
                Text("Ainda nao possui uma conta? Cadastre-se")
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            
            .navigationBarBackButtonHidden(true)
            .alert("Ops, algo deu errado", isPresented: $showAlert) {
                Button {
                    //
                } label: {
                    Text("Ok")
                }
            } message: {
                Text("Houve um erro ao entrar na sua conta, por favor tente novamente mais tarde.")
            }

        }
            
        }
        

}

#Preview {
    SigninView()
}
