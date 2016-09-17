#include "fbgfx.bi"
#include "AuLib.bi"

#include "drawSignals.bas"

using fb, auios

randomize timer()

'Create window using AuLib
dim shared as AuWindow wnd
wnd.set()
wnd.create()

'Ascii character to use
dim as string character = chr(139)
'dim as ubyte character = chr(139)
'dim as string character = "a"

'Used for positioning the tables on the window
dim as integer cnt = 0, sep = 32

drawSignal_NRZL(32*1, 64*cnt+sep*(cnt+1), character):cnt+=1
drawSignal_NRZI(32*1, 64*cnt+sep*(cnt+1), character):cnt+=1
drawSignal_Manchester(32*1, 64*cnt+sep*(cnt+1), character):cnt+=1
drawSignal_DifferentialManchester(32*1, 64*cnt+sep*(cnt+1), character):cnt+=1
drawSignal_BipolarAMI(32*1, 64*cnt+sep*(cnt+1), character):cnt+=1


sleep()
end(1)