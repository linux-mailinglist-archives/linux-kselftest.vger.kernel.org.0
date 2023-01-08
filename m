Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DF16617AC
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Jan 2023 18:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjAHR7A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 Jan 2023 12:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjAHR66 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 Jan 2023 12:58:58 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 001C264D9;
        Sun,  8 Jan 2023 09:58:55 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 308Hwg9X020774;
        Sun, 8 Jan 2023 18:58:42 +0100
Date:   Sun, 8 Jan 2023 18:58:42 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Gilang Fachrezy <gilang4321@gmail.com>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v3 0/5] nolibc signal handling support
Message-ID: <20230108175842.GB18859@1wt.eu>
References: <20230108135904.851762-1-ammar.faizi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230108135904.851762-1-ammar.faizi@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ammar,

On Sun, Jan 08, 2023 at 08:58:59PM +0700, Ammar Faizi wrote:
> From: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> 
> Hi Willy,
> 
> On top of the series titled "nolibc auxiliary vector retrieval support".
> The prerequisite patches of this series are in that series.
> 
> This is v2 of nolibc signal handling support. It adds signal handling
> support to the nolibc subsystem:
> 
> 1)  Initial implementation of nolibc sigaction(2) function.
> 
>     `sigaction()` needs an architecture-dependent "signal trampoline"
>     function that invokes __rt_sigreturn syscall to resume the process
>     after a signal gets handled.
> 
>     The "signal trampoline" function is called `__restore_rt` in this
>     implementation. The naming `__restore_rt` is important for GDB. It
>     also has to be given a special optimization attribute
>     "omit-frame-pointer" to prevent the compiler from creating a stack
>     frame that makes the `%rsp` value no longer points to the `struct
>     rt_sigframe` that the kernel constructed.
> 
> 
> 2)  signal(2) function.
> 
>     signal() function is the simpler version of sigaction(). Unlike
>     sigaction(), which fully controls the struct sigaction, the caller
>     only cares about the sa_handler when calling the signal() function.
>     signal() internally calls sigaction().
> 
> 
> 3)  More selftests.
> 
>     This series also adds selftests for:
>       - fork(2)
>       - sigaction(2)
>       - signal(2)
> 
> 
> Side note for __restore_rt:
> This has been tested on x86-64 arch and `__restore_rt` generates the
> correct code. The `__restore_rt` codegen correctness on other
> architectures need to be evaluated as well. If it can't generate the
> correct code, it has to be written in inline Assembly.

I'm currently testing it on various archs. For now:

  - x86_64 and arm64 pass the test

  - i386 and arm fail:
      59 sigactiontest_sigaction_sig(2): Failed to set a signal handler
       = -1 EINVAL                [FAIL]
      60 signaltest_signal_sig(2): Failed to set a signal handler
       = -1 EINVAL                   [FAIL]

  - riscv and mips build are now broken:
      sysroot/riscv/include/sys.h:1110:18: error: 'struct sigaction' has no member named 'sa_restorer'
       1110 |         if (!act2.sa_restorer) {
            |                  ^
      sysroot/riscv/include/sys.h:1111:34: error: 'SA_RESTORER' undeclared (first use in this function); did you mean 'SA_RESTART'?
       1111 |                 act2.sa_flags |= SA_RESTORER;
            |                                  ^~~~~~~~~~~
            |                                  SA_RESTART

  - s390 segfaults:
      58 select_fault = -1 EFAULT              [OK]
      59 sigactionqemu: uncaught target signal 11 (Segmentation fault) - core dumped
      Segmentation fault

    It dies in __restore_rt at 1006ba4 while performing the syscall,
    I don't know why, maybe this arch requires an alt stack or whatever :

      0000000001006ba0 <__restore_rt>:
       1006ba0:       a7 19 00 ad             lghi    %r1,173
       1006ba4:       0a 00                   svc     0
       1006ba6:       07 07                   nopr    %r7

At the very least we need to make sure we don't degrade existing tests,
which means making sure that it builds everywhere and that all those
which build do work.

It would be nice to figure what's failing on i386. Given that both it
and arm fail on EINVAL while both x86_64 and arm64 work, I suspect that
once you figure what breaks i386 it'll fix the problem on arm at the
same time. I had a quick look but didn't spot anything suspicious.
Once we've figured this, we could decide to tag archs supporting
sig_action() and condition the functions definition and the tests to
these.

The advantage of trying with i386 is that your regular tools and the
debugger you used for x86_64 will work. I'm proceeding like this with
the toolchains from https://mirrors.edge.kernel.org/pub/tools/crosstool/ :

 $ make nolibc-test LDFLAGS=-g CFLAGS=-g ARCH=i386 CC=/path/to/gcc-11.3.0-nolibc/i386-linux/bin/i386-linux-gcc
 $ gdb ./nolibc-test
 > b sigaction
 > run
 > s
 ...
 
Note that the code looks correct at first glance:

0804b4a0 <__restore_rt>:
 804b4a0:       b8 ad 00 00 00          mov    $0xad,%eax
 804b4a5:       cd 80                   int    $0x80

I also think that the printf() in test_sigaction_sig() are not welcome
as they corrupt the output. Maybe one thing you could do to preserve the
info would be to prepend a space in front of the message and remove the
LF. For example the simple patch below:

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index a1883467451a..42f794c646b7 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -535,7 +535,7 @@ static int test_sigaction_sig(int sig)
         */
        ret = sigaction(sig, &new, &old);
        if (ret) {
-               printf("test_sigaction_sig(%d): Failed to set a signal handler\n", sig);
+               printf(" (failed to set handler for signal %d)", sig);
                return ret;
        }
 
@@ -549,7 +549,7 @@ static int test_sigaction_sig(int sig)
         * test_signal_handler() must set @g_test_sig to @sig.
         */
        if (g_test_sig != sig) {
-               printf("test_sigaction_sig(%d): Invalid g_test_sig value (%d != %d)\n", sig, g_test_sig, sig);
+               printf(" (invalid g_test_sig value (%d != %d))", sig, g_test_sig);
                return -1;
        }
 
@@ -558,7 +558,7 @@ static int test_sigaction_sig(int sig)
         */
        ret = sigaction(sig, &old, NULL);
        if (ret) {
-               printf("test_sigaction_sig(%d): Failed to restore the signal handler\n", sig);
+               printf(" (Failed to restore handler for signal %d)", sig);
                return ret;
        }
 
@@ -574,7 +574,7 @@ static int test_signal_sig(int sig)
         */
        old = signal(sig, test_signal_handler);
        if (old == SIG_ERR) {
-               printf("test_signal_sig(%d): Failed to set a signal handler\n", sig);
+               printf(" (failed to set handler for signal %d)", sig);
                return -1;
        }
 
@@ -588,7 +588,7 @@ static int test_signal_sig(int sig)
         * test_signal_handler() must set @g_test_sig to @sig.
         */
        if (g_test_sig != sig) {
-               printf("test_signal_sig(%d): Invalid g_test_sig value (%d != %d)\n", sig, g_test_sig, sig);
+               printf(" (invalid g_test_sig value (%d != %d))", sig, g_test_sig);
                return -1;
        }
 
@@ -597,7 +597,7 @@ static int test_signal_sig(int sig)
         */
        old = signal(sig, old);
        if (old == SIG_ERR) {
-               printf("test_signal_sig(%d): Failed to restore the signal handler\n", sig);
+               printf(" (Failed to restore handler for signal %d)", sig);
                return -1;
        }
 
Gives me this:

...
56 select_null = 0                       [OK]
57 select_stdout = 1                     [OK]
58 select_fault = -1 EFAULT              [OK]
59 sigaction (failed to set handler for signal 2) = -1 EINVAL                [FAIL]
60 signal (failed to set handler for signal 2) = -1 EINVAL                   [FAIL]
61 stat_blah = -1 ENOENT                 [OK]
62 stat_fault = -1 EFAULT                [OK]
63 symlink_root = -1 EEXIST              [OK]
...

Which is way more readable and still grep-friendly.

Thanks!
Willy
