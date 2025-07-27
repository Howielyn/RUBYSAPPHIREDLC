INCLUDE "../macros.asm"
INCLUDE "../constants/items.asm"
INCLUDE "../constants/scriptcommandsseedfix2.asm"

	Mystery_Event

	db CHECKSUM_CRC
	dd 0 ; checksum placeholder
	GBAPTR DataStart
	GBAPTR DataEnd

DataStart:
	db IN_GAME_SCRIPT
	db 1,4 ; Elms lab
	db 1   ; science boy
	GBAPTR NormanScriptStart
	GBAPTR NormanScriptEnd

	db PRELOAD_SCRIPT
	GBAPTR PreloadScriptStart

	db END_OF_CHUNKS

PreloadScriptStart:
	setvirtualaddress PreloadScriptStart

	callasm $0201C045
	
	virtualloadpointer GoSeeYourFather
	
	setbyte 2
	
	dw $0000
	
	end

	WriteFlashMemory
	
	
	GLITCHMOVECALLBACK 
	SEEDRNGANDFIXSAVE
	VBLANKINTR_CHECKSAVE 
	dd $0
	dd $0
	dd $0
	dd $0

GoSeeYourFather:
	Text_DE "Lauf und besuche deinen Vater in der\n"
	Text_DE "ARENA von BLÜTENBURG CITY.@"

	Text_EN "Talk to one of Prof. Elms aides\n"
	Text_EN "to UPGRADE your Emerald!@"


	end





NormanScriptStart:
	setvirtualaddress NormanScriptStart
	
	lockall
	faceplayer

	writebytetoaddr $1E, $2024744
	writebytetoaddr $20, $2024745
	writebytetoaddr $01, $2024746
	writebytetoaddr $49, $2024747
	writebytetoaddr $01, $2024748
	writebytetoaddr $4B, $2024749
	writebytetoaddr $18, $202474A
	writebytetoaddr $47, $202474B
	writebytetoaddr $BC, $202474C
	writebytetoaddr $AB, $202474D
	writebytetoaddr $03, $202474E
	writebytetoaddr $02, $202474F
	writebytetoaddr $4D, $2024750
	writebytetoaddr $31, $2024751
	writebytetoaddr $15, $2024752
	writebytetoaddr $08, $2024753
	
	callasm $02024745 ;readflash
	
	pause $10
	
	comparefarbytetobyte $03002720, $01
	virtualgotoif 1, VblankIntr_Off
	
VblankIntr_On:	
	virtualmsgbox IsOff
	waitmsg
	db $6E, $17, $8
	release
	lockall
	compare LASTRESULT, 0
	virtualgotoif 1, Changemind	
	
	sound $4
	waitfanfare
	writebytetoaddr $FF, $2024744
	writebytetoaddr $B4, $2024745
	writebytetoaddr $06, $2024746
	writebytetoaddr $48, $2024747
	writebytetoaddr $04, $2024748
	writebytetoaddr $49, $2024749
	writebytetoaddr $06, $202474A
	writebytetoaddr $4A, $202474B
	writebytetoaddr $0B, $202474C
	writebytetoaddr $DF, $202474D
	writebytetoaddr $02, $202474E
	writebytetoaddr $48, $202474F
	writebytetoaddr $02, $2024750
	writebytetoaddr $49, $2024751
	writebytetoaddr $01, $2024752
	writebytetoaddr $60, $2024753
	writebytetoaddr $FF, $2024754
	writebytetoaddr $BC, $2024755
	writebytetoaddr $70, $2024756
	writebytetoaddr $47, $2024757
	writebytetoaddr $20, $2024758
	writebytetoaddr $27, $2024759
	writebytetoaddr $00, $202475A
	writebytetoaddr $03, $202475B
	writebytetoaddr $01, $202475C
	writebytetoaddr $B2, $202475D
	writebytetoaddr $01, $202475E
	writebytetoaddr $02, $202475F
	writebytetoaddr $8C, $2024760
	writebytetoaddr $AC, $2024761
	writebytetoaddr $03, $2024762
	writebytetoaddr $02, $2024763
	writebytetoaddr $A8, $2024764
	writebytetoaddr $00, $2024765
	writebytetoaddr $00, $2024766
	writebytetoaddr $04, $2024767

	
	callasm $02024745 ;initialsetup.txt

	virtualmsgbox TurnedOn
	waitmsg
	waitkeypress
	release

	end
	
VblankIntr_Off:
	copybyte $020375e2, $203AF1C
	copybyte $020375e3, $203AF1D
	
	buffernumber $00, $8005
	virtualmsgbox CurrentSeed
	waitmsg
	db $6E, $17, $8
	release
	lockall
	compare LASTRESULT, 0
	virtualgotoif 1, Changemind	
	
	sound $3
	waitfanfare
	
	writebytetoaddr $ff, $2024744
	writebytetoaddr $b4, $2024745
	writebytetoaddr $02, $2024746
	writebytetoaddr $48, $2024747
	writebytetoaddr $02, $2024748
	writebytetoaddr $49, $2024749
	writebytetoaddr $01, $202474A
	writebytetoaddr $60, $202474B
	writebytetoaddr $ff, $202474C
	writebytetoaddr $bc, $202474D
	writebytetoaddr $70, $202474E
	writebytetoaddr $47, $202474F
	writebytetoaddr $20, $2024750
	writebytetoaddr $27, $2024751
	writebytetoaddr $00, $2024752
	writebytetoaddr $03, $2024753
	writebytetoaddr $39, $2024754
	writebytetoaddr $07, $2024755
	writebytetoaddr $00, $2024756
	writebytetoaddr $08, $2024757
	
	callasm $02024745 ;resetpr.txt
	
	virtualmsgbox TurnedOn
	waitmsg
	waitkeypress
	release
	
	pause $10
	
	writebytetoaddr $0B, $02037356
	
	end

Changemind:
	virtualmsgbox Change
	waitmsg
	waitkeypress
	release
	end

IsOff:
	Text_EN "Would you like UPGRADE your Emerald\n"
	Text_EN "experience?@"
TurnedOn:
	Text_EN "Done! Now you have to save the\n"
	Text_EN "game for it to stick!@"
	
Change:
	Text_EN "If you change your mind, I’m here!@"

CurrentSeed:
	Text_EN "Your current Initial Seed is\n"
	Text_EN "\v2! Would you like me to turn the\l"
	Text_EN "upgrade off?@" 


NormanScriptEnd:






DataEnd:
	EOF
  	