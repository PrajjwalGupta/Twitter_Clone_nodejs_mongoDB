//
//  MainView.swift
//  Twitter_Clone_node
//
//  Created by Prajjwal Gupta on 22/11/24.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        VStack {
            TopBarView()
            Home()
        }
    }
}

#Preview {
    MainView()
}
