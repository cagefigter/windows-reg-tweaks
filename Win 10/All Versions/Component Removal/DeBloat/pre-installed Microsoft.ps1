# Build the removal function
Function Remove-App([String]$AppName){
	$PackageFullName = (Get-AppxPackage $AppName).PackageFullName
	$ProPackageFullName = (Get-AppxProvisionedPackage -online | where {$_.Displayname -like $AppName}).PackageName
	Remove-AppxPackage -package $PackageFullName | Out-Null
	Remove-AppxProvisionedPackage -online -packagename $ProPackageFullName | Out-Null
}

# Remove the following Apps (via identifiers)
Remove-App "Microsoft.3DBuilder"                       # 3DBuilder app
Remove-App "Microsoft.Advertising*"                    # Advertising framework
Remove-App "Microsoft.BingFinance"                     # Money app - Financial news
Remove-App "Microsoft.BingFoodAndDrink"                # Food and Drink app
Remove-App "Microsoft.BingHealthAndFitness"            # Health and Fitness app
Remove-App "Microsoft.BingNews"                        # Generic news app
Remove-App "Microsoft.BingSports"                      # Sports app - Sports news
Remove-App "Microsoft.BingTranslator"                  # Translator app - Bing Translate
Remove-App "Microsoft.BingTravel"                      # Travel app
Remove-App "Microsoft.CommsPhone"                      # Phone app
Remove-App "Microsoft.ConnectivityStore"			   # Connectivity Store
Remove-App "Microsoft.FreshPaint"                      # Canvas app
Remove-App "Microsoft.GetHelp"                         # Get Help link
Remove-App "Microsoft.Getstarted"                      # Get Started link
Remove-App "Microsoft.Messaging"                       # Messaging app
Remove-App "Microsoft.MicrosoftJackpot"                # Jackpot app
Remove-App "Microsoft.MicrosoftJigsaw"                 # Jigsaw app
Remove-App "Microsoft.MicrosoftOfficeHub"			   # MS Office Hub
Remove-App "Microsoft.MicrosoftPowerBIForWindows"      # Power BI app - Business analytics
Remove-App "Microsoft.MicrosoftSudoku"				   # Sudoku Game
Remove-App "Microsoft.MinecraftUWP*"				   # Minecraft Game
Remove-App "Microsoft.MovieMoments"                    # imported from stage_2_de-bloat.bat
Remove-App "Microsoft.NetworkSpeedTest*"
Remove-App "Microsoft.Office.OneNote"                  # Onenote app
Remove-App "Microsoft.Office.Sway"                     # Sway app
Remove-App "Microsoft.OneConnect"                      # OneConnect app
Remove-App "Microsoft.People"                          # People app
Remove-App "Microsoft.SkypeApp"                        # Get Skype link
Remove-App "Microsoft.SkypeWiFi"
Remove-App "Microsoft.Studios.Wordament"               # imported from stage_2_de-bloat.bat
Remove-App "Microsoft.WindowsFeedbackHub"              # Feedback app
Remove-App "Microsoft.WindowsReadingList*"             # Windows read-later list
Remove-App "Microsoft.Zune*"                           # Zune collection of apps


# Inactive identifers
#Remove-App "Microsoft.Appconnector"                   # Problematic
#Remove-App "Microsoft.BingWeather"                    # Weather app
#Remove-App "Microsoft.BioEnrollment"                  # not sure about this one
#Remove-App "Microsoft.Microsoft3DViewer"              # 3D model viewer
#Remove-App "Microsoft.MicrosoftSolitaireCollection"   # Solitaire collection
#Remove-App "Microsoft.MicrosoftStickyNotes"           # Pulled from active list due to user requests
#Remove-App "Microsoft.Windows.Photos"                 # Photos app
#Remove-App "Microsoft.WindowsAlarms"                  # Alarms and Clock app
#Remove-App "Microsoft.WindowsCalculator"              # Calculator app
#Remove-App "Microsoft.WindowsCamera"                  # Camera app
#Remove-App "Microsoft.WindowsMaps"                    # Maps app
#Remove-App "Microsoft.WindowsSoundRecorder"           # Sound Recorder app, recording sound and mic is default blocked
#Remove-App "Microsoft.WindowsStore"                   # Windows Store
#Remove-App "Microsoft.windowscommunicationsapps"      # Calendar and Mail app
#Remove-App "Microsoft.MSPaint"                        # MS Paint (Paint 3D)
#Remove-App "Microsoft.ZuneMusic"	                   # Zune Music				
#Remove-App "Microsoft.ZuneVideo"					   # Zune Video
#Remove-App "Microsoft.Xbox*"						   # Removing XBox and support also breaks Xbox 360 Controller (driver) 
#Remove-App "Microsoft.Xbox.TCUI"
#Remove-App "Microsoft.XboxApp"
#Remove-App "Microsoft.XboxGameCallableUI"
#Remove-App "Microsoft.XboxGameOverlay"
#Remove-App "Microsoft.XboxIdentityProvider"
#Remove-App "Microsoft.XboxSpeechToTextOverlay"