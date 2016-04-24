# RocWebBrowser

#Requirements
RocWebBrowser | Minimum iOS Target | Notes
------------  | ------------- | ------------
wkwebview     | ios8.0        | link WebKit.framework
 webview      | ios6.0        | none

#Architecture

#Usage
###Creating an Present Browser
		RocWebBrowserViewController *webBrowser =[RocWebBrowserViewController webBrowser];
	    [webBrowser setDelegate:self];
	    [self.navigationController pushViewController:webBrowser animated:YES];
	    static NSString *const defaultAddress = @"https://www.baidu.com";
	    [webBrowser loadURLString:defaultAddress];

###Sample
![Mou icon](https://raw.githubusercontent.com/king-roc/image/master/image/Push.gif)
###Creating an Push Browser

		UINavigationController *webBrowserNavigationController = [RocWebBrowserViewController navigationControllerWithWebBrowser];
	    RocWebBrowserViewController *webBrowser = [webBrowserNavigationController rootWebBrowser];
	    [webBrowser setDelegate:self];
	    webBrowser.showsURLInNavigationBar = YES;
	    webBrowser.tintColor = [UIColor whiteColor];
	    webBrowser.barTintColor = [UIColor colorWithRed:102.0f/255.0f green:204.0f/255.0f blue:51.0f/255.0f alpha:1.0f];
	    webBrowser.showsPageTitleInNavigationBar = NO;
	    webBrowser.showsURLInNavigationBar = NO;
	    [self presentViewController:webBrowserNavigationController animated:YES completion:nil];
	    [webBrowser loadURLString:defaultAddress];
###Sample
![Mou icon](https://raw.githubusercontent.com/king-roc/image/master/image/Present.gif)
