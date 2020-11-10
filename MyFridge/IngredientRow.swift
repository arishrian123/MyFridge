

import SwiftUI

struct IngredientRow: View {
  let ingredient: Ingredient
  
  static let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    return formatter
  }()
  
  func expiryDayCalc(expiryDate: Date) -> (String) {
    
    let seconds = expiryDate.timeIntervalSinceNow
    
    let days = Int(seconds) / 86400
    let hours = Int(seconds) / 3600
    let minutes = (Int(seconds) % 3600) / 60
    
    var time = "\(days)D \(hours)H \(minutes)M"

    if days == 0 && hours == 0 && !(minutes.signum() == 1) {
      time = "Expired for \(minutes * -1)M"
    } else if days == 0 && !(hours.signum() == 1) && !(minutes.signum() == 1){
      time = "Expired for \(hours * -1)H \(minutes * -1)M"
    } else if !(days.signum() == 1) && !(hours.signum() == 1) && !(minutes.signum() == 1){
      time = "Expired for \(days * -1)D \(hours * -1)H \(minutes * -1)M"
    }
    else if days == 0 && hours == 0 && minutes < 0{
      time = "Expired Now"
    }
    else if days == 0 && hours != 0 && (minutes.signum() == 1){
      time = "\(hours)H \(minutes)M"
    } else if days == 0 && hours == 0 && minutes != 0 {
      time = "\(minutes)M"
    }
    
    return time
    }

  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        ingredient.title.map(Text.init)
          .font(.title)
        
        Spacer()
        
        Text(expiryDayCalc(expiryDate: ingredient.expiryDate!))
          .font(.caption)
          .foregroundColor(.red)
        
      }
      HStack {
        ingredient.brand.map(Text.init)
          .font(.caption)
        Spacer()
        ingredient.expiryDate.map { Text(Self.dateFormatter.string(from: $0)) }
          .font(.caption)
      }
    }
  }
}
