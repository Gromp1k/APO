//
//  HistogramView.swift
//  APO
//
//  Created by Kacper on 18/08/2021.
//\
import SwiftUI

/// View of histogram
/// Innitialize with UIImage.getPixels() extension
struct HistogramView: View {
    var values: [CGFloat] = []
    
    init(values:[CGFloat]){
        self.values = values
    }
    var body: some View {
        HStack{
            BarChart(values: self.values)
                .frame(height: abs(350))
        }
    }
}

struct HistogramView_Previews: PreviewProvider {
    static var previews: some View {
        HistogramView(values: (UIImage(named: "lena")?.getPixels())! )
    }
}

struct BarChart: View {
    let values: [CGFloat]
    var barColor: Color = .black
    private let horizontalPadding: CGFloat = 0.5
    private let xCords = [0,50,100,150,200,255]
    var body: some View {
        VStack{
            GeometryReader{ proxy in
                VStack(alignment:.center){
                    HStack(alignment: .bottom, spacing: 0){
                        ForEach(values, id: \.self){ value in
                            Rectangle()
                                .foregroundColor(barColor)
                                .frame(width: proxy.width(considering: values, and: horizontalPadding),
                                       height: proxy.height(of: value, considering: values))
                                .padding(.horizontal, horizontalPadding * 0.95)
                        }
                    }
                Rectangle()
                    .frame(width: proxy.size.width * 0.875 ,height:2)
                    .padding(.top,-7)
                    ZStack(alignment: .leading){
                        ForEach(xCords, id: \.self){ x in
                            Text("\(x)")
                                .font(.system(size:10))
                                .padding(.leading, x == 255 ?
                                            ((CGFloat(0.855) * proxy.size.width * CGFloat(x)/255 ) ) :
                                            (CGFloat(0.90) * proxy.size.width * CGFloat(x)/255 ))
                        }
                    }
                }
                .padding()
            }
        }
    }
}

extension GeometryProxy{
    func width(considering values: [CGFloat], and horizontalPadding: CGFloat) -> CGFloat{
        let baseWidth = 0.9*(size.width / CGFloat(values.count) )
        let offsettedWidth = baseWidth - horizontalPadding * 2
        return offsettedWidth
    }
    
    func height(of currentValue: CGFloat, considering values: [CGFloat] ) -> CGFloat{
        guard let maximumValue = values.max() else{
            return 0
        }
        return CGFloat(currentValue / maximumValue) * size.height
    }
}
