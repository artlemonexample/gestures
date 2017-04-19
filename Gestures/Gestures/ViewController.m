//
//  ViewController.m
//  Gestures
//
//  Created by Artem Kravchenko on 4/19/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import "ViewController.h"

NSUInteger const kCountOfViews = 5;

@interface ViewController ()

@property (nonatomic, assign) CGFloat pinchScale;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self generateBackViews];
}


#pragma mark - Generator

- (void)generateBackViews {
    CGFloat offsetY = [UIScreen mainScreen].bounds.size.height / (CGFloat)kCountOfViews;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    for (int i = 0; i < kCountOfViews; i++) {
        UILabel *label = [UILabel new];
        label.textAlignment = NSTextAlignmentCenter;
        label.userInteractionEnabled = YES;
        UIGestureRecognizer *gestureReconizer = nil;
        switch (i) {
            case 0:
            {
                label.backgroundColor = UIColor.greenColor;
                label.text = @"Tap";
                gestureReconizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
                ((UITapGestureRecognizer*)gestureReconizer).numberOfTapsRequired = 3;
            } break;
            case 1:
                label.backgroundColor = UIColor.yellowColor;
                label.text = @"Long Press";
                gestureReconizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
                break;
            case 2:
                label.backgroundColor = UIColor.blueColor;
                label.text = @"Pan";
                gestureReconizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(hadnlePan:)];
                break;
            case 3:
                label.backgroundColor = UIColor.purpleColor;
                label.text = @"Pinch";
                gestureReconizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
                break;
            case 4:
                label.backgroundColor = UIColor.grayColor;
                label.text = @"Swipe";
                gestureReconizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
                ((UISwipeGestureRecognizer*)gestureReconizer).direction = UISwipeGestureRecognizerDirectionUp;
                break;
            default:
                label.backgroundColor = self.randomColor;
                break;
        }
        CGRect frame = CGRectMake(0, i*offsetY, screenWidth, offsetY);
        label.frame = frame;
        [self.view addSubview:label];
        if (gestureReconizer != nil) {
            [label addGestureRecognizer:gestureReconizer];
        }
    }
}


#pragma mark - Actions

- (void)handleTap:(UITapGestureRecognizer*)gestureRecognizer {
    UILabel *label = (id)gestureRecognizer.view;
    label.userInteractionEnabled = NO;
    label.text = @"USER DID TAP";
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        label.userInteractionEnabled = YES;
        label.text = @"Tap";
    });
}

- (void)handleLongPress:(UILongPressGestureRecognizer*)gestureRecognizer {
    UILabel *label = (id)gestureRecognizer.view;
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            label.text = @"LONG PRESS STATE BEGAN";
            break;
        case UIGestureRecognizerStateChanged:
            label.text = @"LONG PRESS STATE CHANGED";
            break;
        case UIGestureRecognizerStateEnded: {
            label.text = @"LONG PRESS STATE ENDED";
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                label.text = @"Long Press";
            });
        } break;
            
        default:
            break;
    }
}

- (void)hadnlePan:(UIPanGestureRecognizer*)gestureRecognizer {
    UILabel *label = (id)gestureRecognizer.view;
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            label.text = @"";
            break;
        case UIGestureRecognizerStateChanged: {
            CGPoint touchPoint = [gestureRecognizer locationInView:label];
            label.text = [NSString stringWithFormat:@"%@ ; %@", @((int)touchPoint.x), @((int)touchPoint.y)];
        }break;
        case UIGestureRecognizerStateEnded: {
            label.text = @"PAN STATE ENDED";
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                label.text = @"Pan";
            });
        } break;
        default:
            break;
    }
}

- (void)handlePinch:(UIPinchGestureRecognizer*)gestureRecognizer {
    UILabel *label = (id)gestureRecognizer.view;
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            self.pinchScale = 1.0;
            break;
        case UIGestureRecognizerStateChanged: {
            label.text = [NSString stringWithFormat:@"%@", @(self.pinchScale - gestureRecognizer.scale)];
        } break;
        case UIGestureRecognizerStateEnded: {
            label.text = @"PINCH STATE ENDED";
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                label.text = @"Pinch";
            });
        } break;
        default:
            break;
    }
}

- (void)handleSwipe:(UISwipeGestureRecognizer*)gestureRecognizer {
    UILabel *label = (id)gestureRecognizer.view;
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            label.text = @"SWIPE DID HANDLE";
            break;
        case UIGestureRecognizerStateEnded: {
            label.text = @"SWIPE STATE ENDED";
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                label.text = @"Swipe";
            });
        } break;
        default:
            break;
    }
}


#pragma mark - Utils

- (UIColor *)randomColor
{
    CGFloat red = arc4random_uniform(255) / 255.0;
    CGFloat green = arc4random_uniform(255) / 255.0;
    CGFloat blue = arc4random_uniform(255) / 255.0;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    NSLog(@"%@", color);
    return color;
}


@end
