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
    SKColor *_skyColor;
}
@end

@implementation GameScene

-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        self.physicsWorld.gravity = CGVectorMake(0.0, -5.0);
        
        _skyColor = [SKColor colorWithRed:113.0/255.0 green:197.0/255.0 blue:207.0/255.0 alpha:1.0];
        [self setBackgroundColor:_skyColor];
        
        // Adding bird
        SKTexture *birdTexture1 = [SKTexture textureWithImageNamed:@"Bird1"];
        birdTexture1.filteringMode = SKTextureFilteringNearest;
        SKTexture *birdTexture2 = [SKTexture textureWithImageNamed:@"Bird2"];
        birdTexture2.filteringMode = SKTextureFilteringNearest;
        
        SKAction *flap = [SKAction repeatActionForever:[SKAction animateWithTextures:@[birdTexture1, birdTexture2] timePerFrame:0.2]];
        
        _bird = [SKSpriteNode spriteNodeWithTexture:birdTexture1];
        [_bird setScale:2.0];
        _bird.position = CGPointMake(self.frame.size.width/4, CGRectGetMidY(self.frame));
        [_bird runAction:flap];
        
        _bird.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:_bird.size.height/2];
        _bird.physicsBody.dynamic = YES;
        _bird.physicsBody.allowsRotation = NO;
        
        [self addChild:_bird];
        
        // Adding ground
        SKTexture *groundTexture = [SKTexture textureWithImageNamed:@"Ground"];
        groundTexture.filteringMode = SKTextureFilteringNearest;
        
        SKAction *moveGroundSprite = [SKAction moveByX:-groundTexture.size.width*2 y:0 duration:0.02*groundTexture.size.width*2];
        SKAction *resetGroudSprite = [SKAction moveByX:groundTexture.size.width*2 y:0 duration:0];
        SKAction *moveGroundSpriteForever = [SKAction repeatActionForever:[SKAction sequence:@[moveGroundSprite, resetGroudSprite]]];
        
        for (int i = 0; i < 2+self.frame.size.width/(groundTexture.size.width*2); ++i) {
            SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithTexture:groundTexture];
            [sprite setScale:2.0];
            sprite.position = CGPointMake(i*sprite.size.width, sprite.size.height/2);
            [sprite runAction:moveGroundSpriteForever];
            [self addChild:sprite];
        }
        
        // Create ground physic container
        SKNode *dummy = [SKNode node];
        dummy.position = CGPointMake(0, groundTexture.size.height);
        dummy.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.frame.size.width, groundTexture.size.height*2)];
        dummy.physicsBody.dynamic = NO;
        [self addChild:dummy];
        
        // Create skyline
        SKTexture *skylineTexture = [SKTexture textureWithImageNamed:@"Skyline"];
        skylineTexture.filteringMode = SKTextureFilteringNearest;
        
        SKAction *moveSkylineSprite = [SKAction moveByX:-skylineTexture.size.width*2 y:0 duration:0.1 * skylineTexture.size.width*2];
        SKAction *resetSkylineSprite = [SKAction moveByX:skylineTexture.size.width*2 y:0 duration:0];
        SKAction *moveSkylineSpriteForever = [SKAction repeatActionForever:[SKAction sequence:@[moveSkylineSprite, resetSkylineSprite]]];
        
        for (int i = 0; i < 2+self.frame.size.width/(skylineTexture.size.width*2); ++i) {
            SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithTexture:skylineTexture];
            [sprite setScale:2.0];
            sprite.zPosition = -20;
            sprite.position = CGPointMake(i*sprite.size.width, sprite.size.height/2 + groundTexture.size.height*2);
            [sprite runAction:moveSkylineSpriteForever];
            [self addChild:sprite];
        }
    }
    
    return self;
}

-(void)didMoveToView:(SKView *)view {
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    _bird.physicsBody.velocity = CGVectorMake(0, 0);
    [_bird.physicsBody applyImpulse:CGVectorMake(0, 8)];
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    _bird.zRotation = clamp(-1, 0.5, _bird.physicsBody.velocity.dy * (_bird.physicsBody.velocity.dy < 0 ? 0.03 : 0.01));
    
}

CGFloat clamp(CGFloat min, CGFloat max, CGFloat value){
    if (value > max) {
        return max;
    } else if (value < min){
        return min;
    } else {
        return value;
    }
}

@end
