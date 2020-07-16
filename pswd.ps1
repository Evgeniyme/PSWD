Import-Module ActiveDirectory
function GetOU {
                Write-Host "Please Enter part of name OU:" -ForegroundColor Green -BackgroundColor Black
                [string]$inp = Read-Host 
                $global:OU = Get-ADOrganizationalUnit -filter "name -like '$inp*'"  
}

Write-Host "1. Unset Pass never exp 2. Set pass newer exp 3. Count users in OU 4. Last date pass change in OU users" -ForegroundColor Green -BackgroundColor Black
[int]$task = Read-Host

switch ($task) {
        1 { GetOU
            $Cred = Get-Credential
            Get-ADUser -Filter * -SearchBase $OU | Set-ADUser -Credential $Cred  -server kwekwe.controlpay.intranet -PasswordNeverExpires:$false
           }
        2 { GetOU
            $Cred = Get-Credential
            Get-ADUser -Filter * -SearchBase $OU | Set-ADUser -Credential $Cred -server kwekwe.controlpay.intranet -PasswordNeverExpires:$true
          }
        3 { GetOU
            Get-ADUser -Filter * -SearchBase $OU | Select-object | sort  sAMAccountName | ft sAMAccountName
            Write-Host "Total users:" (Get-ADUser -Filter * -SearchBase $OU).count
           }
        4 { GetOU
            Get-ADUser -Filter * -SearchBase $OU -properties passwordlastset, passwordneverexpires | sort  passwordlastset | ft Name, passwordlastset, Passwordneverexpires}
          }  
        
