//
//  LUTView.swift
//  APO
//
//  Created by Kacper on 05/09/2021.
//

import SwiftUI


struct LUTView: View {

    var points:[CGFloat]
    
    var body: some View{
        ScrollView{
        VStack{
            ForEach(0..<points.count ){ index in
                HStack{
                    Text("\(index)")
                        .padding(.leading,15)
                    Spacer()
                    Divider()
                    Spacer()
                    Text(String(format:"%.0f", points[Int(index)]))
                        .padding(.trailing,15)
                }
            }
        }
        
    }.padding(.top,40)
    }
}
