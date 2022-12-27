Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECA365677C
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Dec 2022 07:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiL0G1D (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Dec 2022 01:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiL0G1B (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Dec 2022 01:27:01 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EDA20BA1;
        Mon, 26 Dec 2022 22:26:58 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 2BR6QemS005393;
        Tue, 27 Dec 2022 07:26:40 +0100
Date:   Tue, 27 Dec 2022 07:26:40 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Gilang Fachrezy <gilang4321@gmail.com>,
        VNLX Kernel Department <kernel@vnlx.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Kanna Scarlet <knscarlet@gnuweeb.org>,
        Muhammad Rizki <kiizuha@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [RFC PATCH v1 0/8] nolibc signal handling support
Message-ID: <20221227062640.GA5337@1wt.eu>
References: <20221222035134.3467659-1-ammar.faizi@intel.com>
 <20221222043452.GB29086@1wt.eu>
 <20221222134615.3535422-1-ammar.faizi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222134615.3535422-1-ammar.faizi@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ammar,

On Thu, Dec 22, 2022 at 08:46:15PM +0700, Ammar Faizi wrote:
> I agree with following the @envp pointer to get the auxv. I was
> trying to wire up a new function '__start' (with double underscores)
> written in C that accepts @argc, @argv and @envp. Then it calls 'main'.
> Then we call '__start' instead of 'main' from '_start'. This way, we
> can arrange nolibc-defined data without touching Assembly much in
> '__start' (before main).
> 
> But then I noticed that it wouldn't work because we may have users
> who define the 'main' function differently, e.g.:
> 
>     int main(void);
>     int main(int argc, char **argv);
>     int main(int argc, char **argv, char **envp);
> 
> So '__start' can't call main. We still need to call the main from the
> inline Assembly (from '_start').

Yes, and quite frankly I prefer to make that the least complicated.
Doing just a simple loop in the _start code is trivial. The main
concern was to store the data. Till now we had an optional .bss
section, we didn't save environ and errno was optional. But let's
be honest, while it does allow for writing the smallest programs,
most programs will have at least one global variable and will get
this section anyway, so we don't save anything in practice. This
concern used to be valid when I was making tiny executables when
running on floppies where each byte mattered, but now that's pointless.

Thus what I'm proposing is to switch to weak symbol definitions for
errno, environ, and auxv. I did a quick test to make sure that the same
symbol was properly used when accessed from two units and that's OK, I'm
seeing the same instance for all of them (which is better than the current
situation where errno is static, hence per-unit).

My quick-and-dirty test looks like this:

diff --git a/arch-x86_64.h b/arch-x86_64.h
index e780fdf..73f7b5f 100644
--- a/arch-x86_64.h
+++ b/arch-x86_64.h
@@ -209,6 +209,9 @@ struct sys_stat_struct {
        _ret;                                                                 \
 })
 
+char **environ __attribute__((weak,unused));
+long *auxv __attribute__((weak,unused));
+
 /* startup code */
 /*
  * x86-64 System V ABI mandates:
@@ -218,11 +221,17 @@ struct sys_stat_struct {
  */
 asm(".section .text\n"
     ".weak _start\n"
     "_start:\n"
     "pop %rdi\n"                // argc   (first arg, %rdi)
     "mov %rsp, %rsi\n"          // argv[] (second arg, %rsi)
     "lea 8(%rsi,%rdi,8),%rdx\n" // then a NULL then envp (third arg, %rdx)
+    "mov %rdx, environ\n"       // save environ
     "xor %ebp, %ebp\n"          // zero the stack frame
+    "mov %rdx, %rax\n"          // search for auxv (follows NULL after last en>
+    "0: add $8, %rax\n"
+    "   cmp -8(%rax), %rbp\n"
+    "   jnz 0b\n"
+    "mov %rax, auxv\n"          // save auxv
     "and $-16, %rsp\n"          // x86 ABI : esp must be 16-byte aligned befor>
     "call main\n"               // main() returns the status code, we'll exit >
     "mov %eax, %edi\n"          // retrieve exit code (32 bit)

diff --git a/errno.h b/errno.h
index df0e473..9781077 100644
--- a/errno.h
+++ b/errno.h
@@ -29,7 +29,8 @@
 #include <asm/errno.h>
 
 /* this way it will be removed if unused */
-static int errno;
+//static int errno;
+int errno __attribute__((weak));
 
 #ifndef NOLIBC_IGNORE_ERRNO
 #define SET_ERRNO(v) do { errno = (v); } while (0)

$ cat a.c
#include "nolibc.h"

extern void b(void);

int main(int argc, char **argv, char **envp)
{
        //environ = envp;
        errno = 1234;
        printf("main(): errno=%d env(TERM)=%s auxv=%p auxv[0].t=0x%lx auxv[0].v=0x%lx\n",
               errno, getenv("TERM"), auxv, auxv?auxv[0]:0, auxv?auxv[1]:0);
        b();
        return 0;
}

$ cat b.c
#include "nolibc.h"

void b(void)
{
        long *v = auxv;

        printf("b(): errno=%d env(TERM)=%s auxv=%p auxv[0].t=0x%lx auxv[0].v=0x%lx\n",
               errno, getenv("TERM"), auxv, auxv?auxv[0]:0, auxv?auxv[1]:0);

        printf("auxv:\n");
        while (v && v[0]) {
                printf("  0x%lx: 0x%lx\n", v[0], v[1]);
                v += 2;
        }
}

$ gcc -Os -fno-asynchronous-unwind-tables -include /g/public/nolibc/nolibc.h -Wall -nostdlib -static  -o ab a.c b.c

$ nm --size ab
0000000000000004 V errno
0000000000000008 V auxv
0000000000000008 V environ
0000000000000014 W memset
0000000000000018 W memcpy
0000000000000018 W raise
000000000000001b W abort
0000000000000030 W memmove
0000000000000053 t u64toa_r
0000000000000053 t u64toa_r
0000000000000082 T main
00000000000000a4 T b
0000000000000289 t printf
000000000000028c t printf.constprop.0

$ ./ab
main(): errno=1234 env(TERM)=xterm auxv=0x7ffdd0c31df8 auxv[0].t=0x21 auxv[0].v=0x7ffdd0d56000
b(): errno=1234 env(TERM)=xterm auxv=0x7ffdd0c31df8 auxv[0].t=0x21 auxv[0].v=0x7ffdd0d56000
auxv:
  0x21: 0x7ffdd0d56000
  0x10: 0xbfebfbff
  0x6: 0x1000
  0x11: 0x64
  0x3: 0x400040
  0x4: 0x38
  0x5: 0x7
  0x7: 0x0
  0x8: 0x0
  0x9: 0x401082
  0xb: 0x1fd
  0xc: 0x1fd
  0xd: 0x64
  0xe: 0x64
  0x17: 0x0
  0x19: 0x7ffdd0c31f39
  0x1a: 0x2
  0x1f: 0x7ffdd0c33ff3
  0xf: 0x7ffdd0c31f49

Note that I could verify that some of the entries above are valid
(e.g. "x86_64" in 0xf = AT_PLATFORM).

Thus now my focus will be on storing these variables where relevant
for all archs, so that your getauxval() implementation works on top
of it. It will be much cleaner and will also improve programs' ease
of implementation and reliability.

Cheers,
Willy

PS: maybe we should trim the Cc list for future exchanges.

