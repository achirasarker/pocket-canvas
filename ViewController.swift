//
//  ViewController.swift
//  Sketch Pad
//
//  Created by Achira Sarker
//  2020-07-15
//

import UIKit

class ViewController: UIViewController {

    let context = CIContext()
    var original: CanvasView?
    
    @IBOutlet weak var canvasView: CanvasView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func applySepia(_ sender: Any) {
        if original == nil {
            return
        }
        let filter = CIFilter(name: "CISepiaTone")
        filter?.setValue(0.5, forKey: kCIInputIntensityKey)
        display(filter: filter!)
    }
    
    
    @IBAction func applyVintage(_ sender: Any) {
        if original == nil {
            return
        }
        let filter = CIFilter(name: "CIPhotoEffectFade")
        display(filter: filter!)
    }
    
    @IBAction func applyNoir(_ sender: Any) {
        if original == nil {
            return
        }
        let filter = CIFilter(name: "CIPhotoEffectNoir")
        display(filter: filter!)
    }
    
    func display(filter: CIFilter) {
        canvasView = UIImage(cgImage: self.context.createCGImage(output!, from: output!.extent)!)
    }
    
    
    @IBAction func clearCanvas(_ sender: Any) {
        canvasView.clearCanvas()
    }
    
    
    @IBAction func brushSize(_ sender: UISlider) {
        canvasView.lineWidth = CGFloat(sender.value)
    }
    
    @IBAction func onClickSave(_ sender: Any) {
        let image = canvasView.takeScreenshot()
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(imageSaved(_:didFinishSavingWithError:contextType:)), nil)
    }
    
    @objc func imageSaved(_ image: UIImage, didFinishSavingWithError error: Error?, contextType: UnsafeRawPointer) {
        if error != nil {
            print("Cannot save photo into photo library")
        }else {
            print("Image saved")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //get rid of any resources that can be recreated 
    }

}

extension UIView {
    
    func takeScreenshot() -> UIImage{
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if image != nil {
            return image!
        }
        return UIImage()
    }
}
