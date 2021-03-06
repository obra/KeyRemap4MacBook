#import "ConfigXMLParser.h"

@implementation ConfigXMLParser (Private)

- (NSArray*) get_xml_paths
{
  return [NSArray arrayWithObjects:
          [NSArray arrayWithObjects:[self preferencepane_get_private_xml_path],
           [NSNumber numberWithInt:CONFIGXMLPARSER_XML_TYPE_CHECKBOX],
           [NSNumber numberWithInt:CONFIGXMLPARSER_XML_OWNER_USER],
           nil],
          [NSArray arrayWithObjects:@"/Library/org.pqrs/KeyRemap4MacBook/prefpane/checkbox.xml",
           [NSNumber numberWithInt:CONFIGXMLPARSER_XML_TYPE_CHECKBOX],
           [NSNumber numberWithInt:CONFIGXMLPARSER_XML_OWNER_SYSTEM],
           nil],
          [NSArray arrayWithObjects:@"/Library/org.pqrs/KeyRemap4MacBook/prefpane/number.xml",
           [NSNumber numberWithInt:CONFIGXMLPARSER_XML_TYPE_NUMBER],
           [NSNumber numberWithInt:CONFIGXMLPARSER_XML_OWNER_SYSTEM],
           nil],
          nil];
}

- (void) showAlert {
  NSAlert* alert = [[NSAlert new] autorelease];
  [alert setMessageText:@"KeyRemap4MacBook Error"];
  [alert addButtonWithTitle:@"Close"];
  [alert addButtonWithTitle:@"Open PreferencePane"];
  [alert setInformativeText:error_message_];

  NSInteger response = [alert runModal];
  if (response == NSAlertSecondButtonReturn) {
    [[NSWorkspace sharedWorkspace] openFile:@"/Library/PreferencePanes/KeyRemap4MacBook.prefPane"];
  }
}

- (void) setErrorMessage:(NSException*)exception xmlpath:(NSString*)xmlpath
{
  // skip if an error was already reported.
  if (error_message_) return;

  error_message_ = [[NSString stringWithFormat:@"Error in %@\n\n%@\n\n%@", xmlpath, [exception name], [exception reason]] retain];

  [self performSelectorOnMainThread:@selector(showAlert)
                         withObject:nil
                      waitUntilDone:YES];
}

- (void) removeErrorMessage
{
  if (error_message_) {
    [error_message_ release];
    error_message_ = nil;
  }
}

- (NSXMLElement*) castToNSXMLElement:(NSXMLNode*)node
{
  if ([node kind] != NSXMLElementKind) return nil;
  return (NSXMLElement*)(node);
}

- (NSString*) trim:(NSString*)string
{
  return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
