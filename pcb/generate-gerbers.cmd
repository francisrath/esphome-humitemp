set out=humitemp-production-panel-gerbers
set panel=humitemp-production-panel


@echo Creating panel
@kikit panelize ^
    --layout "grid; rows: 5; cols: 2; space: 2mm" ^
    --tabs annotation ^
    --cuts "mousebites; drill: 0.4mm; spacing: 0.6mm; offset: -0.2mm; prolong: 0.5mm" ^
    --framing "railstb; width: 5mm; space: 3mm;" ^
    --tooling "3hole; hoffset: 2.5mm; voffset: 2.5mm; size: 1.5mm" ^
    --fiducials "3fid; hoffset: 5mm; voffset: 2.5mm; coppersize: 2mm; opening: 1mm;" ^
    --text "simple; text: esphome humitemp; anchor: mt; voffset: 2.5mm; hjustify: center; vjustify: center;" ^
    --text2 "simple; text: JLCJLCJLCJLC; anchor: mb; voffset: -2.5mm; hjustify: center; vjustify: center;" ^
    --post "millradius: 1mm" ^
    esphome-humitemp.kicad_pcb %panel%.kicad_pcb

@if not exist %out% (mkdir %out%)
@del %out%\*
@echo Exporting Gerbers
@kicad-cli pcb export gerbers -o %out% %panel%.kicad_pcb
@del %out%\%panel%-?_fab.gbr %out%\%panel%-?_courtyard.gbr
@echo Exporting Excellon drill files
@kicad-cli pcb export drill -o %out% %panel%.kicad_pcb
@echo Compressing Gerbers
@zip -q %out%.zip %out%\*
@echo %out%.zip ready for upload