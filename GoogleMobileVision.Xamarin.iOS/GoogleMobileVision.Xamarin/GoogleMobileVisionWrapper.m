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

    NSLog(@"Detected %lu textes.", (unsigned long)features.count);

    NSString *result = @"";

    for (GMVTextBlockFeature *textBlock in features) {
        NSLog(@"lang: %@ value: %@", textBlock.language, textBlock.value);

        // For each text block, iterate over each line.
        for (GMVTextLineFeature *textLine in textBlock.lines) {
            NSLog(@"lang: %@ value: %@", textLine.language, textLine.value);

            // For each line, iterate over each word.
            for (GMVTextElementFeature *textElement in textLine.elements) {
                NSLog(@"value: %@", textElement.value);
                result = [result stringByAppendingString: textElement.value];
            }
        }
    }

    return result;
}

@end
