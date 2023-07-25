Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F006276214B
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 20:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjGYS2A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 14:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjGYS17 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 14:27:59 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D0751FC2;
        Tue, 25 Jul 2023 11:27:55 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 36PIRaB0025070;
        Tue, 25 Jul 2023 20:27:36 +0200
Date:   Tue, 25 Jul 2023 20:27:36 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de,
        svens@linux.ibm.com, ammarfaizi2@gnuweeb.org
Subject: Re: [PATCH v1 1/8] tools/nolibc: add support for powerpc
Message-ID: <20230725182736.GA24943@1wt.eu>
References: <ZL9r5B9KBNl1va8i@1wt.eu>
 <20230725110255.20575-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725110255.20575-1-falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Zhangjin,

On Tue, Jul 25, 2023 at 07:02:55PM +0800, Zhangjin Wu wrote:
> > > With this new syscall.h, to support my_syscall<N>, the arch-<ARCH>.h
> > > will only require to add ~10 lines to define their own syscall
> > > instructions, registers and clobberlist, which looks like this (for
> > > powerpc):
> > > 
> > >     #define _NOLIBC_SYSCALL_CALL "sc; bns+ 1f; neg  %0, %0; 1:"
> > > 
> > >     /* PowerPC doesn't always restore r3-r12 for us */
> > >     #define _NOLIBC_SYSCALL_CLOBBERLIST 
> > >     	"memory", "cr0", "r12", "r11", "r10", "r9", "r8", "r7", "r6", "r5", "r4"
> > > 
> > >     /* PowerPC write GPRS in kernel side but not restore them */
> > >     #define _NOLIBC_GPRS_AS_OUTPUT_OPERANDS
> > >     
> > >     #define _NOLIBC_REG_NUM  "r0"
> > >     #define _NOLIBC_REG_RET  "r3"
> > >     #define _NOLIBC_REG_arg1 "r3"
> > >     #define _NOLIBC_REG_arg2 "r4"
> > >     #define _NOLIBC_REG_arg3 "r5"
> > >     #define _NOLIBC_REG_arg4 "r6"
> > >     #define _NOLIBC_REG_arg5 "r7"
> > >     #define _NOLIBC_REG_arg6 "r8"
> > > 
> > > Before:
> > > 
> > >     $ ls tools/include/nolibc/arch-*.h | while read f; do git show dfef4fc45d5713eb23d87f0863aff9c33bd4bfaf:$f 2>/dev/null | wc -l | tr -d '\n'; echo " $f"; done
> > >     157 tools/include/nolibc/arch-aarch64.h
> > >     199 tools/include/nolibc/arch-arm.h
> > >     178 tools/include/nolibc/arch-i386.h
> > >     164 tools/include/nolibc/arch-loongarch.h
> > >     195 tools/include/nolibc/arch-mips.h
> > >     0 tools/include/nolibc/arch-powerpc.h
> > >     160 tools/include/nolibc/arch-riscv.h
> > >     186 tools/include/nolibc/arch-s390.h
> > >     176 tools/include/nolibc/arch-x86_64.h
> > > 
> > > After:
> > > 
> > >     $ wc -l tools/include/nolibc/arch-*.h
> > >        54 tools/include/nolibc/arch-aarch64.h
> > >        84 tools/include/nolibc/arch-arm.h
> > >        90 tools/include/nolibc/arch-i386.h                        /* the last one use stack to pass arguments, reserve as-is */
> > >        59 tools/include/nolibc/arch-loongarch.h
> > >       120 tools/include/nolibc/arch-mips.h                        /* the last two use stack to pass arguments, reserve as-is */
> > >        73 tools/include/nolibc/arch-powerpc.h
> > >        58 tools/include/nolibc/arch-riscv.h
> > >        87 tools/include/nolibc/arch-s390.h
> > >        67 tools/include/nolibc/arch-x86_64.h
> > > 
> > > syscall.h itself:
> > > 
> > >     $ wc -l tools/include/nolibc/syscall.h
> > >     112 tools/include/nolibc/syscall.h 
> > 
> > The important thing to consider is not the number of lines but the
> > *maintainability*.
> 
> The original goal is not really the number of lines (only a
> 'side-effect'), but is exactly easier porting/maintainability with
> clearer code architecture,

I do feel the exact opposite. One is totally straightforward with
self-explanatory function names and their equivalent machine-specific
asm() statements, the other one involves countless cryptic macros for
which it is particularly difficult to figure what depends on what.

> > You factored the syscall code so much above with all
> > these macros that I don't even understand how they're going to interact
> > with each other, especially "%0".
> 
> Yeah, it is my fault, this should be cleaned up with the return register
> directly:
> 
>     #define _NOLIBC_SYSCALL_CALL \
>     	"sc; bns+ 1f; neg 3, 3; 1:"

This doesn't change my point of view on it, really.

> > Also I don't know what the macro
> > _NOLIBC_GPRS_AS_OUTPUT_OPERANDS does.
> 
> This is the root cause to inspire me to add the new syscall.h, let's
> explain the background step by step.
> 
> All of the other architectures (except PowerPC) restore GPRS for us when
> return from syscall, so, their clobber list simply not include the GPRS
> and only need to add the input registers in the 'INPUT Operands' list.

I still have no idea what a GPRS is.

> But PowerPC doesn't restore such GPRS for us, I'm not sure if it is a
> feature (Maybe) or a bug.

We don't really care. The *exact* purpose of an asm() statement is to
write stuff that cannot be expressed at a higher level. Sure sometimes
you can abuse macros. But this should be extremely light. Here you seem
to be using a common asm statement for everyone and going to stuff the
combination of all these macros into it. asm() statements are already
quite cryptic for a lot of people, and the minimum required is that
they are easy to read so that the few who know what these are doing can
help debug them. When Ammar spotted the alignment bug in our _start
code, it didn't take long to figure the root cause of the issue nor to
fix it, precisely because that code was straightforward for someone with
a bit of asm skills. But how do you want anyone to figure what's happening
in something full of abstractions ? Look for example, in order to add
the stackprot support, Thomas just had to append a call at various
points. When you need to do that in factored code that's forcefully
arranged to try to suit all archs and toolchains at once, it may end up
being almost impossible without breaking the organization and starting
to create arch-specific definitions again.

> for PowerPC32, the following line will restore
> the GPRS for us, but may be not a good idea to do so for it may decrease
> the syscall performance although save some instructions in user-space
> and also, the other libcs also follow the current rule, so, this may be
> a design intention we must follow (welcome your suggestions).
> 
>     diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
>     index fe27d41f9a3d..1ed535e9144c 100644
>     --- a/arch/powerpc/kernel/entry_32.S
>     +++ b/arch/powerpc/kernel/entry_32.S
>     @@ -155,6 +155,7 @@ syscall_exit_finish:
>             bne     3f
>             mtcr    r5
>     
>     +       REST_GPRS(3, 12, r1)
>      1:     REST_GPR(2, r1)
>             REST_GPR(1, r1)
>             rfi

I don't know PPC and I have zero opinion there. For this we'll ask one
of the PPC maintainers for guidance, and since we have clean asm code,
they will easily be able to say "yes that's fine", "hmmm no that's not
the right way to do it", or "I suspect you forgot to save flags here",
or anything else, because the code will match a pattern they know well.
With all the macros hell, it will just be "hmmm good luck".

> For PowerPC, if with the previous method like the other architectures,
> the clobber list differs for every my_syscall<N> and all of the input
> registers must be put in the 'OUTPUT Operands' too to avoid compiler to
> save and resue a variable in such GPRS across my_syscall<N> calls.

But do you realize that you're proposing to write macros to factor things
between archs that are already different within a single arch ? How is
this supposed to help at doing anything ?

> Originally in my local new version of arch-powerpc.h, we got such code
> for every my_syscall<N>, use my_syscall6() as an example:
> 
>     #define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)                 \
>     ({                                                                           \
>             register long _ret  __asm__ ("r3");                                  \
>             register long _num  __asm__ ("r0") = (num);                          \
>             register long _arg1 __asm__ ("r3") = (long)(arg1);                   \
>             register long _arg2 __asm__ ("r4") = (long)(arg2);                   \
>             register long _arg3 __asm__ ("r5") = (long)(arg3);                   \
>             register long _arg4 __asm__ ("r6") = (long)(arg4);                   \
>             register long _arg5 __asm__ ("r7") = (long)(arg5);                   \
>             register long _arg6 __asm__ ("r8") = (long)(arg6);                   \
>                                                                                  \
>             __asm__ volatile (                                                   \
>                     "       sc\n"                                                \
>                     "       bns+ 1f\n"                                           \
>                     "       neg  %0, %0\n"                                       \
>                     "1:\n"                                                       \
>                     : "=r"(_ret),                                                \
> 		      "+r"(_arg2), "+r"(_arg3), "+r"(_arg4),                     \
>                       "+r"(_arg5), "+r"(_arg6)                                   \
>                     : "0"(_arg1), "r"(_num)                                      \
>                     : _NOLIBC_SYSCALL_CLOBBERLIST                                \
>             );                                                                   \
>             _ret;                                                                \
>     })
> 
> It almost aligns with the other architectures, but the full clobber list
> differs for every my_syscall<N>, the basic one is:
> 
>     /* PowerPC kernel doesn't always restore r4-r12 for us */
>     #define _NOLIBC_SYSCALL_CLOBBERLIST \
>         "memory", "cr0", "r12", "r11", "r10", "r9",
> 
> Use my_syscall0() as a further example, we need something like this:
> 
>     #define my_syscall0(num)                                                     \
>     ({                                                                           \
>             register long _ret  __asm__ ("r3");                                  \
>             register long _num  __asm__ ("r0") = (num);                          \
>                                                                                  \
>             __asm__ volatile (                                                   \
>                     "       sc\n"                                                \
>                     "       bns+ 1f\n"                                           \
>                     "       neg  %0, %0\n"                                       \
>                     "1:\n"                                                       \
>                     : "=r"(_ret)                                                 \
>                     : "r"(_num)                                                  \
>                     : _NOLIBC_SYSCALL_CLOBBERLIST, "r8", "r7", "r6", "r5", "r4"  \
>             );                                                                   \
>             _ret;                                                                \
>     })
> 
> The additional "r8"..."r4" must be appended to the clobber list for they
> can not be put together for every my_syscall<N> due to conflicts between
> they between the clobber list and the "OUTPUT/INPUT operands".

Perfect, yet another example of the real purpose of asm() statements.
They're not generic and are made to finely tune what you're inserting.

> I found a solution to share the same _NOLIBC_SYSCALL_CLOBBERLIST, that
> is split the "OUTPUT/INPUT Operands" list out of the core syscall
> assembly:
> 
>     #define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)                 \
>     ({                                                                           \
>             register long _ret  __asm__ ("r3");                                  \
>             register long _num  __asm__ ("r0") = (num);                          \
>             register long _arg1 __asm__ ("r3") = (long)(arg1);                   \
>             register long _arg2 __asm__ ("r4") = (long)(arg2);                   \
>             register long _arg3 __asm__ ("r5") = (long)(arg3);                   \
>             register long _arg4 __asm__ ("r6") = (long)(arg4);                   \
>             register long _arg5 __asm__ ("r7") = (long)(arg5);                   \
>             register long _arg6 __asm__ ("r8") = (long)(arg6);                   \
>                                                                                  \
>             __asm__ volatile ("": "+r"(_arg2), "+r"(_arg3), "+r"(_arg4),         \
>                                   "+r"(_arg5), "+r"(_arg6)::);                   \
>                                                                                  \
>             __asm__ volatile (                                                   \
>                     "       sc\n"                                                \
>                     "       bns+ 1f\n"                                           \
>                     "       neg  %0, %0\n"                                       \
>                     "1:\n"                                                       \
>                     : "=r"(_ret)                                                 \
>                     : "0"(_arg1), "r"(_num)                                      \
>                     : _NOLIBC_SYSCALL_CLOBBERLIST                                \
>             );                                                                   \
>             _ret;                                                                \
>     })

So basically "it happens to work but we don't know why, but this is still
much more maintainable" ? Please no, really no, no, no. That's ugly,
tricky and you don't even know what the compiler will do between these
two statements.

> Note, a question here is, the above split still require more discussion
> to make sure it does work for different toolchains (only test for gcc
> currently) or even if this method is right from scratch, welcome your
> suggestion.

asm() statements are used to work around toolchain limitations/differences
and bugs. I've seen Ammar's response with the link to the gcc bug, that's
a good example as well of the reasons why we MUST NOT do these hacks.

> As a result, all of the my_syscall<N> are able to share the core syscall
> calling assembly block, so, here is what we at last have:
> 
>     #define _my_syscall_tail()                                              \
>     	__asm__ volatile (                                                  \
>     		_NOLIBC_SYSCALL_CALL                                        \
>     		: "=r"(_ret)                                                \
>     		: "r"(_num)                                                 \
>     		: _NOLIBC_SYSCALL_CLOBBERLIST                               \
>     	);                                                                  \
>     	_ret
> 
> And further, we also found it was possible to share most of them among
> these not ugly but completely duplicated lines:

But please, from the beginning, all I understand is "it is possible to",
but I still fail to understand the ultimate goal. Making the code uglier
and unmaintainable because it is possible is not a valid argument. For
doing stuff like above, there must be a serious limitation to work around
that has no other solution, and even then a huge #if/#endif could possibly
do it.

> That's why at last we have such blocks (of course, for PowerPC itself
> it is a big change and not necessary):
> 
>     #define _my_syscall_head(num)                                               \
>     	register long _ret __asm__ (_NOLIBC_REG_RET);                           \
>     	register long _num __asm__ (_NOLIBC_REG_NUM) = (num)                    \
>     
>     #ifdef _NOLIBC_REG_ERR
>     #define _NOLIBC_REG_EXTRA _NOLIBC_REG_ERR
>     #endif
>     
>     #ifdef _NOLIBC_REG_EXTRA
>     #define _my_syscall_extra() \
>     	register long reg_extra __asm__ (_NOLIBC_REG_EXTRA);                   \
>     	__asm__ volatile ("": "=r"(reg_extra)::)
>     #else
>     #define _my_syscall_extra()
>     #endif
>     
>     /* Architectures like PowerPC write GPRS in kernel side and not restore them */
>     #ifndef _NOLIBC_GPRS_AS_OUTPUT_OPERANDS
>     #define _my_syscall_argn(n, arg)                                            \
>     	register long _arg##n __asm__ (_NOLIBC_REG_arg##n) = (long)(arg);       \
>     	__asm__ volatile ("":: "r"(_arg##n):)
>     #else
>     #define _my_syscall_argn(n, arg)                                            \
>     	register long _arg##n __asm__ (_NOLIBC_REG_arg##n) = (long)(arg);       \
>     	__asm__ volatile ("": "+r"(_arg##n)::)
>     #endif

And someone is able to help us work around a compiler or assembler bug
in this ? I can't even spend enough concentration on the whole block to
understand what it's trying to do or what interacts with what. I'm sorry,
that's not a way to deal with asm, nor code shared with multiple developers
in general.

(...)
> And at last:
> 
>     #define __my_syscall_args(N, ...) _my_syscall_args##N(__VA_ARGS__)
>     #define _my_syscall_args(N, ...) __my_syscall_args(N, ##__VA_ARGS__)
> 
>     #define __my_syscall_narg(_0, _1, _2, _3, _4, _5, _6, N, ...) N
>     #define _my_syscall_narg(...) __my_syscall_narg(__VA_ARGS__, 6, 5, 4, 3, 2, 1, 0)
> 
>     #define __my_syscall_argsn(N, argn, ...) \
>     	_my_syscall_args(_my_syscall_narg(NULL, ##__VA_ARGS__), ##__VA_ARGS__); \
>     	_my_syscall_argn(N, argn)
>     
>     #define _my_syscall_argsn(...) __my_syscall_argsn(_my_syscall_narg(NULL, ##__VA_ARGS__), ##__VA_ARGS__)
> 
>     /* Note, my_syscall0() has no argument, can not use my_syscalln() */
>     #define my_syscall0(num)                                                           \
>     ({                                                                                 \
>     	_my_syscall_head(num);                                                         \
>     	_my_syscall_extra();                                                           \
>     	_my_syscall_tail();                                                            \
>     })
>     
>     #define my_syscalln(num, ...)                                                      \
>     ({                                                                                 \
>     	_my_syscall_head(num);                                                         \
>     	_my_syscall_extra();                                                           \
>     	_my_syscall_argsn(__VA_ARGS__);                                                \
>     	_my_syscall_tail();                                                            \
>     })
>     
>     #define my_syscall1(num, arg1)                               my_syscalln(num, arg1)
>     #define my_syscall2(num, arg1, arg2)                         my_syscalln(num, arg2, arg1)
>     #define my_syscall3(num, arg1, arg2, arg3)                   my_syscalln(num, arg3, arg2, arg1)
>     #define my_syscall4(num, arg1, arg2, arg3, arg4)             my_syscalln(num, arg4, arg3, arg2, arg1)
>     
>     #ifndef my_syscall5
>     #define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)       my_syscalln(num, arg5, arg4, arg3, arg2, arg1)
>     #endif
>     #ifndef my_syscall6
>     #define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6) my_syscalln(num, arg6, arg5, arg4, arg3, arg2, arg1)
>     #endif
> 
> At last, I found this worked on all of the supported architectures, so,
> the new syscall.h is proposed.

If the ultimate goal is *just* to provide my_syscalln(), it's not needed
to rework all archs like this. Just doing this does the job as well, it
will allow my_syscalln(syscall_num, ...) to call the respective
my_syscall0/1/2/3/4/5/6 depending on the number of arguments:

  /* my_syscalln() will automatically map to my_syscall<n>() depending
   * on the number of arguments after the syscall, from 0 to 6. It uses
   * positional arguments after a VA_ARGS to resolve as an argument
   * count that's then used to build the underlying macro's name.
   */
  #define _my_syscall0(num, a, b, c, d, e, f) my_syscall0(num)
  #define _my_syscall1(num, a, b, c, d, e, f) my_syscall1(num, a)
  #define _my_syscall2(num, a, b, c, d, e, f) my_syscall2(num, a, b)
  #define _my_syscall3(num, a, b, c, d, e, f) my_syscall3(num, a, b, c)
  #define _my_syscall4(num, a, b, c, d, e, f) my_syscall4(num, a, b, c, d)
  #define _my_syscall5(num, a, b, c, d, e, f) my_syscall5(num, a, b, c, d, e)
  #define _my_syscall6(num, a, b, c, d, e, f) my_syscall6(num, a, b, c, d, e, f)
  #define _my_syscalln(num, a, b, c, d, e, f, g, ...) _my_syscall##g(num, a, b, c, d, e, f)
  #define my_syscalln(num, ...) _my_syscalln(num, ##__VA_ARGS__, 6, 5, 4, 3, 2, 1, 0)

This way there's no need to modify the arch-specific syscall definitions,
this will simply rely on them and preserve their maintainability.

> BTW, another question here is, to utilize the feature of __VA_ARGS__ to
> easier getting the last argument, the order of arguments are reversed
> during the declarations of the my_syscall<N>, any suggestion on this
> part? is it possible to not reverse the order?

There's no reverse order, it's a well-known method consisting in making
a number appear at a fixed position depending on the number of preceeding
arguments:

   my_syscalln(n, a, b, c, d, e, f) becomes
  _my_syscalln(n, a, b, c, d, e, f, 6, 5, 4, 3, 2, 1, 0)
                                    ^
        This macro extracts this number above to build the next macro name:
  _my_syscall6(n, a, b, c, d, e, f)
   my_syscall6(n, a, b, c, d, e, f)

If you use less arguments, say 3, you get this:

   my_syscalln(n, a, b, c)
  _my_syscalln(n, a, b, c, 6, 5, 4, 3, 2, 1, 0)
  _my_syscall3(n, a, b, c, d, e, f)
   my_syscall3(n, a, b, c)  // d, e, f are lost

The last level of macro is used to silently drop the extra args. When
target is already a macro, it's not even necessary as the macro
definition could already end with ", ...".

I've been using a similar one above in other projects for quite a while
and I know that it worked at least in gcc-3.4, so it's definitely safe.

> > And when someone reports a bug
> > like we had in the past with programs randomly crashing depending on
> > stack alignment and such, it becomes particularly tricky to figure what
> > is expected and how it differs from reality.
> >
> 
> Macros are really hard to debug, the above code lines cost me two days ;-)

Someone once said that it requires a must stronger brain to solve a problem
than the one that created it. If it took you two days to arrange this,
imagine how long it will take to someone having not designed this to debug
it! The time it took you is definitely not an argument for adopting this,
quite the opposite. Instead it should have convinced you that this was
going to become unmaintainable.

> but after the common syscall.h, the left architecture specific parts are
> very few and easier to debug and even less copy and paste.

Copy-paste is a problem when bugs need to be fixed. Here there's almost no
copy-paste, copy-paste is done initially to create a new arch but in fact
we're reusing a skeletton to write completely different code. Because code
for PPC and MIPS are different, there's no point imagining that once a bug
affects MIPS we need to automatically apply the same fix to PPC, because
it will be different.

> > I don't know. I still tend to think that
> > this significantly complicates the understanding of the whole thing.
> >
> 
> Willy, don't worry, I do think it make things easier, the worse case is
> using the old code or only use part of our new blocks helpers ;-)

Sorry and don't take it bad, I don't want you to feel it as being rude,
but for me the worst case would be to use the new method precisely
because for now only you probably know how that's supposed to work and
nobody can help us with side effects affecting it.

> For this new syscall.h, it mainly clear the inline assembly codes, as we
> know, inline assembly code is a very complicated thing,

That's why it must remain crystal clear.

> If we clear the
> logic carefully (as we target but not yet) in our common code,
> architecture developers only require to focus on the platform specific
> definitions, it should be better for portability, review and
> maintainability.

In order to work on assembly you first need to be able to locate it
and read it as a sequence of instructions. Here really, you need a
pen and paper to start to resolve it.

> It is very hard to learn the meanning of the OUTPUT operands, INPUT
> operands and even the clobber list and even the flags you mentioned
> below,

One more reason for not passing through this!

> > Also, looking at different archs' syscall code, they're not all defined
> > the same way. Some like i386 use "=a" for the return value. Others use
> > "+r" as an input/output value, others "=r",
> 
> Agree, this is a very hard part of the inline assembly codes, clearing
> up the generic versions in syscall.h with additional comments may really
> help a lot.

No precisely not. It's a hard part for people who don't deal with *that*
arch. But you will not find a developer at ease with all archs. Each one
has its own specifics. However you will find one or a few developers that
are experts on each architecture and who will instantly be able to correct
some of our mistakes, or warn us against toolchain bugs they're aware of
that we need to take care of. They will also know which constraints to
use. The constraint definitions are per-architecture, and for example "a"
on x86 is the accumulator (eax/rax). On other archs it can be something
else. There are archs which support register pairs, some must be aligned
on an even number and depending on how the calls are declared, the compiler
may improperly assign them and emit code that is impossible to assemble
(I've met this several times with the initial ARM code that we managed
to stabilize).

>   For the input registers used as "ERR" or "RET" output, "+r" is used
>   before, but now, we split them to two parts, one is "=r"(_ret) in
>   _my_syscall_tail(), another is in _my_syscall_argn(n, arg), they
>   together work for "+r" = "=r" + "r"

Please do not generalize. The example I gave above indicate stuff that
was initially hard to adjust precisely to help the compiler emit correct
code with a wide enough range of tools. The example Ammar talked about
is a perfect such example.

> Even for s390, test shows, "r" instead of "d" works too

With your toolchain and the code you tested with. There might be a
particular reason, I don't know. Maybe the maintainer is used to
using this because it also works this way on another compiler and
he will be more fluent with this one. That's something important as
well when dealing with asm statements.

> (boot and test
> passed, not yet checked the size and codes generated), but I didn't find
> any document about "d" for s390 from the gcc online doc. This part
> (include all of the supported architectures) should be carefully checked
> if really adding our new syscall.h. add s390 nolibc committer to CC: list.

I do trust the s390 maintainers who contributed this code to know better
than either you and me, and it's certainly not up to us to ask them to
justify their choice. Actually it would be the other way around, you
would need a solid argument for changing code that works.

> But architectures like i386, If "=a", "=b", ... modifiers are necessary,
> new versions of the blocks should be added for these architectures.

You'll just end up with as many blocks at the end, but dealing only with
a union of exception. That's exactly the worst that can be imagined for
maintenance.

> And further, some architectures may resue some helpers from our new syscalls.h
> or at least learn something from what we have done for all of the supported
> architectures.

The arch-specific code is already minimal. We have 7 asm statements for
7 syscall conventions. That's ridiculously low and they contain what
any such arch maintainer would need to find to extend or fix them.

> > If you
> > make it very complicated, I suspect we won't get any such contributions
> > anymore just because nobody figures how to find their way through it,
> > or it would require to change again for everyone just to add one specific
> > case. I tend to think that the current situation is already fairly
> > minimal with quite readable and debuggable calls, and that it's what
> > *really* matters.
> >
> 
> This may really influence the upstream and review flow:
> 
> - If people may send a new architecture support, if just fits the new
>   syscall.h, we may need to review carefully about the test results,
>   especially for the input/output operands, error register.

First they'd need to be able to figure what to put in what. Look, they
know what are the 3 instructions they need to put in an asm statement and
the list of registers, and suddenly they'd need to figure how to spread
them into cryptic macros, some of which are sometimes used, others always
etc. That turns a 20-minute test into half a day, without big assurance
at the end of the day that everything is right.

>   As tests for powerpc shows, the above issues should be covered by our
>   nolibc-test.
> 
> - If people may send a new architecture support as before, If we find it
>   fits our new syscalls.h or it can apply part of the blocks, we can
>   give some suggestions.
>
> - If people send something not just fit our new syscall.h, we may be
>   able to think about if a new 'hook' is required, but it is not
>   necessary, we can delay this change requirement to after a careful
>   design (just like the argument passing via 'stack' case currently) .

That's already the case with i386, s390 and so on. Except that it adds
significant burden for that person.

> > When you're trying to reorganize code, it's important to ask yourself
> > whether you would prefer to debug the old one or the new one at 3am.
> > Hint: at 3am, the more abstractions there are, the less understandable
> > it becomes.
> >
> 
> Interesting and agree, but this abstraction does clear something to be more
> undersatndable too ;-)

It's really the first time I hear that abstractions makes one-liner ASM
code clearer and more understandable. I'm sorry but not, really, that's
exactly the opposite.

> I do hate hard-debuggable macros, but as we mentioned above, the inline
> assembly code is another harder parts, the new carefully tuned blocks may really
> help us to avoid introduce bugs with manually wrotten new codes and also it may
> help us to avoid copy and paste multiple duplicated lines of the same codes. 

No, the asm blocks are trivial for those who speak this language and are
hard for other ones. The macros are significantly harder and for everyone.
I prefer to ask an s390 or PPC maintainer when I need help with their code
rather than tweak the generic code adding a "+r" for every arch then read
about reports saying that this arch breaks with that version of the
compiler on that program with that version of the assembler.

Please again, don't take any of this personally, I'm just feeling that
you tried to address a difficulty to dig into some arch-specific code,
that you wanted to hide and that you feel like it is more maintainable,
but it's not. Maintainability in a shared project doesn't mean that you
are suddenly skilled on everything, but that you are able to find someone
skilled on your problem. It's not necessarily your task to debug an
architecture you don't know (though it's often very instructive), there
are other people for this and that's perfectly fine. We need to make the
task easy for them so that they don't have to learn all the nolibc tricks
to share their knowledge. In the current form with the asm statements
it's perfectly feasible and that's what matters.

Hoping this clarifies my position on this.

Thanks,
Willy
