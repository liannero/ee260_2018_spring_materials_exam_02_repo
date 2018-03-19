@echo off
for /d %%i in (*) do (
cd "%%i"
vivado -mode batch -source vivado_test.tcl
pause
cd ..
)

