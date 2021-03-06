
#import "CCMPreferencesController.h"
#import "CCMProjectNameSheetController.h"

enum CCMButtonTag
{
    CCMButtonCancel = 0,
    CCMButtonOkay = 1
};


@implementation CCMProjectNameSheetController

- (void)beginSheetWithProject:(NSDictionary *)aProject forWindow:(NSWindow *)aWindow
{
    [originalNameField setStringValue:[aProject valueForKey:@"projectName"]];
    [displayNameField setStringValue:[aProject valueForKey:@"projectName"]];
    [NSApp beginSheet:projectNameSheet modalForWindow:aWindow modalDelegate:self
       didEndSelector:@selector(sheetDidEnd:returnCode:contextInfo:) contextInfo:aProject];
}


- (void)closeSheet:(id)sender
{
    [NSApp endSheet:projectNameSheet returnCode:[sender tag]];
}


- (void)sheetDidEnd:(NSWindow *)sheet returnCode:(int)returnCode contextInfo:(void *)contextInfo
{
    [projectNameSheet orderOut:self];
    if(returnCode == CCMButtonCancel)
        return;

    NSString *projectName = [(NSDictionary *)contextInfo objectForKey:@"projectName"];
    [[NSNotificationCenter defaultCenter] postNotificationName:CCMPreferencesChangedNotification object:self];
}

@end
