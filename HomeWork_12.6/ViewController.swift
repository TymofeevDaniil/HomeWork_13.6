import UIKit

class ViewController: UIViewController {
    var fiveDayData: [String] = []
    var fiveDayTemp: [Int] = []
    let c = "C\u{00B0}" // "C" and celsius symbol
    var cityID: String = ""
    
    @IBOutlet weak var countryNameTextField: UITextField!
    @IBAction func goButton(_ sender: Any) {
        cityUrl()
        WeatherDataLoader().cityDataLoader(url: cityID){ weatherData in
            self.cityNameLabel.text = weatherData.name
            self.mainTempLabel.text = "\(weatherData.tempDay1) \(self.c)"
            self.minTempLabel.text = "мин.  \(weatherData.tempMin) \(self.c)"
            self.maxTempLabel.text = "макс. \(weatherData.tempMax) \(self.c)"
            self.iconImageView.image = UIImage(named: "\(weatherData.icon)")
            self.descriptionLabel.text = weatherData.description
            self.fiveDayData = weatherData.dayList
            self.fiveDayTemp = weatherData.tempList
            self.listTable.reloadData()
        }
    }
    
    func cityUrl() {
        guard let city = countryNameTextField.text else {return}
        cityID = "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&units=metric&appid=7b92543413e935f9b9ae8273cb2f54d2&lang=RU"
    }
    
    
    @IBAction func switchFuncSegment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1:
            WeatherDataLoader().loadWeatherAlamofire{ weatherData in
                self.cityNameLabel.text = weatherData.name
                self.mainTempLabel.text = "\(weatherData.tempDay1) \(self.c)"
                self.minTempLabel.text = "мин.  \(weatherData.tempMin) \(self.c)"
                self.maxTempLabel.text = "макс. \(weatherData.tempMax) \(self.c)"
                self.iconImageView.image = UIImage(named: "\(weatherData.icon)")
                self.descriptionLabel.text = weatherData.description
                self.fiveDayData = weatherData.dayList
                self.fiveDayTemp = weatherData.tempList
                self.listTable.reloadData()
                print("using Alamofire")
            }
        default:
            WeatherDataLoader().loadWeatherData(completion: {weatherData in
                self.cityNameLabel.text = weatherData.name
                self.mainTempLabel.text = "\(weatherData.tempDay1) \(self.c)"
                self.minTempLabel.text = "мин.  \(weatherData.tempMin) \(self.c)"
                self.maxTempLabel.text = "макс. \(weatherData.tempMax) \(self.c)"
                self.iconImageView.image = UIImage(named: "\(weatherData.icon)")
                self.descriptionLabel.text = weatherData.description
                self.fiveDayData = weatherData.dayList
                self.fiveDayTemp = weatherData.tempList
                self.listTable.reloadData()
                print("using native method")
            })
        }
    }
    @IBOutlet weak var listTable: UITableView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var mainTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WeatherDataLoader().loadWeatherData(completion: {weatherData in
            self.cityNameLabel.text = weatherData.name
            self.mainTempLabel.text = "\(weatherData.tempDay1) \(self.c)"
            self.minTempLabel.text = "мин.  \(weatherData.tempMin) \(self.c)"
            self.maxTempLabel.text = "макс. \(weatherData.tempMax) \(self.c)"
            self.iconImageView.image = UIImage(named: "\(weatherData.icon)")
            self.descriptionLabel.text = weatherData.description
            self.fiveDayData = weatherData.dayList
            self.fiveDayTemp = weatherData.tempList
            self.listTable.reloadData()
        })
    }
}
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fiveDayData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fiveDayCell") as! fiveDayCell
        cell.dateLabel.text = fiveDayData[indexPath.row]
        cell.tempLabel.text = String(fiveDayTemp[indexPath.row]) + " \(self.c)"
        return cell
    }
}

