$(document).on('turbolinks:load', function() {
  $('.jscroll-div').jscroll({ // 追加したdivのclass名と合わせる
    contentSelector: '.jscroll-div',
    autoTrigger: true,
    nextSelector: '.next a',  // 次ページリンクのセレクタ
    loadingHtml: '<div class="sk-fading-circle"><div class="sk-circle1 sk-circle"></div><div class="sk-circle2 sk-circle"></div><div class="sk-circle3 sk-circle"></div><div class="sk-circle4 sk-circle"></div><div class="sk-circle5 sk-circle"></div><div class="sk-circle6 sk-circle"></div><div class="sk-circle7 sk-circle"></div><div class="sk-circle8 sk-circle"></div><div class="sk-circle9 sk-circle"></div><div class="sk-circle10 sk-circle"></div><div class="sk-circle11 sk-circle"></div><div class="sk-circle12 sk-circle"></div></div>',
    padding: 10
  });
});

function count_length(Field,Messge,MaxLength){
  var Current = document.getElementById(Field).value.length;
  var ColorClass = "green";
  var Limit;
  if (MaxLength && MaxLength>0){
    var Limit = MaxLength - Current;
    if (Limit < 0 ){ColorClass="red";}
      document.getElementById(Messge).innerHTML = "現在"+
        Current+"文字 <span class='"+ColorClass+
          "'>あと"+Limit+"文字</span>";
    } else {
      document.getElementById(Messge).innerHTML = "現在"+
        Current+"文字";
  }
}

$(document).ready(function(){
  count_length('introduction','introduction_count',255);
});