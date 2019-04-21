//
//  EnjoeiTestUITests.swift
//  EnjoeiTestUITests
//
//  Created by Junio Moquiuti on 15/04/19.
//  Copyright © 2019 Junio Moquiuti. All rights reserved.
//

import XCTest
@testable import Pods_EnjoeiTest

class EnjoeiTestUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }
    
    func testExample() {

        //Navigation between tabs and return to home
        let tabBarsQuery = app.tabBars
        tabBarsQuery.children(matching: .button).element(boundBy: 1).tap()
        tabBarsQuery.children(matching: .button).element(boundBy: 2).tap()
        tabBarsQuery.children(matching: .button).element(boundBy: 3).tap()
        tabBarsQuery.children(matching: .button).element(boundBy: 4).tap()
        tabBarsQuery.children(matching: .button).element(boundBy: 0).tap()

        //Force pull to refresh
        let cellsQuery = app.collectionViews.cells
        cellsQuery.otherElements.containing(.staticText, identifier:"biquini top tomara que caia - salinas").element.swipeDown()

        //Force infinity scroll
        let collectionView = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .collectionView).element
        collectionView.swipeUp()
        collectionView.swipeUp()
        cellsQuery.otherElements.containing(.staticText, identifier:"canga de praia").element.swipeUp()

        //Open product details
        collectionView.swipeDown()
        collectionView.swipeDown()
        collectionView.swipeDown()
        cellsQuery.otherElements.containing(.staticText, identifier:"biquini top tomara que caia - salinas").element.tap()

        //Back to home
        app.navigationBars["EnjoeiTest.ProductDetailsView"].buttons["Back"].tap()
    }
}
