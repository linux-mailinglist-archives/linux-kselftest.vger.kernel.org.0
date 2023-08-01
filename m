Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733BF76B214
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 12:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjHAKoH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 06:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjHAKoG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 06:44:06 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3AEDB;
        Tue,  1 Aug 2023 03:44:02 -0700 (PDT)
X-QQ-mid: bizesmtp69t1690886636tmchd546
Received: from linux-lab-host.localdomain ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 01 Aug 2023 18:43:55 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: ZNeI2QSW/Mx39dK7OEJT1d6tsQHw0YoDJZv+lKDYGz6eUdUvBGfqHNhKXEB5a
        9Eet6yVB965cUMZqAUYRYtpMMC2pa67MqD342q8iZiwCN/3CY6c/j1yUnNFR0QLFXjUK9UQ
        XByjUQQHID5nmWmpyvKJ7LHsxANQuFPUdltUgb0c1SpVRMzfqn4xTDbtuCdqoq/JxZiGp6A
        RpPXMgf0utDx2nJyGGLgfXr6gRhQEnjjSkTH++wpjY1T3mC8hgvQazex4/1CJCVA80C0HlA
        j2EG8W2KiI7bxhKCZgIEL9K/4vkaNZXab6Mo81C2x5gCVPkJZ2d9K6hPhCt+aCci0CiaF0A
        EEpgxkvgtxNC29P4NiidaSEmdPCAffa1AOosXGOHNjY/dnT3Ui1BelJvhIOF+V4TRBK5fnN
        Mdkdesql/to=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3218652239303942793
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu, linux@weissschuh.net
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        tanyuan@tinylab.org
Subject: Re: tools/nolibc: RFC: report and drop unused functions/data by gc-section
Date:   Tue,  1 Aug 2023 18:43:55 +0800
Message-Id: <20230801104355.77044-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZMip5q9C/VuNMrUX@1wt.eu>
References: <ZMip5q9C/VuNMrUX@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy, Hi, Thomas

> Hi Zhangjin,
> 
> On Tue, Aug 01, 2023 at 12:59:02PM +0800, Zhangjin Wu wrote:
[...]
> > 
> > Willy, did I misunderstand something again? a simple test shows, seems this is
> > not really always like that, static mainly means 'local', the symbol is still
> > there if without -O2/-Os and is able to be set a breakpoint at:
> > 
[...]
> > 
> > Even with -Os/-O2, an additional '-g' is able to generate the 'test' symbol for
> > debug as we expect.
> 
> Please compare this:
> 
>   $ cat test.c
>   #include <stdio.h>
>   
>   static int test (void)
>   {
>       printf("hello, world!\n");
>   }
>   
>   int main(void)
>   {
>       test();
>   
>       return 0;
>   }
>   
>   $ gcc -Os -o test test.c
>   $ objdump --disassemble=main  test
>   (...)
>   Disassembly of section .text:
>   
>   0000000000401040 <main>:
>     401040:       50                      push   %rax
>     401041:       bf 04 20 40 00          mov    $0x402004,%edi
>     401046:       e8 e5 ff ff ff          call   401030 <puts@plt>
>     40104b:       31 c0                   xor    %eax,%eax
>     40104d:       5a                      pop    %rdx
>     40104e:       c3                      ret    
> 
>   $ gdb ./test
>   (...)
>   Reading symbols from ./test...
>   (gdb) b test
>   Function "test" not defined.
>   (gdb) r
>   Starting program: /dev/shm/test 
>   hello, world!
>   [Inferior 1 (process 8780) exited normally]
> 
> To this:
> 
>   $ cat test.c
>   #include <stdio.h>
>   
>   /*static*/ int test (void)
>   {
>       printf("hello, world!\n");
>   }
>   
>   int main(void)
>   {
>       test();
>   
>       return 0;
>   }
>   
>   $ gcc -Os -o test test.c
>   $ objdump --disassemble=main  test
>   (...)
>   Disassembly of section .text:
>   
>   0000000000401040 <main>:
>     401040:       50                      push   %rax
>     401041:       e8 e0 00 00 00          call   401126 <test>
>     401046:       31 c0                   xor    %eax,%eax
>     401048:       5a                      pop    %rdx
>     401049:       c3                      ret    
> 
>   $ gdb ./test
>   (...)
>   Reading symbols from ./test...
>   (gdb) b test
>   Breakpoint 1 at 0x401126
>   (gdb) r
>   Starting program: /dev/shm/test 
>   
>   Breakpoint 1, 0x0000000000401126 in test ()
>   (gdb) 
> 
> See the difference ?
>

Thanks, Willy, I did all tests and mentioned this difference in my
reply, but is not obviously described ;-)

    "static mainly means 'local', the symbol is still there **if without
    -O2/-Os** and is able to be set a breakpoint at".

> > >     and the code will appear at multiple locations,
> > > > > which is really painful. I'd instead really prefer to avoid static when
> > > > > we don't strictly want to inline the code, and prefer weak when possible
> > > > > because we know many of them will be dropped at link time (and that's
> > > > > the exact purpose).
> > 
> > For the empty __stack_chk_init() one (when the arch not support stackprotector)
> > we used, when with 'weak', it is not possible drop it during link time even
> > with -O3, the weak one will be dropped may be only when there is a global one
> > with the same name is used or the 'weak' one is never really used?
> 
> If that's the case for this one, it's sufficient to enclose it within a pair
> of #if defined(__SSP__).
>

Yeah, it is a solution, but to be honest, let's think about the '#ifdef'
ones we have used in in _start asm(), it is better to not add it back
again ;-) 

[...]
> 
> There is not better or worse, it doesn't work like this. What is important
> to keep in mind is:
>   - if the symbol needs to be exported, it must not be static. If it risks
>     to be declared multiple times (since appearing in a .h possibly included
>     multiple times), it needs to be marked weak.
> 
>   - if the symbol benefits from being reused a lot because it's huge and
>     almost always needed, it can benefit as well from being exported so
>     that at the end there is only one instead of multiple copies.
> 
>   - if the symbol is never needed outside and its duplication is not a
>     problem, it's better static.
> 
> __stack_chk_init() used to be called directly from asm(). We had no other
> option.

Thanks, it explains clearly about why we use 'weak' for _start asm() before.

> With _start_c() it seems this has changed so maybe it can now be
> static (I have not checked).

In my test environment (gcc 9.3 + ld 2.34 + x86_64), as I just tested
about _start_c(), both

    __attribute__((weak))

    and

    static __attribute__((used))

provide the _start_c symbol as required by the _start asm() and it
compiled without any failure.

> But *these* are the only valid justifications,
> nothing based on preference or being better or whatever. These serve two
> completely different goals.
>

ok, so, the only benefit may be the saving of some bits of the function
calling instructions.

> > So, If my above test is ok, then, we'd better simply convert the whole
> > __stack_chk_init() to a static one as below (I didn't investigate this deeply
> > due to the warning about static and weak conflict at the first time):
> 
> Static and weak together make absolutely no sense. Static says "do not export
> it, it's local" and weak says "when you find multiple copies of it, keep only
> one". By definition they are mutually exclusive.
>

Yes, thanks to clarify it, I knew 'weak' is widely used in kernel side to
override the generic weak functions with architecture specific optimized ones.
I have used it frequently especially when I was developing the mainline MIPS
ftrace support, in my memory, the sched_clock() is a very good example.

> > > > Thanks for the clarification. I forgot about that completely!
> > > > 
> > > > The stuff from nolibc-test.c itself (run_foo() and is_settings_valid())
> > > > should still be done.
> > > 
> > > Yes, likely. Nolibc-test should be done just like users expect to use
> > > nolibc, and nolibc should be the most flexible possible.
> > 
> > For the 'static' keyword we tested above, '-g' may help the debug requirement,
> > so, is ok for us to apply 'static' for them safely now?
> 
> Please, read above and do not speculate but actually try by yourself and
> see what doesn't work.

Willy, as I explained above, before sending my last reply, I did all
tests (by default, tests often before any of my replies) but the issue
is what you expected is the one I just not wrote obviously in my reply,
it worths an improvement to avoid info gap ;-)

> I can assure you that it's extremely time consuming
> to have to justify everything that was done over the last years to reach
> the current situation, so as to make sure we don't go back several years
> just due to matters of taste. By definition a libc cannot look nice, and
> when implemented exclusively in include files there are strong tradeoffs
> that are needed. The vast majority of them are already documented in the
> code and others in commit messages. Others will obviously depend on
> everyone's experience at recognizing certain patterns. I think I'll spend
> some time writing some doc explaining some design rules, some choices that
> are imposed to us and certain patterns to adopt or avoid. It will surely
> help and save us a lot of review and discussion time in the future (at
> least I hope).
>

Agree, but I don't think it is a big program, the learning of the commit
message, comments is a basic step before writing something new.

Friendly to mention, something important I have found during the last
several discussions among us is, although all of us are friendly and
kindly enough, but due to some info gap or some info lost, we all may
persist a direction which may have some traps and sometimes very easy to
out-of-topic or out of the issues we are really solving, so, I was even
worried about to send a new patch or start a new reply these days, one
possible reason may be overloaded ;-)

> > A further test shows, with 'static' on _start_c() doesn't help the size, for it
> > is always called from _start(), will never save move instructions, but we need
> > a more 'used' attribute to silence the error 'nolibc-test.c:(.text+0x38cd):
> > undefined reference to `_start_c'', so, reserve it as the before simpler 'void
> > _start_c(void)' may be better?
> > 
> >     static __attribute__((used)) void _start_c(long *sp)
> 
> Again if you test this you'll see that it probably does not work. It's
> called from asm so it needs to be public. And it needs the weak
> attribute to avoid clashes.

Willy, I did test it before sending the last reply, and luckily, it
worked at least with my compiler on x86_64 although we don't really want
it for _start_c, let's reserve global as-is.

I'm not mean we should use 'used' instead of 'weak' we have used in
nolibc, just show my test result here as a reference. 

Seems there is also a new 'retain', but it servces something different,
it tells 'ld --gc-sections' not drop it, but 'used' is for compiler not
discard it, this page does explain more: https://reviews.llvm.org/D96838

Yuan and me are exploring the compiler and linker options/attributes to
let our dead syscall patchset being able to drop every syscall (some of
them are wrongly kept by KEEP), so we found some docs about 'used',
'retain' and the other more related attributes in the past weeks.

> 
> At least you've convinced me about something: we need to split nolibc-test
> into multiple files (e.g. one for syscalls, one for stdlib etc) so that we
> also catch the cases where we're missing some weak attributes.

Ok, thanks.

As a summary, is it ok for Thomas to add a change like this to his patchset (or
a standalone patchset from me)?

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

Best regards,
Zhangjin

> 
> Thanks,
> Willy
