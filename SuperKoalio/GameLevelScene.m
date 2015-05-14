//
//  GameLevelScene.m
//  SuperKoalio
//
//  Created by Jake Gundersen on 12/27/13.
//  Copyright (c) 2013 Razeware, LLC. All rights reserved.
//

#import "GameLevelScene.h"
#import "JSTileMap.h"
#import "Player.h"

@interface GameLevelScene()

@property (nonatomic, strong) JSTileMap *map;
@property (nonatomic, strong) Player *player;
@property (nonatomic, assign) NSTimeInterval previousUpdateTime;

@end

@implementation GameLevelScene

// Before the scene is rendered, every frame will get called to this method.
-(void)update:(NSTimeInterval)currentTime{
  // delta is used to scale movement and other forces (like gravity) in order to achieve smooth, consistent animations.
  NSTimeInterval delta = currentTime - self.previousUpdateTime;
  
  // Sometimes delta may spike. This occurs at the beginning of the game (for the first few frames as things are still being loaded into memory) and occasionaly when something happens on the device (like when a system notification comes in).
  // By capping it at 0.02, we reduce the chance of getting a time step that is too large (which can result in the physics engine behaving in unexpected ways, like Koalio moving through an entire tile).
  if (delta > 0.02) {
    delta = 0.02;
  }
  
  // Used for next frame to determine delta
  self.previousUpdateTime = currentTime;
  
  [self.player update:delta];
}

-(id)initWithSize:(CGSize)size {
  if (self = [super initWithSize:size]) {
    /* Setup your scene here */
    self.backgroundColor = [SKColor colorWithRed:.4 green:.4 blue:.95 alpha:1.0];
    self.map = [JSTileMap mapNamed:@"level1.tmx"];
    [self addChild:self.map];
    
    self.player = [[Player alloc] initWithImageNamed:@"koalio_stand"];
    self.player.position = CGPointMake(100, 50);
    // Because we want Koala in front so give hime a zPosition of 15.
    // This makes it so that if you scroll the tile map, the Koala still stays in the same relative position within the tile map.
    self.player.zPosition = 15;
    // Added the Koala to the map object instead of the scene.
    // Because we want to control exactly which TMX players are in front of and behind the Koala sprite
    [self.map addChild:self.player];
  }
  return self;
}


@end
