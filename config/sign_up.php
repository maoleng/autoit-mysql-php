<?php 
if ( isset($_POST['username'], $_POST['password'], $_POST['name']) ) {	
	$username = $_POST['username'];
	$password = $_POST['password'];
	$name = $_POST['name'];

	require 'connect.php';
	if ( mysqli_connect_errno() ) {
		echo 'Lỗi kết nối database';
	} else {
		$sql_select = "
			SELECT * FROM accounts WHERE username = '$username'LIMIT 1
		";
		$query_sql_select = mysqli_query($connect, $sql_select);
		if ( mysqli_num_rows($query_sql_select) == 1 ) {
			echo 'Tài khoản đã trùng';
		} else {
			$sql_insert = "
				INSERT INTO accounts(username, password, name)
				VALUES('$username', '$password', '$name')
			";
			mysqli_query($connect, $sql_insert);
			echo 'Đăng kí thành công';
		}
		mysqli_close($connect);
	}

} else {
	echo 'Chưa điền tài khoản hoặc mật khẩu';
}