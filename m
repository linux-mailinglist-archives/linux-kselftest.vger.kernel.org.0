Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCFC76A818
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 06:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjHAE7S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 00:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjHAE7R (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 00:59:17 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A261FD0;
        Mon, 31 Jul 2023 21:59:11 -0700 (PDT)
X-QQ-mid: bizesmtp72t1690865943takhnre8
Received: from linux-lab-host.localdomain ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 01 Aug 2023 12:59:02 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: kW11ei911QK6B0OE3CAY7C3OEZKNbiYTxRaE8QZqvA8pLEHRtQ/zi3u4ytL33
        qMZNdk7pvRQSk+8P6rKcxkPjcEwueoy5rFQpOrHyh4R/TIvc1Qij8gxcgshnf1RqNE/cKIs
        SYAsphcnXucGtHHxA1QdiIl64B+dj4tqj1WVemEt+k22RFnJzWVXPJlIBub43TpfRTq4mGj
        EaXrZslDz8Hl3wZgA/URHauv6cbOWWOftEdGdqkyLZU4pdecYeh3YFgKPWuEbbigA4KojP3
        CgpHnir8BVkx7bamJDCkOnGt0dbqX47hf/7QefmTqVhnyITedq0rj80EBpbUe/G/pd7UckJ
        9IkYm8YoOrvaUjbp2gG2HYUnNhjgRAzDZbdaWLY6Svdc1N0Lkk=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8745531179724185604
From:   Zhangjin Wu <falcon@tinylab.org>
To:     linux@weissschuh.net, w@1wt.eu
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        tanyuan@tinylab.org
Subject: tools/nolibc: RFC: report and drop unused functions/data by gc-section 
Date:   Tue,  1 Aug 2023 12:59:02 +0800
Message-Id: <20230801045902.37360-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy, Thomas

Currently, since this part of the discussion is out of the original topic [1],
as suggested by Willy, open a new thread for this.

[1]: https://lore.kernel.org/lkml/20230731224929.GA18296@1wt.eu/#R

The original topic [1] tries to enable -Wall (or even -Wextra) to report some
issues (include the dead unused functions/data) found during compiling stage,
this further propose a method to enable '-ffunction-sections -fdata-sections
-Wl,--gc-sections,--print-gc-sections to' find the dead unused functions/data
during linking stage:

    Just thought about gc-section, do we need to further remove dead code/data
    in the binary? I don't think it is necessary for nolibc-test itself, but with
    '-Wl,--gc-sections -Wl,--print-gc-sections' may be a good helper to show us
    which ones should be dropped or which ones are wrongly declared as public?
    
    Just found '-O3 + -Wl,--gc-section + -Wl,--print-gc-sections' did tell
    us something as below:
    
        removing unused section '.text.nolibc_raise'
        removing unused section '.text.nolibc_memmove'
        removing unused section '.text.nolibc_abort'
        removing unused section '.text.nolibc_memcpy'
        removing unused section '.text.__stack_chk_init'
        removing unused section '.text.is_setting_valid'
    
    These info may help us further add missing 'static' keyword or find
    another method to to drop the wrongly used status of some functions from
    the code side.

Let's continue the discussion as below.

> On Mon, Jul 31, 2023 at 08:36:05PM +0200, Thomas Weißschuh wrote:
> 
> [...]
> 
> > > > > It is very easy to add the missing 'static' keyword for is_setting_valid(), but
> > > > > for __stack_chk_init(), is it ok for us to convert it to 'static' and remove
> > > > > the 'weak' attrbute and even the 'section' attribute? seems it is only used by
> > > > > our _start_c() currently.
> > > > 
> > > > Making is_setting_valid(), __stack_chk_init() seems indeed useful.
> > > > Also all the run_foo() test functions.
> > > 
> > > Most of them could theoretically be turned to static. *But* it causes a
> > > problem which is that it will multiply their occurrences in multi-unit
> > > programs, and that's in part why we've started to use weak instead. Also
> > > if you run through gdb and want to mark a break point, you won't have the
> > > symbol when it's static,

Willy, did I misunderstand something again? a simple test shows, seems this is
not really always like that, static mainly means 'local', the symbol is still
there if without -O2/-Os and is able to be set a breakpoint at:

    // test.c: gcc -o test test.c
    #include <stdio.h>

    static int test (void)
    {
    	printf("hello, world!\n");
    }

    int main(void)
    {
    	test();
    
    	return 0;
    }

Even with -Os/-O2, an additional '-g' is able to generate the 'test' symbol for
debug as we expect.

>     and the code will appear at multiple locations,
> > > which is really painful. I'd instead really prefer to avoid static when
> > > we don't strictly want to inline the code, and prefer weak when possible
> > > because we know many of them will be dropped at link time (and that's
> > > the exact purpose).

For the empty __stack_chk_init() one (when the arch not support stackprotector)
we used, when with 'weak', it is not possible drop it during link time even
with -O3, the weak one will be dropped may be only when there is a global one
with the same name is used or the 'weak' one is never really used?

    #include <stdio.h>

    __attribute__((weak,unused,section(".text.nolibc_memset")))
    int test (void)
    {
    	printf("hello, world!\n");
    }

    int main(void)
    {
    	test();
    
    	return 0;
    }


    0000000000001060 <main>:
        1060:       f3 0f 1e fa             endbr64 
        1064:       48 83 ec 08             sub    $0x8,%rsp
        1068:       e8 03 01 00 00          callq  1170 <test>
        106d:       31 c0                   xor    %eax,%eax
        106f:       48 83 c4 08             add    $0x8,%rsp
        1073:       c3                      retq   
        1074:       66 2e 0f 1f 84 00 00    nopw   %cs:0x0(%rax,%rax,1)
        107b:       00 00 00 
        107e:       66 90                   xchg   %ax,%ax

Seems it is either impossible to add a 'inline' keyword again with the 'weak'
attribute (warned by compiler), so, the _start_c (itself is always called by
_start) will always add an empty call to the weak empty __stack_chk_init(),
-Os/-O2/-O3 don't help. for such an empty function, in my opinion, as the size
we want to care about, the calling place should be simply removed by compiler.

Test also shows, with current __inline__ method, the calling place is removed,
but with c89, the __stack_chk_init() itself will not be droped automatically,
only if not with -std=c89, it will be dropped and not appear in the
--print-gc-sections result.

Even for a supported architecture, the shorter __stack_chk_init() may be better
to inlined to the _start_c()?

So, If my above test is ok, then, we'd better simply convert the whole
__stack_chk_init() to a static one as below (I didn't investigate this deeply
due to the warning about static and weak conflict at the first time):

    diff --git a/tools/include/nolibc/crt.h b/tools/include/nolibc/crt.h
    index 32e128b0fb62..a5f33fef1672 100644
    --- a/tools/include/nolibc/crt.h
    +++ b/tools/include/nolibc/crt.h
    @@ -10,7 +10,7 @@
     char **environ __attribute__((weak));
     const unsigned long *_auxv __attribute__((weak));

    -void __stack_chk_init(void);
    +static void __stack_chk_init(void);
     static void exit(int);

     void _start_c(long *sp)
    diff --git a/tools/include/nolibc/stackprotector.h b/tools/include/nolibc/stackprotector.h
    index b620f2b9578d..13f1d0e60387 100644
    --- a/tools/include/nolibc/stackprotector.h
    +++ b/tools/include/nolibc/stackprotector.h
    @@ -37,8 +37,7 @@ void __stack_chk_fail_local(void)
     __attribute__((weak,section(".data.nolibc_stack_chk")))
     uintptr_t __stack_chk_guard;

    -__attribute__((weak,section(".text.nolibc_stack_chk"))) __no_stack_protector
    -void __stack_chk_init(void)
    +static __no_stack_protector void __stack_chk_init(void)
     {
            my_syscall3(__NR_getrandom, &__stack_chk_guard, sizeof(__stack_chk_guard), 0);
            /* a bit more randomness in case getrandom() fails, ensure the guard is never 0 */
    @@ -46,7 +45,7 @@ void __stack_chk_init(void)
                    __stack_chk_guard ^= (uintptr_t) &__stack_chk_guard;
     }
     #else /* !defined(_NOLIBC_STACKPROTECTOR) */
    -__inline__ void __stack_chk_init(void) {}
    +static void __stack_chk_init(void) {}
     #endif /* defined(_NOLIBC_STACKPROTECTOR) */

     #endif /* _NOLIBC_STACKPROTECTOR_H */

> > 
> > Thanks for the clarification. I forgot about that completely!
> > 
> > The stuff from nolibc-test.c itself (run_foo() and is_settings_valid())
> > should still be done.
> 
> Yes, likely. Nolibc-test should be done just like users expect to use
> nolibc, and nolibc should be the most flexible possible.

For the 'static' keyword we tested above, '-g' may help the debug requirement,
so, is ok for us to apply 'static' for them safely now?

A further test shows, with 'static' on _start_c() doesn't help the size, for it
is always called from _start(), will never save move instructions, but we need
a more 'used' attribute to silence the error 'nolibc-test.c:(.text+0x38cd):
undefined reference to `_start_c'', so, reserve it as the before simpler 'void
_start_c(void)' may be better?

    static __attribute__((used)) void _start_c(long *sp)

Thanks,
Zhangjin

> 
> Cheers,
> Willy
