/*
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

late InAppWebViewController webViewController;
TextEditingController searchController = TextEditingController();
String homepageUrl = "https://www.google.com";
List<String> bookmarks = [];

class CustomWebBrowser extends StatefulWidget {
  const CustomWebBrowser({super.key});

  @override
  _CustomWebBrowserState createState() => _CustomWebBrowserState();
}

class _CustomWebBrowserState extends State<CustomWebBrowser> {
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1E1F22),
        centerTitle: true,
        title: const Text(
          'Flutter Browser',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              webViewController.reload();
            },
          ),
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {
              webViewController.loadUrl(
                urlRequest: URLRequest(url: WebUri.uri(Uri.parse(homepageUrl))),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.bookmark, color: Colors.white),
            onPressed: () {
              String? currentUrl = webViewController.getUrl().toString();
              if (!bookmarks.contains(currentUrl)) {
                bookmarks.add(currentUrl);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Page bookmarked!')),
                );
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              webViewController.goBack();
            },
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward, color: Colors.white),
            onPressed: () {
              webViewController.goForward();
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.0),
          child: SizedBox(
            height: h * 0.065,
            width: w * 0.92,
            child: TextField(
              style: TextStyle(color: Colors.white),
              autocorrect: true,
              controller: searchController,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.white),
                hintText: "Search or type URL...",
                hintStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.white)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.white)),
                filled: true,
                fillColor: Color(0xff939393),
              ),
              onSubmitted: (query) {
                if (query.isNotEmpty) {
                  String url = query.startsWith('http')
                      ? query
                      : Uri.https('www.google.com', '/search', {'q': query})
                      .toString();
                  webViewController.loadUrl(
                    urlRequest: URLRequest(url: WebUri.uri(Uri.parse(url))),
                  );
                }
              },
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest:
            URLRequest(url: WebUri.uri(Uri.parse(homepageUrl))),
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
            onLoadStart: (controller, url) {
              setState(() {
                searchController.text = url.toString();
              });
            },
            onLoadStop: (controller, url) async {
              setState(() {
                searchController.text = url.toString();
              });
            },
            onProgressChanged: (controller, progress) {
              setState(() {
                this.progress = progress / 100;
              });
            },
          ),
          progress < 1.0
              ? LinearProgressIndicator(value: progress)
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
*/
/*final BrowserController browserController = Get.put(BrowserController());
late final InAppWebViewController? webViewController;
final TextEditingController searchController = TextEditingController();
class CustomWebBrowser extends StatelessWidget {


  CustomWebBrowser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1E1F22),
        title: const Text('Flutter Browser', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              webViewController?.reload();
            },
          ),
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              webViewController?.goBack();
            },
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward, color: Colors.white),
            onPressed: () {
              webViewController?.goForward();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchEngineSelector(),
          _buildSearchBar(),
          _buildWebView(),
          _buildLoadingIndicator(),
        ],
      ),
    );
  }

  Widget _buildSearchEngineSelector() {
    return Obx(() => Row(
      children: [
        _buildRadioOption('Google', 'https://www.google.com/search?q='),
        _buildRadioOption('Brave', 'https://search.brave.com/search?q='),
        _buildRadioOption('Yahoo', 'https://search.yahoo.com/search?p='),
        _buildRadioOption('Bing', 'https://www.bing.com/search?q='),
        _buildRadioOption('DuckDuckGo', 'https://duckduckgo.com/?q='),
      ],
    ));
  }

  Widget _buildRadioOption(String label, String url) {
    return Expanded(
      child: RadioListTile<String>(
        title: Text(label, style: const TextStyle(color: Colors.white)),
        value: url,
        groupValue: browserController.currentSearchEngine.value,
        onChanged: (value) {
          browserController.setSearchEngine(value!);
        },
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: 'Search or type URL...',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        ),
        onSubmitted: (query) {
          if (query.isNotEmpty) {
            String url = query.startsWith('http')
                ? query
                : '${browserController.currentSearchEngine.value}$query';
            webViewController?.loadUrl(
              urlRequest: URLRequest(url: WebUri.uri(Uri.parse(url))),
            );
            browserController.addToHistory(url);
          }
        },
      ),
    );
  }

  Widget _buildWebView() {
    return Expanded(
      child: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri.uri(Uri.parse('https://www.google.com'))),
        onWebViewCreated: (controller) {
          webViewController = controller;
        },
        onLoadStart: (controller, url) {
          searchController.text = url.toString();
          browserController.addToHistory(url.toString());
        },
        onLoadStop: (controller, url) {
          searchController.text = url.toString();
        },
        onProgressChanged: (controller, progress) {
          browserController.updateProgress(progress / 100);
        },
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Obx(() => browserController.progress.value < 1.0
        ? LinearProgressIndicator(value: browserController.progress.value)
        : const SizedBox.shrink());
  }
}*/