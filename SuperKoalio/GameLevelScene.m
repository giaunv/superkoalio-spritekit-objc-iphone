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

@end

@implementation GameLevelScene

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
