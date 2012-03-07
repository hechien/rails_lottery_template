# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
[fb_uid, fb_email] = [null, null]

window.fbAsyncInit = ->
  FB.init({
    appId      : '248116461942238',
    status     : true, 
    cookie     : true,
    xfbml      : true,
    oauth      : true,
  })
  
  FB.Event.subscribe 'auth.statusChange', (rep) ->
    if rep["status"] is "connected"
      $(".fb-login-button").hide()
      fb_uid = rep["authResponse"]["userID"];
      FB.api '/me', (meRep) ->
        fb_email = meRep["email"];
        $("p#go").click rollTheDice

rollTheDice = ->
  $.post('/play', "options[fb_uid]=#{fb_uid}&options[fb_email]=#{fb_email}").success((rep) ->
    if rep["win"]
      alert "Congratulation!"
    else
      alert "Oops!"
  ).error((rep) ->
    eval rep["responseText"]
  )