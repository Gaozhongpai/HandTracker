#import <Foundation/Foundation.h>
#import <CoreVideo/CoreVideo.h>

@class HTLandmark;
@class HandTracker;
@class HTHandInfo;

@protocol TrackerDelegate <NSObject>
- (void)handTracker: (HandTracker*)handTracker didOutputHandInfo:(HTHandInfo *)handInfo;
- (void)handTracker: (HandTracker*)handTracker didOutputPixelBuffer: (CVPixelBufferRef)pixelBuffer;
@end

@interface HandTracker : NSObject
- (instancetype)init;
- (void)startGraph;
- (void)processVideoFrame:(CVPixelBufferRef)imageBuffer;
@property (weak, nonatomic) id <TrackerDelegate> delegate;
@end

@interface HTHandInfo : NSObject

@property (nonatomic, readonly) NSArray <HTLandmark *> *landmarks;
@property (nonatomic, readonly) CGSize handSize;
@property (nonatomic, readonly) BOOL isRightHand;
@property (nonatomic, readonly) float handednessScore;

@end

@interface HTLandmark: NSObject
@property(nonatomic, readonly) float x;
@property(nonatomic, readonly) float y;
@property(nonatomic, readonly) float z;

@end
