//
//  AuthorSectionView.swift
//  APO
//
//  Created by Kacper on 05/09/2021.
//

import SwiftUI

///View of image's lookup table
struct AuthorSectionView: View {
    var author:Author
    var body: some View {
        HStack{
                Spacer()
                Link(destination: URL(string: author.github)!, label: {
                    Image(uiImage: UIImage(named:"github_logo")!)
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .frame(width:30,  height: 30 )
                })
                .padding(.all)
                VStack{
                    Image(author.profilePicture)
                        .resizable()
                        .scaledToFill()
                        .frame(width:60,  height: 60 )
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.black, lineWidth: 3))
                        .shadow(radius: 10)
                        .padding(.bottom,5)
                    Text("\(author.name)")
                    Text("\(author.album)")
                }
                .padding(.top,25)
                Link(destination: URL(string: author.linkedin)!, label: {
                    Image(uiImage: UIImage(named:"linkedin_logo")!)
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .frame(width:30,  height: 30 )
                })
                .padding(.all)
                Spacer()
            }
        .shadow(radius: 10)
       // .border(Color.red, width: 2)
    }
}

struct AuthorSectionView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorSectionView(author: Author.exampleAuthor())
    }
}
