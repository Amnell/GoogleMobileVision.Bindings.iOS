//
//  GoogleMobileVisionWrapper.h
//  GoogleMobileVision.Xamarin
//
//  Created by Mathias Amnell on 2018-11-16.
//  Copyright © 2018 Forefront Consulting AB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoogleMobileVisionWrapper : NSObject

- (NSString *)detectTextInImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
