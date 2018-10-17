//
//  StatsCell.swift
//  Fortnite Hub
//
//  Created by Fabio Dantas on 10/10/2018.
//  Copyright © 2018 Fabio Dantas. All rights reserved.
//

import UIKit
 import Charts
class StatsCell: UICollectionViewCell {
    
    @IBOutlet weak var lastUpdate: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var kdRatio: UILabel!
    @IBOutlet weak var kills: UILabel!
    @IBOutlet weak var timeplayed: UILabel!
    @IBOutlet weak var winRate: UILabel!
    @IBOutlet weak var matchesPlayed: UILabel!
    @IBOutlet weak var wins: UILabel!
    @IBOutlet weak var barChartView: BarChartView!
    var months: [String]!
    
    func configureCell(mode: Mode) {
        
        let unixTimestamp = Double(mode.lastUpdate!)
        let lastDate = Date(timeIntervalSince1970: unixTimestamp)
        
        let stringFromLastDate = lastDate.toString(dateFormat: "MMM dd, yyyy")
      
        
        lastUpdate.text = stringFromLastDate
        score.text = String(mode.score!)
        kdRatio.text = String(mode.kdRatio!) + "%"
        kills.text = String(mode.kills!)
        timeplayed.text = hourFromseconds(seconds: mode.timePlayed! * 60)
        winRate.text = String(mode.winRate!) + "%"
        matchesPlayed.text = String(mode.matchesPlayed!)
        wins.text = String(mode.wins!)
        
        let months = [ "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [ 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        setChart(dataPoints: months, values: unitsSold)
       
    }
    
    func hourFromseconds(seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds / 60) % 60
        return "\(hours)h\(minutes)m"
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        barChartView.noDataText = "You need to provide data for the chart."
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: values[i], y: Double(i))
            dataEntries.append(dataEntry)
        }
        
        let charDataSet = BarChartDataSet(values: dataEntries, label: nil)
        var colors = [UIColor().setRGB(r: 178, g: 90, b: 218), UIColor().setRGB(r: 67, g: 160, b: 219)]
        charDataSet.colors = colors
        charDataSet.valueColors = [UIColor.white]
        let charData = BarChartData()
        charData.addDataSet(charDataSet)
        barChartView.data = charData
        barChartView.leftAxis.enabled = false
        barChartView.rightAxis.enabled = false
        barChartView.xAxis.enabled = false
        barChartView.legend.enabled = false
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        
    }
}
