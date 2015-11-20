# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#
# a = 1
#
# console.log a
#
# captitalize = (word) ->
#   word.charAt(0).toUppercase() + word.slice(1)
#
# console.log captitalize("brien")

$ ->
  captitalize = (word) ->
    firstLetterCap = word.charAt(0).toUpperCase()
    firstLetterCap + word.slice(1)

  $(".btn").on "click", ->
    $(@).toggleClass('btn btn-info').toggleClass("btn btn-danger")

  $(".text-input").on "keyup", ->
    text_input = $(@).val().split(" ")
    text_input =  text_input.map (word) -> captitalize(word)
    $(".text-output").text(text_input.join(" "))

# text.charAt(0).toUppercase() + text.slice(1)
