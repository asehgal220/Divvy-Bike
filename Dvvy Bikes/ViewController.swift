//
//  ViewController.swift
//  Dvvy Bikes
//
//  Created by Ananya Sehgal on 6/26/17.
//  Copyright © 2017 De Dawg. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var myTableView: UITableView!
     var location = [[String: String ]] ()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let urlString = "https://feeds.divvybikes.com/stations/stations.json"
        let  url = URL(string: urlString)

        if let url = URL(string: urlString)
        {
        if let myData = try? Data(contentsOf: url, options: [])
        {
            let json = JSON(myData)
            parse(myData: json)
        }
        
    }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return location.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        let locations = location[indexPath.row]
        cell.textLabel?.text = locations["stationName"]
        cell.detailTextLabel?.text = "There are " + locations["availableDocks"]! + " docks out of " +  locations["totalDocks"]! + " docks available"
        
        return cell

    }
    
    func parse (myData:JSON)
    {
        for elements in myData ["stationBeanList"].arrayValue
        {
            let stationName = elements["stationName"].stringValue
            let availableDocks = elements["availableDocks"].stringValue
            let totalDocks =  elements["totalDocks"].stringValue
            let value = elements["statusValue"].stringValue
            let latitudes = elements["latitude"].stringValue
            let longitudes = elements["longitude"].stringValue


            let obj = ["stationName" : stationName, "availableDocks" : availableDocks, "totalDocks": totalDocks,  "statusValue":  value,  "latitude":latitudes,  "longitude":latitudes]
            
            location.append(obj)
        }
        myTableView.reloadData()
    }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?)
        {
            let locations = location[(myTableView.indexPathForSelectedRow?.row)!]
            let dvc = segue.destination as! DetailViewController
            dvc.detailItem = locations
        }
}





