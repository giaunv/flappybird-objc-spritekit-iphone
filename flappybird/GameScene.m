//
//  GameScene.m
//  flappybird
//
//  Created by giaunv on 3/19/15.
//  Copyright (c) 2015 366. All rights reserved.
//

#import "GameScene.h"

@interface GameScene(){
    SKSpriteNode * _bird;
}
@end

@implementation GameScene

-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        SKTexture *birdTexture1 = [SKTexture textureWithImageNamed:@"Bird1"];
        birdTexture1.filteringMode = SKTextureFilteringNearest;
        
        _bird = [SKSpriteNode spriteNodeWithTexture:birdTexture1];
        [_bird setScale:2.0];
        _bird.position = CGPointMake(self.frame.size.width/4, CGRectGetMidY(self.frame));
        [self addChild:_bird];
    }
    
    return self;
}

-(void)didMoveToView:(SKView *)view {
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
