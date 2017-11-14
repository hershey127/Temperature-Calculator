//
//  PreviewViewController.swift
//  Temperature Calculator

//  Created by Harshitha Tadinada on 10/7/2017.
//  Copyright © 2017 UGA. All right
//

import UIKit
var temp: Double = 0.0

class PreviewViewController: UIViewController {
    let analyzeData = AnalyzeData()
    
    @IBOutlet weak var analyze: UIButton!
    @IBOutlet weak var photo: UIImageView!
    
    var image:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photo.image = image
        rgb()
        analyze.layer.cornerRadius = 5
  //      photo.image = drawRectangleOnImage(image: photo.image!)
        
    }

    @IBAction func saveBtn_TouchUpInside(_ sender: Any) {
        guard let imageToSave = image else {
            return
        }
        
        UIImageWriteToSavedPhotosAlbum(imageToSave, nil, nil, nil)
    }
    
    @IBAction func closeBtn_TouchUpInside(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
 
    func getValue()->Double{
            return temp
    }
    
    func rgb(){
        let newImage = resizeImage(image: image!, targetSize: CGSize(width: 100, height: 100))
        let xVar1 = Int (newImage.size.width)*2/5
        let xVar2 = Int (newImage.size.width)*3/5
        let yVar1 = Int (newImage.size.height)*2/5
        let yVar2 = Int (newImage.size.height)*3/5
        
        var countPixels: Int = 0
        var totalR: Int = 0
        var totalG: Int = 0
        var totalB: Int = 0
        for xpoint in xVar1...xVar2{
            for ypoint in yVar1...yVar2{
                    let (r,g,b) = analyzeData.pixel(in: newImage, at: CGPoint(x: xpoint, y: ypoint))!
                    let R: Int = Int(r)
                    let G: Int = Int(g)
                    let B: Int = Int(b)
                    totalB = R + totalB
                    totalG = G + totalG
                    totalR = B + totalR
                    countPixels += 1
                }
            }
        let avgRed = totalR/countPixels
        let avgGreen = totalG/countPixels
        let avgBlue = totalG/countPixels
    
        print(avgRed, avgGreen, avgBlue)

        let temperature = 70.0
        temp = temperature
        
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func drawRectangleOnImage(image: UIImage) -> UIImage {
        let imageSize = image.size
        let scale: CGFloat = 0
        UIGraphicsBeginImageContextWithOptions(imageSize, false, scale)
        
        image.draw(at: CGPoint.zero)
        
        let rectangle = CGRect(x: imageSize.width*7/20 ,y: imageSize.height*9/20, width: imageSize.width*2/5, height: imageSize.height*3/201)
        //(image.size.width)*2/5,y :(image.size.height)*2/5), size: image.size))
        UIColor.black.setFill()
        UIRectFill(rectangle)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    @IBAction func analyzeData(_ sender: UIButton){
        if(image != nil){
            rgb()
        }
    func setPhotoImageView(image: UIImage){
        photo.image = image
        }
    func getPhotoImageView()-> UIImageView!{
        return photo
        }
    }
    func getTemperature() -> Double{
        return temp
    }
}



