# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



# turbolinks+jQuery fix "ready page:load"
$(document).on "ready page:load", ->
  $('form').on 'click', '.remove_fields', (event) ->
    event.preventDefault()
    console.log('click remove')
    $(this).prev('input[type=hidden]').val('true')
    $(this).closest('fieldset').hide()

  $('form').on 'click', '.Add_tip', (event) ->
    event.preventDefault()
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    last = $(this).before($(this).data('fields').replace(regexp, time))
    ultimo_id = $('.js-update-editor:last').attr('id')
    CKEDITOR.replace(ultimo_id)
