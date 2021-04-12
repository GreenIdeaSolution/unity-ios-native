#import <Foundation/Foundation.h>
#import <mach/mach.h>

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

// @see: https://support.unity.com/hc/en-us/articles/115000172606-iOS-runtime-memory-tracking
-(float) report_memory
{
    struct task_basic_info info;
    mach_msg_type_number_t size = TASK_BASIC_INFO_COUNT;
    kern_return_t kerr = task_info(mach_task_self(),
                                    TASK_BASIC_INFO,
                                    (task_info_t)&info,
                                    &size);
    float memInUse = 0;
    if( kerr == KERN_SUCCESS )
    {
        memInUse = (float)info.resident_size / 1024 / 1024;
        NSLog(@"Memory in use (in MiB): %f", memInUse);
    }
    else
    {
        NSLog(@"Error with task_info(): %s", mach_error_string(kerr));
    }

    return memInUse;
}

@end

extern "C"
{
    // double IOS_getElapseTime()
    // {
    //     return [[MyPlugin shareInstance] getElapsedTime];
    // }

    float IOS_getMemoryUsage()
    {
        return [[MyPlugin shareInstance] report_memory];
    }
}
