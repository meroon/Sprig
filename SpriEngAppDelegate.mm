
#import "SpriEngAppDelegate.h"


#include "Game.h"
#include "EnvironmentData.h"

#include <string>

using std::string;

@implementation SpriEngAppDelegate

@synthesize window = _window;
@synthesize glView = _glView;

Game _game;


#pragma mark GLView Delegate

- (void)setupView:(GLView *)theView
{	
    //[OpenGLTexture3D loadTextureWithFilename:@"spritesheet.png"];
    //[[OpenGLTexture3D alloc] initWithFilename:@"sprite.png" width:64 height:64];
    
    EnvironmentData data;
    data.basePath = std::string([[[NSBundle mainBundle] bundlePath] UTF8String]); 
    data.screenRect = Rectangle(_glView.bounds.size.width, _glView.bounds.size.height);
    
    UITapGestureRecognizer *singleTap = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)] autorelease];
    singleTap.numberOfTapsRequired = 1;
    [theView addGestureRecognizer:singleTap];
    
	_game.Init(data);
}

- (void)handleSingleTap:(UIGestureRecognizer *)sender
{
    CGPoint translate = [sender locationInView:_glView];
    
    _game.input.singleTap(translate.x, translate.y);
}

- (void)drawView:(GLView *)theView
{
	_game.Update();
}


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
	[_glView start];
	
    // Override point for customization after application launch.
	
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
   
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    
}


- (void)dealloc {
    [_glView release];
	[_window release];
    [super dealloc];
}


@end

