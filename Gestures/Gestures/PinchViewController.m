//
//  PinchViewController.m
//  Gestures
//
//  Created by Sb R on 21.04.17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import "PinchViewController.h"

@interface PinchViewController ()

@property (weak, nonatomic) IBOutlet UILabel *PinchLabel;

@end

@implementation PinchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //жест Pinch взятый по образцу с тап))
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector
        (PinchHandle:)];
    
    [self.PinchLabel addGestureRecognizer:tap];
    
    
    
}

- (void)PinchHandle:(UITapGestureRecognizer*)Pinch {
    self.PinchLabel.text = @"TAP DIDNT HANDLE";
    self.PinchLabel.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.PinchLabel.userInteractionEnabled = YES;
        self.PinchLabel.text = @"TAP";
        
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
