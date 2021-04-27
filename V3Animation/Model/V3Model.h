//
//  V3Model.h
//  TestAnimation
//
//  Created by Chandan Kumar on 25/04/21.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kANIMATION_DURATION 3.0f

typedef NS_ENUM(NSUInteger, V3AnimationDirection) {
    eBMDIRECTION_NORTH = 0,
    eBMDIRECTION_NORTH_EAST,
    eBMDIRECTION_EAST,
    eBMDIRECTION_SOUTH_EAST,
    eBMDIRECTION_SOUTH,
    eBMDIRECTION_SOUTH_WEST,
    eBMDIRECTION_WEST,
    eBMDIRECTION_NORTH_WEST
};

NS_ASSUME_NONNULL_BEGIN

@interface V3Model : NSObject

- (UIImage *)firstImage;
- (V3AnimationDirection)firstDirection;
- (NSTimeInterval)activationImageDuration;

@end

NS_ASSUME_NONNULL_END
