//
//  AppDelegate.h
//  puzzlegame
//
//  Created by Jason on 7/31/18.
//  Copyright © 2018 Jason Ngov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

