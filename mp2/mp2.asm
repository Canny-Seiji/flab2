BITS 32
GLOBAL _start

%macro PRINT 1
    mov ecx, %1
    call print_string
%endmacro

SECTION .data
welcome db '=======================================',10
        db '       DUNGEON OF THE LOST KING',10
        db '=======================================',10
        db '              |>>>>',10
        db '              |',10
        db '          _  _|_  _',10
        db '         |;|_|;|_|;|',10
        db '         \.    .  /',10
        db '          \:  .  /',10
        db '           ||:   |',10
        db '           ||:.  |',10
        db '           ||:  .|',10
        db '       ENTER IF YOU DARE!',10,0
name_prompt db 'Enter your hero name: ',0
class_menu db 10,'Choose your character:',10,'[1] Warrior',10,'[2] Mage',10,'[3] Archer',10,'Enter choice: ',0
warrior db 'Warrior ',0
mage db 'Mage ',0
archer db 'Archer ',0
greeting db 10,'Welcome, ',0
newline db 10,0
invalid db 'Invalid input. Please try again.',10,0
main_menu db 10,'========== MAIN MENU ==========',10
          db '[1] Explore Dungeon',10,'[2] View Character Status',10
          db '[3] Use Health Potion',10,'[4] View Inventory',10
          db '[5] Exit Game',10,'Enter choice: ',0
goblin_art db 10,'ROOM 1 - GOBLIN CHAMBER',10
           db '          ,      ,',10
           db '         /(.-""-.)\',10
           db '     |\  \/      \/  /|',10
           db '     | \ / =.  .= \ / |',10
           db '      \  \   ^    /  /',10
           db "       \  '-----'  /",10
           db 'A GOBLIN APPEARS!',10,0
chest_art db 10,'ROOM 2 - TREASURE CHAMBER',10
          db '          __________',10
          db '         /_________/|',10
          db '        |  _____  | |',10
          db '        | |  ?  | | |',10
          db '        | |_____| | /',10
          db '        |_________|/',10
          db '[1] Open Chest  [2] Leave Chest',10,'Enter choice: ',0
dragon_art db 10,"ROOM 3 - DRAGON'S LAIR",10
           db '               / \  //\',10
           db '      |\___/|      \\',10
           db '      /0  0  \      |',10
           db '     /   ^    \    /',10
           db '    /  \___/   \  /',10
           db '    \___________\/',10
           db 'THE DRAGON AWAKENS!',10,0
combat_menu db '[1] Attack  [2] Defend',10,'[3] Use Potion  [4] Run',10,'Enter choice: ',0
hp_label db 'Health: ',0
max_label db ' / ',0
attack_label db 'Attack: ',0
enemy_label db 'Enemy Health: ',0
class_label db 'Class: ',0
name_label db 'Hero: ',0
room_label db 'Current Room: ',0
potions_label db 'Potions: ',0
gold_label db 'Gold: ',0
hit_label db 'You take damage: ',0
slain db 'Enemy defeated!',10,0
ran db 'You escaped to the main menu. The room has not advanced.',10,0
healed db 'Potion consumed. Restored health: ',0
empty db 'No potions left!',10,0
found db 'You found 50 gold!',10,0
left db 'You left the chest.',10,0
win db 10,'VICTORY!',10,'CONGRATULATIONS, ',0
win_end db '!',10,'You defeated the dragon and escaped!',10,'YOU ARE A HERO!',10,0
lose db 10,'GAME OVER',10,'Your hero has fallen.',10,'The dungeon remains undefeated.',10,'BETTER LUCK NEXT TIME!',10,0
bye db 'Thanks for playing!',10,0

SECTION .bss
hero_name resb 128
input_buffer resb 128
input_byte resb 1
number_buffer resb 12
class_name resd 1
health resd 1
max_health resd 1
attack resd 1
potions resd 1
gold resd 1
room resd 1
enemy_health resd 1
enemy_attack resd 1

SECTION .text
_start:
    call display_welcome
    call get_player_info
    call initialize_character
    PRINT greeting
    mov ecx, [class_name]
    call print_string
    PRINT hero_name
    PRINT newline
.main_loop:
    call display_main_menu
    call read_choice
    cmp eax, 1
    je .explore
    cmp eax, 2
    je .status
    cmp eax, 3
    je .potion
    cmp eax, 4
    je .inventory
    cmp eax, 5
    je exit_program
    PRINT invalid
    jmp .main_loop
.explore:
    call explore_dungeon
    cmp dword [health], 0
    jle .finished
    cmp dword [room], 4
    je .finished
    jmp .main_loop
.status:
    call display_status
    jmp .main_loop
.potion:
    call use_potion
    jmp .main_loop
.inventory:
    call display_inventory
    jmp .main_loop
.finished:
    call display_game_result
    jmp exit_program

display_welcome:
    PRINT welcome
    ret

get_player_info:
.name:
    PRINT name_prompt
    call read_line
    test eax, eax
    jz .bad_name
    ; Copy the name and its zero terminator into separate storage.
    mov ecx, eax
    inc ecx
    mov esi, input_buffer
    mov edi, hero_name
    cld
    rep movsb
    jmp .class
.bad_name:
    PRINT invalid
    jmp .name
.class:
    PRINT class_menu
    call read_choice
    cmp eax, 1
    jl .bad_class
    cmp eax, 3
    jg .bad_class
    ret                        
.bad_class:
    PRINT invalid
    jmp .class

initialize_character:
    mov dword [gold], 0
    mov dword [room], 1
    cmp eax, 2
    je .mage
    cmp eax, 3
    je .archer
    mov dword [health], 100
    mov dword [attack], 20
    mov dword [potions], 2
    mov dword [class_name], warrior
    jmp .maximum
.mage:
    mov dword [health], 70
    mov dword [attack], 30
    mov dword [potions], 3
    mov dword [class_name], mage
    jmp .maximum
.archer:
    mov dword [health], 85
    mov dword [attack], 25
    mov dword [potions], 2
    mov dword [class_name], archer
.maximum:
    mov eax, [health]
    mov [max_health], eax
    ret

display_main_menu:
    PRINT main_menu
    ret

explore_dungeon:
    cmp dword [room], 1
    je .goblin
    cmp dword [room], 2
    je .treasure
    cmp dword [room], 3
    je .dragon
    ret
.goblin:
    PRINT goblin_art
    mov dword [enemy_health], 30
    mov dword [enemy_attack], 10
    call battle_enemy
    cmp eax, 1
    jne .return
    inc dword [room]
    ret
.treasure:
    PRINT chest_art
    call read_choice
    cmp eax, 1
    je .open
    cmp eax, 2
    je .leave
    PRINT invalid
    jmp .treasure
.open:
    add dword [gold], 50
    PRINT found
    jmp .advance
.leave:
    PRINT left
.advance:
    inc dword [room]
    ret
.dragon:
    PRINT dragon_art
    mov dword [enemy_health], 60
    mov dword [enemy_attack], 15
    call battle_enemy
    cmp eax, 1
    jne .return
    inc dword [room]             
.return:
    ret

battle_enemy:
.turn:
    PRINT hp_label
    mov eax, [health]
    call print_number
    PRINT newline
    PRINT enemy_label
    mov eax, [enemy_health]
    call print_number
    PRINT newline
    PRINT combat_menu
    call read_choice
    cmp eax, 1
    je .attack
    cmp eax, 2
    je .defend
    cmp eax, 3
    je .potion
    cmp eax, 4
    je .run
    PRINT invalid
    jmp .turn
.attack:
    mov eax, [attack]
    sub [enemy_health], eax
    cmp dword [enemy_health], 0
    jle .won                    
    mov eax, [enemy_attack]
    jmp .damage
.defend:
    mov eax, [enemy_attack]
    sub eax, 5
    cmp eax, 0
    jge .damage
    xor eax, eax                
.damage:
    sub [health], eax
    PRINT hit_label
    call print_number
    PRINT newline
    cmp dword [health], 0
    jle .lost
    jmp .turn
.potion:
    call use_potion             
    jmp .turn
.run:
    PRINT ran
    xor eax, eax
    ret
.won:
    mov dword [enemy_health], 0
    PRINT slain
    mov eax, 1
    ret
.lost:
    mov dword [health], 0       
    mov eax, -1
    ret

use_potion:
    cmp dword [potions], 0
    jle .none
    dec dword [potions]
    mov edx, [health]
    mov eax, edx
    add eax, 20
    cmp eax, [max_health]
    jle .store
    mov eax, [max_health]
.store:
    mov [health], eax
    sub eax, edx
    PRINT healed
    call print_number
    PRINT newline
    ret
.none:
    PRINT empty
    ret

display_status:
    PRINT name_label
    PRINT hero_name
    PRINT newline
    PRINT class_label
    mov ecx, [class_name]
    call print_string
    PRINT newline
    PRINT hp_label
    mov eax, [health]
    call print_number
    PRINT max_label
    mov eax, [max_health]
    call print_number
    PRINT newline
    PRINT attack_label
    mov eax, [attack]
    call print_number
    PRINT newline
    PRINT room_label
    mov eax, [room]
    call print_number
    PRINT newline
    ret

display_inventory:
    PRINT gold_label
    mov eax, [gold]
    call print_number
    PRINT newline
    PRINT potions_label
    mov eax, [potions]
    call print_number
    PRINT newline
    ret

display_game_result:
    cmp dword [health], 0
    jle .loss
    PRINT win
    PRINT hero_name
    PRINT win_end
    call display_status
    call display_inventory
    ret
.loss:
    PRINT lose
    call display_status
    call display_inventory
    ret

exit_program:
    PRINT bye
    mov eax, 1                  
    xor ebx, ebx
    int 0x80

print_string:
    pushad
    xor edx, edx
.count:
    cmp byte [ecx + edx], 0
    je .write
    inc edx
    jmp .count
.write:
    mov eax, 4                  ; Linux sys_write
    mov ebx, 1                  ; Standard output
    int 0x80
    popad
    ret

print_number:
    pushad
    mov edi, number_buffer + 11
    mov byte [edi], 0
    mov ebx, 10
.convert:
    xor edx, edx
    div ebx
    add dl, '0'
    dec edi
    mov [edi], dl
    test eax, eax
    jnz .convert
    mov ecx, edi
    call print_string
    popad
    ret

read_line:
    push ebx
    push ecx
    push edx
    push esi
    push edi
    xor esi, esi
    xor edi, edi               
.read:
    mov eax, 3                  
    xor ebx, ebx                
    mov ecx, input_byte
    mov edx, 1
    int 0x80
    cmp eax, 0
    jle exit_program            
    mov al, [input_byte]
    cmp al, 10
    je .done
    cmp al, 13
    je .read
    cmp esi, 127
    jae .overflow
    mov [input_buffer + esi], al
    inc esi
    jmp .read
.overflow:
    mov edi, 1
    jmp .read
.done:
    test edi, edi
    jz .terminate
    xor esi, esi
.terminate:
    mov byte [input_buffer + esi], 0
    mov eax, esi
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    ret

read_choice:
    call read_line
    cmp eax, 1
    jne .invalid
    movzx eax, byte [input_buffer]
    cmp eax, '0'
    jl .invalid
    cmp eax, '9'
    jg .invalid
    sub eax, '0'
    ret
.invalid:
    mov eax, -1
    ret