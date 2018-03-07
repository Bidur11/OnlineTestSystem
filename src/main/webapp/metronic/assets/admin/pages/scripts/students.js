$(document).on("click", ".btnDel", function () {
    var userId = $(this).attr('value');
    $(".modal-footer #del").val( userId );
});