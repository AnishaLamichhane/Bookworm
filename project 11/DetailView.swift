//
//  DetailView.swift
//  project 11
//
//  Created by Anisha Lamichhane on 6/3/21.
//

import SwiftUI
import CoreData

struct DetailView: View {
//   property to hold our Core Data managed object context (so we can delete stuff)
    @Environment(\.managedObjectContext) var moc
//   property to hold our presentation mode (so we can pop the view off the navigation stack)
    @Environment(\.presentationMode) var presentationMode
    @State private var showingDeleteAlert = false
    @State private var publishedDate = Date()
    
    let book : Book
    var body: some View {
        GeometryReader { geo in
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    Image(self.book.genre ?? "Fantasy")
                        .frame(maxWidth: geo.size.width)
                  
                    
                    Text(self.book.genre?.uppercased() ?? "") //challenge 1
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                }
                Text(self.book.author ?? "Unknown Author")
                    .font(.title)
                    .foregroundColor(.secondary)
                
                Text(self.book.review ?? "No Review")
                    
//                challenge 3
                Text(publishedDate.addingTimeInterval(600), style: .date)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding()
                
                
//                here we don't to let user to change rating so we use constant
                RatingView(rating: .constant(Int(self.book.rating)))
                    .font(.largeTitle)
                Spacer()
            }
        }
        .navigationBarTitle(Text(book.title ?? "Unknown Book"), displayMode: .inline)
        .alert(isPresented: $showingDeleteAlert) {
            Alert(title: Text("Delete Book"), message: Text("Are you sure ?"), primaryButton: .destructive(Text("Delete")) {
                self.deleteBook()
            }, secondaryButton: .cancel())
        }
        
        .navigationBarItems(trailing: Button(action: {
            self.showingDeleteAlert = true
            
        }) {
            Image(systemName: "trash")
        })
    }
    
    func deleteBook() {
        moc.delete(book)
        
        // uncomment this line if you want to make the deletion permanent
        // try? self.moc.save()
        
        presentationMode.wrappedValue.dismiss()
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Test book"
        book.author = "Test author"
        book.genre = "Fantasy"
        book.rating = 4
        book.review = "This was a great book; I really enjoyed it."
        
        return NavigationView {
           DetailView(book: book)
       }

    }
}
