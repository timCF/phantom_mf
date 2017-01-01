fp = require("funphan")(300000)
fp.debug = false
[login, password, ...urls] = fp.args
console.log("start ... login = #{login}, password = #{password}, urls = #{JSON.stringify(urls)}")
state = {
  submitted: false,
  urls: urls
}

fp.parse = (data) -->
  console.log("from eval ... #{data}")
  <-- setTimeout(_, 5000)
  if not(state.submitted) then fp.page.render("screen.png")
  state.submitted = true
  if (state.urls.length > 0)
    url = state.urls.pop()
    console.log("trying update #{url}")
    fp.open(url, maybe_update)
  else
    console.log("finish script ...")
    fp.exit(0, false)

# NOTE : for page evaluating required simple function wrapper without currying
# but INSIDE this function currying can be used!
auth = (login, password) ->
  document.getElementsByName("loginuser")[0].value = login
  document.getElementsByName("loginpassword")[0].value = password
  document.forms[0].submit()
  "logged in with login #{login} and password #{password}"

maybe_update = ->
  links = document.getElementsByClassName('link')
  [update] = [].filter.call(links, (el) -> el.title == "Обновить тему")
  if update
    update.click()
    "updated!"
  else
    "update is not avaiable ..."

fp.open("http://www.musicforums.ru/buysell/login.php?bn=mfor_buysell", auth, login, password)
