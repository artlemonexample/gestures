//
//  SwipeViewController.m
//  Gestures
//
//  Created by Oleksandr Kurtsev on 19.04.17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import "SwipeViewController.h"

@interface SwipeViewController ()

@property (weak, nonatomic) IBOutlet UILabel *swipeLabel;

@end

@implementation SwipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Тап который распозн жесты
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandle:)];
    
    [self.swipeLabel addGestureRecognizer:tap];
    
    
    
}

- (void)swipeHandle:(UITapGestureRecognizer*)swipe {
    self.swipeLabel.text = @"TAP DIDNT HANDLE";
    self.swipeLabel.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.swipeLabel.userInteractionEnabled = YES;
        self.swipeLabel.text = @"TAP";
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
