//
//  GoogleMobileVision_XamarinTests.m
//  GoogleMobileVision.XamarinTests
//
//  Created by Mathias Amnell on 2018-11-16.
//  Copyright © 2018 Forefront Consulting AB. All rights reserved.
//

#import <XCTest/XCTest.h>
@import UIKit;
@import GoogleMobileVision_Xamarin;

@interface GoogleMobileVision_XamarinTests : XCTestCase

@end

@implementation GoogleMobileVision_XamarinTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    UIImage *image = [UIImage new];
    GoogleMobileVisionWrapper *wrapper = [[GoogleMobileVisionWrapper alloc] init];
    [wrapper detectTextInImage: image];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
