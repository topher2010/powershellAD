Add-Type -AssemblyName System.Windows.Forms

function msgbox {
    param (
        [string]$Message,
        [string]$Title = 'Message box title',   
        [string]$buttons = 'OKCancel'
    )

    switch ($buttons) {
        'ok' {$btn = [System.Windows.Forms.MessageBoxButtons]::OK; break}
        'okcancel' {$btn = [System.Windows.Forms.MessageBoxButtons]::OKCancel; break}
        'AbortRetryIgnore' {$btn = [System.Windows.Forms.MessageBoxButtons]::AbortRetryIgnore; break}
        'YesNoCancel' {$btn = [System.Windows.Forms.MessageBoxButtons]::YesNoCancel; break}
        'YesNo' {$btn = [System.Windows.Forms.MessageBoxButtons]::yesno; break}
        'RetryCancel'{$btn = [System.Windows.Forms.MessageBoxButtons]::RetryCancel; break}
        default {$btn = [System.Windows.Forms.MessageBoxButtons]::RetryCancel; break}
     }
    }
    
function Get-Username {

    $Usrnme = $Username.Text
    $Result = Get-ADUser $Usrnme | Select SamAccountName
    
    If($result.SamAccountName -eq $Usrnme) {
        $msgbx1 = msgbox -message "This username already exists, please try a new one" -title "Username already exists" -buttons ok

    }
}

$CopyADUser = New-Object system.Windows.Forms.Form
$CopyADUser.Text = "Copy AD User"
$CopyADUser.BackColor = "#ffffff"
$CopyADUser.TopMost = $true
$CopyADUser.Width = 420
$CopyADUser.Height = 460

$label = New-Object system.windows.Forms.Label
$label.Text = "Username to Copy"
$label.AutoSize = $true
$label.Width = 25
$label.Height = 10
$label.location = new-object system.drawing.point(25,20)
$label.Font = "Microsoft Sans Serif,10"
$CopyADUser.controls.Add($label)

$NewUsername = New-Object system.windows.Forms.Label
$NewUsername.Text = "New Username"
$NewUsername.AutoSize = $true
$NewUsername.Width = 25
$NewUsername.Height = 10
$NewUsername.location = new-object system.drawing.point(242,20)
$NewUsername.Font = "Microsoft Sans Serif,10"
$CopyADUser.controls.Add($NewUsername)

$EnterFirstName = New-Object system.windows.Forms.Label
$EnterFirstName.Text = "Enter First Name"
$EnterFirstName.AutoSize = $true
$EnterFirstName.Width = 25
$EnterFirstName.Height = 10
$EnterFirstName.location = new-object system.drawing.point(25,102)
$EnterFirstName.Font = "Microsoft Sans Serif,10"
$CopyADUser.controls.Add($EnterFirstName)

$EnterLastName = New-Object system.windows.Forms.Label
$EnterLastName.Text = "Enter Last Name"
$EnterLastName.AutoSize = $true
$EnterLastName.Width = 25
$EnterLastName.Height = 10
$EnterLastName.location = new-object system.drawing.point(242,103)
$EnterLastName.Font = "Microsoft Sans Serif,10"
$CopyADUser.controls.Add($EnterLastName)

$EnterNewPassword = New-Object system.windows.Forms.Label
$EnterNewPassword.Text = "Enter New Password"
$EnterNewPassword.AutoSize = $true
$EnterNewPassword.Width = 25
$EnterNewPassword.Height = 10
$EnterNewPassword.location = new-object system.drawing.point(25,183)
$EnterNewPassword.Font = "Microsoft Sans Serif,10"
$CopyADUser.controls.Add($EnterNewPassword)

$EnterPhoneNumber = New-Object system.windows.Forms.Label
$EnterPhoneNumber.Text = "Enter Phone Number"
$EnterPhoneNumber.AutoSize = $true
$EnterPhoneNumber.Width = 25
$EnterPhoneNumber.Height = 10
$EnterPhoneNumber.location = new-object system.drawing.point(242,184)
$EnterPhoneNumber.Font = "Microsoft Sans Serif,10"
$CopyADUser.controls.Add($EnterPhoneNumber)

$UsernameCopy = New-Object system.windows.Forms.TextBox
$UsernameCopy.Width = 100
$UsernameCopy.Height = 20
$UsernameCopy.location = new-object system.drawing.point(28,53)
$UsernameCopy.Font = "Microsoft Sans Serif,10"
$CopyADUser.controls.Add($UsernameCopy)

$Username = New-Object system.windows.Forms.TextBox
$Username.Width = 100
$Username.Height = 20
$Username.location = new-object system.drawing.point(244,52)
$Username.Font = "Microsoft Sans Serif,10"
$CopyADUser.controls.Add($Username)

$FirstName = New-Object system.windows.Forms.TextBox
$FirstName.Width = 100
$FirstName.Height = 20
$FirstName.location = new-object system.drawing.point(28,138)
$FirstName.Font = "Microsoft Sans Serif,10"
$CopyADUser.controls.Add($FirstName)

$LastName = New-Object system.windows.Forms.TextBox
$LastName.Width = 100
$LastName.Height = 20
$LastName.location = new-object system.drawing.point(243,140)
$LastName.Font = "Microsoft Sans Serif,10"
$CopyADUser.controls.Add($LastName)

$NewPassword = New-Object system.windows.Forms.TextBox
$NewPassword.Width = 100
$NewPassword.Height = 20
$NewPassword.location = new-object system.drawing.point(28,220)
$NewPassword.Font = "Microsoft Sans Serif,10"
$CopyADUser.controls.Add($NewPassword)

$PhoneNumber = New-Object system.windows.Forms.TextBox
$PhoneNumber.Width = 100
$PhoneNumber.Height = 20
$PhoneNumber.location = new-object system.drawing.point(242,220)
$PhoneNumber.Font = "Microsoft Sans Serif,10"
$CopyADUser.controls.Add($PhoneNumber)

$CreateAccount = New-Object system.windows.Forms.Button
$CreateAccount.Text = "Create Account"
$CreateAccount.Width = 127
$CreateAccount.Height = 27
$CreateAccount.Add_MouseClick({
#add here code triggered by the event

Get-Username

$New_Pass = ($NewPassword.Text) | ConvertTo-SecureString -AsPlainText -Force
$New_DisplayName = $LastName.Text + ', ' + $FirstName.Text 
$New_Path = (Get-ADUser ($UsernameCopy.Text)).DistinguishedName -replace '^.*?,\s*(?=ou=)', ''
$HomePage = Get-ADUser ($UsernameCopy.Text) -Properties homepage
$NewDescription = Get-ADUser ($UsernameCopy.Text) -Properties description
$NewOffice = Get-ADUser ($UsernameCopy.Text) -Properties office
$NewStreet = Get-ADUser ($UsernameCopy.Text) -Properties streetaddress
$NewCity = Get-ADUser ($UsernameCopy.Text) -Properties city
$NewState = Get-ADUser ($UsernameCopy.Text) -Properties state
$NewPostalCode = Get-ADUser ($UsernameCopy.Text) -Properties postalcode
$NewTitle = Get-ADUser ($UsernameCopy.Text) -Properties title
$NewDepartment = Get-ADUser ($UsernameCopy.Text) -Properties department
$NewCompany = Get-ADUser ($UsernameCopy.Text) -Properties company
$NewScript = Get-ADUser ($UsernameCopy.Text) -Properties scriptpath

#Get Domain Name
$NewDomain = ((Get-ADUser $UsernameCopy.Text).distinguishedname) -split "," | ? {$_ -like "DC=*"}
$NewDomain = $NewDomain -join "." -replace ("DC=","")

$AD_Account_To_Copy = Get-ADUser $UsernameCopy.Text -Properties memberof

$params = @{'SamAccountName' = $Username.Text;
            'Instance' = $AD_Account_To_Copy;
            'DisplayName' = $New_DisplayName;
            'GivenName' = $FirstName.Text;
            'Path' = $New_Path;
            'SurName' = $LastName.Text;
            'ChangePasswordAtLogon' = $true;
            'Enabled' = $true;
            'UserPrincipalName' = $Username.Text + '@' + $NewDomain;
            'AccountPassword' = $New_Pass;
            'HomePage' = $HomePage.HomePage;
            'Description' = $NewDescription.Description;
            'Office' = $NewOffice.Office;
            'StreetAddress' = $NewStreet.StreetAddress;
            'City' = $NewCity.City;
            'State' = $NewState.State;
            'PostalCode' = $NewPostalCode.PostalCode;
            'Title' = $NewTitle.Title;
            'Department' = $NewDepartment.Department;
            'Company' = $NewCompany.Company;
            'ScriptPath' = $NewScript.ScriptPath;
            'OfficePhone' = $PhoneNumber.text;
            'EmailAddress' = $Username.Text + '@azadc.gov'
            }

New-ADUser -Name $New_DisplayName @params

$TempMembership = Get-ADUser -Identity $UsernameCopy.Text -Properties MemberOf | 
                            Select -ExpandProperty MemberOf | 
                            Add-ADGroupMember -Members $Username.Text


})
$CreateAccount.location = new-object system.drawing.point(125,370)
$CreateAccount.Font = "Microsoft Sans Serif,10"
$CopyADUser.controls.Add($CreateAccount)

[void]$CopyADUser.ShowDialog()
$CopyADUser.Dispose()
