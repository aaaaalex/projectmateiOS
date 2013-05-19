//
//  MyTasksTableViewController.h
//  Project Mate
//
//  Created by Alex Xia on 5/18/13.
//  Copyright (c) 2013 Cloud Computing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@interface MyTasksTableViewController : UITableViewController
@property (strong, nonatomic) NSString *userid;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *CreateTask;


@end
