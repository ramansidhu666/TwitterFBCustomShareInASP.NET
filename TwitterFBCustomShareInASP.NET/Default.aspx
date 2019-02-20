<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

</head>
<body>
    <form id="form1" runat="server">
        <h1>Custom fb, twitter share sample</h1>
        <div id="DetailDiv">
        </div>
        <script src="Scripts/jquery-2.1.3.min.js"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                createHtml();
            });

            //create html //
            function createHtml() {               
                var title = "How to Authenticate and Get Data Using Instagram API";
                //var summary = encodeURIComponent("This article explains how to authenticate an Instagram API and how to get user photos, user details and popular photos using the Instagram API.");
                var url = location.href;
                var image = 'http://www.c-sharpcorner.com/UploadFile/AuthorImage/raj1979.jpg';
                var appid = '<%=ConfigurationManager.AppSettings["FacebookConsumerKey"].ToString() %>';
               // alert(appid);

                //login pop height, width
                var w = 600;
                var h = 400;
                var left = Number((screen.width / 2) - (w / 2));
                var top = Number((screen.height / 2) - (h / 2));
                //****//

                //facebook login window and pass paramemters like title, summary, url, image
                var fb = '<a rel="nofollow"   title=\"Share this post on Facebook\" onclick="FbApp_Login(\'' + title + '\',\'' + url + '\',\'' + image + '\');"><img src="Images/fb.png" height="100px" /></a>';
                //****//

                //twitter login window and pass paramemters like title, url
                var twitter = "<a  href=https://twitter.com/intent/tweet?original_referer=" + encodeURIComponent(url) + "&amp;related=ModelQ-Job&amp;text=" + encodeURIComponent(title) + "&amp;tw_p=tweetbutton&amp;url=" + encodeURIComponent(url) + "&amp;via=_ModelQ title=\"Share this post on Twitter\" onclick=\"javascript:window.open(this.href,  '', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,width=" + w + ", height=" + h + ", top=" + top + ", left=" + left + "');return false;\"><img height='100px' src='Images/twitter.png' /></a>";
                //****//

                var socialMediaButtons = fb + "&nbsp;&nbsp;" + twitter;

                //bind social variables into div
                jQuery("#DetailDiv").append(' <div><table width="100%"><tr><td valign="top" style=" width:100px; height:100px;"><div>' + socialMediaButtons + '</div></td></tr></table> </div>');
                //****//
            }

            // Facebook login
            function FbApp_Login(title, url, image) {
                //alert(title);
                //alert(sumary);
                //alert(url);
                //alert(image);
                FB.login(function (response) {
                    if (response.authResponse) {
                        statusChangeCallback(response, title, url, image);
                    }
                }, { scope: 'email,user_photos,publish_actions' });
            }
            window.fbAsyncInit = function () {
                FB.init({
                    appId: '<%=ConfigurationManager.AppSettings["FacebookConsumerKey"].ToString() %>',
                    cookie: true,  // enable cookies to allow the server to access 
                    xfbml: true,  // parse social plugins on this page
                    version: 'v2.0' // use version 2.0
                });

            };

            // This is called with the results from from FB.getLoginStatus().
            function statusChangeCallback(response, title, url, image) {
                if (response.status === 'connected') {
                    // Logged into your app and Facebook.           
                    FB.ui(
                      {
                          method: 'feed',
                          name: title,
                          link: url,
                          picture: image,
                          caption: title,
                          description: "This is test summary",
                          // source: url,
                          redirect_uri: url,
                      }
                )

                }
            }            

            // Load the SDK asynchronously
            (function (d, s, id) {
                var js, fjs = d.getElementsByTagName(s)[0];
                if (d.getElementById(id)) return;
                js = d.createElement(s); js.id = id;
                js.src = "//connect.facebook.net/en_US/sdk.js";
                fjs.parentNode.insertBefore(js, fjs);
            }(document, 'script', 'facebook-jssdk'));

        </script>


    </form>
</body>
</html>
