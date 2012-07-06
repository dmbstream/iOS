//
//  RegisterViewController.m
//  iOS
//
//  Created by James Geurts on 7/5/12.
//  Copyright (c) 2012 Bia Creations. All rights reserved.
//

#import "RegisterViewController.h"
#import "AccountService.h"
#import "AppDelegate.h"
#import "UITextField+Validation.h"
#import "Constants.h"
#import "LoginManager.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

@synthesize activityIndicator;
@synthesize username;
@synthesize email;
@synthesize password;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    username.delegate = self;
    email.delegate = self;
    password.delegate = self;
}

- (void)viewDidUnload
{
    [self setUsername:nil];
    [self setEmail:nil];
    [self setPassword:nil];
    [self setActivityIndicator:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)textFieldShouldReturn:(UITextField*)_textField
{
    if (_textField == username) {
        [email becomeFirstResponder];        
    } else if (_textField == email) {
        [password becomeFirstResponder];        
    } else if (_textField == password) {
        [password resignFirstResponder];
        [self createAccount:password];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [super textFieldDidBeginEditing:textField];
    
    // Call the createInputAccessoryView method we created earlier.
    // By doing that we will prepare the inputAccView.
    if (super.activeField == username) {
        [super createInputAccessoryView:NO enableNext:YES];
    } else if (super.activeField == email) {
        [super createInputAccessoryView:YES enableNext:YES];
    } else if (super.activeField == password) {
        [super createInputAccessoryView:YES enableNext:NO];
    }
    
    // Now add the view as an input accessory view to the selected textfield.
    [textField setInputAccessoryView:super.inputAccessoryView];    
}
- (IBAction)focusNextInput:(id)sender {
    if (super.activeField == username) {
        [email becomeFirstResponder];
    } else if (super.activeField == email) {
        [password becomeFirstResponder];
    }

}
- (IBAction)focusPreviousInput:(id)sender {
    if (super.activeField == email) {
        [username becomeFirstResponder];
    } else if (super.activeField == password) {
        [email becomeFirstResponder];
    }
}


- (IBAction)createAccount:(id)sender {
    
    BOOL isValid = TRUE;
    NSString *userErrors = [[NSString alloc] initWithString:@""];
    
    if(![username requiredText] || ![username validUsername])
    {
        isValid = FALSE;
        [username becomeFirstResponder];
        userErrors = [userErrors stringByAppendingString:@"A username of at least 3 characters is required. \r\n"];
    }
    if(![email requiredText] || ![email validEmailAddress])
    {
        isValid = FALSE;
        [email becomeFirstResponder];
        userErrors = [userErrors stringByAppendingString:@"A valid email address is required. \r\n"];
    }
    if(![password requiredText] || ![password validPassword])
    {
        if (isValid) 
        {
            [password becomeFirstResponder];
        }
        userErrors = [userErrors stringByAppendingString:@"A password of at least 6 characters is required. \r\n"];
        isValid = FALSE;
    }
    
    if (isValid) 
    {
        self.activityIndicator.hidden = NO;
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        [appDelegate requestNetworkActivityIndicator];
        AccountService *service = [AccountService new];

      
        [service registerUser:[username text] email:[email text] password:[password text] completionHandler:^(User* user, NSError* error) {
            [appDelegate releaseNetworkActivityIndicator];
            self.activityIndicator.hidden = YES;
            
            if (error) {
                NSMutableString *message = [[NSMutableString alloc] initWithString: @"Unable to register at this time:  \r\n"];
                [message appendString:[error localizedDescription]];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                
                [alertView show];
                
                NSLog(@"%@", error);
            } else {
                NSLog(@"%@", user);
                
                LoginManager *manager = [[LoginManager alloc] init];
                manager.token = user.token;
                
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:LOGGED_IN];
                [[NSUserDefaults standardUserDefaults] setValue:user.name forKey:USER_NAME];
                [[NSUserDefaults standardUserDefaults] setInteger:user.id forKey:USER_ID];
                [[NSUserDefaults standardUserDefaults] setBool:user.isDonor forKey:USER_IS_DONOR];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_LOGGED_IN object:self];
                
                [super dismissModalViewControllerAnimated:YES];
            }
        }];
    } 
    else
    {
        UIAlertView *errors = [[UIAlertView alloc] initWithTitle:nil message:userErrors delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [errors show];
    }
    
}

- (IBAction)back:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

@end
