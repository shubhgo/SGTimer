#import "SGTimer.h"

@implementation SGTimer

@synthesize insertOrder;
@synthesize timerName;

- (id)init
{
    if (self = [super init]) {
        self.timerName = @"Default Timer";
        self.insertOrder = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)initWithName:(NSString *)name
{
    if (self = [super init]) {
        self.timerName = [name copy];
        self.insertOrder = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [insertOrder release];
    [super dealloc];
}

- (void)recordTimeWithTag:(NSString *)tag
{
    NSMutableDictionary *timeRec = [[NSMutableDictionary alloc] init];
	[timeRec setObject:[NSDate date] forKey:@"time"];
	[timeRec setObject:tag forKey:@"tag"];
	[self.insertOrder addObject:timeRec];
	[timeRec release];
}

- (void)report
{
	for(NSInteger i = 0; i < [insertOrder count]; i++)
	{
		if(i > 0)
		{
			double foo = [[[insertOrder objectAtIndex:(i)] objectForKey:@"time"] timeIntervalSinceDate:[[insertOrder objectAtIndex:(i-1)] objectForKey:@"time"]];
			double houndreds = foo*100;
			NSMutableString *viz = [NSMutableString stringWithCapacity:foo];
			for(NSInteger j = 0; j < houndreds; j++)
			{
				[viz appendString:@"|"];
			}
			NSLog(@"%@: Between '%@' and '%@':\n%@\n took %f s",timerName,[[insertOrder objectAtIndex:(i-1)] objectForKey:@"tag"],[[insertOrder objectAtIndex:i] objectForKey:@"tag"],viz,foo);
		}
	}
}
@end
