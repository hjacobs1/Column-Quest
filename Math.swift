//
//  Math.swift
//  Column Quest Alpha
//
//  Created by Henry Jacobs on 11/2/17.
//  Copyright © 2017 Henry Jacobs. All rights reserved.
//

import Foundation
import UIKit
import EasyImagy
import MathSwift

class Math{
    
    var avgArr = [Matrix]()
    // not sure if its right to have it as an RGBA array
    // need to find a way to print the array so i can check the values
    var Cb1: Image = Image<RGBA>(named: "Cb 1")!.resize(width: 50, height: 50)
    var Cb2: Image = Image<RGBA>(named: "Cb 2")!.resize(width: 50, height: 50)
    var Cb3: Image = Image<RGBA>(named: "Cb 3")!.resize(width: 50, height: 50)
    var Cb4: Image = Image<RGBA>(named: "Cb 4")!.resize(width: 50, height: 50)
    var Cb5: Image = Image<RGBA>(named: "Cb 5")!.resize(width: 50, height: 50)
    var Cb6: Image = Image<RGBA>(named: "Cb 6")!.resize(width: 50, height: 50)
    
    var Cw1: Image = Image<RGBA>(named: "Cw 1")!.resize(width: 50, height: 50)
    var Cw2: Image = Image<RGBA>(named: "Cw 2")!.resize(width: 50, height: 50)
    var Cw3: Image = Image<RGBA>(named: "Cw 3")!.resize(width: 50, height: 50)
    var Cw4: Image = Image<RGBA>(named: "Cw 4")!.resize(width: 50, height: 50)
    var Cw5: Image = Image<RGBA>(named: "Cw 5")!.resize(width: 50, height: 50)
    var Cw6: Image = Image<RGBA>(named: "Cw 6")!.resize(width: 50, height: 50)
    
    var Db1: Image = Image<RGBA>(named: "Db 1")!.resize(width: 50, height: 50)
    var Db2: Image = Image<RGBA>(named: "Db 2")!.resize(width: 50, height: 50)
    var Db3: Image = Image<RGBA>(named: "Db 3")!.resize(width: 50, height: 50)
    var Db4: Image = Image<RGBA>(named: "Db 4")!.resize(width: 50, height: 50)
    var Db5: Image = Image<RGBA>(named: "Db 5")!.resize(width: 50, height: 50)
    
    var Dw1: Image = Image<RGBA>(named: "Dw 1")!.resize(width: 50, height: 50)
    var Dw2: Image = Image<RGBA>(named: "Dw 2")!.resize(width: 50, height: 50)
    var Dw3: Image = Image<RGBA>(named: "Dw 3")!.resize(width: 50, height: 50)
    var Dw4: Image = Image<RGBA>(named: "Dw 4")!.resize(width: 50, height: 50)
    var Dw5: Image = Image<RGBA>(named: "Dw 5")!.resize(width: 50, height: 50)
    
    var Ib1: Image = Image<RGBA>(named: "Ib 1")!.resize(width: 50, height: 50)
    var Ib2: Image = Image<RGBA>(named: "Ib 2")!.resize(width: 50, height: 50)
    var Ib3: Image = Image<RGBA>(named: "Ib 3")!.resize(width: 50, height: 50)
    var Ib4: Image = Image<RGBA>(named: "Ib 4")!.resize(width: 50, height: 50)
    var Ib5: Image = Image<RGBA>(named: "Ib 5")!.resize(width: 50, height: 50)
    var Ib6: Image = Image<RGBA>(named: "Ib 6")!.resize(width: 50, height: 50)
    
    var Iw1: Image = Image<RGBA>(named: "Iw 1")!.resize(width: 50, height: 50)
    var Iw2: Image = Image<RGBA>(named: "Iw 2")!.resize(width: 50, height: 50)
    var Iw3: Image = Image<RGBA>(named: "Iw 3")!.resize(width: 50, height: 50)
    var Iw4: Image = Image<RGBA>(named: "Iw 4")!.resize(width: 50, height: 50)
    var Iw5: Image = Image<RGBA>(named: "Iw 5")!.resize(width: 50, height: 50)
    var Iw6: Image = Image<RGBA>(named: "Iw 6")!.resize(width: 50, height: 50)
    

    func toMatrix (theImage: Image<RGBA>) -> Matrix{
        var arr = [[Double]]()
        var arrx = [Double]()
        var image: Image = theImage
        //let w = proc.w
        //let h = proc.h
        for var i in 0..<50 {
            for var j in 0..<50 {
                let pixel = image[i,j]
                let grayOfPixel = pixel.grayInt
                arrx.append(Double(grayOfPixel))
            }
            arr.append(arrx)
            arrx.removeAll()
        }
        var theMat = Matrix(elements: arr)
        return theMat
    }
    func sumElements(input: Matrix) -> Double{
        var sum = 0.0
        for element in input{
            sum = sum + element
        }
        return sum
    }
    
    func doTheMath (input: Image<RGBA>, database: [Matrix]) -> String{
        let m = toMatrix(theImage: input)
        
        var corinthianComparison = (m - database[0]) ^~ 2
        var doricComparison = (m - database[1]) ^~ 2
        var ionicComparsion = (m - database[2]) ^~ 2
        
        if sumElements(input: corinthianComparison) < sumElements(input: doricComparison) && sumElements(input: corinthianComparison) < sumElements(input: ionicComparsion){
             return "Your Column is Corinthian!"
        }
        else if sumElements(input: doricComparison) < sumElements(input: ionicComparsion){
            return "Your Column is Doric!"
        }
        else{
            return "Your Column is Ionic!"
        }
    }
    
    init() {
        var Cb1Mat = toMatrix (theImage: Cb1)
        var Cb2Mat = toMatrix (theImage: Cb2)
        var Cb3Mat = toMatrix (theImage: Cb3)
        var Cb4Mat = toMatrix (theImage: Cb4)
        var Cb5Mat = toMatrix (theImage: Cb5)
        var Cb6Mat = toMatrix (theImage: Cb6)
        
        var CbAVG = (Cb1Mat + Cb2Mat + Cb3Mat + Cb4Mat + Cb5Mat + Cb6Mat) / 6
        
        var Cw1Mat = toMatrix (theImage: Cw1)
        var Cw2Mat = toMatrix (theImage: Cw2)
        var Cw3Mat = toMatrix (theImage: Cw3)
        var Cw4Mat = toMatrix (theImage: Cw4)
        var Cw5Mat = toMatrix (theImage: Cw5)
        var Cw6Mat = toMatrix (theImage: Cw6)
        
        var CwAVG = (Cw1Mat + Cw2Mat + Cw3Mat + Cw4Mat + Cw5Mat + Cw6Mat) / 6
        
        var Db1Mat = toMatrix (theImage: Db1)
        var Db2Mat = toMatrix (theImage: Db2)
        var Db3Mat = toMatrix (theImage: Db3)
        var Db4Mat = toMatrix (theImage: Db4)
        var Db5Mat = toMatrix (theImage: Db5)
        
        var DbAVG = (Db1Mat + Db2Mat + Db3Mat + Db4Mat + Db5Mat) / 5
      
        var Dw1Mat = toMatrix (theImage: Dw1)
        var Dw2Mat = toMatrix (theImage: Dw2)
        var Dw3Mat = toMatrix (theImage: Dw3)
        var Dw4Mat = toMatrix (theImage: Dw4)
        var Dw5Mat = toMatrix (theImage: Dw5)
        
        var DwAVG = (Dw1Mat + Dw2Mat + Dw3Mat + Dw4Mat + Dw5Mat) / 5
        
        var Ib1Mat = toMatrix (theImage: Ib1)
        var Ib2Mat = toMatrix (theImage: Ib2)
        var Ib3Mat = toMatrix (theImage: Ib3)
        var Ib4Mat = toMatrix (theImage: Ib4)
        var Ib5Mat = toMatrix (theImage: Ib5)
        var Ib6Mat = toMatrix (theImage: Ib6)
        
        var IbAVG = (Ib1Mat + Ib2Mat + Ib3Mat + Ib4Mat + Ib5Mat + Ib6Mat) / 6
       
        var Iw1Mat = toMatrix (theImage: Iw1)
        var Iw2Mat = toMatrix (theImage: Iw2)
        var Iw3Mat = toMatrix (theImage: Iw3)
        var Iw4Mat = toMatrix (theImage: Iw4)
        var Iw5Mat = toMatrix (theImage: Iw5)
        var Iw6Mat = toMatrix (theImage: Iw6)
        
        var IwAVG = (Iw1Mat + Iw2Mat + Iw3Mat + Iw4Mat + Iw5Mat + Iw6Mat) / 6
        
        var cAVG = (CbAVG + CwAVG) / 2
        var dAVG = (DbAVG + DwAVG) / 2
        var iAVG = (IbAVG + IwAVG) / 2
        print(cAVG.size)
        print(dAVG.size)
        print(iAVG.size)
        avgArr = [cAVG, dAVG, iAVG]
        
        func returnArray () -> [Matrix]{
            return avgArr
        }
    }
    
    func mathCall(inp: Image<RGBA>) -> String{
    var image = inp.resize(width: 50, height: 50)
        image = image.map { (pixel: RGBA) -> RGBA in
            pixel.gray < 128 ? RGBA.black : RGBA.white}
        return doTheMath(input: image, database: avgArr)
    }
    
}
