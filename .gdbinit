## source ~/Gdbinit/gdbinit
source ~/Gdbinit/stl-views.gdb
source ~/Gdbinit/pygdb.py
# # tui enable
# # winheight src 15
# 保存历史命令
set history filename ./.gdb_history
set history save on
# 记录执行gdb的过程
set logging file ./.log.txt
set logging on
set logging redirect on
set logging overwrite off
# set logging debugredirect on
# 退出时不显示提示信息
# set confirm off
# 打印数组的索引下标
set print array-indexes on
# 每行打印一个结构体成员
set print pretty on
# 退出并保留断点
define qbp
    save breakpoints ./.gdb_bp
    quit
end
document qbp
    Exit and save the breakpoint
end
# 保留历史工作断点
define downbp
    save breakpoints ./.gdb_bp
end
document downbp
    Save the historical work breakpoint
end
# 加载历史工作断点
define loadbp
    source ./.gdb_bp
end
document loadbp
    Load the historical work breakpoint
end

define myloop_print
set $total = $arg0
set $i = 0
   while($i<$total)
     set $i = $i + 1
     print $i, $i
     cont
   end
end

define plistnode
    set $i=0
    set $_node = (ListNode*)$arg0
    while $_node
        set $i = $i + 1
        printf "node %d address:0x%lx val:%d next:0x%lx \n",$i, $_node,$_node->val,$_node->next
        set $_node = $_node->next
    end
end
document plistnode
    This is a command to dump all elements in Linked List
    arg0 is the head
end


###A gdbinit file for use when debugging on the MIPS CPU architecture.
###Copyright (C) 2012  Zachary Cutlip [uid000_at_gmail_dot_com]
###                                   TWitter: @zcutlip
###
###This program is free software; you can redistribute it and/or
###modify it under the terms of the GNU General Public License
###as published by the Free Software Foundation; either version 2
###of the License, or (at your option) any later version.
###
###This program is distributed in the hope that it will be useful,
###but WITHOUT ANY WARRANTY; without even the implied warranty of
###MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
###GNU General Public License for more details.
###
###You should have received a copy of the GNU General Public License
###along with this program; if not, write to the Free Software
###Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

###-----------------------------------------------------------------------------
###                                global options
###-----------------------------------------------------------------------------
##set height 0
##set width 0
##set history save on
##set history filename ~/.gdb_mips_history

##set $64BITS = 0
##set $CONTEXTSIZE_CODE = 8
##set $CONTEXTSIZE_STACK = 6
##set $SHOWSTACK = 0
##set $COLOR=1

##-----------------------------------------------------------------------------
##                           variable initialization
##-----------------------------------------------------------------------------
#set $oldv0 = 0
#set $oldv1 = 0
#set $olda0 = 0
#set $olda1 = 0
#set $olda2 = 0
#set $olda3 = 0
#set $oldt0 = 0
#set $oldt1 = 0
#set $oldt2 = 0
#set $oldt3 = 0
#set $oldt4 = 0
#set $oldt5 = 0
#set $oldt6 = 0
#set $oldt7 = 0
#set $oldt8 = 0
#set $oldt9 = 0
#set $olds0 = 0
#set $olds1 = 0
#set $olds2 = 0
#set $olds3 = 0
#set $olds4 = 0
#set $olds5 = 0
#set $olds6 = 0
#set $olds7 = 0
#set $olds8 = 0
#set $oldgp = 0
#set $oldlo = 0
#set $oldhi = 0
#set $oldsp = 0
#set $oldra = 0
#set $oldpc = 0
##

###-----------------------------------------------------------------------------
###                                color-helpers
###-----------------------------------------------------------------------------
### define coloron
###     set $COLOR=1
### end
### define coloroff
###     set $COLOR=0
###     nocolor
### end

### define green
###     if $COLOR == 1
###         echo \033[32m
###     end
### end

### define red
###     if $COLOR == 1
###         echo \033[31m
###     end
### end

### define blue
###     if $COLOR == 1
###         echo \033[34m
###     end
### end

### define nocolor
###     echo \033[0m
### end

### define draw-separator
###     blue
###     printf "-----------------------------------------------------------------"
###     printf "\n"
###     nocolor
### end

##-----------------------------------------------------------------------------
##                              breakpoint aliases
##-----------------------------------------------------------------------------

#define bpl
#    info breakpoints
#end
#document bpl
#List all breakpoints.
#end


#define bp
#    if $argc != 1
#        help bp
#    else
#        break $arg0
#    end
#end

#define bpc
#    if $argc != 1
#        help
#    else
#        clear $arg0
#    end
#end
#document bpc
#Clear breakpoint.
#Usage: bpc LOCATION
#LOCATION may be a line number, function name, or "*" and an address.
#end

#define bpe
#    if $argc != 1
#        help bpe
#    else
#        enable $arg0
#    end
#end
#document bpe
#Enable breakpoint with number NUM.
#Usage: bpe NUM
#end

#define bpd
#end
#document bpd
#end

#define bpt
#end
#document bpt
#end

#define bpm
#end
#document bpm
#end

#define bhb
#end
#document bhb
#end

#define bht
#end
#document bht
#end



##-----------------------------------------------------------------------------
##                                  hex/ascii
##-----------------------------------------------------------------------------

#define ascii_char
#    if $argc != 1
#        help ascii_char
#    else
#        # thanks elaine :)
#        set $_c = *(unsigned char *)($arg0)
#        if ($_c < 0x20 || $_c > 0x7E)
#            printf "."
#        else
#            printf "%c", $_c
#        end
#    end
#end
#document ascii_char
#Print ASCII value of byte at address ADDR.
#Print "." if the value is unprintable.
#Usage: ascii_char ADDR
#end

#define hex_quad
#    if $argc != 1
#        help hex_quad
#    else
#        printf "%02X %02X %02X %02X %02X %02X %02X %02X", \
#               *(unsigned char*)($arg0), *(unsigned char*)($arg0 + 1),     \
#               *(unsigned char*)($arg0 + 2), *(unsigned char*)($arg0 + 3), \
#               *(unsigned char*)($arg0 + 4), *(unsigned char*)($arg0 + 5), \
#               *(unsigned char*)($arg0 + 6), *(unsigned char*)($arg0 + 7)
#    end
#end
#document hex_quad
#Print eight hexadecimal bytes starting at address ADDR.
#Usage: hex_quad ADDR
#end



#define hexdump
#    if $argc != 1
#        help hexdump
#    else
#        echo \033[1m
#        if ($64BITS == 1)
#         printf "0x%016lX : ", $arg0
#        else
#         printf "0x%08X : ", $arg0
#        end
#        echo \033[0m
#        hex_quad $arg0
#        echo \033[1m
#        printf " - "
#        nocolor
#        hex_quad $arg0+8
#        printf " "
#        echo \033[1m
#        ascii_char $arg0+0x0
#        ascii_char $arg0+0x1
#        ascii_char $arg0+0x2
#        ascii_char $arg0+0x3
#        ascii_char $arg0+0x4
#        ascii_char $arg0+0x5
#        ascii_char $arg0+0x6
#        ascii_char $arg0+0x7
#        ascii_char $arg0+0x8
#        ascii_char $arg0+0x9
#        ascii_char $arg0+0xA
#        ascii_char $arg0+0xB
#        ascii_char $arg0+0xC
#        ascii_char $arg0+0xD
#        ascii_char $arg0+0xE
#        ascii_char $arg0+0xF
#        echo \033[0m
#        printf "\n"
#    end
#end
#document hexdump
#Display a 16-byte hex/ASCII dump of memory at address ADDR.
#Usage: hexdump ADDR
#end




##-----------------------------------------------------------------------------
##                              process information
##-----------------------------------------------------------------------------

#define pp-reg
#    if $argc !=2
#        help pp-reg
#    else
#        set $newreg = $arg0
#        set $oldreg = $arg1
#        if $newreg != $oldreg
#            red
#        end
#        printf "%08X",$newreg
#        nocolor
#    end
#end
#document pp-reg
#pretty print register value, with color based on old register value
#Usage: show-reg REG OLDREG
#end


#define reg
#    draw-separator
#    red
#    printf "[registers]\n"
#    nocolor
   
#    #Line 1
#    printf "  "

#    #V0
#    green
#    printf "V0: "
#    nocolor
#    pp-reg $v0 $oldv0
#    printf "  "

#    #V1
#    green
#    printf "V1: "
#    nocolor
#    pp-reg $v1 $oldv1
#    printf "  "

#    #A0
#    green
#    printf "A0: "
#    nocolor
#    pp-reg $a0 $olda0
#    printf "  "

#    #A1
#    green
#    printf "A1: "
#    nocolor
#    pp-reg $a1 $olda1
#    printf "\n"
   
#    #Line 2
#    printf "  "
   
#    #A2
#    green
#    printf "A2: "
#    nocolor
#    pp-reg $a2 $olda2
#    printf "  "
   
#    #A3
#    green
#    printf "A3: "
#    nocolor
#    pp-reg $a3 $olda3
#    printf "  "

#    #T0
#    green
#    printf "T0: "
#    nocolor
#    pp-reg $t0 $oldt0
#    printf "  "

#    #T1
#    green
#    printf "T1: "
#    nocolor
#    pp-reg $t1 $oldt1
#    printf "\n"
   

#    #Line 3
#    printf "  "
   
   
#    #T2
#    green
#    printf "T2: "
#    nocolor
#    pp-reg $t2 $oldt2
#    printf "  "

#    #T2
#    green
#    printf "T3: "
#    nocolor
#    pp-reg $t3 $oldt3
#    printf "  "

#    #T4
#    green
#    printf "T4: "
#    nocolor
#    pp-reg $t4 $oldt4
#    printf "  "

#    #T5
#    green
#    printf "T5: "
#    nocolor
#    pp-reg $t5 $oldt5
#    printf "\n"

#    #Line 4
#    printf "  "

#    #T6
#    green
#    printf "T6: "
#    nocolor
#    pp-reg $t6 $oldt6
#    printf "  "

#    #T7
#    green
#    printf "T7: "
#    nocolor
#    pp-reg $t7 $oldt7
#    printf "  "

#    #S0
#    green
#    printf "S0: "
#    nocolor
#    pp-reg $s0 $olds0
#    printf "  "

#    #S1
#    green
#    printf "S1: "
#    nocolor
#    pp-reg $s1 $olds1
#    printf "\n"

#    #Line 5
#    printf "  "

#    #S2
#    green
#    printf "S2: "
#    nocolor
#    pp-reg $s2 $olds2
#    printf "  "

#    #S3
#    green
#    printf "S3: "
#    nocolor
#    pp-reg $s3 $olds3
#    printf "  "

#    #S4
#    green
#    printf "S4: "
#    nocolor
#    pp-reg $s4 $olds4
#    printf "  "

#    #S5
#    green
#    printf "S5: "
#    nocolor
#    pp-reg $s5 $olds5
#    printf "\n"

#    #Line 6
#    printf "  "

#    #S6
#    green
#    printf "S6: "
#    nocolor
#    pp-reg $s6 $olds6
#    printf "  "

#    #S7
#    green
#    printf "S7: "
#    nocolor
#    pp-reg $s7 $olds7
#    printf "  "
   
#    #T8
#    green
#    printf "T8: "
#    nocolor
#    pp-reg $t8 $oldt8
#    printf "  "
   
#    #T9
#    green
#    printf "T9: "
#    nocolor
#    pp-reg $t9 $oldt9
#    printf "\n"

#    #Line 7
#    printf "  "

#    #GP
#    green
#    printf "GP: "
#    nocolor
#    pp-reg $gp $oldgp
#    printf "  "
   
#    #S8
#    green
#    printf "S8: "
#    nocolor
#    pp-reg $s8 $olds8
#    printf "  "

#    #HI
#    green
#    printf "HI: "
#    nocolor
#    pp-reg $hi $oldhi
#    printf "  "
   
#    #LO
#    green
#    printf "LO: "
#    nocolor
#    pp-reg $lo $oldlo
#    printf "\n"

#    #Line 8
#    printf "  "

#    #SP
#    green
#    printf "SP: "
#    nocolor
#    pp-reg $sp $oldsp
#    printf "  "

#    #PC
#    green
#    printf "PC: "
#    nocolor
#    #no need to track old pc, since it changes every time
#    pp-reg $pc $pc
#    printf "  "
   
#    #RA
#    green
#    printf "RA: "
#    nocolor
#    pp-reg $ra $oldra
#    printf "\n"
   

#    set $oldv0 = $v0
#    set $oldv1 = $v1
#    set $olda0 = $a0
#    set $olda1 = $a1
#    set $olda2 = $a2
#    set $olda3 = $a3
#    set $oldt0 = $t0
#    set $oldt1 = $t1
#    set $oldt2 = $t2
#    set $oldt3 = $t3
#    set $oldt4 = $t4
#    set $oldt5 = $t5
#    set $oldt6 = $t6
#    set $oldt7 = $t7
#    set $oldt8 = $t8
#    set $oldt9 = $t9
#    set $olds0 = $s0
#    set $olds1 = $s1
#    set $olds2 = $s2
#    set $olds3 = $s3
#    set $olds4 = $s4
#    set $olds5 = $s5
#    set $olds6 = $s6
#    set $olds7 = $s7
#    set $olds8 = $s8
#    set $oldgp = $gp
#    set $oldlo = $lo
#    set $oldhi = $hi
#    set $oldsp = $sp
#    set $oldra = $ra
#    set $oldpc = $pc
##
#end
#document reg
#display registers
#end

#define code
#    draw-separator
#    red
#    printf "[code]\n"
#    nocolor

#    set $context_i = $CONTEXTSIZE_CODE
#    if ($context_i > 0)
#        green
#        x /i $pc
#        set $context_i--
#        nocolor
#    end
#    while ($context_i > 0)
#        x /i
#        set $context_i--
#    end
   
   
#end

#define showstack
#    draw-separator
#    red
#    printf "[stack]\n"
#    printf "[sp: 0x%08X]\n", $sp
#    nocolor
#    set $context_i = $CONTEXTSIZE_STACK
#    while ($context_i > 0)
#        set $context_t = $sp + 0x10 * ($context_i - 1)
#        hexdump $context_t
#        set $context_i--
#    end
#end

#define context
#    reg
#    code
#    if ($SHOWSTACK == 1)
#        showstack
#    end
#    draw-separator
#end

#define hook-stop
#    context
#end

#define enablestack
#    set $SHOWSTACK=1
#end
#document enablestack
#no comment
#end
