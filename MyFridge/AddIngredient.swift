

import SwiftUI

struct AddIngredient: View {
  static let DefaultIngredientTitle = "Nothing"
  static let DefaultIngredientBrand = "Nothing"
  
  let id = UUID()
  @State var title = ""
  @State var brand = ""
  @State var expiryDate = Date()
  let onComplete: (String, String, Date, UUID) -> Void

  var body: some View {
    NavigationView {
      Form {
        Section(header: Text("Name")) {
          TextField("Name", text: $title)
        }
        Section(header: Text("Brand")) {
          TextField("Brand", text: $brand)
        }
        Section {
          DatePicker(
            selection: $expiryDate,
            displayedComponents: .date) {
              Text("Expiry Date").foregroundColor(Color(.gray))
          }
        }
        Section {
          Button(action: addMoveAction) {
            Text("Add Ingredient")
          }
        }
      }
      .navigationBarTitle(Text("Add Ingredient"), displayMode: .inline)
    }
  }

  private func addMoveAction() {
    onComplete(
      title.isEmpty ? AddIngredient.DefaultIngredientTitle : title,
      brand.isEmpty ? AddIngredient.DefaultIngredientBrand : brand,
      expiryDate, id)
  }
}
