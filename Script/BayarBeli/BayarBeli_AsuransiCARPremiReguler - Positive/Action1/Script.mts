'Load General Function Lib
Call LoadFunctionLibrary(Environment("TestDir") & "\..\..\..\Function Library\.Global Library\General.qfl")

'Load Excel Global and Local
'Load Function Library Test Case -> Test Case flow
Call InitiationScenario()
'Init Napalm
Call InitiationNapalm()

'Set itterator run or no run in excel
Call fnRunningIterator()

Call ScenarioTestCase()

Call spReportSave()
