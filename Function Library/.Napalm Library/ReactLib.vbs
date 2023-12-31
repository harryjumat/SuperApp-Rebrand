REM Created by		: Dadit
REM Enhanced by		: Adhy - Dadit
REM Date Created	: 4 April 2018
REM	Date Updated	: 14 Agustus 2018

REM Upated by 		: Dea
REM Date Updated 	: 18 April 2019 (Napalm Lib v1.9)

REM ============================= Changelog 1.5
REM == 3 Agustus 2018
	REM == 1. Penambahan InitiateReactV2(), dan EnumDataType()
REM ============================================================

'Public react
Dim react
Public initiated

initiated = False
Set react = Nothing

Class EnumDataType
    Public  Passed, Warning, Failed, Done
    Private Sub Class_Initialize
        Passed = 0
        Warning = 1
        Failed = 2
		Done = 3
    End Sub
End Class

Dim ReportStatus
Set ReportStatus = New EnumDataType

'Function ini dipanggil di AWAL project setelah function "CreateFolder"!!!!
Function InitiateReact(byval projectName, byval authorName, byval tcId)

	If Not initiated Then
	On error resume next
		Set react = CreateObject("Napalm.React")
		react.SetOutputDirectory objFolder
		react.SetOutputFormat "pdf"
		react.SetImageSizePercentage 200
		react.SetAuthor authorName
		react.SetProjectName projectName
		react.SetTestCaseId tcId		
		initiated = True
	On error goto 0
	End If

End Function

' Function InitiateReactV2(byval projectName, byval authorName, byval tcId)

	' If Not initiated Then
		' Set react = CreateObject("Napalm.React")
		' If PathFolder1 = "" Then
			' react.SetOutputDirectory objFolder
			' else			
			' react.SetOutputDirectory PathFolder1
		' End If
		' react.SetImageSizePercentage 200
		' react.SetAuthor authorName
		' react.SetProjectName projectName
		' react.SetTestCaseId tcId
		' Call react.SetCreateDocumentSummary(true)
		' Call react.SetAutoHideWarningStatusIfEmptyInSummary(false)
		' Call react.SetDisplayLegendInDocumentSummary(true)
		' initiated = True
	' End If
' End Function

'Function InitiateReactV2(byval projectName, byval authorName, byval tcId)
'	If Not initiated Then
'		Set react = CreateObject("Napalm.React")
'		react.SetOutputDirectory PathFolder
'		react.SetImageSizePercentage 200
'		react.SetAuthor authorName
'		react.SetProjectName projectName
'		react.SetTestCaseId tcId
'		Call react.SetCreateDocumentSummary(true)
'		Call react.SetAutoHideWarningStatusIfEmptyInSummary(false)
'		Call react.SetDisplayLegendInDocumentSummary(true)
'		initiated = True
'	End If
'End Function


'Function ini dipanggil di AKHIR Action pada setiap Project atau Test
'Function SaveReact()
'	If CInt(Environment("TestIteration")) = CInt(DataTable.GlobalSheet.GetRowCount()) Then
'		If initiated Then
'			react.Save Environment.Value("TestName"), true
'		End If
'	End If
'End Function

Function SaveReact()
	If CInt(Environment("TestIteration")) = CInt(DataTable.GlobalSheet.GetRowCount()) Then
		If initiated Then
			react.Save dtTempTC, true
		End If
	End If
End Function

'-------------------------------- Napalm Lib v1.9
Dim CoverTitle
Dim CoverSubTitle
Dim CompanyLogo

'CoverTitle		= DataTable.Value ("COVER_TITLE", dtGlobalSheet)
'CoverSubTitle	= DataTable.Value ("COVER_SUBTITLE", dtGlobalSheet)
'CompanyLogo		= DataTable.Value ("COMPANY_LOGO", dtGlobalSheet)
'ProjectName		= DataTable.Value ("PROJECT_NAME", dtGlobalSheet)

Function InitiateReact_V2_1(byval CoverTitle, byval CoverSubTitle, byval CompanyLogo, byval projectName, byval authorName, byval tcId)
	If not initiated Then
		On error resume next
		
		Set react = CreateObject("Napalm.React")
		react.SetOutputDirectory PathFolder
		
		Call react.About()
		Call react.SetUseCover(true)
		
		react.SetCoverLogoPath CompanyLogo
		react.SetCoverTitle CoverTitle
		react.SetCoverSubTitle CoverSubTitle
		
		react.SetImageSizePercentage 200
		react.SetAuthor authorName
		react.SetProjectName projectName
		react.SetTestCaseId tcId
		
		Call react.SetCreateDocumentSummary(true)
		Call react.SetAutoHideWarningStatusIfEmptyInSummary(false)
		Call react.SetDisplayLegendInDocumentSummary(true)
		
		initiated = True
		On error goto 0
	End If
End Function


Function SaveReact_V1_9
	If CInt(Environment("TestIteration")) = CInt(DataTable.GlobalSheet.GetRowCount()) Then
		react.Save dtTempTC, true
	End If
End Function

REM ----- Untuk menyimpan banyak test case di dalam 1 folder
Function SaveReact_Merge()
	react.Save dtTempTC, true
	initiated = false 
End Function




REM ----- New Function

Sub spReportSave()
	If CInt(Environment("ActionIteration")) = CInt(DataTable.LocalSheet.GetRowCount()) Then
		If initiated Then
			react.Save Environment("ActionName"), true
			initiated = false
		End If
	End If
End Sub

REM ********************************************
REM Save Report and Generate
REM ********************************************
Sub spReportForceSave()
	If initiated Then
		react.Save Environment("ActionName"), true
		initated = false
	End If
End Sub
