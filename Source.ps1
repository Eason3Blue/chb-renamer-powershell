Write-Output "选择1使用正则表达式模式,选择2使用字符串匹配模式";
$method=Read-Host "输入模式选项";
$regex=(Read-Host "输入参数");
Write-Output '输入你要替换成的字符串,若直接回车则为空,输入$auto则会自动按顺序更换成阿拉伯数字';
$change=(Read-Host "输入替换内容");
if($change -eq '$auto'){
    [int]$begin=(Read-Host "输入你开始数字");
}
#模式选项，选择1使用正则表达式模式，选择2使用字符串匹配模式。
$count=$begin;
Get-ChildItem | ForEach-Object {
    if($method -eq 1){
        $regex=[regex]$regex;
        $re=$regex.Match($_.Name);
        if($re.Success -eq $true){
            $cto=$change;
            if($change -eq '$auto'){
                $cto=$count;
            }
            $be=$_.Name;$af=$_.Name.Replace($re.Value,$cto);
            Rename-Item $be $af;
            Write-Output "成功将"$be"改名为"$af;
            $count++;
        }else{
            Write-Output $_.FullName"不匹配";
        }
    }elseif ($method -eq 2) {
        $re=($_.FullName | findstr $regex);
        if($re -ne $null){
            $cto=$change;
            if($change -eq '$auto'){
                $cto=$count;
            }
            $be=$_.Name;$af=$_.Name.Replace($regex,$cto);
            Rename-Item $be $af;
            Write-Output "成功将"$be"改名为"$af;
            $count++;
        }else{
            Write-Output $_.FullName"不匹配";
        }
    }
}
if($count -eq $begin){
    Write-Output "无事可做";
}
Pause;