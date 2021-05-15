#import "FNumber.h"

@implementation FNumber

- (BOOL)checkZero
{
	int n;
	
	for(n = 1; n < 32; n++) //sign bit unimportant
		if(bit[n] == 1) return FALSE;
	return TRUE;
}
	
- (void)convertFromBinary
{
	int sign = bit[0], n;
	int exponent = 0, temp = 1;
	
	convertedFloat = 0;
	
	if([self checkZero])
		[decimalField setStringValue:@"0"];
	else
	{
		for(n = 8; n > 0; n--)
		{
			if(bit[n]) exponent += temp;
			temp *= 2;
		}
	
		exponent -= 127;
	
		double significand = 0;
		double dTemp = .5;
		for(n = 9; n < 32; n++)
		{
			if(bit[n]) significand += dTemp;
			dTemp /= 2;
		}
	
		convertedFloat = pow(-1,sign) * pow(2,exponent) * (1+significand);
		[decimalField setDoubleValue:convertedFloat];
	}
}

- (void)convertToBinary:(float)value
{
	float userFloat = value;
	float temp = userFloat, f;
	int e = 0, n;
	NSCell *cell;
	
	[self clear];
	
	if(temp != 0)
	{
		if(temp < 0)
		{
			temp *= -1;
			bit[0] = 1;
			cell = [binaryMatrix cellWithTag:0];
			[cell setTitle:@"1"];
      [cell setState:NSControlStateValueOn];
		}
		
		if(temp >= 2)
		{
			while(temp >= 2)
			{
				temp /= 2;
				e++;
			}
		}
		else
		{
			while(temp < 1)
			{
				temp *= 2;
				e--;
			}
		}
		
		f = temp - 1;
		e += 127;
		
		//[decimalField setDoubleValue:e];
		//find the exponent bits
		//exponent ranges from bit[1..8]
		temp = 128;
		for(n = 1; n < 9; n++)
		{
			if(e >= temp)
			{
				bit[n] = 1;
				e -= temp;
				cell = [binaryMatrix cellWithTag:n];
				[cell setTitle:@"1"];
        [cell setState:NSControlStateValueOn];
			}
			temp /= 2;
		}
		
		//find the significand
		//significand ranges from bit[9..31]
		temp = 0.5;
		for(n = 9; n < 32; n++)
		{
			if(f >= temp)
			{
				bit[n] = 1;
				f -= temp;
				cell = [binaryMatrix cellWithTag:n];
				[cell setTitle:@"1"];
        [cell setState:NSControlStateValueOn];
			}
			temp /= 2;
		}
		
		[self convertFromBinary];
	}
}

- (void)clear
{
	NSCell *cell;
	int n;
	
	for(n = 0; n < 32; n++)
	{
		cell = [binaryMatrix cellWithTag:n];
		[cell setTitle:@"0"];
    [cell setState:NSControlStateValueOff];
		bit[n] = 0;
	}
	[decimalField setStringValue:@"0"];
}

- (IBAction)toggleBinary:(id)sender
{
	int tag = [ [sender selectedCell] tag];
	NSString *oldValue = [ [sender selectedCell] title];
	
	if([oldValue isEqualToString:@"0"])
	{
		[ [sender selectedCell] setTitle:@"1"];
		bit[tag] = 1;
	}
	else
	{
		[ [sender selectedCell] setTitle:@"0"];
		bit[tag] = 0;
	}
	
	[self convertFromBinary];
}


- (IBAction)floatToBinary:(id)sender
{
	[self convertToBinary:[sender doubleValue]];
}

- (IBAction)presets:(id)sender
{	
	[self clear];
	
	switch([ [sender selectedCell] tag])
	{
		case 0:				//1000
			bit[1] = 1;
			bit[5] = 1;
			bit[9] = 1;
			bit[10] = 1;
			bit[11] = 1;
			bit[12] = 1;
			bit[14] = 1;
			break;
		case 1:				//100
			bit[1] = 1;
			bit[6] = 1;
			bit[8] = 1;
			bit[9] = 1;
			bit[12] = 1;
			break;
		case 2:				//10
			bit[1] = 1;
			bit[7] = 1;
			bit[10] = 1;
			break;
		case 3:				//1
			bit[2] = 1;
			bit[3] = 1;
			bit[4] = 1;
			bit[5] = 1;
			bit[6] = 1;
			bit[7] = 1;
			bit[8] = 1;
			break;
		case 4:				//pi
			bit[1] = 1;
			bit[9] = 1;
			bit[12] = 1;
			bit[15] = 1;
			bit[20] = 1;
			bit[21] = 1;
			bit[22] = 1;
			bit[23] = 1;
			bit[24] = 1;
			bit[25] = 1;
			bit[27] = 1;
			bit[28] = 1;
			bit[30] = 1;
			bit[31] = 1;
			break;
		case 5:				//avagadro's number
			bit[1] = 1;
			bit[2] = 1;
			bit[5] = 1;
			bit[6] = 1;
			bit[8] = 1;
			bit[9] = 1;
			bit[10] = 1;
			bit[11] = 1;
			bit[12] = 1;
			bit[13] = 1;
			bit[14] = 1;
			bit[15] = 1;
			bit[20] = 1;
			bit[21] = 1;
			bit[24] = 1;
			bit[25] = 1;
			bit[26] = 1;
			bit[27] = 1;
			bit[28] = 1;
			bit[30] = 1;
			break;
		case 6:				//acceleration due to gravity
			bit[0] = 1;
			bit[1] = 1;
			bit[7] = 1;
			bit[11] = 1;
			bit[12] = 1;
			bit[13] = 1;
			bit[16] = 1;
			bit[17] = 1;
			bit[18] = 1;
			bit[20] = 1;
			bit[28] = 1;
			bit[30] = 1;
			break;
		case 7:				//e
			bit[1] = 1;
			bit[10] = 1;
			bit[12] = 1;
			bit[13] = 1;
			bit[15] = 1;
			bit[16] = 1;
			bit[17] = 1;
			bit[18] = 1;
			bit[19] = 1;
			bit[20] = 1;
			bit[25] = 1;
			bit[27] = 1;
			bit[29] = 1;
			break;
		default:
			break;
	}
	
	int n;
	NSCell *cell;
	
	for(n = 0; n < 32; n++)
	{
		if(bit[n])
		{
			cell = [binaryMatrix cellWithTag:n];
			[cell setTitle:@"1"];
      [cell setState:NSControlStateValueOn];
		}
	}
	
	[self convertFromBinary];
}

- (IBAction)reset:(id)sender
{
	[self clear];
}

- (IBAction)invert:(id)sender
{
	NSCell *cell;
	NSString *oldTitle;
	int n;
	
	for(n = 0; n < 32; n++)
	{
		cell = [binaryMatrix cellWithTag:n];
		oldTitle = [cell title];
		if([oldTitle isEqualToString:@"0"])
		{
			[cell setTitle:@"1"];
			bit[n] = 1;
      [cell setState:NSControlStateValueOn];
		}
		else
		{
			[cell setTitle:@"0"];
			bit[n] = 0;
      [cell setState:NSControlStateValueOff];
		}
	}
	
	[self convertFromBinary];
}

- (IBAction)randomBits:(id)sender
{
	NSCell *cell;
	int n;
	
	[self clear];
	
	for(n = 0; n < 32; n++)
	{
		if(rand() % 2)
		{
			cell = [binaryMatrix cellWithTag:n];
			[cell setTitle:@"1"];
      [cell setState:NSControlStateValueOn];
			bit[n] = 1;
		}
	}
	
	[self convertFromBinary];
}

- (IBAction)shiftLeft:(id)sender
{
	int n;
	NSCell *cellc, *cellp;
	
	for(n = 1; n < 32; n++)
	{
		cellc = [binaryMatrix cellWithTag:n];
		cellp = [binaryMatrix cellWithTag:(n-1)];
		
		bit[n-1] = bit[n];
		
		[cellp setTitle:[cellc title]];
		[cellp setState:[cellc state]];
	}
	
	cellc = [binaryMatrix cellWithTag:31];
	[cellc setTitle:@"0"];
  [cellc setState:NSControlStateValueOff];
	
	bit[31] = 0;
	
	[self convertFromBinary];
}

- (IBAction)shiftRight:(id)sender
{
	int n;
	NSCell *cellc, *celln;
	
	for(n = 30; n >= 0; n--)
	{
		cellc = [binaryMatrix cellWithTag:n];
		celln = [binaryMatrix cellWithTag:(n+1)];
		
		bit[n+1] = bit[n];
		
		[celln setTitle:[cellc title]];
		[celln setState:[cellc state]];
	}
	
	cellc = [binaryMatrix cellWithTag:0];
	[cellc setTitle:@"0"];
  [cellc setState:NSControlStateValueOff];
	
	bit[0] = 0;
	
	[self convertFromBinary];
}

- (IBAction)negate:(id)sender
{
	int newVal;
	NSCell *cell;
	
	cell = [binaryMatrix cellWithTag:0];
	
	newVal = (bit[0] ? 0 : 1);
	
	bit[0] = newVal;
	[cell setTitle:(newVal ? @"1" : @"0")];
  [cell setState:(newVal ? NSControlStateValueOn : NSControlStateValueOff)];
	
	[self convertFromBinary];
}

- (IBAction)addOrSubtract:(id)sender
{
	switch([sender tag])
	{
		case 99:
			convertedFloat++;
			break;
		case 100:
			convertedFloat--;
			break;
		default:
			break;
	}
	
	[self convertToBinary:convertedFloat];
}

- (IBAction)doubleOrHalve:(id)sender
{
	switch([sender tag])
	{
		case 97:
			convertedFloat *= 2.0;
			break;
		case 98:
			convertedFloat /= 2.0;
			break;
		default:
			break;
	}
	
	[self convertToBinary:convertedFloat];
}

@end
