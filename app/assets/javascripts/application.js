// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require_tree .
//$('.send_invite').bind('ajax:before', function() {  
//        alert("test");  
//   });  

jQuery.noConflict();

jQuery(function($) {
 $(".send_invite").click(function() {
  $('#status').fadeOut('fast').fadeIn('slow').html('Request send!');
 })
});

// jQuery(document).ready(function($) {
//              $('#button').bind('ajax:success', function() {  
//        alert('Hello World!');//$(this).closest('li.item-a').fadeOut();  
//    });  
//  }); 

jQuery(function($) {
           $("#button").click(function() {
                      $('li').closest('li').fadeOut(); 
           });
});
