Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D01A7612CE
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 13:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbjGYLFo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 07:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233808AbjGYLFZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 07:05:25 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016662728;
        Tue, 25 Jul 2023 04:03:18 -0700 (PDT)
X-QQ-mid: bizesmtp81t1690282976tz3l08g4
Received: from linux-lab-host.localdomain ( [61.141.78.189])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 25 Jul 2023 19:02:55 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: J5JfekO1WsjKALVrtAKMH3DRPd8kV2AXbTjsHeXomowh7c2lynND+IylxuW7S
        lYOqWHjauPUXevMdfpC21u/nrE4Gr+xXSi6KXRyG1NL6zSukMQwzetCZQ9F9TyrFQPaZvJ1
        BoICItCRnk7CrIiQLFmizrXZg3tWvplwVjvuapZTsvN0FeI7artlFU/S8ztDK067yngIwwY
        g8jWbPmgyIKtFuTenYlA3EVcIErP9mYBz14lJGjMHXhGdPnmEWN71iZc92DGrxGWmA1GUaY
        HvNH5qztHv374ehQafR/+CIeDC0NtAPdFu4s+D7q4xhyNL7nKo7NqX54U2lKJ/d84KT09wm
        r5YDd4Rsx90sfjkb82yyC2k5eUR2w5pV+hhiN+iQYURVLneZPZLRWUZdQyDsw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15422033172746534861
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de,
        svens@linux.ibm.com, ammarfaizi2@gnuweeb.org
Subject: Re: [PATCH v1 1/8] tools/nolibc: add support for powerpc
Date:   Tue, 25 Jul 2023 19:02:55 +0800
Message-Id: <20230725110255.20575-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZL9r5B9KBNl1va8i@1wt.eu>
References: <ZL9r5B9KBNl1va8i@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

Thanks very much for your comments on the new syscall.h proposal, just
replied more, it is a very long email, hope it explains more clearly ;-) 

Also CCed i386 and s390 committers, welcome your dicussion. 

> On Tue, Jul 25, 2023 at 01:44:14PM +0800, Zhangjin Wu wrote:
> > This discussion does inspire me a lot to shrink the whole architecture
> > specific nolibc my_syscall<N>() macros, like crt.h, a common syscall.h
> > is added to do so. I have finished most of them except the ones passing
> > arguments via stack, still trying to merge these ones.
> > 
> > With this new syscall.h, to support my_syscall<N>, the arch-<ARCH>.h
> > will only require to add ~10 lines to define their own syscall
> > instructions, registers and clobberlist, which looks like this (for
> > powerpc):
> > 
> >     #define _NOLIBC_SYSCALL_CALL "sc; bns+ 1f; neg  %0, %0; 1:"
> > 
> >     /* PowerPC doesn't always restore r3-r12 for us */
> >     #define _NOLIBC_SYSCALL_CLOBBERLIST 
> >     	"memory", "cr0", "r12", "r11", "r10", "r9", "r8", "r7", "r6", "r5", "r4"
> > 
> >     /* PowerPC write GPRS in kernel side but not restore them */
> >     #define _NOLIBC_GPRS_AS_OUTPUT_OPERANDS
> >     
> >     #define _NOLIBC_REG_NUM  "r0"
> >     #define _NOLIBC_REG_RET  "r3"
> >     #define _NOLIBC_REG_arg1 "r3"
> >     #define _NOLIBC_REG_arg2 "r4"
> >     #define _NOLIBC_REG_arg3 "r5"
> >     #define _NOLIBC_REG_arg4 "r6"
> >     #define _NOLIBC_REG_arg5 "r7"
> >     #define _NOLIBC_REG_arg6 "r8"
> > 
> > Before:
> > 
> >     $ ls tools/include/nolibc/arch-*.h | while read f; do git show dfef4fc45d5713eb23d87f0863aff9c33bd4bfaf:$f 2>/dev/null | wc -l | tr -d '\n'; echo " $f"; done
> >     157 tools/include/nolibc/arch-aarch64.h
> >     199 tools/include/nolibc/arch-arm.h
> >     178 tools/include/nolibc/arch-i386.h
> >     164 tools/include/nolibc/arch-loongarch.h
> >     195 tools/include/nolibc/arch-mips.h
> >     0 tools/include/nolibc/arch-powerpc.h
> >     160 tools/include/nolibc/arch-riscv.h
> >     186 tools/include/nolibc/arch-s390.h
> >     176 tools/include/nolibc/arch-x86_64.h
> > 
> > After:
> > 
> >     $ wc -l tools/include/nolibc/arch-*.h
> >        54 tools/include/nolibc/arch-aarch64.h
> >        84 tools/include/nolibc/arch-arm.h
> >        90 tools/include/nolibc/arch-i386.h                        /* the last one use stack to pass arguments, reserve as-is */
> >        59 tools/include/nolibc/arch-loongarch.h
> >       120 tools/include/nolibc/arch-mips.h                        /* the last two use stack to pass arguments, reserve as-is */
> >        73 tools/include/nolibc/arch-powerpc.h
> >        58 tools/include/nolibc/arch-riscv.h
> >        87 tools/include/nolibc/arch-s390.h
> >        67 tools/include/nolibc/arch-x86_64.h
> > 
> > syscall.h itself:
> > 
> >     $ wc -l tools/include/nolibc/syscall.h
> >     112 tools/include/nolibc/syscall.h 
> 
> The important thing to consider is not the number of lines but the
> *maintainability*.

The original goal is not really the number of lines (only a
'side-effect'), but is exactly easier porting/maintainability with
clearer code architecture, I have wrotten another message to explain
more about this background, so, let's directly reply here and discuss
more. 

> You factored the syscall code so much above with all
> these macros that I don't even understand how they're going to interact
> with each other, especially "%0".

Yeah, it is my fault, this should be cleaned up with the return register
directly:

    #define _NOLIBC_SYSCALL_CALL \
    	"sc; bns+ 1f; neg 3, 3; 1:"

> Also I don't know what the macro
> _NOLIBC_GPRS_AS_OUTPUT_OPERANDS does.

This is the root cause to inspire me to add the new syscall.h, let's
explain the background step by step.

All of the other architectures (except PowerPC) restore GPRS for us when
return from syscall, so, their clobber list simply not include the GPRS
and only need to add the input registers in the 'INPUT Operands' list.

But PowerPC doesn't restore such GPRS for us, I'm not sure if it is a
feature (Maybe) or a bug. for PowerPC32, the following line will restore
the GPRS for us, but may be not a good idea to do so for it may decrease
the syscall performance although save some instructions in user-space
and also, the other libcs also follow the current rule, so, this may be
a design intention we must follow (welcome your suggestions).

    diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
    index fe27d41f9a3d..1ed535e9144c 100644
    --- a/arch/powerpc/kernel/entry_32.S
    +++ b/arch/powerpc/kernel/entry_32.S
    @@ -155,6 +155,7 @@ syscall_exit_finish:
            bne     3f
            mtcr    r5
    
    +       REST_GPRS(3, 12, r1)
     1:     REST_GPR(2, r1)
            REST_GPR(1, r1)
            rfi

For PowerPC, if with the previous method like the other architectures,
the clobber list differs for every my_syscall<N> and all of the input
registers must be put in the 'OUTPUT Operands' too to avoid compiler to
save and resue a variable in such GPRS across my_syscall<N> calls.

Originally in my local new version of arch-powerpc.h, we got such code
for every my_syscall<N>, use my_syscall6() as an example:

    #define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)                 \
    ({                                                                           \
            register long _ret  __asm__ ("r3");                                  \
            register long _num  __asm__ ("r0") = (num);                          \
            register long _arg1 __asm__ ("r3") = (long)(arg1);                   \
            register long _arg2 __asm__ ("r4") = (long)(arg2);                   \
            register long _arg3 __asm__ ("r5") = (long)(arg3);                   \
            register long _arg4 __asm__ ("r6") = (long)(arg4);                   \
            register long _arg5 __asm__ ("r7") = (long)(arg5);                   \
            register long _arg6 __asm__ ("r8") = (long)(arg6);                   \
                                                                                 \
            __asm__ volatile (                                                   \
                    "       sc\n"                                                \
                    "       bns+ 1f\n"                                           \
                    "       neg  %0, %0\n"                                       \
                    "1:\n"                                                       \
                    : "=r"(_ret),                                                \
		      "+r"(_arg2), "+r"(_arg3), "+r"(_arg4),                     \
                      "+r"(_arg5), "+r"(_arg6)                                   \
                    : "0"(_arg1), "r"(_num)                                      \
                    : _NOLIBC_SYSCALL_CLOBBERLIST                                \
            );                                                                   \
            _ret;                                                                \
    })

It almost aligns with the other architectures, but the full clobber list
differs for every my_syscall<N>, the basic one is:

    /* PowerPC kernel doesn't always restore r4-r12 for us */
    #define _NOLIBC_SYSCALL_CLOBBERLIST \
        "memory", "cr0", "r12", "r11", "r10", "r9",

Use my_syscall0() as a further example, we need something like this:

    #define my_syscall0(num)                                                     \
    ({                                                                           \
            register long _ret  __asm__ ("r3");                                  \
            register long _num  __asm__ ("r0") = (num);                          \
                                                                                 \
            __asm__ volatile (                                                   \
                    "       sc\n"                                                \
                    "       bns+ 1f\n"                                           \
                    "       neg  %0, %0\n"                                       \
                    "1:\n"                                                       \
                    : "=r"(_ret)                                                 \
                    : "r"(_num)                                                  \
                    : _NOLIBC_SYSCALL_CLOBBERLIST, "r8", "r7", "r6", "r5", "r4"  \
            );                                                                   \
            _ret;                                                                \
    })

The additional "r8"..."r4" must be appended to the clobber list for they
can not be put together for every my_syscall<N> due to conflicts between
they between the clobber list and the "OUTPUT/INPUT operands".

I found a solution to share the same _NOLIBC_SYSCALL_CLOBBERLIST, that
is split the "OUTPUT/INPUT Operands" list out of the core syscall
assembly:

    #define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)                 \
    ({                                                                           \
            register long _ret  __asm__ ("r3");                                  \
            register long _num  __asm__ ("r0") = (num);                          \
            register long _arg1 __asm__ ("r3") = (long)(arg1);                   \
            register long _arg2 __asm__ ("r4") = (long)(arg2);                   \
            register long _arg3 __asm__ ("r5") = (long)(arg3);                   \
            register long _arg4 __asm__ ("r6") = (long)(arg4);                   \
            register long _arg5 __asm__ ("r7") = (long)(arg5);                   \
            register long _arg6 __asm__ ("r8") = (long)(arg6);                   \
                                                                                 \
            __asm__ volatile ("": "+r"(_arg2), "+r"(_arg3), "+r"(_arg4),         \
                                  "+r"(_arg5), "+r"(_arg6)::);                   \
                                                                                 \
            __asm__ volatile (                                                   \
                    "       sc\n"                                                \
                    "       bns+ 1f\n"                                           \
                    "       neg  %0, %0\n"                                       \
                    "1:\n"                                                       \
                    : "=r"(_ret)                                                 \
                    : "0"(_arg1), "r"(_num)                                      \
                    : _NOLIBC_SYSCALL_CLOBBERLIST                                \
            );                                                                   \
            _ret;                                                                \
    })

Note, a question here is, the above split still require more discussion
to make sure it does work for different toolchains (only test for gcc
currently) or even if this method is right from scratch, welcome your
suggestion.

As a result, all of the my_syscall<N> are able to share the core syscall
calling assembly block, so, here is what we at last have:

    #define _my_syscall_tail()                                              \
    	__asm__ volatile (                                                  \
    		_NOLIBC_SYSCALL_CALL                                        \
    		: "=r"(_ret)                                                \
    		: "r"(_num)                                                 \
    		: _NOLIBC_SYSCALL_CLOBBERLIST                               \
    	);                                                                  \
    	_ret

And further, we also found it was possible to share most of them among
these not ugly but completely duplicated lines:

            register long _ret  __asm__ ("r3");                                  \
            register long _num  __asm__ ("r0") = (num);                          \
            register long _arg1 __asm__ ("r3") = (long)(arg1);                   \
            register long _arg2 __asm__ ("r4") = (long)(arg2);                   \
            register long _arg3 __asm__ ("r5") = (long)(arg3);                   \
            register long _arg4 __asm__ ("r6") = (long)(arg4);                   \
            register long _arg5 __asm__ ("r7") = (long)(arg5);                   \
            register long _arg6 __asm__ ("r8") = (long)(arg6);                   \
                                                                                 \
            __asm__ volatile ("": "+r"(_arg2), "+r"(_arg3), "+r"(_arg4),         \
                                  "+r"(_arg5), "+r"(_arg6)::);
                                                            
That's why at last we have such blocks (of course, for PowerPC itself
it is a big change and not necessary):

    #define _my_syscall_head(num)                                               \
    	register long _ret __asm__ (_NOLIBC_REG_RET);                           \
    	register long _num __asm__ (_NOLIBC_REG_NUM) = (num)                    \
    
    #ifdef _NOLIBC_REG_ERR
    #define _NOLIBC_REG_EXTRA _NOLIBC_REG_ERR
    #endif
    
    #ifdef _NOLIBC_REG_EXTRA
    #define _my_syscall_extra() \
    	register long reg_extra __asm__ (_NOLIBC_REG_EXTRA);                   \
    	__asm__ volatile ("": "=r"(reg_extra)::)
    #else
    #define _my_syscall_extra()
    #endif
    
    /* Architectures like PowerPC write GPRS in kernel side and not restore them */
    #ifndef _NOLIBC_GPRS_AS_OUTPUT_OPERANDS
    #define _my_syscall_argn(n, arg)                                            \
    	register long _arg##n __asm__ (_NOLIBC_REG_arg##n) = (long)(arg);       \
    	__asm__ volatile ("":: "r"(_arg##n):)
    #else
    #define _my_syscall_argn(n, arg)                                            \
    	register long _arg##n __asm__ (_NOLIBC_REG_arg##n) = (long)(arg);       \
    	__asm__ volatile ("": "+r"(_arg##n)::)
    #endif

And this further build args for us:

    #define _my_syscall_args0()
    
    #define _my_syscall_args1(...) \
    	_my_syscall_args0(); \
    	_my_syscall_argn(1, __VA_ARGS__)
    
    #define _my_syscall_args2(arg2, ...) \
    	_my_syscall_args1(__VA_ARGS__); \
    	_my_syscall_argn(2, arg2)
    
    #define _my_syscall_args3(arg3, ...) \
    	_my_syscall_args2(__VA_ARGS__); \
    	_my_syscall_argn(3, arg3)
    
    #define _my_syscall_args4(arg4, ...) \
    	_my_syscall_args3(__VA_ARGS__); \
    	_my_syscall_argn(4, arg4)
    
    #define _my_syscall_args5(arg5, ...) \
    	_my_syscall_args4(__VA_ARGS__); \
    	_my_syscall_argn(5, arg5)
    
    #define _my_syscall_args6(arg6, ...) \
    	_my_syscall_args5(__VA_ARGS__); \
    	_my_syscall_argn(6, arg6)

And at last:

    #define __my_syscall_args(N, ...) _my_syscall_args##N(__VA_ARGS__)
    #define _my_syscall_args(N, ...) __my_syscall_args(N, ##__VA_ARGS__)

    #define __my_syscall_narg(_0, _1, _2, _3, _4, _5, _6, N, ...) N
    #define _my_syscall_narg(...) __my_syscall_narg(__VA_ARGS__, 6, 5, 4, 3, 2, 1, 0)

    #define __my_syscall_argsn(N, argn, ...) \
    	_my_syscall_args(_my_syscall_narg(NULL, ##__VA_ARGS__), ##__VA_ARGS__); \
    	_my_syscall_argn(N, argn)
    
    #define _my_syscall_argsn(...) __my_syscall_argsn(_my_syscall_narg(NULL, ##__VA_ARGS__), ##__VA_ARGS__)

    /* Note, my_syscall0() has no argument, can not use my_syscalln() */
    #define my_syscall0(num)                                                           \
    ({                                                                                 \
    	_my_syscall_head(num);                                                         \
    	_my_syscall_extra();                                                           \
    	_my_syscall_tail();                                                            \
    })
    
    #define my_syscalln(num, ...)                                                      \
    ({                                                                                 \
    	_my_syscall_head(num);                                                         \
    	_my_syscall_extra();                                                           \
    	_my_syscall_argsn(__VA_ARGS__);                                                \
    	_my_syscall_tail();                                                            \
    })
    
    #define my_syscall1(num, arg1)                               my_syscalln(num, arg1)
    #define my_syscall2(num, arg1, arg2)                         my_syscalln(num, arg2, arg1)
    #define my_syscall3(num, arg1, arg2, arg3)                   my_syscalln(num, arg3, arg2, arg1)
    #define my_syscall4(num, arg1, arg2, arg3, arg4)             my_syscalln(num, arg4, arg3, arg2, arg1)
    
    #ifndef my_syscall5
    #define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)       my_syscalln(num, arg5, arg4, arg3, arg2, arg1)
    #endif
    #ifndef my_syscall6
    #define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6) my_syscalln(num, arg6, arg5, arg4, arg3, arg2, arg1)
    #endif

At last, I found this worked on all of the supported architectures, so,
the new syscall.h is proposed.

BTW, another question here is, to utilize the feature of __VA_ARGS__ to
easier getting the last argument, the order of arguments are reversed
during the declarations of the my_syscall<N>, any suggestion on this
part? is it possible to not reverse the order? If possible, the
my_syscall<N> declarations may be simplified to:

    #define my_syscall1(...) my_syscalln(__VA_ARGS__)

And even be possible to define syscall() from unistd.h as a alias of
my_syscalln():

    #define syscall(...) my_syscalln(__VA_ARGS__)

And further, these three from unistd.h are sharable:

    #define __syscall_narg(_0, _1, _2, _3, _4, _5, _6, N, ...) N
    #define _syscall_narg(...) __syscall_narg(__VA_ARGS__, 6, 5, 4, 3, 2, 1, 0)
    #define _syscall_n(N, ...) _syscall(N, __VA_ARGS__)

> And when someone reports a bug
> like we had in the past with programs randomly crashing depending on
> stack alignment and such, it becomes particularly tricky to figure what
> is expected and how it differs from reality.
>

Macros are really hard to debug, the above code lines cost me two days ;-)

but after the common syscall.h, the left architecture specific parts are
very few and easier to debug and even less copy and paste.

> Maybe it's possible to do something in between, like defining a few
> more slightly larger blocks,

Yeah, here is the method we applied, new blocks added are:

    /* for ret and num */
    #define _my_syscall_head(num)                                           \

    /* for extra err output */
    #define _my_syscall_extra()                                             \

    /* for every argument, with additional OUTPUT/INPUT operands setting */
    #define _my_syscall_argn(n, arg)                                        \

    /* for the core syscall calling and return */
    #define _my_syscall_tail()                                              \

    /* for variable number of args */
    #define _my_syscall_args0()
    #define _my_syscall_args1(...) \
    #define _my_syscall_args2(arg2, ...) \
    #define _my_syscall_args3(arg3, ...) \
    #define _my_syscall_args4(arg4, ...) \
    #define _my_syscall_args5(arg5, ...) \
    #define _my_syscall_args6(arg6, ...) \

    /* unified variable number of args */
    #define _my_syscall_argsn(...)

    /* my_syscall0 */
    #define my_syscall0(num)                                                               \

    /* my_syscalln */
    #define my_syscalln(num, ...) \

Still require more discussion on their names or even more
simplification.

> I don't know. I still tend to think that
> this significantly complicates the understanding of the whole thing.
>

Willy, don't worry, I do think it make things easier, the worse case is
using the old code or only use part of our new blocks helpers ;-)

For this new syscall.h, it mainly clear the inline assembly codes, as we
know, inline assembly code is a very complicated thing, If we clear the
logic carefully (as we target but not yet) in our common code,
architecture developers only require to focus on the platform specific
definitions, it should be better for portability, review and
maintainability.

It is very hard to learn the meanning of the OUTPUT operands, INPUT
operands and even the clobber list and even the flags you mentioned
below, clearing up them is really required, this new syscall.h also
require more comments on the macro functions and variables. 

> Also, looking at different archs' syscall code, they're not all defined
> the same way. Some like i386 use "=a" for the return value. Others use
> "+r" as an input/output value, others "=r",

Agree, this is a very hard part of the inline assembly codes, clearing
up the generic versions in syscall.h with additional comments may really
help a lot.

For OUTPUT/INPUT operands, they may be enough for the generic versions:

     #define _my_syscall_tail()                                              \
    	__asm__ volatile (                                                  \
    		_NOLIBC_SYSCALL_CALL                                        \
    		: "=r"(_ret)                                                \
    		: "r"(_num)                                                 \
    		: _NOLIBC_SYSCALL_CLOBBERLIST                               \
    	);                                                                  \
    	_ret

    #ifdef _NOLIBC_REG_ERR
    #define _NOLIBC_REG_EXTRA _NOLIBC_REG_ERR
    #endif
    
    #ifdef _NOLIBC_REG_EXTRA
    #define _my_syscall_extra() \
    	register long reg_extra __asm__ (_NOLIBC_REG_EXTRA);                   \
    	__asm__ volatile ("": "=r"(reg_extra)::)
    #else
    #define _my_syscall_extra()
    #endif


    /* Architectures like PowerPC write GPRS in kernel side and not restore them */
    #ifndef _NOLIBC_GPRS_AS_OUTPUT_OPERANDS
    #define _my_syscall_argn(n, arg)                                            \
    	register long _arg##n __asm__ (_NOLIBC_REG_arg##n) = (long)(arg);       \
    	__asm__ volatile ("":: "r"(_arg##n):)
    #else
    #define _my_syscall_argn(n, arg)                                            \
    	register long _arg##n __asm__ (_NOLIBC_REG_arg##n) = (long)(arg);       \
    	__asm__ volatile ("": "+r"(_arg##n)::)
    #endif

- "=r" is only required for output registers, it is mainly for "RET"
  register and "ERR" register.

- "r" is for input, mainly for "NUM" register and the input arguments
  (sometimes, the input arguments are used as "RET" and "ERR" too).

- "+r" means both input and output, only used by powerpc currently.

  For the input registers used as "ERR" or "RET" output, "+r" is used
  before, but now, we split them to two parts, one is "=r"(_ret) in
  _my_syscall_tail(), another is in _my_syscall_argn(n, arg), they
  together work for "+r" = "=r" + "r"

Btw, have checked "=r" instead of "=a" works on i386 too for we already
bind the _ret variable with "RET" register, but still need to check if
"=a" is necessary?

> others "+d" or "=d". And
> reading the comments, there are some arch-specific choices for these
> declarations, that are sometimes there to force the toolchain a little
> bit.

Even for s390, test shows, "r" instead of "d" works too (boot and test
passed, not yet checked the size and codes generated), but I didn't find
any document about "d" for s390 from the gcc online doc. This part
(include all of the supported architectures) should be carefully checked
if really adding our new syscall.h. add s390 nolibc committer to CC: list.

If "r" really not works on a target, we can use the logic like this
(include syscall.h after architecture specific definitions):

    #ifndef my_syscall5
    #define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)       my_syscalln(num, arg5, arg4, arg3, arg2, arg1)
    #endif
    #ifndef my_syscall6
    #define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6) my_syscalln(num, arg6, arg5, arg4, arg3, arg2, arg1)
    #endif

The blocks from syscalls.h are only provided as generic support, the
architectures can define their own versions. all of our new blocks can
be protected like my_syscall<N> above, for example:

    #ifndef _my_syscall_tail
    #define _my_syscall_tail ...
    #endif

But for s390 here, if it really requires "d" instead of "r", we are able
to allow architectures define their own modifier like this:

    #ifndef _NOLIBC_INLINE_ASM_MODIFIER
    #define _NOLIBC_INLINE_ASM_MODIFIER "r"
    #endif

Then, we can define _NOLIBC_INLINE_ASM_MODIFIER for s390:
    
    #define _NOLIBC_INLINE_ASM_MODIFIER "d"

But architectures like i386, If "=a", "=b", ... modifiers are necessary,
new versions of the blocks should be added for these architectures.

As a short summary for this part, the modifiers used by different
architectures should be carefully checked, welcome more suggestions from
the toolchains developers or the architecture maintainers, I will
compare the code generated too.

> Others like MIPS pass some of their args in the stack, so a name
> only is not sufficient. Thus, trying to factor all of this will not only
> make it very hard to insert arch-specific adjusments, but it will also
> make the code much less readable.
>

Currently, I didn't yet work on merging the 'stack' support, we used
'#ifdef's in syscall.h:

    #ifndef my_syscall5
    #define my_syscall5 ...
    #endif
    #ifndef my_syscall6
    #define my_syscall6 ...
    #endif

So, they are the same as before: 

    $ grep "#define my_syscall" -ur tools/include/nolibc/arch-*.h
    tools/include/nolibc/arch-i386.h:#define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)	\
    tools/include/nolibc/arch-mips.h:#define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)                        \
    tools/include/nolibc/arch-mips.h:#define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)

Still require more work on how to support these ones, but it is not that
urgent ;-)

> Also think about this for a moment: you had the opportunity to add two
> new archs by simply restarting from existing ones. s390 and loongarch
> were added the same way, leaving enough freedom to the implementers to
> adjust the definitions to fit their environment's constraints.

I think this reserves as-is if the new arch-<ARCH>.h simply not include
our new syscalls.h, so, the new syscalls.h is optional, the worse case
is as-is, no regression, enough freedom as before ;-)

And further, some architectures may resue some helpers from our new syscalls.h
or at least learn something from what we have done for all of the supported
architectures.

And eventually, if our generic versions fits, just defining the
syscall instructions, registers and clobber list should be enough.

> If you
> make it very complicated, I suspect we won't get any such contributions
> anymore just because nobody figures how to find their way through it,
> or it would require to change again for everyone just to add one specific
> case. I tend to think that the current situation is already fairly
> minimal with quite readable and debuggable calls, and that it's what
> *really* matters.
>

This may really influence the upstream and review flow:

- If people may send a new architecture support, if just fits the new
  syscall.h, we may need to review carefully about the test results,
  especially for the input/output operands, error register.

  As tests for powerpc shows, the above issues should be covered by our
  nolibc-test.

- If people may send a new architecture support as before, If we find it
  fits our new syscalls.h or it can apply part of the blocks, we can
  give some suggestions.

- If people send something not just fit our new syscall.h, we may be
  able to think about if a new 'hook' is required, but it is not
  necessary, we can delay this change requirement to after a careful
  design (just like the argument passing via 'stack' case currently) .

> When you're trying to reorganize code, it's important to ask yourself
> whether you would prefer to debug the old one or the new one at 3am.
> Hint: at 3am, the more abstractions there are, the less understandable
> it becomes.
>

Interesting and agree, but this abstraction does clear something to be more
undersatndable too ;-)

I do hate hard-debuggable macros, but as we mentioned above, the inline
assembly code is another harder parts, the new carefully tuned blocks may really
help us to avoid introduce bugs with manually wrotten new codes and also it may
help us to avoid copy and paste multiple duplicated lines of the same codes. 

> > Willy, do we need to rename my_syscall<N> to _nolibc_syscall<N> to limit
> > these macros nolibc internally? I plan to rename all of the new adding
> > macros with _nolibc_ (for funcs) or _NOLIBC_ (for variables).
> 
> Why not, I'm not opposed to that. Just keep in mind that every single
> rename complicates backports (or may even silently break them), so it's
> important to know where you want to go and to try to make changes converge
> towards something stable and durable.

Yeah, let's keep the changes minimal, we could prefix the new macros
with _nolibc_ or _NOLIBC_, the old ones can be kept as-is.

Best regards,
Zhangjin

> 
> Thanks,
> Willy
