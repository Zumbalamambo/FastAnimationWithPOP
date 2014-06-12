//
//  UIView+FastAnimationSpec.m
//  FastAnimationWithPop
//
//  Created by ZangChengwei on 14-6-12.
//  Copyright 2014年 WilliamZang. All rights reserved.
//

#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"
#import "UIView+FastAnimation.h"
#import "FAAnimationTest.h"

SpecBegin(UIViewFastAnimation)

describe(@"UIView+FastAnimation", ^{
    __block UIView *targetView = nil;
    beforeAll(^{

    });
    
    beforeEach(^{
        targetView = [[UIView alloc] init];
        [FAAnimationTest resetHasPerform];
    });
    
    it(@"Check prop", ^{

        NSString *type = @"SomeType@!@";
        targetView.animationType = type;
        expect(targetView.animationType).to.equal(type);
        NSNumber *value1 = [NSNumber numberWithDouble:3.15];
        NSNumber *value2 = [NSNumber numberWithDouble:5.25];
        targetView.delay = value1.doubleValue;
        targetView.duration = value2.doubleValue;
        expect(@(targetView.delay)).to.equal(value1);
        expect(@(targetView.duration)).to.equal(value2);
    });  
    
    it(@"Normal awakeFromNib", ^{
        [targetView awakeFromNib];
    });
    
    it(@"set not exists class", ^{
        targetView.animationType = @"NotExistsClass";
        targetView.duration = 1.0;
        BOOL hasAssert = NO;
        @try {
            [targetView awakeFromNib];
        }
        @catch (NSException *exception){
            hasAssert = YES;
            expect(exception.description).to.equal(@"The property 'animationType' must a class name and conforms protocol 'FastAnmationProtocol'");
        }
        expect(hasAssert).to.beTruthy();
    });
    
    it(@"add test animation with full class name", ^{
       targetView.animationType = @"FAAnimationTest";
        targetView.duration = 1.0;
        [targetView awakeFromNib];
        expect([FAAnimationTest animationHasPerform]).will.beTruthy();
    });
    
    it(@"add test animation with short name", ^{
        targetView.animationType = @"Test";
        targetView.duration = 1.0;
        [targetView awakeFromNib];
        expect([FAAnimationTest animationHasPerform]).will.beTruthy();
    });
    afterEach(^{
        targetView = nil;
    });
    
    afterAll(^{

    });
});

SpecEnd