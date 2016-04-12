#import "PreProcessorMacros.h"

@implementation PreProcessorMacros

#ifdef DEBUG
BOOL const DEBUG_BUILD = YES;
#else
BOOL const DEBUG_BUILD = NO;
#endif

@end
