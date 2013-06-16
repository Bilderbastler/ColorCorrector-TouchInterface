#import "EXPMatchers+beVerified.h"
#import <OCMock/OCMock.h>

EXPMatcherImplementationBegin(beVerified, (void)) {
    BOOL actualIsNil = (actual == nil);
    
    __block NSString* failureMessage;
    
    prerequisite(^BOOL{
        return !(actualIsNil);
        // Return `NO` if matcher should fail whether or not the result is inverted using `.Not`.
    });
    
    match(^BOOL{
        BOOL didPass = YES;
        @try {
            [actual verify];
        }
        @catch (NSException *exception) {
            didPass = NO;
            if ([exception.name isEqualToString:@"NSInvalidArgumentException"]) {
                failureMessage = @"The object is no mock object";
            }else{
                NSString *substringForFirstMatch;
                NSString* string = exception.reason;
                // get rid of class name and object memory adress 
                NSRegularExpression *objectAdressRegex = [NSRegularExpression regularExpressionWithPattern:@"(?<=: )[^<]*"
                                                                                       options:NSRegularExpressionCaseInsensitive
                                                                                         error:nil];
                NSRange rangeOfFirstMatch = [objectAdressRegex rangeOfFirstMatchInString:string options:0 range:NSMakeRange(0, [string length])];
                if (!NSEqualRanges(rangeOfFirstMatch, NSMakeRange(NSNotFound, 0))) {
                    substringForFirstMatch = [string substringWithRange:rangeOfFirstMatch];
                }
                
                failureMessage = substringForFirstMatch;
            }
            
        }
        return didPass;
    });
    
    failureMessageForTo(^NSString *{
        if(actualIsNil) return @"the mock object is nil/null";
        return failureMessage;
    });
    
    failureMessageForNotTo(^NSString *{
        if(actualIsNil) return @"the mock object is nil/null";
        return failureMessage;
    });
}
EXPMatcherImplementationEnd
