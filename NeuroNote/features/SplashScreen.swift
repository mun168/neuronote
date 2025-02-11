//
//  SplashScreen.swift
//  TactPlanFin
//
//  Created by Desmond Rgwaringesu on 4/11/2023.
//

import SwiftUI

struct SplashScreen: View {
    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some View {
        VStack{
            Spacer()
            Image("splash")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Spacer()
        }.background(Color("secondary"))
         .preferredColorScheme(isDarkMode ? .dark : .light)

    }
}

#Preview {
    SplashScreen()
}
