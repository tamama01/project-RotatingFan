.model small
.386
.data
;============== fan initial ================
	f1	db	32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, "$"
	f2	db	32, 196, 32, 196, 32, 111, 32, 196, 32, 196, 32, "$"
	fi	db	32, 32, 32, 32, 32, 111, 32, 32, 32, 32, 32, "$"
	fo	db	32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, "$"
;============== fan move 1 =================
	f3	db	32, 32, 32, 92, 32, 32, 32, 32, 32, 32, 32,"$"
	f4	db	32, 32, 32, 32, 92, 32, 32, 32, 32, 32, 32,"$"
	f5	db	32, 32, 32, 32, 32, 32, 92, 32, 32, 32, 32,"$"
	f6	db	32, 32, 32, 32, 32, 32, 32, 92, 32, 32, 32,"$"
;============= fan move 2 ===================
	f7	db	32, 32, 32, 32, 32, 124, 32, 32, 32, 32, 32,"$"
;============= fan move 3 ===================
	fa	db	32, 32, 32, 32, 32, 32, 32, 47, 32, 32, 32,"$"
	fb	db	32, 32, 32, 32, 32, 32, 47, 32, 32, 32, 32,"$"
	fc	db	32, 32, 32, 32, 47, 32, 32, 32, 32, 32, 32,"$"
	fd	db	32, 32, 32, 47, 32, 32, 32, 32, 32, 32, 32,"$"
;===========================================
;============== Status =====================
	tempStat	db		"The Surrounding Temperature:$"	; 30
	speedStat	db		"Fan Blade's Speed          :$"
	pivotStat	db		"Pivot Status               :$"
	fanTimeMs	db		"Fan timer (in seconds)     :$"
	titleMs1	db		"===============================",10,13,"         New-Gen-Fan",10,13,"===============================$"
;===========================================
;============== Selection ==================
	selectTempMs	db		"Enter your surrounding temperature: $"	;36
	fanTime			db		"Select duration of the fan (in seconds): $"
	durList			db		"1. 20 Seconds",10,13," 2. 40 Seconds",10,13," 3. 60 Seconds$"
	durList1		db		"20 Seconds$"
	durList2		db		"40 Seconds$"
	durList3		db		"60 Seconds$"
	speed1Ms		db		"1200 RPM$"
	speed2Ms		db		"1300 RPM$"
	speed3Ms		db		"1450 RPM$"
	pivotAsk		db		"Pivot the fan? (y/n) :$"
	pivotTrue		db		"Pivot$"
	pivotFalse		db		"Not Pivot$"
	xwork			db 		"The temperature you entered is unreasonable for the device to operate!", 13,10," Please enter temperature between 0 to 40. $"
;===========================================
	pressAnyMs		db		"Press anything to continue...$"
	tryAgainMs		db		"Do you wish to use the fan again? (y/n):$"
	
	selectTemp		db		4,3	dup(0)
	temp1			db		4	dup(0)
	time			db		4	dup(0)
	pivotData		db		4	dup(0)
;===========================================

.code
start:
	mov	ax, @data
	mov ds, ax
	
	mov	ah,	0h
	mov al, 03h		; set vidoe mode
	int 10h
	
fanStatus:
	; set cursor
	mov	ah, 02h
	mov	bh,	0		; page number
	mov	dh,	0		; row
	mov	dl,	0		; column
	int 10h
	
	lea dx, titleMs1
	mov ah, 09h
	int 21h

	; set cursor
	mov	ah, 02h
	mov	bh,	0		; page number
	mov	dh,	4		; row
	mov	dl,	1		; column
	int 10h
	
	lea dx, tempStat
	mov	ah,	09h
	int	21h
	
	; set cursor
	mov	ah, 02h
	mov	bh,	0		; page number
	mov	dh,	5		; row
	mov	dl,	1		; column
	int 10h
	
	lea dx, speedStat
	mov	ah,	09h
	int	21h

	; set cursor
	mov	ah, 02h
	mov	bh,	0		; page number
	mov	dh,	6		; row
	mov	dl,	1		; column
	int 10h
	
	lea dx, pivotStat
	mov	ah,	09h
	int	21h
	
	; set cursor
	mov	ah, 02h
	mov	bh,	0		; page number
	mov	dh,	7		; row
	mov	dl,	1		; column
	int 10h
	
	lea dx, fanTimeMs
	mov	ah,	09h
	int	21h

selection1:
	; set cursor
	mov	ah, 02h
	mov	bh,	0		; page number
	mov	dh,	10		; row
	mov	dl,	1		; column
	int 10h
	
	lea dx, selectTempMs
	mov	ah,	09h
	int	21h
	
	; set cursor
	mov	ah, 02h
	mov	bh,	0		; page number
	mov	dh,	10		; row
	mov	dl,	36		; column
	int 10h
	
	mov ah, 01h
	int 21h
	cmp al, 30h
	jbe retInput
	mov temp1[2], al
	
	mov	ah, 01h
	int 21h
	cmp al, 30h
	jbe retInput
	mov	temp1[3], al
	
	; set cursor
	mov	ah, 02h
	mov	bh,	0		; page number
	mov	dh,	4		; row
	mov	dl,	30		; column
	int 10h
	
	mov ah, 02h
	mov dl, temp1[2]
	int 21h

	; set cursor
	mov	ah, 02h
	mov	bh,	0		; page number
	mov	dh,	4		; row
	mov	dl,	31		; column
	int 10h
	
	mov ah, 02h
	mov dl, temp1[3]
	int 21h
	
	lea bx,	temp1
	mov ch, [bx+2]
	mov cl, [bx+3]
	
	jmp selection2

selection2:
	; set cursor
	mov	ah, 02h
	mov	bh,	0		; page number
	mov	dh,	12		; row
	mov	dl,	1		; column
	int 10h
	
	lea dx, durList
	mov	ah,	09h
	int 21h
	
	; set cursor
	mov	ah, 02h
	mov	bh,	0		; page number
	mov	dh,	16		; row
	mov	dl,	1		; column
	int 10h
	
	lea dx, fanTime
	mov	ah,	09h
	int 21h
	
	mov ah, 01h
	int 21h
	
	mov time[2], al
	
	; set cursor
	mov	ah, 02h
	mov	bh,	0		; page number
	mov	dh,	18		; row
	mov	dl,	1		; column
	int 10h
	
	lea dx, pivotAsk
	mov	ah,	09h
	int 21h
	
	mov ah, 01h
	int 21h
	
	mov pivotData[2], al
	
	cmp pivotData[2], 121  ; check if input is 'y'
	jz cmpTime
						
	cmp pivotData[2], 110  ; check if input is 'n'
	jz cmpTime	
	
	jmp selection2
	
cmpTime:
	cmp time[2], 31h
	je	time1
	cmp	time[2], 32h
	je 	time2
	cmp	time[2], 33h
	je 	time3
	jmp	selection2

	retInput:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	20		; row
		mov	dl,	1		; column
		int 10h
		
		lea dx, xwork
		mov	ah,	09h
		int 21h
		jmp selection1
	
time1:
	cmpTemp1:
		cmp	cx,'15'
		jle retInput
	
		cmp cx,'25' ;is temp 25?
		jbe coldTime1    ;jump if below 25 (<25)
		
		cmp cx,'35'
		jle medTime1     ;jump to med if less (<33)

		cmp cx,'49'
		jle hotTime1    ;jump to hots if less or equal(<=35)	
		
		cmp cx,'50'
		jae retInput
		
	coldTime1:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	30		; column
		int 10h
		
		lea dx, durList1
		mov	ah,	09h
		int 21h		
		
		cmpPivot1:
			cmp pivotData[2], 121  ; check if input is 'y'
			jz pivotDisTrue1
			cmp pivotData[2], 110  ; check if input is 'n'
			jz 	pivotDisFalse1
			pivotDisTrue1:
				; set cursor
				mov	ah, 02h
				mov	bh,	0		; page number
				mov	dh,	6		; row
				mov	dl,	30		; column
				int 10h
				
				lea dx, pivotTrue
				mov	ah,	09h
				int	21h
				jmp pivotColdsTime1
			pivotDisFalse1:
				mov	ah, 02h
				mov	bh,	0		; page number
				mov	dh,	6		; row
				mov	dl,	30		; column
				int 10h
				
				lea dx, pivotFalse
				mov	ah,	09h
				int	21h
				jmp nopivotColdstime1
			pivotColdsTime1:
				add di, 12				; cold + pivot + 20 seconds
				jmp coldsPivot
			nopivotColdstime1:
				add di, 30				; cold + 20 seconds
				jmp colds

	medTime1:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	30		; column
		int 10h
		
		lea dx, durList1
		mov	ah,	09h
		int 21h
		
		cmpPivot2:
			cmp pivotData[2], 121  ; check if input is 'y'
			jz pivotDisTrue2
			cmp pivotData[2], 110  ; check if input is 'n'
			jz 	pivotDisFalse2
			pivotDisTrue2:
				; set cursor
				mov	ah, 02h
				mov	bh,	0		; page number
				mov	dh,	6		; row
				mov	dl,	30		; column
				int 10h
				
				lea dx, pivotTrue
				mov	ah,	09h
				int	21h
				jmp pivotMedTime1
			pivotDisFalse2:
				mov	ah, 02h
				mov	bh,	0		; page number
				mov	dh,	6		; row
				mov	dl,	30		; column
				int 10h
				
				lea dx, pivotFalse
				mov	ah,	09h
				int	21h
				jmp nopivotMedtime1
			pivotMedTime1:
				add di, 19				; med + pivot + 20 seconds
				jmp medPivot
			nopivotMedtime1:
				add di, 17				; med + 20 seconds
				jmp med		

	hotTime1:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	30		; column
		int 10h
		
		lea dx, durList1
		mov	ah,	09h
		int 21h

		cmpPivot3:
			cmp pivotData[2], 121  ; check if input is 'y'
			jz pivotDisTrue3
			cmp pivotData[2], 110  ; check if input is 'n'
			jz 	pivotDisFalse3
			pivotDisTrue3:
				; set cursor
				mov	ah, 02h
				mov	bh,	0		; page number
				mov	dh,	6		; row
				mov	dl,	30		; column
				int 10h
				
				lea dx, pivotTrue
				mov	ah,	09h
				int	21h
				jmp pivotHotsTime1
			pivotDisFalse3:
				mov	ah, 02h
				mov	bh,	0		; page number
				mov	dh,	6		; row
				mov	dl,	30		; column
				int 10h
				
				lea dx, pivotFalse
				mov	ah,	09h
				int	21h
				jmp nopivotHotstime1
			pivotHotsTime1:
				add di, 35				; cold + pivot + 20 seconds
				jmp hotsPivot
			nopivotHotstime1:
				add di, 52				; cold + 20 seconds
				jmp hots

time2:
	cmpTemp2:
		cmp cx,'25' ;is temp 25?
		jb coldTime2    ;jump if below 25 (<25)
		
		cmp cx,'33'
		jl medTime2     ;jump to med if less (<33)

		cmp cx,'40'
		jle hotTime2    ;jump to hots if less or equal(<=35)	
		
		cmp cx,'50'
		jae retInput
	coldTime2:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	30		; column
		int 10h
		
		lea dx, durList2
		mov	ah,	09h
		int 21h

		cmpPivot4:
			cmp pivotData[2], 121  ; check if input is 'y'
			jz pivotDisTrue4
			cmp pivotData[2], 110  ; check if input is 'n'
			jz 	pivotDisFalse4
			pivotDisTrue4:
				; set cursor
				mov	ah, 02h
				mov	bh,	0		; page number
				mov	dh,	6		; row
				mov	dl,	30		; column
				int 10h
				
				lea dx, pivotTrue
				mov	ah,	09h
				int	21h
				jmp pivotColdsTime2
			pivotDisFalse4:
				mov	ah, 02h
				mov	bh,	0		; page number
				mov	dh,	6		; row
				mov	dl,	30		; column
				int 10h
				
				lea dx, pivotFalse
				mov	ah,	09h
				int	21h
				jmp nopivotColdstime2
			pivotColdsTime2:
				add di, 22				; cold + pivot + 40 seconds
				jmp coldsPivot
			nopivotColdstime2:
				add di, 33			; cold + 40 seconds
				jmp colds

	medTime2:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	30		; column
		int 10h
		
		lea dx, durList2
		mov	ah,	09h
		int 21h

		cmpPivot5:
			cmp pivotData[2], 121  ; check if input is 'y'
			jz pivotDisTrue5
			cmp pivotData[2], 110  ; check if input is 'n'
			jz 	pivotDisFalse5
			pivotDisTrue5:
				; set cursor
				mov	ah, 02h
				mov	bh,	0		; page number
				mov	dh,	6		; row
				mov	dl,	30		; column
				int 10h
				
				lea dx, pivotTrue
				mov	ah,	09h
				int	21h
				jmp pivotMedTime2
			pivotDisFalse5:
				mov	ah, 02h
				mov	bh,	0		; page number
				mov	dh,	6		; row
				mov	dl,	30		; column
				int 10h
				
				lea dx, pivotFalse
				mov	ah,	09h
				int	21h
				jmp nopivotMedtime2
			pivotMedTime2:
				add di, 36				; med + pivot + 20 seconds
				jmp medPivot
			nopivotMedtime2:
				add di, 53				; med + 20 seconds
				jmp med	

	hotTime2:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	30		; column
		int 10h
		
		lea dx, durList2
		mov	ah,	09h
		int 21h

		cmpPivot6:
			cmp pivotData[2], 121  ; check if input is 'y'
			jz pivotDisTrue6
			cmp pivotData[2], 110  ; check if input is 'n'
			jz 	pivotDisFalse6
			pivotDisTrue6:
				; set cursor
				mov	ah, 02h
				mov	bh,	0		; page number
				mov	dh,	6		; row
				mov	dl,	30		; column
				int 10h
				
				lea dx, pivotTrue
				mov	ah,	09h
				int	21h
				jmp pivotHotsTime2
			pivotDisFalse6:
				mov	ah, 02h
				mov	bh,	0		; page number
				mov	dh,	6		; row
				mov	dl,	30		; column
				int 10h
				
				lea dx, pivotFalse
				mov	ah,	09h
				int	21h
				jmp nopivotHotstime2
			pivotHotsTime2:
				add di, 69				; hots + pivot + 20 seconds
				jmp hotsPivot
			nopivotHotstime2:
				add di, 102				; hots + 20 seconds
				jmp hots

time3:
	cmpTemp3:
		cmp cx,'25' ;is temp 25?
		jb coldTime3    ;jump if below 25 (<25)
		
		cmp cx,'33'
		jl medTime3	    ;jump to med if less (<33)

		cmp cx,'40'
		jle hotTime3    ;jump to hots if less or equal(<=35)	
		
		cmp cx,'50'
		jae retInput
	coldTime3:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	30		; column
		int 10h
		
		lea dx, durList3
		mov	ah,	09h
		int 21h

		cmpPivot7:
			cmp pivotData[2], 121  ; check if input is 'y'
			jz pivotDisTrue7
			cmp pivotData[2], 110  ; check if input is 'n'
			jz 	pivotDisFalse7
			pivotDisTrue7:
				; set cursor
				mov	ah, 02h
				mov	bh,	0		; page number
				mov	dh,	6		; row
				mov	dl,	30		; column
				int 10h
				
				lea dx, pivotTrue
				mov	ah,	09h
				int	21h
				jmp pivotColdsTime3
			pivotDisFalse7:
				mov	ah, 02h
				mov	bh,	0		; page number
				mov	dh,	6		; row
				mov	dl,	30		; column
				int 10h
				
				lea dx, pivotFalse
				mov	ah,	09h
				int	21h
				jmp nopivotColdstime3
			pivotColdsTime3:
				add di, 32				; cold + pivot + 20 seconds
				jmp coldsPivot
			nopivotColdstime3:
				add di, 48			; cold + 20 seconds
				jmp colds

	medTime3:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	30		; column
		int 10h
		
		lea dx, durList3
		mov	ah,	09h
		int 21h
		
		cmpPivot8:
			cmp pivotData[2], 121  ; check if input is 'y'
			jz pivotDisTrue8
			cmp pivotData[2], 110  ; check if input is 'n'
			jz 	pivotDisFalse8
			pivotDisTrue8:
				; set cursor
				mov	ah, 02h
				mov	bh,	0		; page number
				mov	dh,	6		; row
				mov	dl,	30		; column
				int 10h
				
				lea dx, pivotTrue
				mov	ah,	09h
				int	21h
				jmp pivotMedTime3
			pivotDisFalse8:
				mov	ah, 02h
				mov	bh,	0		; page number
				mov	dh,	6		; row
				mov	dl,	30		; column
				int 10h
				
				lea dx, pivotFalse
				mov	ah,	09h
				int	21h
				jmp nopivotMedtime3
			pivotMedTime3:
				add di, 53				; med + pivot + 20 seconds
				jmp medPivot
			nopivotMedtime3:
				add di, 79				; med + 20 seconds
				jmp med	
		
	hotTime3:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	30		; column
		int 10h
		
		lea dx, durList3
		mov	ah,	09h
		int 21h

		cmpPivot9:
			cmp pivotData[2], 121  ; check if input is 'y'
			jz pivotDisTrue9
			cmp pivotData[2], 110  ; check if input is 'n'
			jz 	pivotDisFalse9
			pivotDisTrue9:
				; set cursor
				mov	ah, 02h
				mov	bh,	0		; page number
				mov	dh,	6		; row
				mov	dl,	30		; column
				int 10h
				
				lea dx, pivotTrue
				mov	ah,	09h
				int	21h
				jmp pivotHotsTime3
			pivotDisFalse9:
				mov	ah, 02h
				mov	bh,	0		; page number
				mov	dh,	6		; row
				mov	dl,	30		; column
				int 10h
				
				lea dx, pivotFalse
				mov	ah,	09h
				int	21h
				jmp nopivotHotstime3
			pivotHotsTime3:
				add di, 102				; cold + pivot + 20 seconds
				jmp hotsPivot
			nopivotHotstime3:
				add di, 153				; cold + 20 seconds
				jmp hots

coldsPivot:
	; set cursor
	mov	ah, 02h
	mov	bh,	0		; page number
	mov	dh,	5		; row
	mov	dl,	30		; column
	int 10h
	
	lea dx, speed1Ms
	mov	ah, 09h
	int 21h
	call pivotspeed1
	
	mov	ah, 02h
	mov	bh,	0		; page number
	mov	dh,	19		; row
	mov	dl,	1		; column
	int 10h
	
	lea dx, pressAnyMs
	mov	ah,	09h
	int 21h
	
	mov ah, 01h
	int 21h
	jmp clearscreen
	
medPivot:
	; set cursor
	mov	ah, 02h
	mov	bh,	0		; page number
	mov	dh,	5		; row
	mov	dl,	30		; column
	int 10h
	
	lea dx, speed2Ms
	mov	ah, 09h
	int 21h
	call pivotspeed2
	
	mov	ah, 02h
	mov	bh,	0		; page number
	mov	dh,	19		; row
	mov	dl,	1		; column
	int 10h

	lea dx, pressAnyMs
	mov	ah,	09h
	int 21h

	mov ah, 01h
	int 21h
	jmp clearscreen

hotsPivot:
	; set cursor
	mov	ah, 02h
	mov	bh,	0		; page number
	mov	dh,	5		; row
	mov	dl,	30		; column
	int 10h
	
	lea dx, speed3Ms
	mov	ah, 09h
	int 21h
	call pivotspeed3
	
	mov	ah, 02h
	mov	bh,	0		; page number
	mov	dh,	19		; row
	mov	dl,	1		; column
	int 10h

	lea dx, pressAnyMs
	mov	ah,	09h
	int 21h

	mov ah, 01h
	int 21h
	jmp clearscreen

colds:
	; set cursor
	mov	ah, 02h
	mov	bh,	0		; page number
	mov	dh,	5		; row
	mov	dl,	30		; column
	int 10h
	
	lea dx, speed1Ms
	mov	ah, 09h
	int 21h
	call speed1
	
	mov	ah, 02h
	mov	bh,	0		; page number
	mov	dh,	19		; row
	mov	dl,	1		; column
	int 10h

	lea dx, pressAnyMs
	mov	ah,	09h
	int 21h

	mov ah, 01h
	int 21h
	jmp clearscreen
	
med:
	; set cursor
	mov	ah, 02h
	mov	bh,	0		; page number
	mov	dh,	5		; row
	mov	dl,	30		; column
	int 10h
	
	lea dx, speed2Ms
	mov	ah, 09h
	int 21h
	call speed2
	
	mov	ah, 02h
	mov	bh,	0		; page number
	mov	dh,	19		; row
	mov	dl,	1		; column
	int 10h

	lea dx, pressAnyMs
	mov	ah,	09h
	int 21h

	mov ah, 01h
	int 21h
	jmp clearscreen
	
hots:
	; set cursor
	mov	ah, 02h
	mov	bh,	0		; page number
	mov	dh,	5		; row
	mov	dl,	30		; column
	int 10h
	
	lea dx, speed3Ms
	mov	ah, 09h
	int 21h
	call speed3
	
	mov	ah, 02h
	mov	bh,	0		; page number
	mov	dh,	19		; row
	mov	dl,	1		; column
	int 10h

	lea dx, pressAnyMs
	mov	ah,	09h
	int 21h

	mov ah, 01h
	int 21h
	jmp clearscreen
	
speed1	proc
	fanRot1:
		dec di
		cmp	di,	0
		je return1
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	4		; row
		mov	dl,	50		; column
		int 10h
	
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f2
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	10		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		call delay1
		jmp fanRot2

	fanRot2:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f3
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f4
		mov ah, 09h
		int 21h

		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f5
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f6
		mov ah, 09h
		int 21h
		call delay1
		jmp fanRot3
		
	fanRot3:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h

		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h
		
		call delay1
		jmp fanRot4

	fanRot4:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, fa
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, fb
		mov ah, 09h
		int 21h

		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, fc
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, fd
		mov ah, 09h
		int 21h
		call delay1
		jmp fanRot1
	return1:
	ret
speed1	endp

speed2	proc
	fanRot11:
		dec di
		cmp	di,	0
		je return2
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	4		; row
		mov	dl,	50		; column
		int 10h
	
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f2
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	10		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		call delay2
		jmp fanRot22

	fanRot22:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f3
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f4
		mov ah, 09h
		int 21h

		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f5
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f6
		mov ah, 09h
		int 21h
		call delay2
		jmp fanRot33
		
	fanRot33:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h

		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h
		
		call delay2
		jmp fanRot44

	fanRot44:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, fa
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, fb
		mov ah, 09h
		int 21h

		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, fc
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, fd
		mov ah, 09h
		int 21h
		call delay2
		jmp fanRot11
	return2:
	ret
speed2	endp

speed3	proc
	fanRot111:
		dec di
		cmp	di,	0
		je return3
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	4		; row
		mov	dl,	50		; column
		int 10h
	
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f2
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	10		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		call delay3
		jmp fanRot222

	fanRot222:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f3
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f4
		mov ah, 09h
		int 21h

		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f5
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f6
		mov ah, 09h
		int 21h
		call delay3
		jmp fanRot333
		
	fanRot333:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h

		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h
		
		call delay3
		jmp fanRot444

	fanRot444:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, fa
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, fb
		mov ah, 09h
		int 21h

		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, fc
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, fd
		mov ah, 09h
		int 21h
		call delay3
		jmp fanRot111
	return3:
	ret
speed3	endp

pivotspeed1	proc
	fanPiv1:
		dec di
		cmp	di,	0
		je returnpiv1
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	4		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f2
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	10		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		call delay1
		jmp fanPiv2

	fanPiv2:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f3
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f4
		mov ah, 09h
		int 21h

		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f5
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f6
		mov ah, 09h
		int 21h
		call delay1
		jmp fanPiv3
		
	fanPiv3:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h

		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h
		
		call delay1
		jmp fanPiv4

	fanPiv4:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, fa
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, fb
		mov ah, 09h
		int 21h

		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, fc
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, fd
		mov ah, 09h
		int 21h
		
		call delay1
		jmp fanPiv5
		
fanPiv5:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	4		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f2
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	10		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		call delay1
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, fo
		mov ah, 09h
		int 21h

		call delay1
		jmp fanPiv6

	fanPiv6:
		dec di
		cmp	di,	0
		je returnpiv1
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	4		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f2
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	10		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		call delay1
		jmp fanPiv7

	fanPiv7:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f3
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f4
		mov ah, 09h
		int 21h

		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f5
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f6
		mov ah, 09h
		int 21h
		call delay1
		jmp fanPiv8
		
	fanPiv8:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h

		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h
		
		call delay1
		jmp fanPiv9

	fanPiv9:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, fa
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, fb
		mov ah, 09h
		int 21h

		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, fc
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, fd
		mov ah, 09h
		int 21h
		call delay1
		jmp fanpiv10
		
fanPiv10:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	4		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f2
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	10		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		call delay1
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		call delay1
		jmp fanPiv11

	fanPiv11:
		dec di
		cmp	di,	0
		je returnpiv1
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	4		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f2
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	10		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		call delay1
		jmp fanPiv12

	fanPiv12:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f3
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f4
		mov ah, 09h
		int 21h

		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f5
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f6
		mov ah, 09h
		int 21h
		call delay1
		jmp fanPiv13
		
	fanPiv13:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h

		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h
		
		call delay1
		jmp fanPiv14

	fanPiv14:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, fa
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, fb
		mov ah, 09h
		int 21h

		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, fc
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, fd
		mov ah, 09h
		int 21h
		call delay1
		jmp fanpiv15

fanPiv15:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	4		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f2
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	10		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		call delay1
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		call delay1
		jmp fanPiv16

	fanPiv16:
		dec di
		cmp	di,	0
		je returnpiv1
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	4		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f2
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	10		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		call delay1
		jmp fanPiv17

	fanPiv17:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f3
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f4
		mov ah, 09h
		int 21h

		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f5
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f6
		mov ah, 09h
		int 21h
		call delay1
		jmp fanPiv18
		
	fanPiv18:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h

		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h
		
		call delay1
		jmp fanPiv19

	fanPiv19:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, fa
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, fb
		mov ah, 09h
		int 21h

		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, fc
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, fd
		mov ah, 09h
		int 21h
		call delay1
		jmp fanPiv20

fanPiv20:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	4		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f2
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	10		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		call delay1
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h

		call delay1
		jmp fanPiv1
	returnpiv1:
		ret
pivotspeed1	endp

pivotspeed2	proc
	fanPivA:
		dec di
		cmp	di,	0
		je returnpiv2
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	4		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f2
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	10		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		call delay2
		jmp fanPivB

	fanPivB:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f3
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f4
		mov ah, 09h
		int 21h

		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f5
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f6
		mov ah, 09h
		int 21h
		call delay2
		jmp fanPivC
		
	fanPivC:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h

		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h
		
		call delay2
		jmp fanPivD

	fanPivD:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, fa
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, fb
		mov ah, 09h
		int 21h

		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, fc
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, fd
		mov ah, 09h
		int 21h
		
		call delay2
		jmp fanPivE
		
fanPivE:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	4		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f2
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	10		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		call delay2
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, fo
		mov ah, 09h
		int 21h

		call delay2
		jmp fanPivF

	fanPivF:
		dec di
		cmp	di,	0
		je returnpiv2
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	4		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f2
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	10		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		call delay2
		jmp fanPivH

	fanPivH:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f3
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f4
		mov ah, 09h
		int 21h

		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f5
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f6
		mov ah, 09h
		int 21h
		call delay2
		jmp fanPivI
		
	fanPivI:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h

		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h
		
		call delay2
		jmp fanPivJ

	fanPivJ:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, fa
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, fb
		mov ah, 09h
		int 21h

		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, fc
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, fd
		mov ah, 09h
		int 21h
		call delay2
		jmp fanpivK
		
fanPivK:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	4		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f2
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	10		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		call delay2
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		call delay2
		jmp fanPivL

	fanPivL:
		dec di
		cmp	di,	0
		je returnpiv2
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	4		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f2
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	10		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		call delay2
		jmp fanPivM

	fanPivM:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f3
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f4
		mov ah, 09h
		int 21h

		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f5
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f6
		mov ah, 09h
		int 21h
		call delay2
		jmp fanPivN
		
	fanPivN:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h

		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h
		
		call delay2
		jmp fanPivO

	fanPivO:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, fa
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, fb
		mov ah, 09h
		int 21h

		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, fc
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, fd
		mov ah, 09h
		int 21h
		call delay2
		jmp fanpivP

fanPivP:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	4		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f2
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	10		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		call delay2
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		call delay2
		jmp fanPivQ

	fanPivQ:
		dec di
		cmp	di,	0
		je returnpiv2
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	4		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f2
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	10		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		call delay2
		jmp fanPivR

	fanPivR:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f3
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f4
		mov ah, 09h
		int 21h

		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f5
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f6
		mov ah, 09h
		int 21h
		call delay2
		jmp fanPivS
		
	fanPivS:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h

		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h
		
		call delay2
		jmp fanPivT

	fanPivT:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, fa
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, fb
		mov ah, 09h
		int 21h

		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, fc
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, fd
		mov ah, 09h
		int 21h
		call delay2
		jmp fanPivU

fanPivU:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	4		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f2
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	10		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		call delay2
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h

		call delay2
		jmp fanPivA
	returnpiv2:
		ret
pivotspeed2	endp

pivotspeed3	proc
	fanPiv01:
		dec di
		cmp	di,	0
		je returnpiv3
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	4		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f2
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	10		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		call delay3
		jmp fanPiv02

	fanPiv02:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f3
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f4
		mov ah, 09h
		int 21h

		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f5
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f6
		mov ah, 09h
		int 21h
		call delay3
		jmp fanPiv03
		
	fanPiv03:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h

		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h
		
		call delay3
		jmp fanPiv04

	fanPiv04:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, fa
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, fb
		mov ah, 09h
		int 21h

		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, fc
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, fd
		mov ah, 09h
		int 21h
		
		call delay3
		jmp fanPiv05
		
fanPiv05:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	4		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f2
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	10		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		call delay3
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	50		; column
		int 10h
		
		lea dx, fo
		mov ah, 09h
		int 21h

		call delay3
		jmp fanPiv06

	fanPiv06:
		dec di
		cmp	di,	0
		je returnpiv3
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	4		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f2
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	10		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		call delay3
		jmp fanPiv07

	fanPiv07:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f3
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f4
		mov ah, 09h
		int 21h

		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f5
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f6
		mov ah, 09h
		int 21h
		call delay3
		jmp fanPiv08
		
	fanPiv08:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h

		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h
		
		call delay3
		jmp fanPiv09

	fanPiv09:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, fa
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, fb
		mov ah, 09h
		int 21h

		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, fc
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, fd
		mov ah, 09h
		int 21h
		call delay3
		jmp fanpiv010
		
fanPiv010:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	4		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f2
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	10		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		call delay3
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		call delay3
		jmp fanPiv011

	fanPiv011:
		dec di
		cmp	di,	0
		je returnpiv3
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	4		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f2
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	10		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		call delay3
		jmp fanPiv012

	fanPiv012:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f3
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f4
		mov ah, 09h
		int 21h

		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f5
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f6
		mov ah, 09h
		int 21h
		call delay3
		jmp fanPiv013
		
	fanPiv013:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h

		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h
		
		call delay3
		jmp fanPiv014

	fanPiv014:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, fa
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, fb
		mov ah, 09h
		int 21h

		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, fc
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, fd
		mov ah, 09h
		int 21h
		call delay3
		jmp fanpiv015

fanPiv015:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	4		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f2
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	10		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		call delay3
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	60		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		call delay3
		jmp fanPiv016

	fanPiv016:
		dec di
		cmp	di,	0
		je returnpiv3
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	4		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f2
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	10		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		call delay3
		jmp fanPiv017

	fanPiv017:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f3
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f4
		mov ah, 09h
		int 21h

		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f5
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f6
		mov ah, 09h
		int 21h
		call delay3
		jmp fanPiv018
		
	fanPiv018:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h

		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f7
		mov ah, 09h
		int 21h
		
		call delay3
		jmp fanPiv019

	fanPiv019:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, fa
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, fb
		mov ah, 09h
		int 21h

		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, fc
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, fd
		mov ah, 09h
		int 21h
		call delay3
		jmp fanPiv020

fanPiv020:
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	4		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	5		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	6		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f2
		mov ah, 09h
		int 21h
		
		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	8		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	9		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h

		; set cursor
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	10		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, f1
		mov ah, 09h
		int 21h
		
		call delay3
		mov	ah, 02h
		mov	bh,	0		; page number
		mov	dh,	7		; row
		mov	dl,	55		; column
		int 10h
		
		lea dx, fi
		mov ah, 09h
		int 21h

		call delay3
		jmp fanPiv01
	returnpiv3:
		ret
pivotspeed3	endp

delay1 proc
	mov al, 0
	mov cx, 4d
	mov dx, 65000d
	mov ah, 86h
	int 15h
	ret
delay1 endp

delay2 proc
	mov al, 0
	mov cx, 2d
	mov dx, 65000d
	mov ah, 86h
	int 15h
	ret
delay2 endp

delay3 proc
	mov al, 0
	mov cx, 1d
	mov dx, 35000d
	mov ah, 86h
	int 15h
	ret
delay3 endp

tryagain:
	; set cursor
	mov	ah, 02h
	mov	bh,	0		; page number
	mov	dh,	10		; row
	mov	dl,	19		; column
	int 10h
	
	lea dx, tryAgainMs
	mov	ah,	09h
	int 21h
	
	mov ah, 01h
	int 21h
	
	cmp	al,	121			; check if input is "y"
	je clearscreenReturn
	cmp	al,	110			; check if input is "n"
	je exit
	jmp tryagain
	
clearscreen:
	mov ax, 3
	int 10h
	jmp tryagain

clearscreenReturn:
	mov ax, 3
	int 10h
	jmp fanStatus

exit:
	.exit
end start