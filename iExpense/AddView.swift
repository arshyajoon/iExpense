//
//  AddView.swift
//  iExpense
//
//  Created by Arshya GHAVAMI on 1/19/21.
//

import SwiftUI

struct AddView: View {
    @State private var name = ""
        @State private var type = "Personal"
        @State private var amount = ""

        static let types = ["Business", "Personal"]
    @ObservedObject var expenses: Expenses
    @Environment(\.presentationMode) var presentationMode
    @State private var isShowingAlert = false
    var body: some View {
        NavigationView {
                   Form {
                       TextField("Name", text: $name)
                       Picker("Type", selection: $type) {
                           ForEach(Self.types, id: \.self) {
                               Text($0)
                           }
                       }
                       TextField("Amount", text: $amount)
                           .keyboardType(.numberPad)
                   }
                   .navigationBarTitle("Add new expense")
                   .navigationBarItems(trailing: Button("Save") {
                       if let actualAmount = Int(self.amount) {
                           let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                           self.expenses.items.append(item)
                        self.presentationMode.wrappedValue.dismiss()
                       } else {
                        self.isShowingAlert = true
                       }
                   })
                   .alert(isPresented: $isShowingAlert) { () -> Alert in
                    Alert(title: Text("Invalid word"), message: Text("This is an invalid word"), dismissButton: .default(Text("Ok")))
                   }
               }
           }
    }


struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
