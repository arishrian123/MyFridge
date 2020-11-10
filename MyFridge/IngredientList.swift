

import SwiftUI

// swiftlint:disable multiple_closures_with_trailing_closure
struct IngredientList: View {
  @Environment(\.managedObjectContext) var managedObjectContext
  // 1.
  @FetchRequest(
    // 2.
    entity: Ingredient.entity(),
    // 3.
    sortDescriptors: [
      NSSortDescriptor(keyPath: \Ingredient.title, ascending: true)
    ]
    //,predicate: NSPredicate(format: "genre contains 'Action'")
    // 4.
  ) var ingredients: FetchedResults<Ingredient>

  @State var isPresented = false

  var body: some View {
    NavigationView {
      List {
        ForEach(ingredients, id: \.title) {
          IngredientRow(ingredient: $0)
        }
        .onDelete(perform: deleteIngredient)
      }
      .sheet(isPresented: $isPresented) {
        AddIngredient { title, brand, expiry in
          self.addIngredient(title: title, brand: brand, expiryDate: expiry)
          self.isPresented = false
        }
      }
      .navigationBarTitle(Text("My Fridge"))
      .navigationBarItems(trailing:
        Button(action: { self.isPresented.toggle() }) {
          Image(systemName: "plus")
        }
      )
    }
  }

  func deleteIngredient(at offsets: IndexSet) {
    // 1.
    offsets.forEach { index in
      // 2.
      let ingredient = self.ingredients[index]

      // 3.
      self.managedObjectContext.delete(ingredient)
    }

    // 4.
    saveContext()
  }


  func addIngredient(title: String, brand: String, expiryDate: Date) {
    // 1
    let newIngredient = Ingredient(context: managedObjectContext)

    // 2
    newIngredient.title = title
    newIngredient.brand = brand
    newIngredient.expiryDate = expiryDate

    // 3
    saveContext()
  }


  func saveContext() {
    do {
      try managedObjectContext.save()
    } catch {
      print("Error saving managed object context: \(error)")
    }
  }
}

struct IngredientList_Previews: PreviewProvider {
  static var previews: some View {
    IngredientList()
  }
}
