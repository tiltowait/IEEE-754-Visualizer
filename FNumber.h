/* FNumber */

#import <Cocoa/Cocoa.h>

@interface FNumber : NSObject
{
    IBOutlet id binaryMatrix;
    IBOutlet id decimalField;
	int bit[32];
	double convertedFloat;
}
- (BOOL)checkZero;
- (void)convertFromBinary;
- (void)convertToBinary:(float)value;
- (void)clear;
- (IBAction)toggleBinary:(id)sender;
- (IBAction)floatToBinary:(id)sender;
- (IBAction)presets:(id)sender;
- (IBAction)reset:(id)sender;
- (IBAction)invert:(id)sender;
- (IBAction)randomBits:(id)sender;
- (IBAction)shiftLeft:(id)sender;
- (IBAction)shiftRight:(id)sender;
- (IBAction)negate:(id)sender;
- (IBAction)addOrSubtract:(id)sender;
- (IBAction)doubleOrHalve:(id)sender;
@end
