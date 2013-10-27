/*
 * Photostream Import
 *
 * Scans the photostream folder and copies new files to another directory
 * that picasa is set to monitor.
 *
 * Requirements:
 *     - AutoHotkey v1.1.+ (maybe)
 */

VERSION := "0.1.0"

; BUG: if some fatal error happens and app closes it doesn't close the whole
; application. Thus needs this to say only have one running.
#SingleInstance force
#NoEnv
;;#Warn ; Only uncomment when testing
SendMode Input ; A lot of examples say this is faster than default
; TODO: Use this as an option so working dir can be set to user directory
SetWorkingDir %A_ScriptDir%
OnExit, HandleExit

IniRead, source_dir, config.ini, options, source_dir
IniRead, dest_dir, config.ini, options, dest_dir
IniRead, sort_method, config.ini, options, sort_method, year
IniRead, enable_log, config.ini, options, enable_log, true
IniRead, log_file, config.ini, options, log_file, runtime.log
IniRead, ignore_log_level, config.ini, options, ignore_log_level

LogMsg("INFO", "Process started")

; Error Checking
if sort_method not in year,month,day
    HandleError("Value for sort_method should be year, month, or day. Received " . sort_method)
if (FileExist(source_dir) = "")
    HandleError("source_dir " . source_dir . " does not exist")
if (FileExist(dest_dir) = "")
    HandleError("dest_dir " . dest_dir . " does not exist")

;ListVars
;Pause
Loop, %source_dir%\*
{
    ; Don't copy desktop.ini in case it would mess with whatever photo program
    ; scans this folder.
    if (A_LoopFileName = "desktop.ini")
        Continue
    FileGetTime, file_mod_time, %A_LoopFileLongPath%
    FormatTime, file_time_year, %file_mod_time%, yyyy
    FormatTime, file_time_month, %file_mod_time%, MM
    FormatTime, file_time_day, %file_mod_time%, dd
    if sort_method = year
        dest_path := dest_dir . "\" . file_time_year
    if sort_method = month
        dest_path := dest_dir . "\" . file_time_year . "\" . file_time_month
    if sort_method = day
        dest_path := dest_dir . "\" . file_time_year . "\" . file_time_month . "\" . file_time_day
    IfNotExist, %dest_path%
    {
        LogMsg("INFO", "Creating " . dest_path)
        FileCreateDir, %dest_path%
        if ErrorLevel
        {
            HandleError("Could not create directory " . dest_path . " (" . ErrorLevel . "): " . A_LastError)
        }
    }
    IfNotExist, %dest_path%\%A_LoopFileName%
    {
        LogMsg("INFO", "Copying file " . A_LoopFileName . " to " . dest_path)
        FileCopy, %A_LoopFileLongPath%, %dest_path%
        if ErrorLevel
        {
            HandleError("Could not copy " . A_LoopFileLongPath . " to " . dest_path . "Error: " . A_LastError)
        }
    }
}

LogMsg("INFO", "Done")
ExitApp

; Prints the given error to log and screen and exits app
HandleError(str)
{
    ;ListVars
    ;Pause
    LogMsg("ERROR", str)
    MsgBox, %str%
    ExitApp
}

; Logs the given string to %log_file%
LogMsg(error_level, str)
{
    global enable_log
    global ignore_log_level
    if (enable_log != "false" && InStr(ignore_log_level, error_level) = False)
    {
        global log_file
        if (log_file = "")
        {
            MsgBox, log_file not set, please correct
            ExitApp
        }
        FileAppend, %A_Now% %error_level% %str%`n, %log_file%
    }
}

HandleExit:
    LogMsg("INFO", "Exiting app. Reason: " . A_ExitReason)
    ExitApp


/* This would be more useful if I had a gui
GuiEscape:
GuiClose:
ExitApp
*/
