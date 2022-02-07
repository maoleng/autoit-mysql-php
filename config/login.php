<?php 
if ( isset($_POST['username'], $_POST['password']) ) {
	$username = $_POST['username'];
	$password = $_POST['password'];

	require 'connect.php';
	if ( mysqli_connect_errno() ) {
		echo 'Lỗi kết nối database';
	} else {
		$sql_select = "
			SELECT * FROM accounts WHERE username = '$username' && password = '$password' LIMIT 1
		";
		$query_sql_select = mysqli_query($connect, $sql_select);
		if ( mysqli_num_rows($query_sql_select) != 1 ) {
			echo 'Tài khoản hoặc mật khẩu có vấn đề';
		} else {
			$each_account = mysqli_fetch_array($query_sql_select);
			echo 'Oke ' . $each_account['name'];
		}
		mysqli_close($connect);
	}

} else {
	echo 'Chưa điền tài khoản hoặc mật khẩu';
}