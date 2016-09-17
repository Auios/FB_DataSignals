'drawSignals.bas

'Define colors
'could have used #define but whatever.
const sz = 32
const white = rgb(255,255,255)
const gray = rgb(80,80,80)
const red = rgb(255,0,0)
const green = rgb(0,255,0)
const blue = rgb(0,0,255)

declare sub drawSignal_NRZL(x as integer, y as integer, letter as string)
declare sub drawSignal_NRZI(x as integer, y as integer, letter as string)
declare sub drawSignal_Manchester(x as integer, y as integer, letter as string)
declare sub drawSignal_DifferentialManchester(x as integer, y as integer, letter as string)
declare sub drawSignal_BipolarAMI(x as integer, y as integer, letter as string)

'Usage example:
'   drawSignal_NRZL(30,50,"C")

sub drawSignal_NRZL(x as integer, y as integer, letter as string)
    if(len(letter) = 0) then
        print "Error"
        exit sub
    end if
    
    dim as string binLet
    dim as integer signal, preSignal
    
    letter = left(letter,1)
    binLet = bin(asc(letter))
    
    while(len(binLet) < 8)
        binLet = "0" + binLet
    wend
    
    'Middle horz line
    line(x, y+sz)-(x+sz*8, y+sz),gray
    
    'Draw letter
    draw string(x+sz*8+12, y+12),letter
    
    'Draw numbers and vert lines
    for i as integer = 0 to 7
        draw string(x+sz*i+12,y+12),mid(binLet,i+1,1)
        line(x+(sz*i),y)-(x+(sz*i),y+sz*2),gray
    next i
    
    'Outline box
    line(x, y)-(x+sz*8, y+sz*2),gray,b
    
    for i as integer = 0 to 7
        'Check last signal
        signal = val(mid(binLet,i+1,1))
        if(preSignal <> signal) then
            preSignal = signal
            line(x+sz*i, y+sz+sz*0.25)-(x+sz*i, y+sz+sz*0.75)
        end if
        
        'Horz signal lines
        if(signal) then
            'Low
            line(x+sz*i, y+sz*1.75)-(x+sz*(i+1), y+sz*1.75)
        else
            'High
            line(x+sz*i, y+sz*1.25)-(x+sz*(i+1), y+sz*1.25)
        end if
    next i
end sub

sub drawSignal_NRZI(x as integer, y as integer, letter as string)
    if(len(letter) = 0) then
        print "Error"
        exit sub
    end if
    
    dim as string binLet
    dim as integer signal, preSignal
    dim as boolean change = false, curSignal
    
    letter = left(letter,1)
    binLet = bin(asc(letter))
    
    while(len(binLet) < 8)
        binLet = "0" + binLet
    wend
    
    'Middle horz line
    line(x, y+sz)-(x+sz*8, y+sz),gray
    
    'Draw letter
    draw string(x+sz*8+12, y+12),letter
    
    'Draw numbers and vert lines
    for i as integer = 0 to 7
        draw string(x+sz*i+12,y+12),mid(binLet,i+1,1)
        line(x+(sz*i),y)-(x+(sz*i),y+sz*2),gray
    next i
    
    'Outline box
    line(x, y)-(x+sz*8, y+sz*2),gray,b
    
    for i as integer = 0 to 7
        signal = val(mid(binLet,i+1,1))
        if(signal) then change = true
        
        if(change) then
            change = false
            
            if(curSignal) then
                curSignal = false
            else
                cursignal = true
            end if
            
            line(x+sz*i, y+sz+sz*0.25)-(x+sz*i, y+sz+sz*0.75)
        end if
        
        'Horz signal lines
        if(curSignal) then
            'High
            line(x+sz*i, y+sz*1.25)-(x+sz*(i+1), y+sz*1.25)
        else
            'Low
            line(x+sz*i, y+sz*1.75)-(x+sz*(i+1), y+sz*1.75)
        end if
    next i
end sub

sub drawSignal_Manchester(x as integer, y as integer, letter as string)
    if(len(letter) = 0) then
        print "Error"
        exit sub
    end if
    
    dim as string binLet
    dim as integer signal, preSignal
    dim as boolean change = false, curSignal
    
    letter = left(letter,1)
    binLet = bin(asc(letter))
    
    while(len(binLet) < 8)
        binLet = "0" + binLet
    wend
    
    'Middle horz line
    line(x, y+sz)-(x+sz*8, y+sz),gray
    
    'Draw letter
    draw string(x+sz*8+12, y+12),letter
    
    'Draw numbers and vert lines
    for i as integer = 0 to 7
        draw string(x+sz*i+12,y+12),mid(binLet,i+1,1)
        line(x+(sz*i),y)-(x+(sz*i),y+sz*2),gray
    next i
    
    'Outline box
    line(x, y)-(x+sz*8, y+sz*2),gray,b
    
    for i as integer = 0 to 7
        signal = val(mid(binLet,i+1,1))
        
        if(preSignal = signal) then
            line(x+sz*i, y+sz+sz*0.25)-(x+sz*i, y+sz+sz*0.75)
        end if
        preSignal = signal
        
        if(signal) then
            'High
            line(x+sz*i, y+sz+sz*0.75)-(x+sz*i+sz/2, y+sz+sz*0.75)'Left
            line(x+sz*i+sz/2, y+sz+sz*0.25)-(x+sz*i+sz/2, y+sz+sz*0.75)'Middle
            line(x+sz*i+sz/2, y+sz+sz*0.25)-(x+sz*i+sz, y+sz+sz*0.25)'Right
        else
            'Low
            line(x+sz*i, y+sz+sz*0.25)-(x+sz*i+sz/2, y+sz+sz*0.25)'Left
            line(x+sz*i+sz/2, y+sz+sz*0.25)-(x+sz*i+sz/2, y+sz+sz*0.75)'Middle
            line(x+sz*i+sz/2, y+sz+sz*0.75)-(x+sz*i+sz, y+sz+sz*0.75)'Right
        end if
    next i
end sub

sub drawSignal_DifferentialManchester(x as integer, y as integer, letter as string)
    if(len(letter) = 0) then
        print "Error"
        exit sub
    end if
    
    dim as string binLet
    dim as integer signal, preSignal
    dim as boolean change = false, curSignal
    
    letter = left(letter,1)
    binLet = bin(asc(letter))
    
    while(len(binLet) < 8)
        binLet = "0" + binLet
    wend
    
    'Middle horz line
    line(x, y+sz)-(x+sz*8, y+sz),gray
    
    'Draw letter
    draw string(x+sz*8+12, y+12),letter
    
    'Draw numbers and vert lines
    for i as integer = 0 to 7
        draw string(x+sz*i+12,y+12),mid(binLet,i+1,1)
        line(x+(sz*i),y)-(x+(sz*i),y+sz*2),gray
    next i
    
    'Outline box
    line(x, y)-(x+sz*8, y+sz*2),gray,b
    
    for i as integer = 0 to 7
        signal = val(mid(binLet,i+1,1))
        if(signal) then change = true
        
        if(change) then
            change = false
            
            if(curSignal) then
                curSignal = false
            else
                cursignal = true
            end if
        else
            line(x+sz*i, y+sz+sz*0.25)-(x+sz*i, y+sz+sz*0.75)
        end if
        
        if(curSignal) then
            'Right
            line(x+sz*i, y+sz+sz*0.75)-(x+sz*i+sz/2, y+sz+sz*0.75)'Left
            line(x+sz*i+sz/2, y+sz+sz*0.25)-(x+sz*i+sz/2, y+sz+sz*0.75)'Middle
            line(x+sz*i+sz/2, y+sz+sz*0.25)-(x+sz*i+sz, y+sz+sz*0.25)'Right
        else
            'Left
            line(x+sz*i, y+sz+sz*0.25)-(x+sz*i+sz/2, y+sz+sz*0.25)'Left
            line(x+sz*i+sz/2, y+sz+sz*0.25)-(x+sz*i+sz/2, y+sz+sz*0.75)'Middle
            line(x+sz*i+sz/2, y+sz+sz*0.75)-(x+sz*i+sz, y+sz+sz*0.75)'Right
            
        end if
    next i
end sub

sub drawSignal_BipolarAMI(x as integer, y as integer, letter as string)
    if(len(letter) = 0) then
        print "Error"
        exit sub
    end if
    
    dim as string binLet
    dim as integer signal, preSignal
    dim as boolean change = true, curSignal
    
    letter = left(letter,1)
    binLet = bin(asc(letter))
    
    while(len(binLet) < 8)
        binLet = "0" + binLet
    wend
    
    'Middle horz line
    line(x, y+sz)-(x+sz*8, y+sz),gray
    
    'Draw letter
    draw string(x+sz*8+12, y+12),letter
    
    'Draw numbers and vert lines
    for i as integer = 0 to 7
        draw string(x+sz*i+12,y+12),mid(binLet,i+1,1)
        line(x+(sz*i),y)-(x+(sz*i),y+sz*2),gray
    next i
    
    'Outline box
    line(x, y)-(x+sz*8, y+sz*2),gray,b
    
    for i as integer = 0 to 7
        preSignal = signal
        signal = val(mid(binLet,i+1,1))
        
        if(signal) then
            'High - Bipolar
            if(change) then
                'High
                change = false
                line(x+sz*i, y+sz*1.25)-(x+sz*(i+1), y+sz*1.25)
            else
                'Low
                change = true
                line(x+sz*i, y+sz*1.75)-(x+sz*(i+1), y+sz*1.75)
            end if
            
            if(preSignal) then
                line(x+sz*i, y+sz*1.25)-(x+sz*i, y+sz*1.75)
            else
                if(change) then
                    line(x+sz*i, y+sz*1.5)-(x+sz*i, y+sz*1.75)
                else
                    line(x+sz*i, y+sz*1.25)-(x+sz*i, y+sz*1.5)
                end if
            end if
        else
            'Low - Middle
            line(x+sz*i, y+sz*1.5)-(x+sz*(i+1), y+sz*1.5)
            if(preSignal) then
                if(change) then
                    line(x+sz*i, y+sz*1.5)-(x+sz*i, y+sz*1.75)
                else
                    line(x+sz*i, y+sz*1.5)-(x+sz*i, y+sz*1.25)
                end if
            end if
        end if
    next i
end sub
