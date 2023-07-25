Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27176760A56
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 08:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjGYGaJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 02:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjGYGaI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 02:30:08 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D0EB1137;
        Mon, 24 Jul 2023 23:30:06 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 36P6TuQl026078;
        Tue, 25 Jul 2023 08:29:56 +0200
Date:   Tue, 25 Jul 2023 08:29:56 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v1 1/8] tools/nolibc: add support for powerpc
Message-ID: <ZL9r5B9KBNl1va8i@1wt.eu>
References: <20230723081520.GA19768@1wt.eu>
 <20230725054414.15055-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725054414.15055-1-falcon@tinylab.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 25, 2023 at 01:44:14PM +0800, Zhangjin Wu wrote:
> This discussion does inspire me a lot to shrink the whole architecture
> specific nolibc my_syscall<N>() macros, like crt.h, a common syscall.h
> is added to do so. I have finished most of them except the ones passing
> arguments via stack, still trying to merge these ones.
> 
> With this new syscall.h, to support my_syscall<N>, the arch-<ARCH>.h
> will only require to add ~10 lines to define their own syscall
> instructions, registers and clobberlist, which looks like this (for
> powerpc):
> 
>     #define _NOLIBC_SYSCALL_CALL "sc; bns+ 1f; neg  %0, %0; 1:"
> 
>     /* PowerPC doesn't always restore r3-r12 for us */
>     #define _NOLIBC_SYSCALL_CLOBBERLIST 
>     	"memory", "cr0", "r12", "r11", "r10", "r9", "r8", "r7", "r6", "r5", "r4"
> 
>     /* PowerPC write GPRS in kernel side but not restore them */
>     #define _NOLIBC_GPRS_AS_OUTPUT_OPERANDS
>     
>     #define _NOLIBC_REG_NUM  "r0"
>     #define _NOLIBC_REG_RET  "r3"
>     #define _NOLIBC_REG_arg1 "r3"
>     #define _NOLIBC_REG_arg2 "r4"
>     #define _NOLIBC_REG_arg3 "r5"
>     #define _NOLIBC_REG_arg4 "r6"
>     #define _NOLIBC_REG_arg5 "r7"
>     #define _NOLIBC_REG_arg6 "r8"
> 
> Before:
> 
>     $ ls tools/include/nolibc/arch-*.h | while read f; do git show dfef4fc45d5713eb23d87f0863aff9c33bd4bfaf:$f 2>/dev/null | wc -l | tr -d '\n'; echo " $f"; done
>     157 tools/include/nolibc/arch-aarch64.h
>     199 tools/include/nolibc/arch-arm.h
>     178 tools/include/nolibc/arch-i386.h
>     164 tools/include/nolibc/arch-loongarch.h
>     195 tools/include/nolibc/arch-mips.h
>     0 tools/include/nolibc/arch-powerpc.h
>     160 tools/include/nolibc/arch-riscv.h
>     186 tools/include/nolibc/arch-s390.h
>     176 tools/include/nolibc/arch-x86_64.h
> 
> After:
> 
>     $ wc -l tools/include/nolibc/arch-*.h
>        54 tools/include/nolibc/arch-aarch64.h
>        84 tools/include/nolibc/arch-arm.h
>        90 tools/include/nolibc/arch-i386.h                        /* the last one use stack to pass arguments, reserve as-is */
>        59 tools/include/nolibc/arch-loongarch.h
>       120 tools/include/nolibc/arch-mips.h                        /* the last two use stack to pass arguments, reserve as-is */
>        73 tools/include/nolibc/arch-powerpc.h
>        58 tools/include/nolibc/arch-riscv.h
>        87 tools/include/nolibc/arch-s390.h
>        67 tools/include/nolibc/arch-x86_64.h
> 
> syscall.h itself:
> 
>     $ wc -l tools/include/nolibc/syscall.h
>     112 tools/include/nolibc/syscall.h 

The important thing to consider is not the number of lines but the
*maintainability*. You factored the syscall code so much above with all
these macros that I don't even understand how they're going to interact
with each other, especially "%0". Also I don't know what the macro
_NOLIBC_GPRS_AS_OUTPUT_OPERANDS does. And when someone reports a bug
like we had in the past with programs randomly crashing depending on
stack alignment and such, it becomes particularly tricky to figure what
is expected and how it differs from reality.

Maybe it's possible to do something in between, like defining a few
more slightly larger blocks, I don't know. I still tend to think that
this significantly complicates the understanding of the whole thing.

Also, looking at different archs' syscall code, they're not all defined
the same way. Some like i386 use "=a" for the return value. Others use
"+r" as an input/output value, others "=r", others "+d" or "=d". And
reading the comments, there are some arch-specific choices for these
declarations, that are sometimes there to force the toolchain a little
bit. Others like MIPS pass some of their args in the stack, so a name
only is not sufficient. Thus, trying to factor all of this will not only
make it very hard to insert arch-specific adjusments, but it will also
make the code much less readable.

Also think about this for a moment: you had the opportunity to add two
new archs by simply restarting from existing ones. s390 and loongarch
were added the same way, leaving enough freedom to the implementers to
adjust the definitions to fit their environment's constraints. If you
make it very complicated, I suspect we won't get any such contributions
anymore just because nobody figures how to find their way through it,
or it would require to change again for everyone just to add one specific
case. I tend to think that the current situation is already fairly
minimal with quite readable and debuggable calls, and that it's what
*really* matters.

When you're trying to reorganize code, it's important to ask yourself
whether you would prefer to debug the old one or the new one at 3am.
Hint: at 3am, the more abstractions there are, the less understandable
it becomes.

> Willy, do we need to rename my_syscall<N> to _nolibc_syscall<N> to limit
> these macros nolibc internally? I plan to rename all of the new adding
> macros with _nolibc_ (for funcs) or _NOLIBC_ (for variables).

Why not, I'm not opposed to that. Just keep in mind that every single
rename complicates backports (or may even silently break them), so it's
important to know where you want to go and to try to make changes converge
towards something stable and durable.

Thanks,
Willy
