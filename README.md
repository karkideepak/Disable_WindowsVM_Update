# Disable_WindowsVM_Update
Windows Update is often recommended inside VMs for unexpected changes, performance issue and wasted resources.
VM is used for labs, security testing, automation or short lived tasks.

Goodbye to installing updates loop.

Check the status of Windows Update:
```Get-Service -Name wuauserv | Format-List *```
* Get-Service → gets the Windows Update service
* -Name wuauserv → targets Windows Update
* Format-List → shows output as a list (easy to read)
* \* → means show all properties

```Get-Service wuauserv | Select Status, StartType```

See all Windows Service Properties
```Get-CimInstance Win32_Service -Filter "Name='wuauserv'" | Format-List * ```
