

$Hello = "Wouaouwww"
$World = "Love it !!"
$string = @"
                Msg1 = Type "Windows".
                Msg2 = She said, "$Hello, $World."
                Msg3 = Enter an alias (or "nickname")
"@

@{
}

$Run = @{
  Run = @{ "Next" = $Run; }
  Proc = @{
    "Running" = ( Get-Process | Format );
    "pwsh"    = @{ "Exec" = ( Get-Process pwsh ); "Info" = ( Get-Process pwsh | Format ) }
  };
  Cmds = @{ "Prompt" = ( "Invoke-Command Write-Host" ); "ColorPrmpt" = ( "Invoke-Command Write-Colorize.ps1 -Object" ) };
  Tags = @{ "Tags" = "`t-Tag:   " }
  Alrt = @{ "Acts" = "[Action]"; 'Info' = "[Info]"; "Tag" = "[Tag]"; "Yell" = "[Yell]"; "Help" = "[Help]"; "Note" = "[Note]"; "Verb" = "[Verb]"; "Error" = "[Error]"; }
  Inln = @{ "Red" = "-NoNewline -ForegroundColor Red" }
  Nwlm = @{ "Red" = "$ForegroundColor Red" }
}

Write-Host -Object "test"


Write-Host $string $Run.Nwlm.Red

$Run.Alrt.Info
