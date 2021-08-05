$iterations = 100
$saveFile =  "$PSScriptRoot\results.txt"

$m1Description = 'Refence: Only doing calculations'
Write-Host 'Starting Measurement 1'
$m1 = Measure-Command {
  1..10 | ForEach-Object {
    $_ + ($_ * $_)
  }
}

$m2Description = 'Using Write-Host to output result of calculation to the host'
Write-Host 'Starting Measurement 2'
$m2 = Measure-Command {
  1..$iterations | ForEach-Object {
    Write-Host "Result of calculation: $($_ + ($_ * $_))"
  }
}

$m3Description = 'Using Write-Output to output result of calculation'
Write-Host 'Starting Measurement 3'
$m3 = Measure-Command {
  1..$iterations | ForEach-Object {
    Write-Output "Result of calculation: $($_ + ($_ * $_))"
  }
}

$m4Description = 'Saving result of calculation to an Array'
Write-Host 'Starting Measurement 4'
$m4 = Measure-Command {
  $result = @()
  1..$iterations | ForEach-Object {
    $result += $_ + ($_ * $_)
  }
}

$m5Description = 'Saving result of calculation to an ArrayList'
Write-Host 'Starting Measurement 5'
$m5 = Measure-Command {
  $resultAL = New-Object System.Collections.ArrayList
  1..$iterations | ForEach-Object {
    [void]$resultAL.Add(($_ + ($_ * $_)))
  }
}

$m6Description = 'Using Write-Progress to output result of calculation'
Write-Host 'Starting Measurement 6'
$count = 0
$m6 = Measure-Command {
  1..$iterations | ForEach-Object {
    $count++
    Write-Progress –Activity 'Processing' –CurrentOperation "Result: $($_ + ($_ * $_))" –PercentComplete (($count / $iterations * 100))
  }
}

$m7Description = 'Save result of calculation to file, write per iteration'
Write-Host 'Starting Measurement 7'
$m7 = Measure-Command {
  1..$iterations | ForEach-Object {
    $result = $_ + ($_ * $_)
    $result | Out-File –FilePath $saveFile –Append
  }
}
Remove-Item –Path $saveFile –Force

$m8Description = 'Save result of calculation to file, write when done (using ArrayList to store results)'
Write-Host 'Starting Measurement 8'
$m8 = Measure-Command {
  $resultAL = New-Object System.Collections.ArrayList
  1..$iterations | ForEach-Object {
    [void]$resultAL.Add(($_ + ($_ * $_)))
  }
  $resultAL | Out-File –FilePath $saveFile –Append
}
Remove-Item –Path $saveFile –Force

Write-Host "Finished all measurements`n"


Write-Output ([PSCustomObject] [Ordered] @{
    Milliseconds = [math]::Round($m1.TotalMilliseconds)
    Description  = $m1Description
})

Write-Output ([PSCustomObject] [Ordered] @{
    Milliseconds = [math]::Round($m2.TotalMilliseconds)
    Description  = $m2Description
  })
Write-Output ([PSCustomObject] [Ordered] @{
    Milliseconds = [math]::Round($m3.TotalMilliseconds)
    Description  = $m3Description
  })
Write-Output ([PSCustomObject] [Ordered] @{
    Milliseconds = [math]::Round($m4.TotalMilliseconds)
    Description  = $m4Description
  })
Write-Output ([PSCustomObject] [Ordered] @{
    Milliseconds = [math]::Round($m5.TotalMilliseconds)
    Description  = $m5Description
  })
Write-Output ([PSCustomObject] [Ordered] @{
    Milliseconds = [math]::Round($m6.TotalMilliseconds)
    Description  = $m6Description
  })
Write-Output ([PSCustomObject] [Ordered] @{
    Milliseconds = [math]::Round($m7.TotalMilliseconds)
    Description  = $m7Description
  })
Write-Output ([PSCustomObject] [Ordered] @{
    Milliseconds = [math]::Round($m8.TotalMilliseconds)
    Description  = $m8Description
  })
