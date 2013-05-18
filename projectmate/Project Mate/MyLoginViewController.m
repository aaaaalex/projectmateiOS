//
//  MyLoginViewController.m
//  Project Mate
//
//  Created by Zongheng Wang on 5/17/13.
//  Copyright (c) 2013 Cloud Computing. All rights reserved.
//

#import "MyLoginViewController.h"

@interface MyLoginViewController ()

@end

@implementation MyLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIGraphicsBeginImageContext(self.view.frame.size);
		[[UIImage imageNamed:@"Wallpaper_Purple"] drawInRect:self.view.bounds];
		UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
		
		[self.view setBackgroundColor:[UIColor colorWithPatternImage:image]];
		
		CALayer *layer = _SignUp.layer;
		layer.borderColor = [[UIColor lightGrayColor] CGColor];
		layer.cornerRadius = 8.0f;
		layer.borderWidth = 1.0f;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	UIView *backView = [[UIView alloc] initWithFrame:CGRectZero];
	backView.backgroundColor = [UIColor clearColor];
	_accountField = [[UITableView alloc] initWithFrame:CGRectMake(10, 193, 300, 100) style:UITableViewStyleGrouped];
	_accountField.dataSource = self;
	_accountField.delegate = self;
	_accountField.scrollEnabled = NO;
	_accountField.backgroundView = backView;
	[self.view addSubview:_accountField];
	
	[_Login setEnabled:NO];
	[_Login setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
	[_Login setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];

	[_SignUp setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	
	self.originalCenter = self.view.center;
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:)
												 name:UIKeyboardWillShowNotification object:nil];
	
	_loginSuccessfully = NO;
}

- (IBAction)signUpTouchDown:(id)sender
{
	[sender setAlpha:0.3];
}

- (IBAction)signUpTouchUp:(id)sender {
	[sender setAlpha:1];
	MySignUpViewController *signup = [[MySignUpViewController alloc] init];
	[self presentViewController:signup animated:YES completion:nil];
	//[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginPressed:(id)sender
{
	[self backgroundTouched:0];
	[_Login setTitle:@"Logging In..." forState:UIControlStateNormal];
	
	NSError *error = nil;
	NSURL *url = [NSURL URLWithString:@"http://cloudprojectmate.appspot.com/login?userId=sdfs&userPwd=sdfs"];
	
    NSData *data = [NSData dataWithContentsOfURL:url options:0 error:&error];
    if(error) {
        NSLog(@"Error on getting JSON: %@", [error description]);
    }
    
    NSArray *JSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    if(error) {
        NSLog(@"Error parsing JSON: %@", [error description]);
    }
	
	NSLog(@"%@", JSON);
    /*
    for(NSDictionary *videoDict in videoJSON) {
        Video *newVideo = [[Video alloc] init];
        [newVideo setTitle:[[videoDict objectForKey:@"title"] objectForKey:@"$t"]];
        [newVideo setSummary:[[videoDict objectForKey:@"content"] objectForKey:@"$t"]];
        [newVideo setThumbnailURL:[[[[videoDict objectForKey:@"media$group"] objectForKey:@"media$thumbnail"] objectAtIndex:0] objectForKey:@"url"]];
        [[self videos] addObject:newVideo];
    }
	
	
    NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/1.1/favorites/create.json"];
    
    //Parameters for Favorites Twitter API
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:_myTweetPin.retweetId forKey:@"id"];
    [parameters setObject:@"false" forKey:@"include_entities"];
    
    [self retweetOrFavorite:@"Favorite" withAPI:url withParameters:parameters];*/
	
	_loginSuccessfully= YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{	
	UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
	if(cell == nil)
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];

	[cell setBackgroundColor:[UIColor whiteColor]];
	
	if (indexPath.row == 0) {
		_loginId = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, 260, 21)];
		_loginId.placeholder = @"Email";
		_loginId.autocorrectionType = UITextAutocorrectionTypeNo;
		_loginId.autocapitalizationType = NO;
		[_loginId setClearButtonMode:UITextFieldViewModeWhileEditing];
		_loginId.returnKeyType = UIReturnKeyNext;
		_loginId.delegate = self;
		_loginId.enablesReturnKeyAutomatically = YES;
		cell.accessoryView = _loginId ;
	} else {
		_password = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, 260, 21)];
		_password.placeholder = @"Password";
		_password.secureTextEntry = YES;
		_password.autocorrectionType = UITextAutocorrectionTypeNo;
		[_password setClearButtonMode:UITextFieldViewModeWhileEditing];
		_password.returnKeyType = UIReturnKeyGo;
		_password.delegate = self;
		_password.enablesReturnKeyAutomatically = YES;
		cell.accessoryView = _password;
	}
	
	[self.view addSubview:_loginId];
	[self.view addSubview:_password];
	
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	return cell;
}

#pragma mark - Text field

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    [textField setText:newString];
	if(_loginId.text.length == 0 || _password.text.length == 0) {
		[_Login setEnabled:NO];
		[_Login setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
	} else {
		[_Login setEnabled:YES];
		[_Login setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
	}
	return NO;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
	if(textField == _loginId)
		_password.text = @"";
	[_Login setEnabled:NO];
	[_Login setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
	return YES;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
	if(textField == _loginId) {
		[_password becomeFirstResponder];
	} else {
		if(_loginId.text.length == 0)
			[self shakeView:_accountField];
		else
			[self loginPressed:0];
	}
    return YES;
}

#pragma mark - Keyboard appears/disappears

- (void)keyboardDidShow:(NSNotification *)note
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    self.view.center = CGPointMake(self.originalCenter.x, 200);
    [UIView commitAnimations];
}

- (IBAction)backgroundTouched:(id)sender
{
	[self.view endEditing:YES]; 
	
	[UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    self.view.center = CGPointMake(self.originalCenter.x, self.originalCenter.y);
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationHasFinished:finished:context:)];
    [UIView commitAnimations];
}

- (void)animationHasFinished:(NSString *)animationID finished:(BOOL)finished context:(void *)context
{
	if(_loginSuccessfully) {
		MyTabBarController *tabBarController = [[MyTabBarController alloc] init];
		[self.navigationController pushViewController:tabBarController animated:YES];
	}
}

#pragma mark - Shake a view

- (void)shakeView:(UIView*)view
{
    CGAffineTransform translateRight = CGAffineTransformTranslate(CGAffineTransformIdentity, 10.0, 0.0);
    CGAffineTransform translateLeft = CGAffineTransformTranslate(CGAffineTransformIdentity, -10.0, 0.0);
	
    view.transform = translateLeft;
	
    [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat animations:^{
        [UIView setAnimationRepeatCount:3.0];
        view.transform = translateRight;
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                view.transform = CGAffineTransformIdentity;
            } completion:NULL];
        }
    }];
}

@end
