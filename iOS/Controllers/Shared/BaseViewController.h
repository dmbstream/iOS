//
//  BaseViewController.h
//  iOS
//
//  Created by James Geurts on 5/5/12.
//  Copyright (c) 2012 Bia Creations. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController <UITextFieldDelegate> {
    CGPoint offset;
    CGSize keyboardSize;
    BOOL isKeyboardVisible;
    int originalScrollViewHeight;
}

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) UITextField *activeField;

@property (nonatomic, strong) UIToolbar *inputAccessoryView;
@property (nonatomic, strong) UIBarButtonItem *inputAccessoryViewPrevious;
@property (nonatomic, strong) UIBarButtonItem *inputAccessoryViewNext;
@property (nonatomic, strong) UIBarButtonItem *inputAccessoryViewDone;

- (void)createInputAccessoryView:(BOOL)enablePrevious enableNext:(BOOL)enableNext;
- (IBAction)dismissKeyboard:(id)sender;
- (IBAction)focusNextInput:(id)sender;
- (IBAction)focusPreviousInput:(id)sender;

- (void)navigateToRootView;
- (void)navigateToSearchView;
- (void)showExpandedPlayerView;
- (void)togglePlay;

@end
