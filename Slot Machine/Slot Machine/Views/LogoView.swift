//
//  LogoView.swift
//  Slot Machine
//
//  Created by Ezequiel Rasgido on 20/06/2022.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        Image("gfx-slot-machine")
            .resizable()
            .scaledToFit()
            .frame(
                minWidth: 256,
                idealWidth: 290,
                maxWidth: 310,
                minHeight: 112,
                idealHeight: 130,
                maxHeight: 140,
                alignment: .center
            )
            .padding(.horizontal)
            .layoutPriority(1)
            .modifier(ShadowModifier())
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}
