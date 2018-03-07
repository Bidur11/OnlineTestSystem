$(function() {
	$('#datetimepicker').datetimepicker({
		viewMode : 'years',
		format : 'MM/YYYY'
	});
});

function checkStudentID() {
	var id = document.getElementById("stdId").value;
	userRole = document.getElementById("user_role").value;
	if(userRole == "admin"){
		currenturl = "/onlinetest/admin/checkid?userid=" + id;
	}else{
		currenturl = "/onlinetest/coach/checkid?userid=" + id;
	}
	if (id) {
		$.ajax({
			type : 'post',
			url : currenturl,
			data: {
				   'id':id,
				  },
			success : function(data) {
				$('#id_status').html(data);
			},
			error : function(jqXHR, status, err){
				console.log("error");
			}
		});
	} else {
		$('#id_status').html("");
		return false;
	}
}