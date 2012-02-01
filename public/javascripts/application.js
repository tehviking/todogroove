$(function() {
  $(".chzn-select").chosen();
})

$(function() {
  $('#task_list').sortable({
    axis: 'y',
//    handle: '.handle',
    update: function() {
//      alert("Updated!");
      $.post($(this).data('update-url'), $(this).sortable('serialize'));
    }

  });
});