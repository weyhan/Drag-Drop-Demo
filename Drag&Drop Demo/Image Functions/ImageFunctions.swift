//
//  ImageFunctions.swift
//  Drag&Drop Demo
//
//  Created by WeyHan Ng on 19/10/2021.
//

import Cocoa
import CoreGraphics

func createImage() -> NSImage {
    let size = NSSize(width: 350, height: 350)
    let image = NSImage(size: size)
    let color = NSColor.white
    image.lockFocus()
    color.drawSwatch(in: NSRect(origin: .zero, size: size))

    let context = NSGraphicsContext.current?.cgContext

    context?.setFillColor(NSColor.blue.cgColor)
    let rectangle = CGRect(x: 150, y: 150, width: 50, height: 50)
    context?.addEllipse(in: rectangle)
    context?.fillPath()

    image.unlockFocus()

    return image
}
