#import <Foundation/Foundation.h>
#import <CoreVideo/CoreVideo.h>

@class HTLandmark;
@class HandTracker;
@class HTHandInfo;

@protocol TrackerDelegate <NSObject>
- (void)handTracker: (HandTracker*)handTracker didOutputLandmarks:(NSArray<HTLandmark *> *)landmarks;
- (void)handTracker: (HandTracker*)handTracker didOutputWorldLandmarks:(NSArray<HTLandmark *> *)landmarks;
- (void)handTracker: (HandTracker*)handTracker didOutputHandness: (BOOL)isRightHand didOutputScore: (float)score;
- (void)handTracker: (HandTracker*)handTracker didOutputPixelBuffer: (CVPixelBufferRef)pixelBuffer;
@end

@interface HandTracker : NSObject
- (instancetype)init;
- (void)startGraph;
- (void)processVideoFrame:(CVPixelBufferRef)imageBuffer;
@property (weak, nonatomic) id <TrackerDelegate> delegate;
@end


@interface HTLandmark: NSObject
@property(nonatomic, readonly) float x;
@property(nonatomic, readonly) float y;
@property(nonatomic, readonly) float z;

@end
