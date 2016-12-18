fp = require("funphan")()
fp.debug = true
[login, password, ...urls] = fp.args
console.log("start ... login = #{login}, password = #{password}, urls = #{JSON.stringify(urls)}")
state = {
  submitted: false,
  urls: urls
}

fp.page.onUrlChanged = (url) -->
  if state.submitted
    console.log("new url #{url}")
    <-- setTimeout(_, 1000)
    fp.page.render('screen.png')
    fp.exit(0, false)

fp.parse = (data) -->
  console.log("from eval ... #{data}")
  state.submitted = true

# NOTE : for page evaluating required simple function wrapper without currying
# but INSIDE this function currying can be used!
auth = (login, password) ->
  document.getElementsByName("loginuser")[0].value = login
  document.getElementsByName("loginpassword")[0].value = password
  document.forms[0].submit()
  "logged in with login #{login} and password #{password}"

fp.open("http://www.musicforums.ru/buysell/login.php?bn=mfor_buysell", auth, login, password)
