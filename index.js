// Generated by LiveScript 1.5.0
(function(){
  var fp, ref$, login, password, urls, state, auth, slice$ = [].slice;
  fp = require("funphan")();
  fp.debug = true;
  ref$ = fp.args, login = ref$[0], password = ref$[1], urls = slice$.call(ref$, 2);
  console.log("start ... login = " + login + ", password = " + password + ", urls = " + JSON.stringify(urls));
  state = {
    submitted: false,
    urls: urls
  };
  fp.page.onUrlChanged = function(url){
    if (state.submitted) {
      console.log("new url " + url);
      return setTimeout(function(){
        fp.page.render('screen.png');
        return fp.exit(0, false);
      }, 1000);
    }
  };
  fp.parse = function(data){
    console.log("from eval ... " + data);
    return state.submitted = true;
  };
  auth = function(login, password){
    document.getElementsByName("loginuser")[0].value = login;
    document.getElementsByName("loginpassword")[0].value = password;
    document.forms[0].submit();
    return "logged in with login " + login + " and password " + password;
  };
  fp.open("http://www.musicforums.ru/buysell/login.php?bn=mfor_buysell", auth, login, password);
}).call(this);