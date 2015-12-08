// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

var colorBoxes = [];

var randHex = function() {
  var chars = "abcdef012345689";
  var hexArray = [];
  for(var i = 0; i < 6; i++) {
    hexArray[i] = chars[Math.floor(Math.random()*chars.length)];
  }
  return "#" + hexArray.join("");
}

function hexToRgb(hex) {
    var result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
    return [parseInt(result[1], 16), parseInt(result[2], 16), parseInt(result[3], 16)]
}

function componentToHex(c) {
    var hex = c.toString(16);
    return hex.length == 1 ? "0" + hex : hex;
}

function rgbToHex(r, g, b) {
    return "#" + componentToHex(r) + componentToHex(g) + componentToHex(b);
}


//Intro color background class
var ColorBox = function(id, timeOffset) {
  if(id <= 9) {
    this.id = "00" + id;
  }
  else if (id <= 99) {
    this.id = "0" + id;
  }
  else {
    this.id = id;
  }
  this.timeOffset = timeOffset;
  this.currColor = "#000000";
  $("#color-background-inner").append("<div class='color-box-container'"
                                      + "ontouchstart=\"this.classList.toggle('hover');\">"
                                      + "<div class='color-box' id='cb-"+this.id+"'>"
                                      + "<div class='front'></div>"
                                      + "<div class='back'><p>#000000</p></div>"
                                      + "</div></div>");
  this.setColor = function(color) {
    this.currColor = color;
    var currentBox = "#cb-"+this.id;
    $(currentBox+", "+currentBox+" > .front").css("background-color", color);
    //darkened background color for the back
    var currRGB = hexToRgb(this.currColor);
    for(var i = 0; i < currRGB.length; i++) {
      currRGB[i] -= 0; //Set this value to 50 for more darkenedness.
      if(currRGB[i] < 0) {
        currRGB[i] = 0;
      }
    }
    $(currentBox+" > .back").css("background-color", rgbToHex(currRGB[0],
                                                              currRGB[1],
                                                              currRGB[2]));
    $(currentBox+" > .back > p").html(this.currColor);
  }
  this.setColor(randHex());
  var that = this;
  setTimeout(function() {
    that.setColor(randHex());
    that.interval = setInterval(function() {
      that.setColor(randHex());
    }, 10000);
  }, timeOffset);
}

$(document).ready(function() {
  for(var i = 0; i < 200; i++) {
    colorBoxes[i] = new ColorBox(i, Math.random()*10000);
  }
});
