@ECHO ON
DEL "compile.love"
for /D %%A in (*) do "C:\Program Files\7-Zip\7z.exe" a -tzip -xr!RUN.bat -xr!compile.zip "%compile.zip"  "%compile"
REN "compile.zip" "compile.love"
compile.love