//
//  AddBookView.swift
//  project 11
//
//  Created by Anisha Lamichhane on 6/2/21.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre : String? //challenge 1
    @State private var review = ""
    

    let genres = ["Fantasy", "Horror" , "Kids" , "Mystery", "Romance", "Poetry", "Thriller", "Suspense"]
    var body: some View {
        
        NavigationView {
            Form {
                Section {
                    TextField("Name of Book: ", text: $title)
                    TextField("Author's Name: ", text: $author)
                  
                    Picker("Genre: ", selection: $genre){
                        ForEach(0..<genres.count) { i in
                            Text(genres[i])
                        }
                    }
                }
                
                Section {
                   RatingView(rating: $rating)
                    
                    TextField("Write a review:", text: $review)
                }
                
                Section {
                    Button("Save") {
//                        create an instance of the Book class using our managed object context  
                        let newBook = Book(context: self.moc)
                        newBook.title = self.title
                        newBook.author =  self.author
                        newBook.rating = Int16(self.rating)
                        newBook.genre = self.genre
                        newBook.review = self.review
                        try? self.moc.save()
                        
//                        to dismiss the sheet
                        self.presentationMode.wrappedValue.dismiss()
                        
                    }
                }
            }
            .navigationBarTitle("Add Book")
            
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
