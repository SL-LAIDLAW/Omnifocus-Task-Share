set configFile to ((path to me as text) & "::") & "config.txt"

set lns to paragraphs of (read file configFile as Çclass utf8È)
set thisFolder to first item of lns
set targetNumber to second item of lns



-- Start Script
set clipboardData to (the clipboard as text)
set empty to {}

tell application "OmniFocus"
	tell default document
		set flaggedTasks to every flattened task whose flagged is true and completed is false
		repeat with a from 1 to length of flaggedTasks
			set currentTask to item a of flaggedTasks
			set the clipboard to empty
			
			set taskName to name of currentTask
			set the clipboard to taskName
			set taskName to (do shell script "python '" & thisFolder & "URLencode.py'")
			
			
			set taskID to id of currentTask
			set taskNote to ((note of currentTask) as string)
			set the clipboard to taskNote
			set taskNote to (do shell script "python '" & thisFolder & "URLencode.py'")
			
			
			if ((estimated minutes of currentTask) as string) is not "missing value" then
				set taskEstimate to (estimated minutes of currentTask) & "m"
			else
				set taskEstimate to ""
			end if
			
			
			set taskDefer to ((defer date of currentTask) as string)
			set the clipboard to taskDefer
			set taskDefer to (do shell script "python '" & thisFolder & "DateFormat.py'")
			
			
			set taskDue to due date of currentTask
			set the clipboard to taskDue
			set taskDue to (do shell script "python '" & thisFolder & "DateFormat.py'")
			
			
			set taskURL to taskName & "&note=" & taskNote & "&defer=" & taskDefer & "&due=" & taskDue & "&estimate=" & taskEstimate
			
			set the clipboard to taskURL
			
			
			--set taskURL to (do shell script "python '" & thisFolder & "URLencode.py'")
			
			set taskURL to "omnifocus:///add?name=" & taskURL
			
			set message2send to ((taskURL) as string)
			
			tell application "Messages"
				set targetService to (id of 1st service whose service type = iMessage)
				set theTarget to buddy targetNumber of service id targetService
				send taskURL to theTarget
			end tell
			
			--set the clipboard to taskURL
			--set flagged of currentTask to false
			
		end repeat
	end tell
end tell

set the clipboard to clipboardData

