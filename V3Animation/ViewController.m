//
//  ViewController.m
//  TestAnimation
//
//  Created by Chandan Kumar on 25/04/21.
//

#import "ViewController.h"
#import "V3Model.h"
#import "UIView+Position.h"

#define kANIMATION_POSITIONS 8.0f // 0 through 8
#define kANIMATION_POSITION 1.0f/kANIMATION_POSITIONS
#define kIMAGE_ONE_ANIMATION_POSITION (7 * kANIMATION_POSITION)
#define kIMAGE_TWO_ANIMATION_POSITION (4 * kANIMATION_POSITION)
#define kIMAGE_THREE_ANIMATION_POSITION (1 * kANIMATION_POSITION)

#define kANIMATION_PARTS 8.0f
#define kANIMATION_PART 1.0f/kANIMATION_PARTS
#define kIMAGE_ONE_TIMING_PERCENTAGE (1 * kANIMATION_PART)
#define kIMAGE_TWO_TIMING_PERCENTAGE (4 * kANIMATION_PART)
#define kIMAGE_THREE_TIMING_PERCENTAGE (7 * kANIMATION_PART)
#define kIMAGE_ANIMATION_LOOP_PERCENT_DELAY (2 * kANIMATION_PART)

#define kONE_THIRD .333f
#define kONE_SIXTH .166f

@interface ViewController ()
{
    int lastAnimationImageIndex;
}

@property (nonatomic) UIView *animationView;
@property (nonatomic) V3Model *model;
@property (nonatomic) BOOL shouldAnimate;
@property (nonatomic) NSTimer *animationTimer;

/* Animation Images */
@property (nonatomic) UIImageView *animationImageOne;
@property (nonatomic) UIImageView *animationImageTwo;
@property (nonatomic) UIImageView *animationImageThree;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.model = [[V3Model alloc] init];
    [self setupUI];
}

- (UIView *)animationView
{
    if (!_animationView) {
        _animationView = [[UIView alloc] init];
        _animationView.translatesAutoresizingMaskIntoConstraints = false;
        _animationView.backgroundColor = [UIColor systemGray6Color];
    }
    return _animationView;
}

- (void)setupUI
{
    [self.view addSubview:self.animationView];
    
    NSLayoutConstraint *centreHorizontallyConstraint = [NSLayoutConstraint
                                                        constraintWithItem:self.animationView
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                        toItem:self.view
                                                        attribute:NSLayoutAttributeCenterX
                                                        multiplier:1.0
                                                        constant:0];

    NSLayoutConstraint *centreVerticalConstraint = [NSLayoutConstraint
                                                    constraintWithItem:self.animationView
                                                    attribute:NSLayoutAttributeCenterY
                                                    relatedBy:NSLayoutRelationEqual
                                                    toItem:self.view
                                                    attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0
                                                    constant:0];
    
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.animationView
                                           attribute:NSLayoutAttributeWidth
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:nil
                                           attribute: NSLayoutAttributeNotAnAttribute
                                           multiplier:1
                                           constant:self.screenWidth];
    
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.animationView
                                           attribute:NSLayoutAttributeHeight
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:nil
                                           attribute: NSLayoutAttributeNotAnAttribute
                                           multiplier:1
                                           constant:self.screenWidth];
    
    [self.view addConstraints:@[widthConstraint, heightConstraint, centreHorizontallyConstraint, centreVerticalConstraint]];
    
}

- (CGFloat)screenWidth
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    return screenRect.size.width;
}

#pragma mark Pass Activation Images

- (NSArray *)animationImages
{
    return @[self.animationImageOne, self.animationImageTwo, self.animationImageThree];
}

- (UIImageView *)animationImageOne
{
    if (!_animationImageOne) {
        _animationImageOne = [self newAnimationImageAtAnimationPosition:kIMAGE_ONE_ANIMATION_POSITION];
    }
    return _animationImageOne;
}

- (UIImageView *)animationImageTwo
{
    if (!_animationImageTwo) {
        _animationImageTwo = [self newAnimationImageAtAnimationPosition:kIMAGE_TWO_ANIMATION_POSITION];
    }
    return _animationImageTwo;
}

- (UIImageView *)animationImageThree
{
    if (!_animationImageThree) {
        _animationImageThree = [self newAnimationImageAtAnimationPosition:kIMAGE_THREE_ANIMATION_POSITION];
    }
    return _animationImageThree;
}

- (UIImageView *)newAnimationImageAtAnimationPosition:(float)positionPercentage
{
    CGRect frame = [self frameForAnimationImageAtAnimationCompletionPercent:positionPercentage];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
    imageView.image = self.model.firstImage;
    imageView.alpha = 0.75f;
    imageView.tag = ++lastAnimationImageIndex;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.animationView addSubview:imageView];
    
    return imageView;
}

- (CGRect)frameForAnimationImageAtAnimationCompletionPercent:(float)positionPercentage
{
    CGRect startingPosition = [self startingFrameForAnimationImage];
    CGRect endingPosition = [self endingFrameForAnimationImage];
    
    CGRect rect = [UIView rectAnimationPercent:positionPercentage betweenStartingFrame:startingPosition endingFrame:endingPosition];
    
    return rect;
}

- (CGRect)startingFrameForAnimationImage
{
    ViewAlignment startingAlignment = self.directionFromV3;
    return [UIView frameForViewOfSize:self.animationImageSize
                        withAlignment:startingAlignment
               alignedWithParentViews:self.animationView
                        withAlignment:[UIView adjoiningWithViewAlignment:startingAlignment]];
}

- (CGRect)endingFrameForAnimationImage
{
    ViewAlignment endingAlignment = self.directionFromV3;
    return [UIView frameForViewOfSize:self.animationImageSize
                        withAlignment:[UIView adjoiningWithViewAlignment:endingAlignment]
               alignedWithParentViews:self.animationView
                        withAlignment:endingAlignment];
}

- (CGSize)animationImageSize
{
//TODO: Make Dynamic
    return CGSizeMake(self.animationView.frame.size.width * kONE_THIRD, self.animationView.frame.size.height * kONE_THIRD);
}

- (ViewAlignment)directionFromV3
{
    return (ViewAlignment)self.model.firstDirection;
}

- (void)resetAnimationImageIndex
{
    lastAnimationImageIndex = -1;
}

#pragma mark - Image Animation

- (void)resetAndRunActivationImageAnimation
{
    [self resetActivationImages];
    [self animateActivationImages];
}

- (void)resetActivationImages
{
    [self resetAnimationImageIndex];
    
    [self.animationImageOne setFrame:[self frameForAnimationImageAtAnimationCompletionPercent:kIMAGE_ONE_ANIMATION_POSITION]];
    [self.animationImageTwo setFrame:[self frameForAnimationImageAtAnimationCompletionPercent:kIMAGE_TWO_ANIMATION_POSITION]];
    [self.animationImageThree setFrame:[self frameForAnimationImageAtAnimationCompletionPercent:kIMAGE_THREE_ANIMATION_POSITION]];
}

- (void)animateActivationImages
{
    [self animateFromStartingPositionOffScreen];
}

- (void)animateFromStartingPositionOffScreen
{
    self.shouldAnimate = YES;
    NSTimeInterval duration = self.model.activationImageDuration;
    
    /* Calculate the time remaining for each animation to complete from starting position */
    NSTimeInterval durationForImageOne = duration * kIMAGE_ONE_TIMING_PERCENTAGE;
    NSTimeInterval durationForImageTwo = duration * kIMAGE_TWO_TIMING_PERCENTAGE;
    NSTimeInterval durationForImageThree = duration * kIMAGE_THREE_TIMING_PERCENTAGE;
    NSTimeInterval durationForAnimationLoop = duration * kIMAGE_ANIMATION_LOOP_PERCENT_DELAY;

    /* Schedule animation loop to begin as soon as first image begins to leave the screen */
    [self performSelector:@selector(beginAnimationLoop) withObject:nil afterDelay:durationForAnimationLoop];
    
    /* Begin animating each image to its starting location */
    [self animateImage:self.animationImageOne withDuration:durationForImageOne];
    [self animateImage:self.animationImageTwo withDuration:durationForImageTwo];
    [self animateImage:self.animationImageThree withDuration:durationForImageThree];
}

- (void)resetAndAnimateImage:(UIImageView *)animatedImage
{
    [self resetImage:animatedImage];
    [self animateImage:animatedImage];
}

- (void)resetImage:(UIImageView *)animatedImage
{
    [animatedImage setFrame:self.startingFrameForAnimationImage];
}

- (void)animateImage:(UIImageView *)animatedImage
{
    [self animateImage:animatedImage withDuration:self.model.activationImageDuration];
}

- (void)animateImage:(UIImageView *)animatedImage withDuration:(NSTimeInterval)duration
{
    [UIView animateWithDuration:duration
                          delay:0.0f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{[animatedImage setFrame:self.endingFrameForAnimationImage];}
                     completion:^(BOOL finished) {}
     ];
}

#pragma mark - Animation Loop

- (void)beginAnimationLoop
{
    NSTimeInterval duration = self.model.activationImageDuration / self.animationImages.count;
    SEL sel = @selector(animateNextImage);

    NSMethodSignature *methodSignature = [self methodSignatureForSelector:sel];
    NSInvocation *animateImageInvocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    [animateImageInvocation setSelector:sel];
    [animateImageInvocation setTarget:self];
    
    /* Perform selector once while setting up timer */
    [self animateNextImage];
    
     /* Remove the timer if already active */
    if (self.animationTimer) {
        [self.animationTimer invalidate];
        self.animationTimer = nil;
    }
    
    if (!self.animationTimer && self.shouldAnimate) {
        self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:duration invocation:animateImageInvocation repeats:YES];
    }
}

- (void)animateNextImage
{
    [self resetAndAnimateImage:self.nextImageView];
}

- (UIImageView *)nextImageView
{
    return [self.animationImages objectAtIndex:self.nextImageViewIndex];
}

- (int)nextImageViewIndex
{
    lastAnimationImageIndex = ++lastAnimationImageIndex;
    
    if (lastAnimationImageIndex >= self.animationImages.count) {
        lastAnimationImageIndex = 0;
    }

    return lastAnimationImageIndex;
}

- (void)stopAnimation
{
    self.shouldAnimate = NO;
    [self.animationTimer invalidate];
    self.animationTimer = nil;
}

- (IBAction)startAnimation:(id)sender
{
    [self resetAndRunActivationImageAnimation];
}

- (IBAction)stopAnimation:(id)sender
{
    [self stopAnimation];
}

@end
