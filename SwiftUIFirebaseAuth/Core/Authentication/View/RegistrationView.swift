//
//  RegistrationView.swift
//  SwiftUIFirebaseAuth
//
//  Created by CARLOS HERNANDEZ TAPIA on 23/11/23.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var fullname = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            //                Image
                                Image("firebase-logo")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 120)
                                .padding(.vertical, 32)
            
            //                Form Fields
                            

                            VStack(spacing: 24){
                                //                Email
                                InputView(text: $email,
                                          title: "Email Addres",
                                          placeholder: "name@example.com")
                                .autocapitalization(.none)
                                
//                                Fullname
                                InputView(text: $fullname,
                                          title: "Full Name",
                                          placeholder: "Enter your name")
                                .autocapitalization(.none)
                                
                                //                Password
                                InputView(text: $password,
                                          title: "Password",
                                          placeholder: "Enter your password",
                                          isSecureField: true)
                                
//                                Confirm Password
                                ZStack(alignment: .trailing) {
                                    
                                    InputView(text: $confirmPassword,
                                              title: "Confirm password",
                                              placeholder: "Confirm your password",
                                              isSecureField: true)
                                    
                                    if !password.isEmpty && !confirmPassword.isEmpty {
                                        if password == confirmPassword {
                                            Image(systemName: "checkmark.circle.fill")
                                                .imageScale(.large)
                                                .fontWeight(.bold)
                                                .foregroundColor(Color(.systemGreen))
                                        } else {
                                            Image(systemName: "xmark.circle.fill")
                                                .imageScale(.large)
                                                .fontWeight(.bold)
                                                .foregroundColor(Color(.systemRed))
                                        }
                                    }
                                    
                                } //ZStack
                            
                            }
                            .padding(.horizontal)
                            .padding(.top, 12)
            
            //                Sign Up Button
                            Button {
                                Task {
                                    try await viewModel.createUser(withEmail: email,password: password, fullname: fullname)
                                }
                            } label: {
                                HStack {
                                    Text("SIGN UP")
                                        .fontWeight(.semibold)
                                    Image(systemName: "arrow.right")
                                }
                                .foregroundColor(.white)
                                .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                            }
                            .background(Color(.systemBlue))
                            .disabled(!formIsValid)
                            .opacity(formIsValid ? 1.0 : 0.5)
                            .cornerRadius(10)
                            .padding(.top, 24)
            
            Spacer()
            
            Button{
                dismiss()
            } label: {
                HStack(spacing: 3){
                    Text("Already have an account?")
                    Text("Sign in")
                        .fontWeight(.bold)
                }
                .font(.system(size: 14))
            }
        }
    }
}

//MARK: - AUTHENTICATION FORM PROTOCOL

extension RegistrationView: AuthenticationFormProtocol {
    
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5        
        && confirmPassword == password
        && !fullname.isEmpty
    }
    
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
