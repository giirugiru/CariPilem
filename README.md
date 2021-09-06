# CariPilem
Simple MovieDB App using MVVM + Combine

Note: Kept the UI as vanilla as possible, only focusing on the code approach & implementation. UI Tested on light-mode.

Pod used: Kingfisher


Additional Notes for Reviewer:
1. Excaping is commonly used for asynchronous task inside a closure. For example: when the app is fetching data from an API call, we wouldnt want the process to just wait there while its fetching data. So we use escaping to make the closure able to 'outlive' its function.
2. VIPER MODULE WIP
3. Protocol defines a method/must have function that needs to be called when an object conforms it.
4. Content Layout -> Used to make constraints for the content inside the scrollview, Frame Layout -> The frame constraints guide of the scrollview itself
5. How to play youtube video on app: We can use three different methods, using the official library (YouTube Player iOS Helper), XCDYouTubeKit (pod), and WKWebView.
