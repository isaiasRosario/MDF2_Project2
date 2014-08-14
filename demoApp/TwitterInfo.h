//
//  TwitterInfo.h
//  demoApp
//
//  Created by Isaias Rosario on 8/14/14.
//  Copyright (c) 2014 Isaias Rosario. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TwitterInfo : NSObject

{
    NSString *screenName;
    NSString *profileImage;
    
}

@property (nonatomic, readonly)NSString *screenName;
@property (nonatomic, readonly)NSString *profileImage;

-(id)initWithPostInfo:(NSString*)name profileImage:(NSString*)image;

@end
