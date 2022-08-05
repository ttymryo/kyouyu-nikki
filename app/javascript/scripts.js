$(document).on('turbolinks:load', function() {
  $('.jscroll-div').jscroll({ // 追加したdivのclass名と合わせる
    contentSelector: '.jscroll-div',
    autoTrigger: true,
    nextSelector: '.next a',  // 次ページリンクのセレクタ
    loadingHtml: '読み込み中',
    padding: 10
  });
});