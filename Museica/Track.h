//
//  Track.h
//  Museica
//
//  Created by Andre on 10/13/13.
//  Copyright (c) 2013 Musecia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Track : NSObject

@property (strong, nonatomic) NSString  *path;
@property (strong, nonatomic) NSData    *data;
@property (nonatomic) int               number;

-(id)   initWithNumber:(int) number;
-(void) record;

@end
