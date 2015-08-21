//
//  AppDelegate.m
//  iTahDoodle
//
//  Created by John Leonard on 8/14/15.
//  Copyright (c) 2015 John Leonard. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - Application delegate callbacks
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // create an empty tasks array to get started
  self.tasks = [NSMutableArray array];
  
  // set up screen
  CGRect winFrame = [[UIScreen mainScreen] bounds];
  UIWindow *theWindow = [[UIWindow alloc] initWithFrame:winFrame];
  self.window = theWindow;
  
  // define frame rectangles for the elements
  CGRect tableFrame = CGRectMake(0, 80, winFrame.size.width, winFrame.size.height - 100);
  CGRect fieldFrame = CGRectMake(20, 40, 200, 31);
  CGRect buttonFrame = CGRectMake(228, 40, 72, 31);
  
  // Create & configure UITableView instance
  self.taskTable = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
  self.taskTable.separatorStyle = UITableViewCellSeparatorStyleNone;
  
  // make AppDelegate the taskTable's data source
  self.taskTable.dataSource = self;
  
  // Tell table what class to instantiate when it needs to create a new cell
  [self.taskTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
  
  // create & configure the UITextField instance
  self.taskField = [[UITextField alloc] initWithFrame:fieldFrame];
  self.taskField.borderStyle = UITextBorderStyleRoundedRect;
  self.taskField.placeholder = @"Type a task, tap Insert";
  
  // create & configure the UIButton instance
  self.insertButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  self.insertButton.frame = buttonFrame;
  [self.insertButton setTitle:@"Insert" forState:UIControlStateNormal];
  
  // Set target and action for Insert button
  [self.insertButton addTarget:self action:@selector(addTask:) forControlEvents:UIControlEventTouchUpInside];
  
  // add the three elemants to the window
  [self.window addSubview:self.taskTable];
  [self.window addSubview:self.taskField];
  [self.window addSubview:self.insertButton];
                    
  // Finalize the window and put it on the screen
  self.window.backgroundColor = [UIColor whiteColor];
  [self.window makeKeyAndVisible];
  
  return YES;
} // didFinishLaunchingWithOptions

- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Actions
- (void)addTask:(id)sender
{
  // get the task
  NSString * text = [self.taskField text];
  
  // quit if taskField is empty
  if([text length] == 0)
  {
    return;
  } // empty text
  
  // add the task to the table
  [self.tasks addObject:text];
  
  // refresh the table to show th enew entry
  [self.taskTable reloadData];
  
  // clear the text field and dismiss the keyboard
  [self.taskField setText:@""];
  [self.taskField resignFirstResponder];
} // addTask()

#pragma mark - Table view management
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  // only has one section, so can just return the number of tasks
  return [self.tasks count];
} // numberOfRowsInSection

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  // check to see if there's an existing cell object that can be reused
  UITableViewCell *c = [self.taskTable dequeueReusableCellWithIdentifier:@"Cell"];
  
  // (re)configure cell based on the model object
  NSString *item = [self.tasks objectAtIndex:indexPath.row];
  c.textLabel.text = item;
  
  return c;
} // cellForRowAtIndexPath


@end
