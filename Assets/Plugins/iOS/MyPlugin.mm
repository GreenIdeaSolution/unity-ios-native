#import <Foundation/Foundation.h>

@interface MyPlugin : NSObject
{
    NSDate *createDate;
}
@end

@implementation MyPlugin

static MyPlugin* _shareInstance;

+(MyPlugin*) shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"Create MyPlugin shareInstance");
        _shareInstance = [[MyPlugin alloc] init];
    });

    return _shareInstance;
}

-(id)init
{
    self = [super init];
    if (self)
    {
        [self initHelper];
    }

    return self;
}

-(void)initHelper
{
    NSLog(@"InitHelper called");
    createDate = [NSDate date];
}

-(double)getElapsedTime
{
    return [[NSDate date] timeIntervalSinceDate:createDate];
}

@end

extern "C"
{
    double IOS_getElapseTime()
    {
        return [[MyPlugin shareInstance] getElapsedTime];
    }
}
