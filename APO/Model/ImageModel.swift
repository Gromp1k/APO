//
//  ImageView.swift
//  APO
//
//  Created by Kacper on 18/08/2021.
//




import Foundation
/// ImageModel is class with the image user works with, it also implements whole logic around it, using Wrapper.mm

class ImageModel : ObservableObject {
    
    //MARK: Due to arm64 arch. problem with ImagePickerController, those are static selected values of images
    @Published var uiimage = UIImage(named:"lena")
    @Published var uiimage2 = UIImage(named:"tlo2")
    
    
    @Published var LUT:[Int] = Array(repeating: 0, count: 256)
    
    //MARK: Due to arm64 arch. problem with asert() object, those are static values of treshold and size of kernel
    private var kernelSize:Int32 = 5
    private var tresholdLevel:Int32 = 127

    //MARK: - wrapper's functions
    func convGray(){ self.uiimage = Wrapper.convertGrayscale(self.uiimage)}
    func convBin(){ self.uiimage = Wrapper.convertBinary(self.uiimage)}
    func convNeg(){ self.uiimage = Wrapper.convertNegative(self.uiimage)}
    func equlize(){ self.uiimage = Wrapper.equalization(self.uiimage) }
    
    func tresholding(/*level: Int*/){self.uiimage = Wrapper.tresholding(self.uiimage, tresholds: tresholdLevel)}
    func tresholdingAdaptive(/*level: Int*/){self.uiimage = Wrapper.tresholdingAdaptive(self.uiimage, tresholds: tresholdLevel)}
    func tresholdingOtsu(/*level:int */){self.uiimage = Wrapper.tresholdingOtsu(self.uiimage, tresholds: tresholdLevel)}
    func blur(){ self.uiimage = Wrapper.blur(self.uiimage,withKernel: kernelSize)}
    func blurGaussian(){self.uiimage = Wrapper.blurGaussian(self.uiimage,withKernel: 7)}
    func blurSobel(){self.uiimage = Wrapper.blurSobel(self.uiimage,withKernel: kernelSize)}
    func blurLaplacian(){self.uiimage = Wrapper.blurLaplacian(self.uiimage,withKernel: kernelSize)}
    func blurCanny(){self.uiimage = Wrapper.blurCanny(self.uiimage,withKernel: kernelSize)}

    func bitwiseOR(){ self.uiimage = Wrapper.bitwiseOR(self.uiimage, with: self.uiimage2)}
    func bitwiseAND(){ self.uiimage = Wrapper.bitwiseAND(self.uiimage, with: self.uiimage2)}
    func bitwiseNOT(){self.uiimage = Wrapper.bitwiseNOT(self.uiimage)}
    func bitwiseXOR(){self.uiimage = Wrapper.bitwiseXOR(self.uiimage, with: self.uiimage2)}
    
    func morphErode(){self.uiimage = Wrapper.morphErode(self.uiimage)}
    func morphDilate(){self.uiimage = Wrapper.morphDilate(self.uiimage)}
    func morphOpen(){self.uiimage = Wrapper.morphOpen(self.uiimage)}
    func morphClose(){self.uiimage = Wrapper.morphClose(self.uiimage)}
    func morphSkale(){self.uiimage = Wrapper.morphSkale(self.uiimage)}
    
    func histNormalize(x1: Int, x2: Int){}
    func histStretch(p1: Int, p2:Int, q1:Int, q2:Int){}

    func depth() -> Int{ return Int(Wrapper.depth(self.uiimage)) }
    func reset(){ self.uiimage = UIImage(named:"lena") }
}

//MARK: private extension to UIImage class, which builds us the LUT of primary selected image
/// private extention creating LUT table from UIImage
/// - Returns: Array of type [CGFloat] of length 256.
extension UIImage {
    func getPixels() -> [CGFloat] {
        guard let cgImage = self.cgImage else { return [] }
        //assert(cgImage.bitsPerPixel == 32, "only support 32 bit images")
        //assert(cgImage.bitsPerComponent == 8,  "only support 8 bit per channel")
        guard let imageData = cgImage.dataProvider?.data as Data? else {  return [] }
        let size = cgImage.width * cgImage.height
        let buffer = UnsafeMutableBufferPointer<UInt32>.allocate(capacity: size)
        _ = imageData.copyBytes(to: buffer)
        var LUT:[CGFloat] = Array(repeating: 0, count: 256)
        LUT.reserveCapacity(size)

       if(cgImage.bitsPerPixel == 8){
           for pixel in buffer {
               var gray : UInt32 = 0
               if cgImage.byteOrderInfo == .orderDefault || cgImage.byteOrderInfo == .order32Big {
                       gray = pixel & 255
                       LUT[Int(gray)]+=1
               }
           }
       }
       if(cgImage.bitsPerPixel == 32)
       {
           for pixel in buffer {
               var r : UInt32 = 0
               var g : UInt32 = 0
               var b : UInt32 = 0
              var gray : Int = 0
               if cgImage.byteOrderInfo == .orderDefault || cgImage.byteOrderInfo == .order32Big {
                   r = pixel & 255
                   g = (pixel >> 8) & 255
                   b = (pixel >> 16) & 255
               }else if cgImage.byteOrderInfo == .order32Little {
                   r = (pixel >> 16) & 255
                   g = (pixel >> 8) & 255
                   b = pixel & 255
               }
               gray = Int((r+g+b)/3)
               LUT[gray]+=1
           }
    }
       return LUT;
    }
}

 

