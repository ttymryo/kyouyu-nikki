$(document).on('turbolinks:load', function() {
  $('.jscroll-div').jscroll({ // 追加したdivのclass名と合わせる
    contentSelector: '.jscroll-div',
    autoTrigger: true,
    nextSelector: '.next a',  // 次ページリンクのセレクタ
    loadingHtml: '<div class="sk-fading-circle"><div class="sk-circle1 sk-circle"></div><div class="sk-circle2 sk-circle"></div><div class="sk-circle3 sk-circle"></div><div class="sk-circle4 sk-circle"></div><div class="sk-circle5 sk-circle"></div><div class="sk-circle6 sk-circle"></div><div class="sk-circle7 sk-circle"></div><div class="sk-circle8 sk-circle"></div><div class="sk-circle9 sk-circle"></div><div class="sk-circle10 sk-circle"></div><div class="sk-circle11 sk-circle"></div><div class="sk-circle12 sk-circle"></div></div>',
    padding: 10
  });
});