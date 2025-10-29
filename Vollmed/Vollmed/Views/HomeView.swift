//
//  HomeView.swift
//  Vollmed
//
//  Created by Bruno Henrique on 27/06/25.
//

import SwiftUI

struct HomeView: View {
    
    let service = WebService()
    @State var specialists: [Specialist] = []
    @State var isLoading: Bool = false
    @State private var isFetchingSpecialists = false
    @State private var errorMessage = ""
    @State private var isShowingSnackBar = false
    
    let viewModel = HomeViewModel(service: HomeNetworkingService(), authService: AuthenticationService())
    
    func logout() async {
        withAnimation(.easeInOut(duration: 0.2)) {
            isLoading = true
        }
        try? await Task.sleep(for: .seconds(2))
        await viewModel.logout()
        withAnimation(.easeInOut(duration: 0.25)) {
            isLoading = false
        }
    }
    
    
    func fetchSpecialists() async {
        isFetchingSpecialists = true
        defer { isFetchingSpecialists = false }
        do {
            try? await Task.sleep(for: .seconds(1))
            guard let response = try await viewModel.getSpecialists() else {
                return
            }
            self.specialists = response
        } catch {
            isShowingSnackBar = true
            let errorType = error as? RequestError
            errorMessage = errorType?.customMessage ?? "Ops ! Ocorreu um erro"
        }
    }
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    Image(.logo)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                        .padding(.vertical, 32)
                    Text("Boas-vindas!")
                        .font(.title2)
                        .bold()
                        .foregroundStyle(Color(.lightBlue))
                    
                    Text("Veja abaixo os especialistas da Vollmed disponíveis e marque já a sua consulta!")
                        .font(.title3)
                        .bold()
                        .foregroundStyle(.accent)
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 16)
                    
                    if isFetchingSpecialists {
                            SkeletonCellView()
                        
                        .padding(.bottom, 8)
                        
                    } else {
                        ForEach(specialists) { specialist in
                            SpecialistCardView(specialist: specialist)
                                .padding(.bottom, 8)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.top)
            .task {
                await fetchSpecialists()
            }
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        guard !isLoading else { return }
                        Task {
                            await logout()
                        }
                    } label: {
                        HStack(spacing: 6) {
                            if isLoading {
                                ProgressView()
                                    .progressViewStyle(.circular)
                                Text("Saindo…")
                            } else {
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                Text("Logout")
                            }
                        }
                        .animation(.easeInOut(duration: 0.2), value: isLoading)
                    }
                    .disabled(isLoading)
                }
            }
            .overlay(
                Group {
                    if isShowingSnackBar {
                        SnackBarErrorView(isShowing: $isShowingSnackBar, message: errorMessage)
                    }
                }, alignment: .bottom
            )
            
            if isLoading {
                Color.black.opacity(0.2)
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 0.2), value: isLoading)
                
                VStack(spacing: 12) {
                    ProgressView()
                        .progressViewStyle(.circular)
                    Text("Finalizando sessão…")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                }
                .padding(20)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                .transition(.scale.combined(with: .opacity))
                .animation(.spring(response: 0.35, dampingFraction: 0.9), value: isLoading)
            }
        }
        .allowsHitTesting(!isLoading)
    }
}

#Preview {
    HomeView()
}
