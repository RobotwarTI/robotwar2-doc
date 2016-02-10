TextStart = $

;str_time_format:
;.db "00:00",$27,"00",$22,0    ; Prints: 00:00'00''

str_arrow:
.db $05,0

str_hp:
.db "HP:",0             ; HP as seen in sidebar

str_ep:
.db "EP:",0             ; EP as seen in sidebar

str_level:
.db "LEVEL:",0			; Level as seen in stats display

str_need:
.db "need:",0			; [DEPRECIATED]

str_diet:
.db "DIET:",0			; [DEPRECIATED]

str_pwned:
.db "- Bummer -",0		; Displayed during level-down


str_plus50_growth
.db "x2 EP growth",0	; [DEPRECIATED]

str_ranks:
.db "RANKS",0			; [DEPRECIATED]

str_rank_ratio:
.db $9A," 0/4",0		; [DEPRECIATED]

str_mission:
.db "$   MISSION?",0	; [DEPRECIATED]

str_unemployed:
.db "(unemployed)",0	; [DEPRECIATED]

str_vs:
.db "Vs.",0				; [DEPRECIATED]

str_enemies:
.db "enemies",0			; [DEPRECIATED]

str_prize:
.db "prize:",0			; [DEPRECIATED]

str_link:
.db $1E,$1F," LINK",0	; [FOR FUTURE USE]

msg_pause_menu:			; Pause menu, as seen in sidebar
.db "STAT",0
.db "ITEM",0
.db "SAVE",0
.db "EXIT",0,$FF
str_save = $ - 11

msg_no_yes:
.db "NO",0
.db "YES",0,$FF

str_of:					; [DEPRECIATED]
.db "of:",0

str_atk:
.db "ATK",0

str_def:
.db "DEF",0

str_spe:
.db "SPE",0

str_items:
.db "ITEM:",0

str_foods:
.db "(Food)",0			; [DEPRECIATED]

str_exiting:
.db "Exit Game?",0		; Exit prompt (shown via sidebar)

msg_fileselect:			; TI-82-only strings here
str_gamea:
.db "G1",0
str_gameb:
.db "G2",0
str_gamec:
.db "G3",0
str_exit:
.db "EXIT",0,$FF


str_waiting:			; [FOR FUTURE USE]
.db "*Waiting*",0

str_new:				; As seen in main menu
.db "*NEW*",0

str_low_memory:			; Soon to be TI-82 only
.db "*Low Mem*",0

msg_game_keys:					; [DEPRECIATED]
.db "2ND",$05,"jump",0
.db "ALPHA",$05,"attack",0
.db "MODE",$05,"pause",0,$FF

str_stat:				; Window title for stats screen
.db "STATS",0

str_bargraph:
.db $DF,$E0,0         ; (bar graph left) (bar graph right)

str_basics:
.db "BASICS",0

msg_dialog_test:		; For debug purposed [DEPRECIATED?]
.db $EE,2,$FF

str_1P:					; [FOR FUTURE USE]
.db "1P",0
str_2P
.db "2P",0

str_percent_sign:
.db $25,0       ; %

str_empty:				; TI-82 only
.db "(Empty slot)",0

str_exit_to:			; [DEPRECIATED]
.db "Exit to Main",0

str_help1:				; File Select Menu's help screen (1st page)
.db "2ND-jump,OK",0
str_help2:
.db "ALPHA-hit,BACK",0
str_help3:
.db "MODE-weapon",0
str_help4:
.db "STAT-options",0

str_version:
.db "Version 2016 v0.2",0

str_url:
.db "Cemetech.net",0






; Dialogs in this game are a little counter-intuitive.  In order to save space, dialogs are
; encoded to replace commonly-used words and expressions into short packets.  When this happens,
; you'll see an $EE in the string.  The $DD code indicates where in a conversation the game will
; prompt the user with the blinking "2nd" icon.  Finally, a $00 works as an endline/newline character;
; while $FF marks the end of the dialog.

; The dialog system was avoided somewhat in 2016 to allow for easier
; translation.
; 
dEND = $FF           ; Ends a dialog, unless followed by "d2ND"
dITEM_DROP = $FE     ; Drop 1 item ; (Example: $FE,1) <-- Drops item #
dSTORY_TRACK = $FD   ; Update story progress ; (Example: $FE,1,%11110000)
dITEM_TAKE = $FC     ; Take 1 particular item from inventory (Parameters: $FC,Item#)
dITEM_CHECK=$FB      ; Branch from dialog if character has an item (Parameters: $FB,Item#,Dialog#)
dCHANGE_MAP=$FA	     ; Immidiately end dialog and load a new map (Paramters: $FA,Map#)
dBLACKOUT=$F9		 ; Black out the background and disable attacks (for cinematic effect)
dDISABLE_MAP_CHANGE=$F8	; Prevent player from exiting the map or entering doors while this dialog is visible.
dCANCEL=$F7			; Cancel dialog immidiately
dCHANGE_MAP_STACKFIX=$F6	; Same as Change Map, but safe to use with contact-triggered events (talking to most people)
dSUB = $EE         ; Substitution ; (Example:  $EE,1)
d2ND = $DD

; Character Portraits are numbered accordingly...
NONE = 0    ; (Display no portrait)
BETH = 1    ; Updated from RW1
KALI = 2    ; New character
NOAH = 3    ; Copied from RW1
REED = 4    ; Copied from RW1
MARCUS = 5  ; Updated from RW1
EDGAR = 6   ; Protagonist
GILBERT = 7 ; Refered to as GILL in this game
CYRU = 8    ; Director Cyru
LETTER = 9  ; A paper envelope icon
ALERT = 10  ; An exclaimation mark icon
HIRI = 11   ; New character
EDMUND = 12 ; Copied from RW1



; Dialog 0
; Local citizens show concern for Edgar's worn condition
dia_you_look_spent: 
.db NONE
.db "You look spent.Did you",0
.db "RUN here?!",0,dEND


; Dialog 1
; Beth is introduced. Player directed where to travel
dia_beths_letter:
.db LETTER
.db dSTORY_TRACK,0,(1<<ReadBethsLetter) ; <-- Semiphore will stop the letter from reappearing
.db "(A letter from BETH)",0,dEND,d2ND
.db BETH
.db "EDGAR, meet me at",0
.db "Atlas Tower. Go EAST",0,dEND


; Dialog 2
; Beth is mentioned once again.  
dia_youre_edgar: 
.db NONE
.db "You're EDGAR? BETH",0
.db "said much about you.",0,dEND


; Dialog 3
; The player is told how to regain the ability to jump
; Note to self: This dialog should auto-change after the player advances.
dia_you_look_too:
.db NONE
.db "You're exhausted! Some food",0
.db "may restore your JUMP",0
.db "ability",0,dEND


; Dialog 4
; Swimming is explained.
dia_oceanside_has:
.db NONE
.db "OCEANSIDE has everything!",0
.db "You can even swim if you",0
.db "have enough HP!",0,dEND


; Dialog 5
; Refers to soccer mini game (removed from beta, will return later)
dia_soccer_start:
.db NONE
.db "Have you noticed how fire",0
.db "attacks bounce off water",0
.db "enemies?",0,dEND,d2ND
.db NONE
.db "I wonder if other types",0
.db "work that way",0,dEND


; Dialog 6
; An aiming tip
dia_soccer_tip:
.db NONE
.db "I watch the ball's shadow",0
.db "to aim",0,dEND


; Dialog 7
; The mines in Crab's Cove are pointed out
dia_those_mines:
.db NONE
.db "No! They got past the mines!",0,dEND


; Dialog 8
; Item expiration is explained.
dia_items_expir:
.db NONE
.db "Did you know most items last",0
.db "for 10 level-ups?",0,dEND,d2ND
.db NONE
.db "Unless they take damage,",0
.db "of course.",0,dEND


; Dialog 9
; [DEPRECIATED]
dia_atlas_secretary:
.db NONE
.db "Welcome. BETH is waiting",0
.db "upstairs. You need to fix",0
.db "the elevators to reach her",0,dEND


; Dialog 10
; (Will not appear in beta.  Add later to the bowling area)
dia_nice_follow:
.db KALI                        ; <-- Picture to use
.db "Let's go for Mai Tais",0
.db "after this",0,dEND


; Dialog 11
; [DEPRECIATED - Clear no longer does this]
dia_clear_key:
.db LETTER
.db "NEWS: Experts say",0
.db "[CLEAR] key a great",0
.db "way to rest",0,dEND


; Dialog 12
; [ALPHA] key is explained. Player is warned of creatures.
dia_hold_it_son:
.db NONE
.db "HOLD IT, KID!",0,dEND,d2ND
.db NONE
.db "You're new here I reckon",0,dEND,d2ND
.db NONE
.db "Oceanside hasn't been",0
.db "safe for weeks",0,dEND,d2ND
.db NONE
.db "Odd creatures invaded..",0
.db "Wrecking anything and",0
.db "anyone",dEND,d2ND
.db EDGAR
.db "My [ALPHA] attack can",0
.db "sort that out! But thanks",0,dEND

; Dialog 13
; [DEPRECIATED]
dia_noahs_welcome:
.db NOAH
.db "EDGAR! We were just",0
.db "talking about you",0,dEND

; Dialog 13 
; [Depreciated]
dia_this_palm_tree:


; Dialog 14 (Opening Story)
; [DEPRECIATED]
dia_opening:


; Dialog 15
; ATLAS Bionics is explianed.  Hiri is mentioned for the second time.
dia_atlas_background:
.db NONE
.db "Yeah. ATLAS Bionics is the",0
.db "leader in deep-brain",0
.db "implants",0,dEND,d2ND
.db NONE
.db "Have you met Dr. HIRI?",0,dEND


; Dialog 16
; Player located BETH! Beth refers to things being *cough* delayed.
dia_beths_welcome:
.db BETH
.db "EDGAR! You",0
.db "had me worried.",dEND,d2ND
.db BETH
.db "You must have had",0
.db "serious flight delays.",0,dEND


; Dialog 17
; Reed also refers to *cough* *cough* delays.
dia_reeds_welcome:
.db REED
.db "REED: I never worry.",0
.db "You're late, by the way.",0,dEND


; Dialog 18
; [DEPRECIATED] [This is no longer a plot point]
dia_burglaries:
.db NONE
.db "ANOTHER burglary upstairs?",0
.db "How many gems are gone",0
.db "THIS time?!",0,dEND


; Dialog 19
; Atlas reference
dia_dr_gergely:
.db NONE
.db "ATLAS Bionics! This is",0
.db "Gergely speaking.",0,dEND


; Dialog 20
; Edgar refers to the electrical towers in the 5th chapter
dia_the_towers:
.db EDGAR
.db "I should take down",0
.db "these towers first",0,dEND


; Dialog 21
; Grand Grove resident implies you are no longer in Oceansdie
dia_are_you_from:
.db NONE
.db "Are you from OCEANSIDE?",dEND


; Dialog 22
; Acheivements are explained.
dia_1st_acheivement:
.db NONE
.db "Awesome! You found a hidden",0
.db "ACHEIVEMENT!",0,dEND,d2ND
.db NONE
.db "These little wonders will",0
.db "double the value of coins",0
.db "and skill",0,dEND,d2ND
.db NONE
.db "Can you find them all?",0,dEND


; Dialog 23
; Edgar meets Kali (a new character). 
dia_kali_meets_you:
.db KALI
.db "Ouch! Watch it!",0,dEND,d2ND
.db KALI
.db "Wha? ",$EE,shELLIPSIS," I've never seen",0
.db "you before",dEND,d2ND
.db KALI
.db "You're not from",0
.db "our island are you?",0,dEND,d2ND
.db KALI
.db "A main-lander?",0,0
.db "Interesting!",0,dEND,d2ND
.db KALI
.db "I'm KALI",0,dEND,d2ND
.db KALI
.db "Welcome to campus",0,dEND,d2ND
.db KALI
.db "ATLAS Bionics?",0
.db "It's to the left.",0,dEND,d2ND
.db KALI
.db dSTORY_TRACK,CHAPTER0,(1<<TalkedToKali)    ; <-- Signal the game that you met Dr.HIRI
.db "I want to see you again",0,dEND


; Dialog 24
; Food items are explained
dia_food_tutorial:
.db NONE
.db "Feeling sluggish?  Eat",0
.db "FRUIT to boost your SPEED",$EE,shELLIPSIS,0,dEND,d2ND
.db NONE
.db $EE,shELLIPSIS,"MEAT to boost your ATTACK",$EE,shELLIPSIS,0,dEND,d2ND
.db NONE
.db $EE,shELLIPSIS,"SANDWICHES to raise your",0
.db "DEFENSE!",0,dEND,d2ND
.db NONE
.db $EE,shELLIPSIS,"and WATER to replenish",0
.db "your ENERGY",0,dEND


; Dialog 25
; [DEPRECIATED]
dia_beth_not_here:
.db NONE
.db "Sorry sir.",$EE,shBETH,"has",0
.db "not arrived yet.",0,dEND,d2ND
.db "Have you toured our campus yet?",0,dEND


; Dialog 26
; Gill (Gilbert) is reunited with Edgar after nearly 4 years.
dia_gilbert_intro:
.db GILBERT
.db "GILL: Halt!",0
.db "Let's see your ID!",0,dEND,d2ND
.db GILBERT
.db "Edgar? Its been a",0
.db "while! You look just",0
.db "like your brother!",0,dEND,d2ND
.db GILBERT
.db "I suppose you heard",0
.db "about the battle bot",0
.db "sightings?",0,dEND,d2ND ; <-- At this point, the bots are assumed non-organic
.db GILBERT
.db "Confidentially, I think",0
.db "REED is behind it.",0
.db $EE,shELLIPSIS,"Somehow.",0,dEND,d2ND ; <-- Gill's dislike of Reed
.db GILBERT
.db "He was that nasty",0
.db "Dr. EDMUND's original",0
.db "protoge, you know?",0,dEND,d2ND  ; <-- Edmund is mentioned for the 1st time in this game.
.db GILBERT
.db "As ATLAS Cheif of",0
.db "Security, I'd keep a",0
.db "close eye on that jerk.",0,dEND,d2ND
.db GILBERT
.db "That's right! Your old",0
.db "pal GILL is moving up",0
.db "in the world! Aw yeah!",0,dEND,d2ND ; <-- Gill's friendship with Edgar
.db GILBERT
.db "Anyway",$EE,shELLIPSIS,0,dEND,d2ND
.db GILBERT
.db "Your mentor, Dr. Noah",0
.db "said something big",0
.db "is going on.",0,dEND,d2ND ; <-- Edgar's relationship to Noah mentioned for the 1st time
.db EDGAR
.db "Big?",0,dEND,d2ND
.db GILBERT
.db "Yeah. He and BETH just",0
.db "met with some guy from",0
.db "the TASKFORCE.",0,dEND,d2ND ; <-- Taskforce's director Cyru mentioned
.db GILBERT
.db "Dr. HIRI is upstairs with",0
.db "a GUEST ID you can use.",0
.db "See you around,old bud!",0,dEND


; DIALOG 27
; Player meets Hiri for the 1st time (a new character)
dia_dr_hiri_intro:
.db HIRI
.db dITEM_CHECK,ITEM_STRANGE_ROBOT,35 ; <-- Jump to dialog #35 if you have the strange robot
.db "You're this EDGAR",0
.db "kid I've heard about?",0,dEND,d2ND
.db HIRI
.db "I am Dr. HIRI",$EE,shELLIPSIS,0
.db "Chief Neuroscientist",0
.db "for bionic implants",0,dEND,d2ND
.db HIRI
.db "You were attacked by",0
.db "battle bots today?",0,dEND,d2ND
.db HIRI
.db "I thought that",0
.db "technology was",0
.db "outlawed!",0,dEND,d2ND
.db HIRI
.db "Curious",$EE,shELLIPSIS,dEND,d2ND
.db HIRI
.db "Could you capture one?",0,dEND,d2ND
.db EDGAR
.db "Uh",$EE,shELLIPSIS,"Well",$EE,shELLIPSIS,0,dEND,d2ND
.db HIRI
.db dITEM_DROP,30               ; <-- Borrowed Zapper is dropped for the player
.db dITEM_DROP,23               ; <-- Battery is dropped for the player
.db "Great! Stun one with",0
.db "this ZAPPER. And bring",0
.db "it here.",0,dEND,d2ND
.db HIRI
.db dSTORY_TRACK,CHAPTER0,(1<<TalkedToHIRI) ; <--This semiphore stops GILL appearing in the east building
.db "I must see for myself!",0,dEND

; DIALOG 28
; This paper bulletin explains the missing patient case
dia_bulletins:
.db LETTER
.db "MARCH News:",0,dEND,d2ND
.db NONE
.db "More former patients",0
.db "now missing. Island",0
.db "seeks explaination.",0,dEND,d2ND
.db LETTER
.db "APRIL News:",0,dEND,d2ND
.db NONE
.db "Atlas receives anoymous",0
.db "threats. Expect increased",0
.db "security",0,dEND,d2ND
.db LETTER
.db "MAY News:",0,dEND,d2ND
.db NONE
.db "Atlas president, Dr.NOAH",0
.db "to visit Pearl Island",0
.db "personally",dEND


; DIALOG 29
dia_end_of_demo:
.db ALERT
; Semiphore below will stop the "Hostile robotics" warning in Oceanside
.db dSTORY_TRACK,CHAPTER1,(1<<Boss1Defeated)
.db "CONGRATULATIONS!",0
.db "You survived the",0
.db "ROBOT WAR 2 Demo!",0,dEND,d2ND
.db ALERT
.db "Will Edgar be united",0
.db "with his friends?",0
.db "What is the TASKFORCE?",0,dEND,d2ND
.db ALERT
.db "And where are the",0
.db "missing patients?",0,dEND,d2ND
.db ALERT
.db "Stay posted as the",0
.db "mystery unfolds!",0,dEND


; DIALOG 30
; This guy is in the Armory shop to explain what batteries do.
dia_batteries:
.db NONE
.db "Hey, newbie! I hope you",0
.db "know every item sold here",0
.db "needs a BATTERY!",0,dEND


; DIALOG 31
; Boss warning message. This might be replaced by a flashing sign in the future.
dia_warning_hostile:
.db ALERT
.db "WARNING!",0
.db "Hostile robotics",0
.db "detected ahead!",0,dEND,d2ND


; DIALOG 32
; Edgar explains to the player how to enter Atlas tower
dia_atlas_locked:
.db EDGAR
.db dITEM_CHECK,ITEM_GUEST_ID,41 ; <- If Edgar has the GUEST ID, jump to dialog #41 (Cyru tells you to move aside)
.db "Atlas tower is locked.",0
.db "I should get a key card",0
.db "next door",0,dEND


; DIALOG 33
; [DEPRECIATED]
dia_i_need_to_stun:
.db EDGAR
.db "I need to stun a",0
.db "small robot to give",0
.db "to Dr.HIRI.",0,dEND,d2ND
.db EDGAR
.db "I can carry one just",0
.db "like an ITEM.",0,dEND

 
; DIALOG 34
; Gilbert explains the descrambler puzzles
dia_building_codes:
.db GILBERT
.db "Darn it! The building",0
.db "control codes are",0
.db "scrambled!",0,dEND,d2ND
.db GILBERT
.db "The elevators can't",0
.db "get you upstairs.",0
.db "Unless",$EE,shELLIPSIS,0,dEND,d2ND
.db GILBERT
.db "Do you remember any",0
.db "of BETH's old hacking",0
.db "tricks?",0,dEND,d2ND ; <-- Beth's hacking prowess is mentioned for the 1st time
.db GILBERT
.db "Maybe you can fix our",0
.db "codes. Give it a try.",0,dEND

; DIALOG 35
; Hiri inspects the squid-bot, and collects the items she loaned you.
dia_heres_your_key:
.db HIRI
.db "You did it! What an",0
.db "odd machine. It's",0
.db "part organic",0,dEND,d2ND
.db HIRI
.db dITEM_TAKE,29       ; <-- Take away the STRANGE ROBOT (Rename to: Squid Robot)
.db dITEM_TAKE,30       ; <-- Take away the BORROWED ZAPPER
.db dITEM_TAKE,23       ; <-- Take away the BATTERY
.db "It's dangerous to",0
.db "take this. Go alone.",0,dEND,d2ND
.db HIRI
.db dITEM_DROP,28               ; <-- Drop the GUEST ID card
.db dSTORY_TRACK,CHAPTER1,(1<<HiriOfferedAnID)	; <-- Semiphore makes Cyru appear outside Atlas Tower
.db "Here is your key",0
.db "to Atlas Tower.",0,dEND


; DIALOG 36
; This man in downtown Oceanside directs you to Atlas Tower and the campus
dia_atlas_is_west:
.db NONE        ; No character portrait
.db "Atlas Tower?",0
.db "It's to the WEST.",0,dEND


; DIALOG 37
; [DO NOT USE - TESTING] This was intended to instantly end any text
dia_CANCEL:     
.db NONE
.db dCANCEL
.db "Testing"
.db 0,dEND



; DIALOG 38
; The flashing monitors are explained by Edgar (in the east tower)
dia_scrambled_terminals:
.db EDGAR
.db "Scrambled terminals!",0
.db "I could hack in if I had",0
.db "permission",0,dEND


; DIALOG 39
; Post-Beltway dialog about CODEX: featuring Noah and Cyru 
dia_give_me_codex:
.db NOAH
.db "No! We need more time",0
.db dBLACKOUT,dEND,d2ND
.db CYRU
.db "No more stalling. We",0
.db "don't want excuses.",0
.db "Give us the CODEX!",0,dEND,d2ND ; <-- Cyru is not yet named to the player
.db NOAH
.db "Madman!",0
.db "You're telling",0
.db "me to just fork over",$EE,shELLIPSIS,0,dEND,d2ND
.db CYRU
.db $EE,shELLIPSIS,"Full wireless access",0 
.db "to all bionics made by",0
.db "you since day one.",0,dEND,d2ND
.db NOAH
.db "There's no way the",0
.db "the laws would allow",0
.db "for such",$EE,shELLIPSIS,0,dEND,d2ND
.db CYRU
.db "You have one hour.",0,dEND,d2ND
.db NONE
.db "*End Call*",0,dEND,d2ND
.db NONE
.db dCHANGE_MAP,0 ; Change map to map #0 (Oceanside/the area with Beth's house)


; DIALOG 4
; Edgar reunites with Noah, Beth, and Reed. Noah reveals Cyru has the fake CODEX
dia_by_jove_its_you:
.db NOAH
.db dSTORY_TRACK,CHAPTER0,(1<<TalkedToKali)	; <-- Make certain only one Kali appears outside this building
.db "By jove, it's you!",0
.db "Edgar! It's been many",0
.db "years since we last met.",dEND,d2ND ; <-- about 4 years
.db EDGAR
.db "Who was that guy",0
.db "outside?",0,dEND,d2ND
.db NOAH
.db "A director from the",0
.db "TASKFORCE. Here to",0 ; <-- Taskforce mentioned a 2nd time
.db "locate missing persons",$EE,shELLIPSIS,0,dEND,d2ND
.db NOAH
.db $EE,shELLIPSIS,"and to take the CODEX.",0,dEND,d2ND
.db REED
.db "Take the CODEX? Ha ha!",0
.db "Good one, sir.",0,dEND,d2ND
.db NOAH
.db $EE,shELLIPSIS,0,dEND,d2ND
.db BETH
.db "Oh no.",0,dEND,d2ND
.db REED
.db "Wait. SERIOUSLY?",0,dEND,d2ND
.db BETH
.db "We need to get it back!",0
.db "In the wrong hands, the",0
.db "CODEX files could",$EE,shELLIPSIS,dEND,d2ND
.db NOAH
.db "It was a fake CODEX,",0
.db "full of cat pictures",0
.db "and internet memes.",0,dEND,d2ND
.db EDGAR
.db "That won't buy much",0
.db "time to locate your",0
.db "missing patients.",0,dEND,d2ND
.db BETH
.db "O_O",0,dEND,d2ND
.db REED
.db "How did you know?",0,dEND,d2ND
.db BETH
.db "I may have",$EE,shELLIPSIS,"brought it",0
.db "up.",0,dEND,d2ND
.db NOAH
.db "No matter. The battle",0
.db "bot sightings point",0
.db "to one culprit."0,dEND,d2ND
.db BETH
.db "Edmund!",0,dEND,d2ND
.db NOAH
.db "Edgar, if you want to",0
.db "return home, we",0
.db "understand, but",$EE,shELLIPSIS,0,dEND,d2ND
.db NOAH
.db "We need your help",0
.db "finding those patients.",0,dEND,d2ND
.db REED
.db "Before the TASKFORCE",0
.db "returns for the real",0
.db "CODEX?",0,dEND,d2ND
.db REED
.db "They blame us for this",0
.db "mess, you know?",0
.db "Followed me, even!",0,dEND,d2ND
.db BETH
.db "My FILES might clear",0
.db "our names.",0,dEND,d2ND
.db BETH
.db "Edgar",$EE,shELLIPSIS,0,dEND,d2ND
.db BETH
.db "To TASKFORCE, you're",0
.db "an ordinary tourist",0,dEND,d2ND
.db BETH
.db dSTORY_TRACK,CHAPTER1,(1<<TalkedToBETH) ; <--Will make item: FILES appear in Beth's House
.db "Retreive the FILES",0
.db "at my house so we",0
.db "can decode them here",0,dEND,d2ND
.db NONE
; Fast-travel to map000 (Beth's house)
.db dCHANGE_MAP_STACKFIX,0


; DIALOG 41		; CYRU
; Director Cyru meets Edgar
dia_move_it_squirt:
.db CYRU
.db "Move it, punk!",0,dEND

; DIALOG 42
; Flashback to Noah and Edmund before Robot War 1
dia_chapter1_end_scene:
.db NONE
.db "(Many years ago..."0,dEND,d2ND
.db NONE
.db "(Before the war...)",0,dEND,d2ND
.db NOAH
.db "By jove, EDMUND! This",0
.db "is revolutionary!",0,dEND,d2ND
.db EDMUND
.db "Indeed,old friend.",0
.db "Our bionics research",0
.db "is finally paying off!",0,dEND,d2ND
.db NOAH
.db "And the investors?",0,dEND,d2ND
.db EDMUND
.db "Our CODEX program",0
.db "was a hit! There's",0
.db "just one hitch...",0,dEND,d2ND
.db NOAH
.db "Never mind that!,",0
.db "This calls for",0
.db "celebration!",0,dEND,d2ND
.db EDMUND
.db "Pizza and laser tag?",0,dEND,d2ND
.db NOAH
.db "Naturally!",0,dEND


; DIALOG 43
; Bowling alley is under construction
dia_bowling_alley_under_construction:
.db NONE
.db "Sorry! The bowling alley",0
.db "is under construction."0,dEND


; DIALOG 44
; Use this message for areas that are not unlocked yet.
dia_i_cant_advance:
.db EDGAR
.db "I can't advance to this",0
.db "area yet.",0,dEND,


; DIALOG 45
; Atlas Tower is raided and Edgar is chased east toward the boss
dia_its_all_destoryed:
.db KALI
.db "EDGAR! It's horrible!",0
.db "It's all destoryed!",0,dEND,d2ND
.db EDGAR
.db "What happend here?!",0
.db 0
.db "Who did this?",0,dEND,d2ND
.db CYRU
.db "Headquarters: This is",0
.db "director CYRU",$EE,shELLIPSIS,0
.db CYRU
.db "Alpha squad has the CODEX",0
.db "and 2 ATLAS prisoners",0
.db "coming your way.",0,dEND,d2ND
.db CYRU
.db "That's right: EAST!",0
.db "On the highway",0,dEND,d2ND
.db EDGAR
.db "Hold it! You need to",0
.db "see this data first!",0,dEND,d2ND
.db CYRU
.db "Men! This kid has bionics!",0
.db "Take him down!",0
.db "NOW!!!",0,dEND,d2ND
.db KALI
.db "EDGAR, they'll kill",0
.db "you! RUN!!",0,dEND,d2ND
.db NONE ; <-- Yes, this is necessary.  Sort of.
; This semiphore will prevent Edgar from re-visiting the University for a while
.db dSTORY_TRACK,CHAPTER1,(1<<AtlasAttacked)	
; Send the player to map 28 - (The map just west of the Oceanside Boss)
.db dCHANGE_MAP_STACKFIX,28




table_status_strings: ; <-- Needs to be moved to a different file
.dw str_bargraph
.dw str_basics
.dw str_hp
.dw str_ep
.dw str_of
.dw str_of
.dw str_atk
.dw str_def
.dw str_spe
.dw str_level
.dw str_need
.dw str_diet
.dw str_plus50_growth
.dw str_ranks
.dw str_rank_ratio
.dw str_rank_ratio
.dw str_rank_ratio
.dw str_rank_ratio
.dw str_mission
.dw str_link

table_status_strings_locs: ; [DEPRECIATED]
.dw $0A2A       ; Location of bargraph
.dw $0A37       ; Location of "BASICS"
.dw $1130       ; Location of "HP:"
.dw $1730       ; Location of "EP:"
.dw $1149       ; Location of "of:"
.dw $1749       ; Location of "of:"
.dw $1E30       ; Location of "ATK"
.dw $1E40       ; Location of "DEF"
.dw $1E4D       ; Location of "SPE"
.dw $2B30       ; Location of "LEVEL"
.dw $3134       ; Location of "need:"
.dw $4832       ; Location of "DIET"
.dw $502F       ; Location of "+50% AT_ growth"
.dw $6732       ; Location of "RANKS"
.dw $6D40       ; Location of 1st "|  0/4"
.dw $7340       ; Location of 2nd "|  0/4"
.dw $7940       ; Location of 3rd "|  0/4"
.dw $7F40       ; Location of 4th "|  0/4"
.dw $962A       ; Location of "$   MISSION?"
.dw $E82A       ; Location of "v^ Link"

table_stat_numbers: ; [DEPRECIATED?]
.dw HP          ; See [rw3.h] for details on variables
.dw HPmax
.dw EP
.dw EPmax
.dw ATK
.dw DEF
.dw SPE
.dw LEVEL
.dw NEED
.dw LEVEL
.dw LEVEL
.dw LEVEL
.dw LEVEL
table_stat_number_locs:
.dw $113A       ; Location of #HP (8-Bit)       ; 17 down , 58 across
.dw $1153       ; Location of #HPmax            ; 17 down , 83 across
.dw $173A       ; Location of #EP               ; 23 down , 58 across
.dw $1753       ; Locatoin of #EPmax            ; 23 down , 83 across
.dw $2430       ; Location of #ATK              ; 36 down , 48 across
.dw $2440       ; Location of #DEF              ; 36 down , 48 across
.dw $244D       ; Location of #SPE              ; 36 down , 77 across
.dw $2B46       ; Location of #LEVEL            ; 43 down , 70 across
.dw $3146       ; Location of #NEED             ; 49 down , 70 across
.dw $6D43       ; Location of #FIRE             ;109 down , 67 across
.dw $7343       ; Location of #WATER            ;115 down , 67 across
.dw $7943       ; Location of #SPARK            ;121 down , 67 across
.dw $7F43       ; Location of #SHADOW           ;127 down , 67 across

tbl_unemployed:
.dw str_unemployed      ; Prints "unemployed"
tbl_unemployed_pos:
.dw $9D2F               ; Location of "unemployed"

tbl_mission_specs:
.dw str_vs
.dw str_enemies
.dw str_prize
tbl_mission_specs_pos
.dw $9D2F               ; Location of "Vs."
.dw $A339               ; Location of "enemies"
.dw $AB2F               ; Location of "prize:"

tbl_mission_digits:
.dw ATK      
.dw ATK
tbl_mission_digits_locs
.dw $9D39               ; Location of 'versus' spec?
.dw $AB45               ; Location of mission's prize amount?
   

tbl_dialogs:
.dw dia_you_look_spent  ; 0   ; You look spent.  Did you run here or something?
.dw dia_beths_letter    ; 1   ; (A letter from BETH)
.dw dia_youre_edgar     ; 2   ; You're EDGAR? BETH said much about you.
.dw dia_you_look_too    ; 3   ; You look too tired to even JUMP...
.dw dia_oceanside_has   ; 4   ; Oceanside has everything!...
.dw dia_soccer_start    ; 5   ; 
.dw dia_soccer_tip      ; 6   ; Soccer tips
.dw dia_those_mines     ; 7   ; No!  They got past the mines!
.dw dia_items_expir     ; 8   ; Ever notice how items expire 
.dw dia_atlas_secretary ; 9   ; (Instructions to take elevator)
.dw dia_nice_follow     ; 10  ; Kali's complement
.dw dia_clear_key       ; 11  ; NEWS: Clear key a great way to rest
.dw dia_hold_it_son     ; 12  ; The man warns Edgar
.dw dia_noahs_welcome   ; 13  ; Noah welcomes Edgar back
.dw dia_opening         ; 14  ; Noah, Beth, Reed confer with Cyru
.dw dia_atlas_background ; 15 ; 
.dw dia_beths_welcome   ; 16 ; BETH: "You had us worried.."
.dw dia_reeds_welcome   ; 17 ; REED: "I never worry.."
.dw dia_burglaries      ; 18 ; Another burglary upstairs?
.dw dia_dr_gergely      ; 19 ; This is Dr. Gergely speaking
.dw dia_the_towers      ; 20 ; EDGAR: I should take down these towers first..
.dw dia_are_you_from    ; 21 ; Are you from Oceanside?
.dw dia_1st_acheivement	; 22 ; Awesome! You found a hidden acheivement!
.dw dia_kali_meets_you	; 23 ; Ouch!  That hurt!...
.dw dia_food_tutorial	; 24 ; Fruit = Speed, Meat = Attack, Sandwich = Defense, Water = Energy
.dw dia_beth_not_here   ; 25 ; Beth not here yet, check the campus area (to meet Kali)
.dw dia_gilbert_intro   ; 26 ; Gilbert intros himself as Chief of Security
.dw dia_dr_hiri_intro   ; 27 ; Dr. Hiri requests a battle bot sample
.dw dia_bulletins       ; 28 ; News from March, April, and May
.dw dia_end_of_demo		; 29 ; "Congratulations! You have completed the RW2 demo!"
.dw dia_batteries		; 30 ; Nameless character explains how batteries work
.dw dia_warning_hostile ; 31 ; WARNING! Hostile radio signature!
.dw dia_atlas_locked    ; 32 ; Edgar: Atlas Tower is locked...
.dw dia_i_need_to_stun  ; 33 ; Edgar: I need to stun a small robot to give..
.dw dia_building_codes  ; 34 ; Gilbert: Darn it! The building codes are scrambled...
.dw dia_heres_your_key  ; 35 ; Dr. Hiri give you a key to Atlas Tower
.dw dia_atlas_is_west   ; 36 ; Unnamed Character: Atlas Tower? It's to the WEST.
.dw dia_CANCEL              ; 37 ; *Instantly stops dialog mode*
.dw dia_scrambled_terminals ; 38 ; Edgar explains the flashing terminals
.dw dia_give_me_codex	    ; 39 ; Noah is ordered by Cyru to hand over CODEX
.dw dia_by_jove_its_you     ; 40 ; Convensation between Noah, Beth, Reed, and Edgar (mystery revealed)
.dw dia_move_it_squirt	    ; 41 ; Cyru rudely says this (while presumably possessing the fake CODEX)
.dw dia_chapter1_end_scene  ; 42 ; Prewar flashback of Noah and Edmund 
.dw dia_bowling_alley_under_construction ; 43 ; Sorry! Bowling under construction.
.dw dia_i_cant_advance		; 44 ; EDGAR: "I can't advance to this area yet"
.dw dia_its_all_destoryed   ; 45 ; KALI says Altas was destroyed.  Cyru tries to arrest Edgar


#ifdef SPASM \ .echo >> "sizes.txt" __FILE,":\t",$ - TextStart,"\n" \#endif
