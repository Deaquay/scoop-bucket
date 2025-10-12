if (!$env:SCOOP_HOME) { $env:SCOOP_HOME = Resolve-Path (scoop prefix scoop) }
. "$env:SCOOP_HOME\test\Import-Bucket-Tests.ps1"

# Override the file discovery to only include bucket files
$TestFiles = @(
    "bucket\*.json"
)

# Override the style tests to only check our bucket files
Describe "Style constraints for bucket files" {
    It "files do not contain leading UTF-8 BOM" {
        $files = Get-ChildItem -Path $TestFiles -Recurse | Where-Object { $_.Extension -in @('.ps1', '.psm1', '.psd1', '.json', '.md', '.txt', '.yml', '.yaml') }
        $bomFiles = @()
        foreach ($file in $files) {
            $bytes = [System.IO.File]::ReadAllBytes($file.FullName)
            if ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF) {
                $bomFiles += $file.FullName
            }
        }
        $bomFiles | Should -BeNullOrEmpty -Because "The following files have utf-8 BOM: $($bomFiles -join ', ')"
    }

    It "files end with a newline" {
        $files = Get-ChildItem -Path $TestFiles -Recurse | Where-Object { $_.Extension -in @('.ps1', '.psm1', '.psd1', '.json', '.md', '.txt', '.yml', '.yaml') }
        $noNewlineFiles = @()
        foreach ($file in $files) {
            $content = Get-Content $file.FullName -Raw
            if ($content -and !$content.EndsWith("`n") -and !$content.EndsWith("`r`n")) {
                $noNewlineFiles += $file.FullName
            }
        }
        $noNewlineFiles | Should -BeNullOrEmpty -Because "The following files do not end with a newline: $($noNewlineFiles -join ', ')"
    }

    It "file newlines are CRLF" {
        $files = Get-ChildItem -Path $TestFiles -Recurse | Where-Object { $_.Extension -in @('.ps1', '.psm1', '.psd1', '.json', '.md', '.txt', '.yml', '.yaml') }
        $nonCrlfFiles = @()
        foreach ($file in $files) {
            $content = Get-Content $file.FullName -Raw
            if ($content -and $content.Contains("`n") -and !$content.Contains("`r`n")) {
                $nonCrlfFiles += $file.FullName
            }
        }
        $nonCrlfFiles | Should -BeNullOrEmpty -Because "The following files have non-CRLF line endings: $($nonCrlfFiles -join ', ')"
    }

    It "files have no lines containing trailing whitespace" {
        $files = Get-ChildItem -Path $TestFiles -Recurse | Where-Object { $_.Extension -in @('.ps1', '.psm1', '.psd1', '.json', '.md', '.txt', '.yml', '.yaml') }
        $trailingWhitespaceFiles = @()
        foreach ($file in $files) {
            $lines = Get-Content $file.FullName
            for ($i = 0; $i -lt $lines.Length; $i++) {
                if ($lines[$i] -match '\s+$') {
                    $trailingWhitespaceFiles += "$($file.FullName), Line: $($i + 1)"
                }
            }
        }
        $trailingWhitespaceFiles | Should -BeNullOrEmpty -Because "The following $($trailingWhitespaceFiles.Count) lines contain trailing whitespace: $($trailingWhitespaceFiles -join ', ')"
    }

    It "any leading whitespace consists only of spaces (excepting makefiles)" {
        $files = Get-ChildItem -Path $TestFiles -Recurse | Where-Object { $_.Extension -in @('.ps1', '.psm1', '.psd1', '.json', '.md', '.txt', '.yml', '.yaml') -and $_.Name -ne 'Makefile' }
        $tabFiles = @()
        foreach ($file in $files) {
            $lines = Get-Content $file.FullName
            for ($i = 0; $i -lt $lines.Length; $i++) {
                if ($lines[$i] -match '^\t') {
                    $tabFiles += "$($file.FullName), Line: $($i + 1)"
                }
            }
        }
        $tabFiles | Should -BeNullOrEmpty -Because "The following $($tabFiles.Count) lines contain TABs within leading whitespace: $($tabFiles -join ', ')"
    }
}
