

. .\Write-Progress.ps1
function test1 {

  # testing psInlineProgress
  $null = Start-Transcript –Path C:\users\grave\Scripts\InlineProgressBar\transcript.txt
  Write-Host ''
}
function test2 {
  # Simple progressBar
  Write-Host 'Example of default behaviour' –ForegroundColor Magenta
  Write-Host ''

  $collection = 0..12
  $count = 0
  foreach ($item in $collection) {
    $count++
    $percentComplete = ($count / $collection.Count) * 100
    Write-Progress –Activity "Processing item #$($item)" –PercentComplete $percentComplete

    Start-Sleep –Milliseconds (Get-Random –Minimum 160 –Maximum 400)
  }
  Write-Progress –Activity 'Finished processing all items' –Complete –UseWriteOutput $True
  Write-Host ''

  # ProgressBar with more information
  Write-Host 'Example with SecondsRemaining and SecondsElapsed' –ForegroundColor Magenta
  Write-Host ''

  $collection = 0..12
  $count = 0
  $start = Get-Date
  $secondsRemaining = 0
  $secondsElapsed = 0
  foreach ($item in $collection) {
    $count++
    $percentComplete = ($count / $collection.Count) * 100
    Write-Progress –Activity "Processing item #$($item)" –PercentComplete $percentComplete –SecondsRemaining $secondsRemaining –SecondsElapsed $secondsElapsed.TotalSeconds

    Start-Sleep –Milliseconds (Get-Random –Minimum 160 –Maximum 400)

    # calculating seconds elapsed and remaining
    $secondsElapsed = (Get-Date) – $start
    $secondsRemaining = ($secondsElapsed.TotalSeconds / $count) * ($collection.Count – $count)
    if ($secondsRemaining -lt 0) {
      $secondsRemaining = 0
    }
  }
  Write-Progress –Activity 'Finished processing all items' –Complete –UseWriteOutput $True –SecondsRemaining 0 –SecondsElapsed $secondsElapsed.TotalSeconds
  Write-Host ''
}
function test3 {
  # Simple progressBar without Percent
  Write-Host 'Example of progress bar without percent' –ForegroundColor Magenta
  Write-Host ''

  $collection = 0..12
  $count = 0
  foreach ($item in $collection) {
    $count++
    $percentComplete = ($count / $collection.Count) * 100
    Write-Progress –Activity "Processing item #$($item)" –PercentComplete $percentComplete –ShowPercent:$false

    Start-Sleep –Milliseconds (Get-Random –Minimum 160 –Maximum 400)
  }
  Write-Progress –Activity 'Finished processing all items' –Complete –UseWriteOutput $true –ShowPercent:$false
  Write-Host ''
}
function test4 {
  # With error handling
  Write-Host 'Example of error handling' –ForegroundColor Magenta
  Write-Host ''

  $collection = 0..12
  $count = 0
  $_error = $false
  foreach ($item in $collection) {
    $count++
    $percentComplete = ($count / $collection.Count) * 100
    Write-Progress –Activity "Processing item #$($item)" –PercentComplete $percentComplete

    try {
      if ($item -eq 9) {
        throw 'ERROR HAPPENED!'
      }
      else {
        Start-Sleep –Milliseconds (Get-Random –Minimum 160 –Maximum 400)
      }
    }
    catch {
      Write-Progress –Stop –OutputLastProgress
      $_error = $true
      $_errorMessage = $_.Exception.Message
      break
    }
  }
  if (-not $_error) {
    Write-Progress –Activity 'Finished processing all items' –Complete
  }
  else {
    # workaround: this Write-Host is needed to be sure that the warning is written on the next line
    Write-Host ''
    Write-Warning $_errorMessage
  }
  Write-Host ''
  $null = Stop-Transcript
}
function test5 {
  param(
    [switch]$Test1,
    [switch]$Test2,
    [switch]$Test3,
    [switch]$Test4,
    [switch]$Test5,
    [switch]$Test6

)
$Title=@{

    Test1 = "'[Customized]'  -ForegroundColor Magenta"
}


  # customized progress bar
  Write-Host $Title.Test1

  if ( $Test1 ) {
    $collection = 0..12
    $count = 0
    foreach ($item in $collection) {
      $count++
      $percentComplete = ($count / $collection.Count) * 100
      Write-Progress –Activity "Items #$($item)" `
        –PercentComplete $percentComplete `
        –ProgressCharacter ([char]9632) `
        –ProgressFillCharacter ([char]9632) `
        –ProgressFill ([char]183) `
        –BarBracketStart $null `
        –BarBracketEnd $null

      Start-Sleep –Milliseconds (Get-Random –Minimum 160 –Maximum 400)
    }
    Write-Progress –Activity 'Done' `
      –Complete –ProgressCharacter ([char]9632) `
      –ProgressFillCharacter ([char]9632) `
      –ProgressFill ([char]183) `
      –BarBracketStart $null `
      –BarBracketEnd $null

  }
  if ( $Test2 ) {
    $collection = 0..12
    $count = 0
    foreach ($item in $collection) {
      $count++
      $percentComplete = ($count / $collection.Count) * 100
      Write-Progress –Activity "Processing item #$($item)" `
                     –PercentComplete $percentComplete `
                     –ProgressCharacter ([char]2588) `
                     –ProgressFillCharacter ([char]9608) `
                     –ProgressFill ([char]183) `
                     –BarBracketStart '|' `
                     –BarBracketEnd '|'

      Start-Sleep –Milliseconds (Get-Random –Minimum 160 –Maximum 400)
    }
    #[char]183 #[char]9608
    Write-Progress –Activity "" `
                   –Complete –ProgressCharacter ([char]2588) `
                   –ProgressFillCharacter ([char]2588) `
                   –ProgressFill ([char]183) `
                   –BarBracketStart '[' `
                   –BarBracketEnd ']'
  }
  if ( $Test3 ) {
    $collection = 0..12
    $count = 0
    foreach ($item in $collection) {
      $count++
      $percentComplete = ($count / $collection.Count) * 100
      Write-Progress –Activity "Processing item #$($item)" `
                     –PercentComplete $percentComplete `
                     –ProgressCharacter ([char]9472) `
                     –ProgressFillCharacter '–' `
                     –ProgressFill '–'

      Start-Sleep –Milliseconds (Get-Random –Minimum 160 –Maximum 400)
    }
    Write-Progress –Activity 'Finished processing all items' `
                   –Complete –ProgressCharacter ([char]9472) `
                   –ProgressFillCharacter '–' `
                   –ProgressFill '–'

  }
  if ( $Test4 ) {
    $collection = 0..12
    $count = 0
    foreach ($item in $collection) {
      $count++
      $percentComplete = ($count / $collection.Count) * 100
      Write-Progress –Activity "Processing item #$($item)" `
                     –PercentComplete $percentComplete `
                     –ProgressCharacter '–' `
                     –ProgressFillCharacter '|' `
                     –ProgressFill '\'  `
                     –BarBracketStart '|' `
                     –BarBracketEnd '|'

      Start-Sleep –Milliseconds (Get-Random –Minimum 160 –Maximum 400)
    }
    Write-Progress –Activity 'Finished processing all items' `
                   –Complete –ProgressCharacter '–' `
                   –ProgressFillCharacter '|' `
                   –ProgressFill '\'  `
                   –BarBracketStart '|' `
                   –BarBracketEnd '|'

  }
  if ( $Test5 ) {
    $collection = 0..12
    $count = 0
    foreach ($item in $collection) {
      $count++
      $percentComplete = ($count / $collection.Count) * 100
      Write-Progress –Activity "Processing item #$($item)" `
                     –PercentComplete $percentComplete `
                     –ProgressCharacter 'C' `
                     –ProgressFillCharacter '.' `
                     –ProgressFill 'o'

      Start-Sleep –Milliseconds (Get-Random –Minimum 160 –Maximum 400)
    }
    Write-Progress –Activity 'Finished processing all items' `
                   –Complete –ProgressCharacter 'C' `
                   –ProgressFillCharacter '.' `
                   –ProgressFill 'o'
  }
  Write-Host ''

}

# test1
# test2
# test3
# test4
test5 -Test2

