//
//  ViewController.m
//  demoApp
//
//  Created by Isaias Rosario on 8/13/14.
//  Copyright (c) 2014 Isaias Rosario. All rights reserved.
//

#import "ViewController.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import "TwitterInfo.h"
#import "CustomCell.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    twitterArr = [[NSMutableArray alloc] init];
    
    // Call refreshTwitter Method
    [self refreshTwitter];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

////////////////////////////////////////////
///////// METHOD refreshTwitter ////////////
////////////////////////////////////////////
-(void)refreshTwitter
{
    // AccountStore Access
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    
    if (accountStore != nil) {
        
        // AcountType Access
        ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        
        
        if (accountType !=nil) {
        
            // Accout Request Acess
            [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {
                
                    if (granted)
                    {
                    
                        //--Access to Twitter--//
                        
                        // Twitter Account Array
                        NSArray *twitterAccounts = [accountStore accountsWithAccountType:accountType];
                    
                        if (twitterAccounts != nil)
                        {
                        
                            // Currect Account Selection
                            ACAccount *currentAccount = [twitterAccounts objectAtIndex:0];
                        
                            if (currentAccount != nil)
                            {
                            
                                NSString *requestURL = @"https://api.twitter.com/1.1/friends/list.json";
                                
                                SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:[NSURL URLWithString:requestURL] parameters:nil];
                                
                                [request setAccount:currentAccount];
                                
                                [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                                    
                                    if ((error == nil) && ([urlResponse statusCode] == 200))
                                    {
                                        
                                        NSDictionary *twitterList = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
                                        
                                        NSArray *followers = [twitterList objectForKey:@"users"];
                                        
                                        //NSLog(@"Array = %@", followers);
                                        
                                        for (NSInteger i=0; i<followers.count; i++) {
                                            
                                            TwitterInfo *twitterInfo = [self createPostInfoFromDictionary:[followers objectAtIndex:i]];
                                            
                                            if (twitterInfo != nil) {
                                                
                                                [twitterArr addObject:twitterInfo];
                                                
                                                //NSLog(@"Array = %@", twitterArr);
                                                
                                            }
                                        }
                                        
                                        NSLog(@"Array = %@", twitterArr);
                                        
                                        //NSDictionary *first = [followers objectAtIndex:0];
                                
                                        //NSLog(@"Data = %@", first.description);
                                        
                                    }//if error
                                    
                                }];
                            
                            }//if currentAccount
                        
                        }//if twitterAccounts
                    
                    }else{
                    
                        //--No Access to Twitter--//
                    
                    }//if granted
                
                }//completion Block
             
             ];// End Account Request
            
        }//if accountType
    }

}
////////////////////////////////////////////
/////////// END refreshTwitter /////////////
////////////////////////////////////////////

-(TwitterInfo*)createPostInfoFromDictionary:(NSDictionary*)postDictionary
{
    
    NSString *nameString = [postDictionary valueForKey:@"screen_name"];
    NSLog(@"Array = %@", nameString);
    
    NSString *imageString = [postDictionary valueForKey:@"profile_image_url"];
    NSLog(@"Array = %@", imageString);
    
    TwitterInfo *twitterInfo = [[TwitterInfo alloc] initWithPostInfo:nameString profileImage:imageString];
    
    [twitterArr addObject:twitterInfo];

    return twitterInfo;

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return 20;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CustomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];
    
    if (cell != nil)
    {
        TwitterInfo *current = [twitterArr objectAtIndex:indexPath.row];
        cell.user.text = [current screenName];
    }
    
    return cell;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
