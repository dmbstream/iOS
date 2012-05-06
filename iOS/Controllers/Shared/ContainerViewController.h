//
//  ContainerViewController.h
//  iOS
//
//  Created by James Geurts on 5/5/12.
//  Copyright (c) 2012 Bia Creations. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContainerViewController : UIViewController

@property (nonatomic, strong) UIViewController *headerController;
@property (nonatomic, strong) UIViewController *footerController;
@property (nonatomic, strong) UIViewController *contentController;

@end
