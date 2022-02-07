#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=
Global $form_main = GUICreate("AutoIT + MySQL + PHP", 616, 394, -1, -1)
Global $MenuItem3 = GUICtrlCreateMenu("Đăng ký")
Global $menu_sign_up = GUICtrlCreateMenuItem("Đăng ký", $MenuItem3)
Global $MenuItem2 = GUICtrlCreateMenu("About")
Global $MenuItem4 = GUICtrlCreateMenuItem("About Me", $MenuItem2)
GUISetFont(20, 400, 0, "Segoe UI")
Global $Button1 = GUICtrlCreateButton("Đăng nhập", 208, 256, 187, 73)
Global $Label1 = GUICtrlCreateLabel("Tài khoản", 64, 64, 114, 41)
Global $Label2 = GUICtrlCreateLabel("Mật khẩu", 64, 160, 114, 41)
Global $input_sign_in_account = GUICtrlCreateInput("", 208, 64, 313, 45)
Global $input_sign_in_password = GUICtrlCreateInput("", 208, 152, 313, 45)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

;gui dang ki
#Region ### START Koda GUI section ### Form=
Global $form_sign_up = GUICreate("Đăng ký", 404, 390, -1, -1)
GUISetFont(20, 400, 0, "Segoe UI")
Global $Label1 = GUICtrlCreateLabel("Họ và tên", 16, 40, 42, 41)
Global $Label2 = GUICtrlCreateLabel("Tài khoản", 16, 128, 114, 41)
Global $Label3 = GUICtrlCreateLabel("Mật khẩu", 16, 208, 114, 41)
Global $input_sign_up_name = GUICtrlCreateInput("", 136, 40, 233, 45)
Global $input_sign_up_account = GUICtrlCreateInput("", 136, 120, 233, 45)
Global $input_sign_up_password = GUICtrlCreateInput("", 136, 200, 233, 45)
Global $button_sign_up = GUICtrlCreateButton("Đăng ký", 136, 288, 163, 65)
#EndRegion ### END Koda GUI section ###

Global Const $host = 'http://localhost/au3/'

While 1
	$nMsg = GUIGetMsg(1)
	Switch $nMsg[0]
		Case $GUI_EVENT_CLOSE
			if $nMsg[1] == $form_sign_up Then
				GUISetState(@SW_HIDE, $form_sign_up)
			ElseIf $nMsg[1] == $form_main Then
				Exit
			EndIf
		Case $menu_sign_up
			GUISetState(@SW_SHOW, $form_sign_up)
		Case $button_sign_up
			Global $name_sign_up = GUICtrlRead($input_sign_up_name)
			Global $username_sign_up = GUICtrlRead($input_sign_up_account)
			Global $password_sign_up = GUICtrlRead($input_sign_up_password)
			Local $post_sign_up = _http_post($host & '/sign_up.php', 'username=' & $username_sign_up & '&password=' & $password_sign_up & '&name=' & $name_sign_up )
			if $post_sign_up == 'Lỗi kết nối database' Then
				MsgBox(0,0,$post_sign_up)
			ElseIf $post_sign_up == 'Tài khoản đã trùng' Then
				MsgBox(0,0, $post_sign_up)
			ElseIf $post_sign_up == 'Đăng kí thành công' Then
				MsgBox(0,0,$post_sign_up)
			Else
				MsgBox(0,0, $post_sign_up)
			EndIf
		Case $Button1
			Global $username = GUICtrlRead($input_sign_in_account)
			Global $password = GUICtrlRead($input_sign_in_password)
			if $username and $password Then
				Local $post = _http_post($host & '/login.php', 'username=' & $username & '&password=' & $password)
				If $post == 'Tài khoản hoặc mật khẩu có vấn đề' Then
					MsgBox(0,0, 'sai pass')
				ElseIf $post == 'Lỗi kết nối database' Then
					MsgBox(0,0, 'Lỗi kết nối database')
				Else
					$tach = StringSplit($post, ' ')
					If $tach[1] == 'Xin' Then
						MsgBox(16 + 262144, "Thông báo", "Chào bạn " & $tach[2])
					Else
						MsgBox(16 + 262144,'Lỗi', $post)
					EndIf
				EndIf
			Else
				MsgBox(16 + 262144, "Lỗi", 'Vui lòng nhập đầy đủ thông tin')
			EndIf
	EndSwitch
WEnd

Func _http_post($url, $data = '')
	Local $oHTTP = ObjCreate('WinHttp.WinHttpRequest.5.1')
	$oHTTP.open("POST", $url, False)
	$oHTTP.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
	$oHTTP.send($data)
	$oHTTP.waitForResponse()
	Return $oHTTP.responseText
EndFunc
