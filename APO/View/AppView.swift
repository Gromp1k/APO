//
//  AppView.swift
//  APO
//
//  Created by Kacper on 07/08/2021.
//

import SwiftUI


/// Main view of application
///@StateObject var imageModel - whenever object ( image ) changes, view update change automatically
///  @State var isShowingImagePicker,  @State var menuOpen  private boolean values for ImaePickerController and Menu
struct AppView: View {
    
    @StateObject var imageModel = ImageModel();
    @State private var isImageSelected:Bool = true;
    @State private var selectedImage = UIImage()
    @State var isShowingImagePicker = false
    @State var menuOpen = false
//    @State var test = true
//    @State var img = UIImage()
    var body: some View {
            ZStack{
                LinearGradient(gradient: Gradient(colors:[.white,Color(UIColor(red: 0.66, green: 0.79, blue: 0.80, alpha: 1.00))]), startPoint: .top, endPoint: .bottomTrailing)
                //UIColor(red: 0.75, green: 0.79, blue: 0.80, alpha: 1.00)
                VStack{
                    /// if image has been selected with ImagePickerController, then show the image
                    if isImageSelected {
                        Image(uiImage: imageModel.uiimage!)
                            .resizable()
                            .scaledToFill()
                            .clipped()
                            .frame(width: 0.7 * UIScreen.main.bounds.width,
                                   height: 0.7 * UIScreen.main.bounds.width )
                            .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        Button(action:{imageModel.reset()}){
                            Text("Reset")
                                .foregroundColor(.red)
                        }
                        .padding(.top,15)
                    }
                    else{/// image has not been selected, show component to select it
                        Button(action:{self.isShowingImagePicker.toggle()}){
                            Text("Select image")
                        }
                        .sheet(isPresented: $isShowingImagePicker, content: {ImagePicker(selectedImage: self.$selectedImage)})
                        .frame(width: 0.7 * UIScreen.main.bounds.width,
                               height: 0.7 * UIScreen.main.bounds.width )
                    }
                    
                   
                }
                VStack{
                    HStack{
                        Button(action:{self.menuOpen.toggle()}){
                            Image(systemName: "line.horizontal.3")
                                .imageScale(.large)
                           // Text("\(imageModel.depth())")
                        }
                        Spacer()
                     //   link(label:"Histogram", destination: HistogramView())
                           // .disabled(isImageSelected ? false : true)
                    }
                    .padding(.trailing, 15)
                    .padding(.leading, 15)
                    .padding(.top,60)
                    .foregroundColor(.black)
                    
                Spacer()
                    MenuView(isImageSelected:$menuOpen, open:$menuOpen , imageModel: self.imageModel)
                }
                .padding(.top,20)
            }
            .padding(.top,40)
            .onTapGesture { if menuOpen { menuOpen.toggle() } }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}



