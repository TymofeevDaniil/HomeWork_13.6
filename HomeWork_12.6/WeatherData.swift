import Foundation

class WeatherData {

//MARK: - Init params
    let name, description, icon: String
    let tempMin, tempMax: Int
    let day1: String
    let tempDay1: Int
    let dayList: [String]; let tempList: [Int]

//MARK: - JSON form
    init?(data: NSDictionary){
        guard let cityContainer = data["city"] as? NSDictionary,
              let name = cityContainer["name"] as? String,

              let listContainer = data["list"] as? [NSDictionary],
              let day1Container = listContainer[0] as? NSDictionary,
              let mainContainerDay1 = day1Container["main"] as? NSDictionary,
              let tempMin = mainContainerDay1["temp_min"] as? Double,
              let tempMax = mainContainerDay1["temp_max"] as? Double,
              let tempDay1 = mainContainerDay1["temp"] as? Double,

              let weatherContainerArray = day1Container["weather"] as? [NSDictionary],
              let weatherContainer = weatherContainerArray[0] as? NSDictionary,
              let description = weatherContainer["description"] as? String,
              let icon = weatherContainer["icon"] as? String,
              let day1 = day1Container["dt_txt"] as? String,

              let day2Container = listContainer[8] as? NSDictionary,
              let mainContainerDay2 = day2Container["main"] as? NSDictionary,
              let tempDay2 = mainContainerDay2["temp"] as? Double,
              let day2 = day2Container["dt_txt"] as? String,

              let day3Container = listContainer[16] as? NSDictionary,
              let mainContainerDay3 = day3Container["main"] as? NSDictionary,
              let tempDay3 = mainContainerDay3["temp"] as? Double,
              let day3 = day3Container["dt_txt"] as? String,

              let day4Container = listContainer[24] as? NSDictionary,
              let mainContainerDay4 = day4Container["main"] as? NSDictionary,
              let tempDay4 = mainContainerDay4["temp"] as? Double,
              let day4 = day4Container["dt_txt"] as? String,

              let day5Container = listContainer[32] as? NSDictionary,
              let mainContainerDay5 = day5Container["main"] as? NSDictionary,
              let tempDay5 = mainContainerDay5["temp"] as? Double,
              let day5 = day5Container["dt_txt"] as? String
        else {
            return nil
        }
        self.name = name
        self.description = description
        self.icon = icon
        self.tempMin = Int(tempMin)
        self.tempMax = Int(tempMax)
        self.tempDay1 = Int(tempDay1)
        self.day1 = day1
        self.dayList = [day1, day2, day3, day4, day5]
        self.tempList = [Int(tempDay1), Int(tempDay2), Int(tempDay3), Int(tempDay4), Int(tempDay5)]
    }
}
