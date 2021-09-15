//
//  MenuView.swift
//  APO
//
//  Created by Kacper on 16/08/2021.
//

import SwiftUI

/// View of Menu, with his static dictionary of MenuItems models ( buttons )
struct MenuView: View {
    
    @State var selectedImage = UIImage()
    @State private var test = false
    @Binding var isImageSelected:Bool
    @Binding var open:Bool
    @ObservedObject var imageModel: ImageModel
    @State private var isImagePickerOpen = false
    @State private var isHistogramShown = false
    @State private var isLUTShown = false
    @State private var menu:[MenuItem] = [
        MenuItem(hashValue:1,title:"File", operations: [
            MenuItem(hashValue:11,title:"Open",actionType: .openFile),
            MenuItem(hashValue:12,title:"Save",actionType: .saveFile),
            MenuItem(hashValue:13,title:"Delete",actionType:.deleteFile)
            ]),
        MenuItem(hashValue:2,title:"Convertion", operations: [
            MenuItem(hashValue:21,title:"Grayscale",actionType: .grayscale),
            MenuItem(hashValue:22,title:"Binary", actionType: .binary),
            MenuItem(hashValue:23,title:"Negate", actionType: .negate),
            MenuItem(hashValue:24,title:"Equalization",actionType:.equalization),
            MenuItem(hashValue:25,title:"Adaptive treshold",actionType:.treshAd),
            MenuItem(hashValue:26,title:"Otsu treshold",actionType:.treshOt)
            ]),
        MenuItem(hashValue:3,title:"Blur", operations: [
            MenuItem(hashValue:31,title:"Blur",actionType: .blur),
            MenuItem(hashValue:32,title:"Gaussian blur", actionType: .blurGaus),
            MenuItem(hashValue:33,title:"Sobel blur", actionType: .blurSobel),
            MenuItem(hashValue:34,title:"Laplasian blur", actionType: .blurLapl),
            MenuItem(hashValue:35,title:"Canny blur", actionType: .blurCanny)
            ]),
        MenuItem(hashValue:4,title:"Bitwise", operations: [
            MenuItem(hashValue:41,title:"AND",actionType: .bitwiseAND),
            MenuItem(hashValue:42,title:"OR", actionType: .bitwiseOR),
            MenuItem(hashValue:43,title:"NOT", actionType: .bitwiseNOT),
            MenuItem(hashValue:44,title:"XOR", actionType: .bitwiseXOR)
            ]),
        MenuItem(hashValue:5,title:"Morphology", operations: [
            MenuItem(hashValue:51,title:"Erode",actionType: .morphErode),
            MenuItem(hashValue:52,title:"Dilate", actionType: .morphDilate),
            MenuItem(hashValue:53,title:"Open", actionType: .morphOpen),
            MenuItem(hashValue:54,title:"Close", actionType: .morphClose),
            MenuItem(hashValue:55,title:"Skale", actionType: .morphSkale)
            ]),
//        MenuItem(hashValue:6,title:"Image data", operations: [
//            MenuItem(hashValue:51,title:"Erode",actionType: .showHistogram),
//            MenuItem(hashValue:52,title:"Dilate", actionType: .showLUT)
//            ])
    ]
    
    func extendMenu()->[MenuItem]{
        return
            [
               MenuItem(hashValue:1,title:"File", operations: [
                   MenuItem(hashValue:11,title:"Open",actionType: .openFile),
                   MenuItem(hashValue:12,title:"Save",actionType: .saveFile),
                   MenuItem(hashValue:13,title:"Delete",actionType:.deleteFile)
                   ]),
               MenuItem(hashValue:2,title:"Convertion", operations: [
                   MenuItem(hashValue:21,title:"Grayscale",actionType: .grayscale),
                   MenuItem(hashValue:22,title:"Binary", actionType: .binary),
                   MenuItem(hashValue:23,title:"Negate", actionType: .negate),
                   MenuItem(hashValue:24,title:"Equalization",actionType:.equalization),
                   MenuItem(hashValue:25,title:"Adaptive treshold",actionType:.treshAd),
                   MenuItem(hashValue:26,title:"Otsu treshold",actionType:.treshOt)
                   ]),
               MenuItem(hashValue:3,title:"Blur", operations: [
                   MenuItem(hashValue:31,title:"Blur",actionType: .blur),
                   MenuItem(hashValue:32,title:"Gaussian blur", actionType: .blurGaus),
                   MenuItem(hashValue:33,title:"Sobel blur", actionType: .blurSobel),
                   MenuItem(hashValue:34,title:"Laplasian blur", actionType: .blurLapl),
                   MenuItem(hashValue:35,title:"Canny blur", actionType: .blurCanny)
                   ]),
               MenuItem(hashValue:4,title:"Bitwise", operations: [
                   MenuItem(hashValue:41,title:"AND",actionType: .bitwiseAND),
                   MenuItem(hashValue:42,title:"OR", actionType: .bitwiseOR),
                   MenuItem(hashValue:43,title:"NOT", actionType: .bitwiseNOT),
                   MenuItem(hashValue:44,title:"XOR", actionType: .bitwiseXOR)
                   ]),
               MenuItem(hashValue:5,title:"Morphology", operations: [
                   MenuItem(hashValue:51,title:"Erode",actionType: .morphErode),
                   MenuItem(hashValue:52,title:"Dilate", actionType: .morphDilate),
                   MenuItem(hashValue:53,title:"Open", actionType: .morphOpen),
                   MenuItem(hashValue:54,title:"Close", actionType: .morphClose),
                   MenuItem(hashValue:55,title:"Skale", actionType: .morphSkale)
                   ])
            ]
     
    }
    
    func simplifyMenu()->[MenuItem]{
       return [MenuItem(hashValue:1,title:"File", operations: [
            MenuItem(hashValue:11,title:"Open",actionType: .openFile),
            MenuItem(hashValue:12,title:"Save",actionType: .saveFile),
            MenuItem(hashValue:13,title:"Delete",actionType:.deleteFile)
            ])]
    }

    func toggleMenu(with hash:Int){
        let index = menu.firstIndex(where: {$0.hashValue == hash})
        menu[index!].isSelected.toggle()
    }
    
    var body: some View{
            VStack(alignment: .leading){
                HStack{ Spacer() }
                AuthorSectionView(author: Author.exampleAuthor())
                    .padding(.bottom,25)
                
                
                ForEach(menu, id: \.hashValue){ parent in
                    VStack{
                        Divider()
                        HStack{
                        Button(action:{ toggleMenu(with: parent.hashValue)}){
                                Image(systemName: parent.isSelected ? "chevron.down" : "chevron.up")
                                Text("\(parent.title)")
                            }
                          }
                         .padding(4)
                         .offset(x:-20)
                        Divider()
                }
                if parent.isSelected && (parent.operations != nil) {
                    ForEach(parent.operations!, id:\.hashValue) { child in
                        Button(action:{ self.open.toggle()
                                    toggleMenu(with: parent.hashValue)
                                    switch child.actionType{
                                    case .treshOt:
                                        imageModel.tresholdingOtsu()
                                        case .equalization:
                                            imageModel.equlize()
                                        case .grayscale:
                                                imageModel.convGray()
                                        case .negate:
                                                imageModel.convNeg()
                                        case .binary:
                                                imageModel.convBin()
                                            case .tresh:
                                                imageModel.tresholding()
                                            case .treshAd:
                                                imageModel.tresholdingAdaptive()
                                            case .bitwiseOR:
                                                imageModel.bitwiseOR()
                                            case .bitwiseAND:
                                                imageModel.bitwiseAND()
                                            case .bitwiseNOT:
                                                imageModel.bitwiseNOT()
                                            case .bitwiseXOR:
                                                imageModel.bitwiseXOR()
                                            case .blur:
                                                imageModel.blur()
                                            case .blurGaus:
                                                imageModel.blurGaussian()
                                            case .blurSobel:
                                                imageModel.blurSobel()
                                            case .blurLapl:
                                                imageModel.blurLaplacian()
                                            case .blurCanny:
                                                imageModel.blurCanny()
                                            case .morphErode:
                                                imageModel.morphErode()
                                            case .morphDilate:
                                                imageModel.morphDilate()
                                            case .morphOpen:
                                                imageModel.morphOpen()
                                            case .morphClose:
                                                imageModel.morphClose()
                                            case .morphSkale:
                                                imageModel.morphSkale()
                                            default :
                                                ()
                                            }
                                        }){
                                            HStack{
                                                Text("\(child.title)")
                                                
                                            }.padding(4)
                                            .offset(x:25)
                        }
                        
                                    }
                                }
                            }
                HStack{
                    Button(action: {
                            self.isHistogramShown.toggle()
                           // printArr(imageModel: imageModel)
                        
                    }){
//                        Image(systemName: isHistogramShown ? "chevron.down" : "chevron.up")
                        Text("Show Histogram")
                    }
                    .padding(4)
                    .offset(x:20)
                   .sheet(isPresented: $isHistogramShown){
                        let values = self.imageModel.uiimage?.getPixels()
                    HistogramView.init(values: values ?? [])
                    }
                }
                .padding(4)
                .offset(x:20)
                Divider()
                HStack{
                    Button(action: {self.isLUTShown.toggle()}){
//                        Image(systemName: isHistogramShown ? "chevron.down" : "chevron.up")
                        Text("Show Lookup Table")
                    }
                    .padding(4)
                    .offset(x:20)
                   .sheet(isPresented: $isLUTShown){
                        let values = self.imageModel.uiimage?.getPixels()
                        LUTView(points: values ?? [])
                    }
                }
                .padding(4)
                .offset(x:20)
                Divider()
                Spacer()
          }
        
        .padding(.vertical,30)
        .background(Color(UIColor(red: 0.701, green: 0.79, blue: 0.80, alpha: 1.00)))
        .padding(.trailing,80)
        .opacity(0.8)
        .offset(x: open ? 0 : -UIScreen.main.bounds.width)
        .animation(.default)
        .edgesIgnoringSafeArea(.vertical)
        .foregroundColor(.black)
        .frame(height: UIScreen.main.bounds.height)
        .onTapGesture {
            self.open.toggle()
        }
    }
}
