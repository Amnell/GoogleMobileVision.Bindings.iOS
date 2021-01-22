//
//  GoogleMobileVisionWrapper.m
//  GoogleMobileVision.Xamarin
//
//  Created by Mathias Amnell on 2018-11-16.
//  Copyright © 2018 Forefront Consulting AB. All rights reserved.
//

#import "GoogleMobileVisionWrapper.h"
#import <GoogleMobileVision/GoogleMobileVision.h>

@implementation GoogleMobileVisionWrapper {
    GMVDetector *textDetector;
}

- (instancetype)init {
    self = [super init];
    if (self != nil) {
        textDetector = [GMVDetector detectorOfType:GMVDetectorTypeText options:nil];
        self.debug = false;
    }
    return self;
}

- (NSString *)detectTextInImage:(UIImage *)image {
    UIDeviceOrientation deviceOrientation = [[UIDevice currentDevice] orientation];
    GMVImageOrientation orientation = [GMVUtility
                                       imageOrientationFromOrientation:deviceOrientation
                                       withCaptureDevicePosition:AVCaptureDevicePositionBack
                                       defaultDeviceOrientation: UIDeviceOrientationPortrait];
    NSDictionary *options = @{ GMVDetectorImageOrientation : @(orientation) };

    NSArray<GMVFeature *> *features = [textDetector featuresInImage:image options:options];

    if (self.debug) {
        NSLog(@"Detected %lu textes.", (unsigned long)features.count);
    }

    NSString *result = @"";

    for (GMVTextBlockFeature *textBlock in features) {
        // For each text block, iterate over each line.
        for (GMVTextLineFeature *textLine in textBlock.lines) {
            // For each line, iterate over each word.
            for (GMVTextElementFeature *textElement in textLine.elements) {
                if (self.debug) {
                    NSLog(@"value: %@", textElement.value);
                }
                result = [result stringByAppendingString: textElement.value];
            }
        }
    }

    return result;
}

- (NSArray<NSString *> *)detectTextLinesInImage:(UIImage *)image {
    UIDeviceOrientation deviceOrientation = [[UIDevice currentDevice] orientation];
    GMVImageOrientation orientation = [GMVUtility
                                       imageOrientationFromOrientation:deviceOrientation
                                       withCaptureDevicePosition:AVCaptureDevicePositionBack
                                       defaultDeviceOrientation: UIDeviceOrientationPortrait];
    NSDictionary *options = @{ GMVDetectorImageOrientation : @(orientation) };

    NSArray<GMVFeature *> *features = [textDetector featuresInImage:image options:options];

    NSMutableArray *result = NSMutableArray.new;

    for (GMVTextBlockFeature *textBlock in features) {
        for (GMVTextLineFeature *textLine in textBlock.lines) {
            if (self.debug) {
                NSLog(@"GMVTextLineFeature: %@", textLine.value);
            }
            [result addObject:textLine.value];
        }
    }

    return result;
}

@end
