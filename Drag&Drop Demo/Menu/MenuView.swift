//
//  MenuView.swift
//  Drag&Drop Demo
//
//  Created by WeyHan Ng on 17/10/2021.
//

import SwiftUI

struct MenuView: View {
    @Namespace var animation

    var body: some View {
        VStack {
            HStack {
                Text("Drag & Drop Demo")
            }
            .padding(.horizontal)
            .padding(.top)

            Divider()
                .padding(.top, 4)

            DraggableImage(image: createImage())

            Text("Drag & drop image above to another app that excepts drop")
                .font(.callout)
                .italic()
                .foregroundColor(.primary)
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))

            Spacer(minLength: 15)
        }
        .frame(width: 250, height: 300)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}


struct DraggableImage: View {
    let image: NSImage

    var body: some View {
        Image(nsImage: image)
            .resizable()
            .scaledToFit()
            .padding()
            .onDrag {
                guard let tiffRepresentation = image.tiffRepresentation, let bitmapImage = NSBitmapImageRep(data: tiffRepresentation), let bitmapRepresentation = bitmapImage.representation(using: .png, properties: [:]) else {

                    return NSItemProvider(item: image.tiffRepresentation as NSSecureCoding?, typeIdentifier: kUTTypeTIFF as String)
                }

                let provider = NSItemProvider(item: bitmapRepresentation as NSSecureCoding?, typeIdentifier: kUTTypePNG as String)
                provider.previewImageHandler = { (handler, _, _) -> Void in
                    handler?(bitmapRepresentation as NSSecureCoding?, nil)
                }

                return provider
            }
    }
}
