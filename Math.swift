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
    
    // variable for an array of matrices that will hold the matrices with elements that represnt 
    // the average gray value of the pixels of all the images of one type of column in the internal library
    var avgArr = [Matrix]()
    
    // variables to manipulate the images in the internal library
    // "C" is for corinthian, "D" is for doric, and "I" is for ionic.
    // "b" is for black background and "w" is for white background.
    // all the image are compresed to be 50 by 50 pixels so that the calculations for the comparisons are more efficient.
    // this compression retains the image's integrity to a high degree.
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
    
    // a function to convert an image to a matrix of its pixel values.
    func toMatrix (theImage: Image<RGBA>) -> Matrix{
        var arr = [[Double]]() /* 2d array */
        var arrx = [Double]() /* array that represents each row of pixesl in an image */
        var image: Image = theImage
        
        // turning the image into a 2D array of its pixel values
        for var i in 0..<50 {
            for var j in 0..<50 {
                let pixel = image[i,j]
                let grayOfPixel = pixel.grayInt
                arrx.append(Double(grayOfPixel))
            }
            arr.append(arrx)
            arrx.removeAll() /* clears arrx so that it can be update to contain the values of the next row of pixels */
        }
        
        var theMat = Matrix(elements: arr)
        return theMat
    }
    
    // summing the elements in a matrix
    func sumElements(input: Matrix) -> Double{
        var sum = 0.0
        for element in input{
            sum = sum + element
        }
        return sum
    }
    
    // function to 
    func doTheMath (input: Image<RGBA>, database: [Matrix]) -> String{
        let m = toMatrix(theImage: input) /* converts the image to be comapared to the library to a matrix of its pixel values */
        
        // Elementwise subtraction of the the average pixel values for images of one column type in the library from the matrix
        // that represents the input image. Then squares the resulting matrix to remove negative values since. This maintains
        // the integrity of the image since every pixel is still proprtional to each other pixel value.
        var corinthianComparison = (m - database[0]) ^~ 2
        var doricComparison = (m - database[1]) ^~ 2
        var ionicComparsion = (m - database[2]) ^~ 2
        
        // The type of column of the input image is determined by which averages of library images of a given type it is less than.
        // The smallest value given by the variables above represents the smallest amount of difference in terms of pixel values
        // and therefore represents the smallest difference between the input image and the average of the images of one column type.
        // These if else statements determine what value is smallest and therefore which type of column in the input image is.
        // It then returns a string which is sent to the ViewController class, which displays the result. 
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
    
    // Initializing and instance of this class converts each image in the library to a matrix of its pixel values
    // and creates an average matrix for each column type and background type. This is done by summing the values in each
    // matrix of a given column type and background then dividing each element of the resulting matrix by the number of images
    // of the given column type and background combination. 
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
        
        // variables for the average matrix for each column type. This averages the result of the averages of the images of
        // a given column type with both backgorunds.
        var cAVG = (CbAVG + CwAVG) / 2
        var dAVG = (DbAVG + DwAVG) / 2
        var iAVG = (IbAVG + IwAVG) / 2
     
        // an array containing the matrices that represnt the average matrices for images of each columb type
        avgArr = [cAVG, dAVG, iAVG]
        
        // returns the array after manipulation so that it can be used in other functions
        func returnArray () -> [Matrix]{
            return avgArr
        }
    }
    
    // takes an input image, compresses it, converts it to grayscale then calles the doTheMath method which makes
    // the comparison to the internal library and ultimately returns the type of column to the ViewController class to
    // be displayed in the user interface.
    func mathCall(inp: Image<RGBA>) -> String{
    var image = inp.resize(width: 50, height: 50)
        image = image.map { (pixel: RGBA) -> RGBA in
            pixel.gray < 128 ? RGBA.black : RGBA.white}
        return doTheMath(input: image, database: avgArr)
    }
    
}
