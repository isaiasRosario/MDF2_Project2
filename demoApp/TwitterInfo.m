//
//  TwitterInfo.m
//  demoApp
//
//  Created by Isaias Rosario on 8/14/14.
//  Copyright (c) 2014 Isaias Rosario. All rights reserved.
//

#import "TwitterInfo.h"

@implementation TwitterInfo

@synthesize screenName, profileImage;

-(id)initWithPostInfo:(NSString*)name profileImage:(NSString*)image
{
    if ((self = [super init]))
    {
        screenName = [name copy];
        profileImage = [image copy];
        
    }
    return self;
    
}

@end
