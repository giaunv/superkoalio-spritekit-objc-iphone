//
//  Player.m
//  SuperKoalio
//
//  Created by Jake Gundersen on 12/27/13.
//  Copyright (c) 2013 Razeware, LLC. All rights reserved.
//

#import "Player.h"
// SKTUTils provide some CGPoint convenience methods
#import "SKTUtils.h"

@implementation Player

-(CGRect)collisionBoundingBox{
    // CGRectInset shrinks a CGRect by the number of points specified in the second and the third arguments.
    // In this case, the width of our collision bounding box will be four points smaller - two on each side - than the bounding box based on the image file we're using
    return CGRectInset(self.frame, 2, 0);
}

-(instancetype)initWithImageNamed:(NSString *)name{
    if (self = [super initWithImageNamed:name]) {
        self.velocity = CGPointMake(0.0, 0.0);
    }
    
    return self;
}

-(void)update:(NSTimeInterval)delta{
    // Velocity desribes how fast an object is moving in a given direction.
    // Accleration is the rate of change in velocity - how an object's speed and direction change over time.
    // A force is an influence that causes a change in speed or direction.
    
    // For each second, we're accelerating the velocity of the Koala 450 points towards the floor
    CGPoint gravity = CGPointMake(0.0, -450.0);
    // Scale the accleration down to the size of the current time step.
    // Even when faced with a variable frame rate, we'll still get consistent accleration.
    CGPoint gravityStep = CGPointMultiplyScalar(gravity, delta);
    
    // Get consitent velocity for a single timestep, no matter what the frame rate is.
    self.velocity = CGPointAdd(self.velocity, gravityStep);
    CGPoint velocityStep = CGPointMultiplyScalar(self.velocity, delta);
    
    // Get the updated position for the Koala.
    self.position = CGPointAdd(self.position, velocityStep);
}

@end
