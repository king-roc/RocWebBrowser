

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@class RocWebBrowserViewController;

/*
 
 UINavigationController+RocWebBrowserWrapper category enables access to casted RocWebBroswerViewController when set as rootViewController of UINavigationController
 
 */
@interface UINavigationController(RocWebBrowser)

// Returns rootViewController casted as RocWebBrowserViewController
- (RocWebBrowserViewController *)rootWebBrowser;

@end



@protocol RocWebBrowserDelegate <NSObject>
@optional
- (void)webBrowser:(RocWebBrowserViewController *)webBrowser didStartLoadingURL:(NSURL *)URL;
- (void)webBrowser:(RocWebBrowserViewController *)webBrowser didFinishLoadingURL:(NSURL *)URL;
- (void)webBrowser:(RocWebBrowserViewController *)webBrowser didFailToLoadURL:(NSURL *)URL error:(NSError *)error;
- (void)webBrowserViewControllerWillDismiss:(RocWebBrowserViewController*)viewController;
@end


/*
 
 RocWebBrowserViewController is designed to be used inside of a UINavigationController.
 For convenience, two sets of static initializers are available.
 
 */
@interface RocWebBrowserViewController : UIViewController <WKNavigationDelegate, WKUIDelegate, UIWebViewDelegate>

#pragma mark - Public Properties

@property (nonatomic, weak) id <RocWebBrowserDelegate> delegate;

// The main and only UIProgressView
@property (nonatomic, strong) UIProgressView *progressView;

// The web views
// Depending on the version of iOS, one of these will be set
@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, strong) UIWebView *uiWebView;

- (id)initWithConfiguration:(WKWebViewConfiguration *)configuration NS_AVAILABLE_IOS(8_0);

#pragma mark - Static Initializers

/*
 Initialize a basic RocWebBrowserViewController instance for push onto navigation stack
 
 Ideal for use with UINavigationController pushViewController:animated: or initWithRootViewController:
 
 Optionally specify RocWebBrowser options or WKWebConfiguration
 */

+ (RocWebBrowserViewController *)webBrowser;
+ (RocWebBrowserViewController *)webBrowserWithConfiguration:(WKWebViewConfiguration *)configuration NS_AVAILABLE_IOS(8_0);

/*
 Initialize a UINavigationController with a RocWebBrowserViewController for modal presentation.
 
 Ideal for use with presentViewController:animated:
 
 Optionally specify RocWebBrowser options or WKWebConfiguration
 */

+ (UINavigationController *)navigationControllerWithWebBrowser;
+ (UINavigationController *)navigationControllerWithWebBrowserWithConfiguration:(WKWebViewConfiguration *)configuration NS_AVAILABLE_IOS(8_0);


@property (nonatomic, strong) UIBarButtonItem *actionButton;

@property (nonatomic, strong) UIColor *tintColor;

@property (nonatomic, strong) UIColor *barTintColor;

@property (nonatomic, assign) BOOL actionButtonHidden;

@property (nonatomic, assign) BOOL showsURLInNavigationBar;

@property (nonatomic, assign) BOOL showsPageTitleInNavigationBar;

@property (nonatomic, assign) BOOL allowsBackForwardGestures;
//是否支持手势左右回退,前进 NS_AVAILABLE_IOS(8_0)WKWebView

//Allow for custom activities in the browser by populating this optional array
@property (nonatomic, strong) NSArray *customActivityItems;

#pragma mark - Public Interface


// Load a NSURLURLRequest to web view
// Can be called any time after initialization
- (void)loadRequest:(NSURLRequest *)request;

// Load a NSURL to web view
// Can be called any time after initialization
- (void)loadURL:(NSURL *)URL;

// Loads a URL as NSString to web view
// Can be called any time after initialization
- (void)loadURLString:(NSString *)URLString;


// Loads an string containing HTML to web view
// Can be called any time after initialization
- (void)loadHTMLString:(NSString *)HTMLString;

@end

