//
//  ViewController.swift
//  Weather Forecast
//
//  Created by Lilit Avetisyan on 1/17/17.
//  Copyright © 2017 Lil. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var city: UITextField!
    
    @IBOutlet var result: UILabel!
    
    @IBAction func submit(_ sender: Any) {
        if let url = URL(string: "http://www.weather-forecast.com/locations/"+city.text!.replacingOccurrences(of: " ", with: "-")+"/forecasts/latest"){
        
        let request = NSMutableURLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            
            var messege = ""
            
            if error != nil{
                
                print(error)
                
            }else{
                
                if let unwrappedData = data{
                    
                    let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                    
                    var stringSeperator = "Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">"
                    
                    if let contentArray = dataString?.components(separatedBy: stringSeperator){
                        
                        if contentArray.count > 1
                        {
                            stringSeperator = "</span>"
                            
                            let newContentArray = contentArray[1].components(separatedBy: stringSeperator)
                            
                            if newContentArray.count > 1{
                                
                                messege = newContentArray[0].replacingOccurrences(of: "&deg;", with: "°")
                                print(messege)
                                
                                
                            }
                            
                        }
                    }
                }
                
                
                if messege == ""{
                    messege = "The weather there could not be found. Please try again."
                }
                DispatchQueue.main.sync(execute: {
                    self.result.text = messege
                })
            }
            
        }
        task.resume()
        }else{
            result.text = "The weather there could not be found. Please try again."
        }

    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

