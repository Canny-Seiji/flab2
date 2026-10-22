BITS 32
%define SYS_EXIT   1
%define SYS_READ   3
%define SYS_WRITE  4
%define STDIN      0
%define STDOUT     1
%define NAME_CAP   64
%define INPUT_CAP  128
section .data
    color_magenta db 27, "[1;35m", 0
    color_cyan db 27, "[1;36m", 0
    color_gold db 27, "[1;33m", 0
    color_green db 27, "[1;32m", 0
    color_reset db 27, "[0m", 0
    panel_top db 10, 27, "[1;35m", "+================================================+", 27, "[0m", 10, 0
    panel_rule db 27, "[1;36m", "+------------------------------------------------+", 27, "[0m", 10, 0
    panel_bottom db 27, "[1;35m", "+================================================+", 27, "[0m", 10, 10, 0
    oracle_subtitle db 27, "[1;33m", "              THE CELESTIAL PROFILE", 27, "[0m", 10, 0
    star_divider db 27, "[1;35m", "             *  .  *  .  *  .  *  .  *", 27, "[0m", 10, 0
    welcome_msg db 10, 27, "[1;35m"
                db "+================================================+", 10
                db "|                                                |", 10
                db "|           MYSTIC ZODIAC ORACLE                 |", 10
                db "|       YOUR GATEWAY TO THE CELESTIAL            |", 10
                db "|                                                |", 10
                db "+================================================+", 10
                db 27, "[1;36m", "  Discover your sign. Explore your possibilities.", 10
                db 27, "[1;33m", "       Love  *  Purpose  *  Fortune", 10
                db 27, "[1;35m", "+================================================+", 27, "[0m", 10, 10, 0
    name_prompt db 27, "[1;33m", "Enter your name: ", 27, "[0m", 0
    month_prompt db 27, "[1;33m", "Enter your birth month (1-12): ", 27, "[0m", 0
    day_prompt db 27, "[1;33m", "Enter your birth day: ", 27, "[0m", 0
    menu_prompt db 27, "[1;33m", "Select an option (1-6): ", 27, "[0m", 0
    greeting_msg db 10, "Welcome, ", 0
    greeting_end db "!", 10, 0
    invalid_input_msg db 27, "[1;31m", "Invalid input. Please try again.", 27, "[0m", 10, 0
    invalid_name_msg db 27, "[1;31m", "Name cannot be empty or too long.", 27, "[0m", 10, 0
    invalid_date_msg db 27, "[1;31m", "Invalid birthdate. Please enter a valid date.", 27, "[0m", 10, 0
    invalid_menu_msg db 27, "[1;31m", "Invalid menu choice. Select 1 through 6.", 27, "[0m", 10, 0
    newline db 10, 0
    menu_text db 10, 27, "[1;35m"
              db "+================================================+", 10
              db "|                  ORACLE MENU                   |", 10
              db "+------------------------------------------------+", 10
              db 27, "[1;36m", "|  [1] Love and Relationships                    |", 10
              db "|  [2] Career and Studies                        |", 10
              db "|  [3] Health and Wellness                       |", 10
              db "|  [4] Lucky Number and Color                    |", 10
              db "|  [5] View Zodiac Information                   |", 10
              db "|  [6] Exit                                      |", 10
              db 27, "[1;35m", "+================================================+", 27, "[0m", 10, 0
    exit_msg db 10, 27, "[1;32m"
             db "+================================================+", 10
             db "|          THE ORACLE HAS SPOKEN                 |", 10
             db "+================================================+", 10
             db 27, "[1;36m", " Thank you for consulting the Mystic Zodiac Oracle!", 10
             db " May your future be filled with possibilities.", 10
             db 27, "[1;35m", "+================================================+", 27, "[0m", 10, 0
    sign_label db 10, 27, "[1;32m", "Zodiac Sign: ", 27, "[0m", 0
    element_label db 27, "[36m", "Element: ", 27, "[0m", 0
    symbol_label db 27, "[36m", "Symbol: ", 27, "[0m", 0
    description_label db 27, "[36m", "Personality: ", 27, "[0m", 0
    art_label db 10, 27, "[1;35m", "Your Zodiac Artwork:", 27, "[0m", 10, 0
    love_label db 10, 27, "[1;35m", "--- Love and Relationships ---", 27, "[0m", 10, 0
    career_label db 10, 27, "[1;35m", "--- Career and Studies ---", 27, "[0m", 10, 0
    health_label db 10, 27, "[1;35m", "--- Health and Wellness ---", 27, "[0m", 10, 0
    lucky_label db 10, 27, "[1;35m", "--- Lucky Number and Color ---", 27, "[0m", 10, 0
    lucky_number_label db 27, "[1;33m", "  Lucky Number: ", 27, "[0m", 0
    lucky_color_label db 27, "[1;33m", "  Lucky Color:  ", 27, "[0m", 0
    prediction_disclaimer db 10
        db "Note: These horoscope predictions are fictional", 10
        db "and intended for entertainment purposes only.", 10, 0
    name_capricorn db "Capricorn", 0
    name_aquarius db "Aquarius", 0
    name_pisces db "Pisces", 0
    name_aries db "Aries", 0
    name_taurus db "Taurus", 0
    name_gemini db "Gemini", 0
    name_cancer db "Cancer", 0
    name_leo db "Leo", 0
    name_virgo db "Virgo", 0
    name_libra db "Libra", 0
    name_scorpio db "Scorpio", 0
    name_sagittarius db "Sagittarius", 0
    zodiac_names dd name_capricorn, name_aquarius
                 dd name_pisces, name_aries
                 dd name_taurus, name_gemini
                 dd name_cancer, name_leo
                 dd name_virgo, name_libra
                 dd name_scorpio, name_sagittarius
    element_earth db "Earth", 0
    element_air db "Air", 0
    element_water db "Water", 0
    element_fire db "Fire", 0
    zodiac_elements dd element_earth, element_air
                    dd element_water, element_fire
                    dd element_earth, element_air
                    dd element_water, element_fire
                    dd element_earth, element_air
                    dd element_water, element_fire
    symbol_capricorn db "The Sea-Goat", 0
    symbol_aquarius db "The Water-Bearer", 0
    symbol_pisces db "The Fish", 0
    symbol_aries db "The Ram", 0
    symbol_taurus db "The Bull", 0
    symbol_gemini db "The Twins", 0
    symbol_cancer db "The Crab", 0
    symbol_leo db "The Lion", 0
    symbol_virgo db "The Maiden", 0
    symbol_libra db "The Scales", 0
    symbol_scorpio db "The Scorpion", 0
    symbol_sagittarius db "The Archer", 0
    zodiac_symbols dd symbol_capricorn, symbol_aquarius
                   dd symbol_pisces, symbol_aries
                   dd symbol_taurus, symbol_gemini
                   dd symbol_cancer, symbol_leo
                   dd symbol_virgo, symbol_libra
                   dd symbol_scorpio, symbol_sagittarius
    desc_capricorn db "Disciplined, practical, and determined.", 0
    desc_aquarius db "Independent, inventive, and thoughtful.", 0
    desc_pisces db "Imaginative, compassionate, and intuitive.", 0
    desc_aries db "Courageous, energetic, and adventurous.", 0
    desc_taurus db "Patient, dependable, and persistent.", 0
    desc_gemini db "Curious, adaptable, and expressive.", 0
    desc_cancer db "Caring, protective, and perceptive.", 0
    desc_leo db "Confident, generous, and expressive.", 0
    desc_virgo db "Analytical, organized, and attentive.", 0
    desc_libra db "Diplomatic, balanced, and cooperative.", 0
    desc_scorpio db "Determined, observant, and resourceful.", 0
    desc_sagittarius db "Optimistic, adventurous, and independent.", 0
    zodiac_descriptions dd desc_capricorn, desc_aquarius
                        dd desc_pisces, desc_aries
                        dd desc_taurus, desc_gemini
                        dd desc_cancer, desc_leo
                        dd desc_virgo, desc_libra
                        dd desc_scorpio, desc_sagittarius
    art_capricorn db "                     /\_/\ ", 10
                  db "                    ( o.o )", 10
                  db "                     > ^ <", 10
                  db "                   CAPRICORN", 10, 0
    art_aquarius db "                      .--.", 10
                 db "                    /    \ ", 10
                 db "                   | WATER |", 10
                 db "                    \_____/", 10
                 db "                    AQUARIUS", 10, 0
    art_pisces db "                    ><(((('>", 10
               db "                    <' )))><", 10
               db "                     PISCES", 10, 0
    art_aries db "                      /\ ", 10
              db "                     /  \ ", 10
              db "                    (RAM )", 10
              db "                    ARIES", 10, 0
    art_taurus db "                    (____)", 10
               db "                    /    \ ", 10
               db "                   /TAURUS\ ", 10
               db "                   \______/", 10, 0
    art_gemini db "                     .----.", 10
               db "                     | || |", 10
               db "                     | || |", 10
               db "                     GEMINI", 10, 0
    art_cancer db "                      .--.", 10
               db "                     (o  o)", 10
               db "                      \__/", 10
               db "                     CANCER", 10, 0
    art_leo db "                     /\_/\ ", 10
            db "                    ( o.o )", 10
            db "                     > ^ <", 10
            db "                      LEO", 10, 0
    art_virgo db "                      .-.", 10
              db "                     (   )", 10
              db "                      '-'", 10
              db "                     VIRGO", 10, 0
    art_libra db "                    ______", 10
              db "                   /______\ ", 10
              db "                      ||", 10
              db "                    __||__", 10
              db "                     LIBRA", 10, 0
    art_scorpio db "                   /\_/\ ", 10
                db "                  ( o.o )---->", 10
                db "                    SCORPIO", 10, 0
    art_sagittarius db "                       /", 10
                    db "                      /", 10
                    db "                     /---->", 10
                    db "                  SAGITTARIUS", 10, 0
    zodiac_art dd art_capricorn, art_aquarius
               dd art_pisces, art_aries
               dd art_taurus, art_gemini
               dd art_cancer, art_leo
               dd art_virgo, art_libra
               dd art_scorpio, art_sagittarius
    love_0 db "Patience may strengthen an important bond.", 0
    love_1 db "An honest conversation may reveal new possibilities.", 0
    love_2 db "Kindness may bring an unexpected connection.", 0
    love_3 db "Confidence may help you express your feelings.", 0
    love_4 db "Consistency may deepen a meaningful relationship.", 0
    love_5 db "A lively conversation may brighten your day.", 0
    love_6 db "Listening carefully may resolve a misunderstanding.", 0
    love_7 db "A thoughtful gesture may bring people closer.", 0
    love_8 db "Small acts of care may mean more than grand promises.", 0
    love_9 db "Balance and compromise may improve a relationship.", 0
    love_10 db "Trust may grow when you communicate openly.", 0
    love_11 db "A shared adventure may create a lasting memory.", 0
    love_predictions dd love_0, love_1, love_2, love_3
                    dd love_4, love_5, love_6, love_7
                    dd love_8, love_9, love_10, love_11
    career_0 db "Steady effort may bring progress toward a long-term goal.", 0
    career_1 db "A new approach may help you solve a difficult problem.", 0
    career_2 db "Creativity may help you see an overlooked solution.", 0
    career_3 db "Taking initiative may open a useful opportunity.", 0
    career_4 db "A consistent study routine may improve your results.", 0
    career_5 db "Sharing ideas may lead to an interesting collaboration.", 0
    career_6 db "A supportive teammate may help you move forward.", 0
    career_7 db "Your preparation may help you perform with confidence.", 0
    career_8 db "Organizing your priorities may make work more manageable.", 0
    career_9 db "Cooperation may help your team reach a shared objective.", 0
    career_10 db "Persistence may help you overcome a complex challenge.", 0
    career_11 db "Exploring a new subject may expand your skills.", 0
    career_predictions dd career_0, career_1, career_2, career_3
                      dd career_4, career_5, career_6, career_7
                      dd career_8, career_9, career_10, career_11
    health_0 db "A balanced schedule may help you feel more organized.", 0
    health_1 db "Making time for rest may help restore your focus.", 0
    health_2 db "A quiet moment may help you reset after a busy day.", 0
    health_3 db "Regular breaks may help you manage a demanding routine.", 0
    health_4 db "A consistent sleep schedule may support your daily routine.", 0
    health_5 db "A change of scenery may help refresh your mind.", 0
    health_6 db "Connecting with supportive people may brighten your mood.", 0
    health_7 db "Making room for recreation may improve your balance.", 0
    health_8 db "Planning your day may leave more time for yourself.", 0
    health_9 db "A calmer routine may help you avoid unnecessary stress.", 0
    health_10 db "Setting reasonable boundaries may protect your free time.", 0
    health_11 db "An enjoyable outdoor activity may refresh your perspective.", 0
    health_predictions dd health_0, health_1, health_2, health_3
                      dd health_4, health_5, health_6, health_7
                      dd health_8, health_9, health_10, health_11
    lucky_0 db "8", 0
    lucky_1 db "11", 0
    lucky_2 db "7", 0
    lucky_3 db "9", 0
    lucky_4 db "6", 0
    lucky_5 db "5", 0
    lucky_6 db "2", 0
    lucky_7 db "1", 0
    lucky_8 db "4", 0
    lucky_9 db "6", 0
    lucky_10 db "13", 0
    lucky_11 db "3", 0
    lucky_numbers dd lucky_0, lucky_1, lucky_2, lucky_3
                  dd lucky_4, lucky_5, lucky_6, lucky_7
                  dd lucky_8, lucky_9, lucky_10, lucky_11
    color_0 db "Brown", 0
    color_1 db "Electric Blue", 0
    color_2 db "Sea Green", 0
    color_3 db "Red", 0
    color_4 db "Green", 0
    color_5 db "Yellow", 0
    color_6 db "Silver", 0
    color_7 db "Gold", 0
    color_8 db "Navy Blue", 0
    color_9 db "Pink", 0
    color_10 db "Maroon", 0
    color_11 db "Purple", 0
    lucky_colors dd color_0, color_1, color_2, color_3
                 dd color_4, color_5, color_6, color_7
                 dd color_8, color_9, color_10, color_11
section .bss
    name_buffer resb NAME_CAP
    input_buffer resb INPUT_CAP
    read_char resb 1
    input_len resd 1
    birth_month resd 1
    birth_day resd 1
    zodiac_id resd 1
    menu_choice resd 1
section .text
    global _start
_start:
    call display_welcome
    call get_user_info
.date_validation_loop:
    call validate_birthdate
    cmp eax, 1
    je .valid_birthdate
    mov esi, invalid_date_msg
    call print_cstr
    call get_birthdate
    jmp .date_validation_loop
.valid_birthdate:
    call determine_zodiac
    mov esi, star_divider
    call print_cstr
    mov esi, greeting_msg
    call print_cstr
    mov esi, color_gold
    call print_cstr
    mov esi, name_buffer
    call print_cstr
    mov esi, color_reset
    call print_cstr
    mov esi, greeting_end
    call print_cstr
    mov esi, star_divider
    call print_cstr
    call display_zodiac_info
.menu_loop:
    call display_menu
    call get_menu_choice
    call show_horoscope
    jmp .menu_loop
display_welcome:
    push esi
    mov esi, welcome_msg
    call print_cstr
    pop esi
    ret
get_user_info:
    push esi
.name_loop:
    mov esi, name_prompt
    call print_cstr
    mov edi, name_buffer
    mov ecx, NAME_CAP
    call read_line
    cmp edx, 1
    je .invalid_name
    cmp eax, 0
    je .invalid_name
    call get_birthdate
    pop esi
    ret
.invalid_name:
    mov esi, invalid_name_msg
    call print_cstr
    jmp .name_loop
get_birthdate:
    push esi
    mov esi, month_prompt
    call get_number
    mov [birth_month], eax
    mov esi, day_prompt
    call get_number
    mov [birth_day], eax
    pop esi
    ret
validate_birthdate:
    push ebx
    mov eax, [birth_month]
    mov ebx, [birth_day]
    cmp eax, 1
    jl .invalid
    cmp eax, 12
    jg .invalid
    cmp ebx, 1
    jl .invalid
    cmp eax, 2
    je .february
    cmp eax, 4
    je .thirty_days
    cmp eax, 6
    je .thirty_days
    cmp eax, 9
    je .thirty_days
    cmp eax, 11
    je .thirty_days
    cmp ebx, 31
    jg .invalid
    mov eax, 1
    jmp .validation_done
.february:
    cmp ebx, 28
    jg .invalid
    mov eax, 1
    jmp .validation_done
.thirty_days:
    cmp ebx, 30
    jg .invalid
    mov eax, 1
    jmp .validation_done
.invalid:
    mov eax, 0
.validation_done:
    pop ebx
    ret
determine_zodiac:
    mov eax, [birth_month]
    mov ecx, [birth_day]
    cmp eax, 1
    je .january
    cmp eax, 2
    je .february
    cmp eax, 3
    je .march
    cmp eax, 4
    je .april
    cmp eax, 5
    je .may
    cmp eax, 6
    je .june
    cmp eax, 7
    je .july
    cmp eax, 8
    je .august
    cmp eax, 9
    je .september
    cmp eax, 10
    je .october
    cmp eax, 11
    je .november
    cmp ecx, 21
    jle .sagittarius
    mov dword [zodiac_id], 0
    ret
.january:
    cmp ecx, 19
    jle .capricorn
    mov dword [zodiac_id], 1
    ret
.february:
    cmp ecx, 18
    jle .aquarius
    mov dword [zodiac_id], 2
    ret
.march:
    cmp ecx, 20
    jle .pisces
    mov dword [zodiac_id], 3
    ret
.april:
    cmp ecx, 19
    jle .aries
    mov dword [zodiac_id], 4
    ret
.may:
    cmp ecx, 20
    jle .taurus
    mov dword [zodiac_id], 5
    ret
.june:
    cmp ecx, 20
    jle .gemini
    mov dword [zodiac_id], 6
    ret
.july:
    cmp ecx, 22
    jle .cancer
    mov dword [zodiac_id], 7
    ret
.august:
    cmp ecx, 22
    jle .leo
    mov dword [zodiac_id], 8
    ret
.september:
    cmp ecx, 22
    jle .virgo
    mov dword [zodiac_id], 9
    ret
.october:
    cmp ecx, 22
    jle .libra
    mov dword [zodiac_id], 10
    ret
.november:
    cmp ecx, 21
    jle .scorpio
    mov dword [zodiac_id], 11
    ret
.capricorn:
    mov dword [zodiac_id], 0
    ret
.aquarius:
    mov dword [zodiac_id], 1
    ret
.pisces:
    mov dword [zodiac_id], 2
    ret
.aries:
    mov dword [zodiac_id], 3
    ret
.taurus:
    mov dword [zodiac_id], 4
    ret
.gemini:
    mov dword [zodiac_id], 5
    ret
.cancer:
    mov dword [zodiac_id], 6
    ret
.leo:
    mov dword [zodiac_id], 7
    ret
.virgo:
    mov dword [zodiac_id], 8
    ret
.libra:
    mov dword [zodiac_id], 9
    ret
.scorpio:
    mov dword [zodiac_id], 10
    ret
.sagittarius:
    mov dword [zodiac_id], 11
    ret
display_zodiac_info:
    push esi
    mov esi, panel_top
    call print_cstr
    mov esi, oracle_subtitle
    call print_cstr
    mov esi, star_divider
    call print_cstr
    mov esi, sign_label
    call print_cstr
    mov eax, [zodiac_id]
    mov esi, [zodiac_names + eax*4]
    call print_cstr
    mov esi, newline
    call print_cstr
    mov esi, panel_rule
    call print_cstr
    mov esi, element_label
    call print_cstr
    mov eax, [zodiac_id]
    mov esi, [zodiac_elements + eax*4]
    call print_cstr
    mov esi, newline
    call print_cstr
    mov esi, panel_rule
    call print_cstr
    mov esi, symbol_label
    call print_cstr
    mov eax, [zodiac_id]
    mov esi, [zodiac_symbols + eax*4]
    call print_cstr
    mov esi, newline
    call print_cstr
    mov esi, panel_rule
    call print_cstr
    mov esi, description_label
    call print_cstr
    mov eax, [zodiac_id]
    mov esi, [zodiac_descriptions + eax*4]
    call print_cstr
    mov esi, newline
    call print_cstr
    mov esi, panel_bottom
    call print_cstr
    call display_zodiac_art
    pop esi
    ret

display_zodiac_art:
    push esi
    mov esi, panel_top
    call print_cstr
    mov esi, art_label
    call print_cstr
    mov esi, color_magenta
    call print_cstr
    mov eax, [zodiac_id]
    mov esi, [zodiac_art + eax*4]
    call print_cstr
    mov esi, color_reset
    call print_cstr
    mov esi, star_divider
    call print_cstr
    mov esi, panel_bottom
    call print_cstr
    pop esi
    ret

display_menu:
    push esi
    mov esi, menu_text
    call print_cstr
    pop esi
    ret
get_menu_choice:
    push esi
.menu_input_loop:
    mov esi, menu_prompt
    call get_number
    cmp eax, 1
    jl .invalid_choice
    cmp eax, 6
    jg .invalid_choice
    mov [menu_choice], eax
    pop esi
    ret
.invalid_choice:
    mov esi, invalid_menu_msg
    call print_cstr
    jmp .menu_input_loop
show_horoscope:
    push esi
    mov eax, [menu_choice]
    cmp eax, 1
    je .love
    cmp eax, 2
    je .career
    cmp eax, 3
    je .health
    cmp eax, 4
    je .lucky
    cmp eax, 5
    je .zodiac_info
    cmp eax, 6
    je .exit
    jmp .done
.love:
    mov esi, panel_top
    call print_cstr
    mov esi, love_label
    call print_cstr
    mov esi, panel_rule
    call print_cstr
    mov eax, [zodiac_id]
    mov esi, [love_predictions + eax*4]
    call print_cstr
    mov esi, newline
    call print_cstr
    mov esi, prediction_disclaimer
    call print_cstr
    mov esi, panel_bottom
    call print_cstr
    jmp .done
.career:
    mov esi, panel_top
    call print_cstr
    mov esi, career_label
    call print_cstr
    mov esi, panel_rule
    call print_cstr
    mov eax, [zodiac_id]
    mov esi, [career_predictions + eax*4]
    call print_cstr
    mov esi, newline
    call print_cstr
    mov esi, prediction_disclaimer
    call print_cstr
    mov esi, panel_bottom
    call print_cstr
    jmp .done
.health:
    mov esi, panel_top
    call print_cstr
    mov esi, health_label
    call print_cstr
    mov esi, panel_rule
    call print_cstr
    mov eax, [zodiac_id]
    mov esi, [health_predictions + eax*4]
    call print_cstr
    mov esi, newline
    call print_cstr
    mov esi, prediction_disclaimer
    call print_cstr
    mov esi, panel_bottom
    call print_cstr
    jmp .done
.lucky:
    mov esi, panel_top
    call print_cstr
    mov esi, lucky_label
    call print_cstr
    mov esi, panel_rule
    call print_cstr
    mov esi, lucky_number_label
    call print_cstr
    mov eax, [zodiac_id]
    mov esi, [lucky_numbers + eax*4]
    call print_cstr
    mov esi, newline
    call print_cstr
    mov esi, lucky_color_label
    call print_cstr
    mov eax, [zodiac_id]
    mov esi, [lucky_colors + eax*4]
    call print_cstr
    mov esi, newline
    call print_cstr
    mov esi, prediction_disclaimer
    call print_cstr
    mov esi, panel_bottom
    call print_cstr
    jmp .done
.zodiac_info:
    call display_zodiac_info
    jmp .done
.exit:
    mov esi, exit_msg
    call print_cstr
    pop esi
    call exit_program
.done:
    pop esi
    ret
exit_program:
    mov eax, SYS_EXIT
    mov ebx, 0
    int 0x80
get_number:
    push esi
.number_input_loop:
    mov esi, [esp]
    call print_cstr
    mov edi, input_buffer
    mov ecx, INPUT_CAP
    call read_line
    mov [input_len], eax
    cmp edx, 1
    je .invalid_number
    call parse_uint
    cmp edx, 1
    jne .invalid_number
    pop esi
    ret
.invalid_number:
    mov esi, invalid_input_msg
    call print_cstr
    jmp .number_input_loop
parse_uint:
    push ebx
    push esi
    mov ecx, [input_len]
    cmp ecx, 0
    je .parse_invalid
    mov esi, input_buffer
    xor eax, eax
.parse_loop:
    movzx ebx, byte [esi]
    cmp ebx, '0'
    jl .parse_invalid
    cmp ebx, '9'
    jg .parse_invalid
    sub ebx, '0'
    imul eax, eax, 10
    add eax, ebx
    cmp eax, 9999
    ja .parse_invalid
    inc esi
    dec ecx
    cmp ecx, 0
    jne .parse_loop
    mov edx, 1
    jmp .parse_done
.parse_invalid:
    xor eax, eax
    xor edx, edx
.parse_done:
    pop esi
    pop ebx
    ret
read_line:
    push ebp
    push edi
    push esi
    push dword 0
    mov esi, edi
    mov ebp, ecx
    xor edi, edi
.read_loop:
    mov eax, SYS_READ
    mov ebx, STDIN
    mov ecx, read_char
    mov edx, 1
    int 0x80
    cmp eax, 1
    jne .read_done
    mov al, [read_char]
    cmp al, 10
    je .read_done
    cmp al, 13
    je .read_loop
    mov eax, ebp
    dec eax
    cmp edi, eax
    jae .buffer_full
    mov al, [read_char]
    mov [esi + edi], al
    inc edi
    jmp .read_loop
.buffer_full:
    mov dword [esp], 1
    jmp .read_loop
.read_done:
    mov byte [esi + edi], 0
    mov eax, edi
    mov edx, [esp]
    add esp, 4
    pop esi
    pop edi
    pop ebp
    ret
print_cstr:
    push ebx
    push ecx
    push edx
    push esi
    push edi
    mov edi, esi
    xor edx, edx
.count_loop:
    cmp byte [edi], 0
    je .write_string
    inc edi
    inc edx
    jmp .count_loop
.write_string:
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, esi
    int 0x80
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    ret
