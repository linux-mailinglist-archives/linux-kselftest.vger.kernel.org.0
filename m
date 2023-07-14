Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3507536F5
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 11:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbjGNJrn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jul 2023 05:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235403AbjGNJrm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jul 2023 05:47:42 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D1C1BD4;
        Fri, 14 Jul 2023 02:47:36 -0700 (PDT)
X-QQ-mid: bizesmtp62t1689328045tm68xu8h
Received: from linux-lab-host.localdomain ( [116.30.126.249])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 14 Jul 2023 17:47:23 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: KzokuMsy9J2dExfopL72Ou8SQB4ufmpc2edexHmD9pZynHiKLM3kn8fgnrdKm
        NuQx63Ef2sNPFCDr9Pj7e8W8+7Qh0+AfEZSDK+Wd/Jdqr4HUpr75zWTQcozvdnOVdFjUvvT
        r1J/NYxQjGKk5z8npamq0tUCzUb0KyN72a4bBJLuRtkcRdMmec++zjEvOEk9DsPhh1xNVgb
        gipSy9t2a8hH+wsFfm8SJrxPGoZFI9HtAGuWIl1h/Bj8gxf8chPbHKlLBkG4lKl8nfMtD4s
        RmH5/eU0a/vSAPd3Ob37CcREa1nUoihilMoJOgBwifNlgXzot5+4uF0aMY9mvuAzX7B8hx6
        ladYaq1EMx2sDeKKPt3BNFGWTOHjxqRPPF76UDd5fZZgYhGWoCCagkMibtrkQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13031537347454340989
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, w@1wt.eu
Subject: Re: [PATCH v3 02/11] tools/nolibc: add new crt.h with _start_c
Date:   Fri, 14 Jul 2023 17:47:23 +0800
Message-Id: <20230714094723.140603-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <63476acf-9e65-4ab0-8e9b-bc35b12710d5@t-8ch.de>
References: <63476acf-9e65-4ab0-8e9b-bc35b12710d5@t-8ch.de>
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

> On 2023-07-14 13:58:13+0800, Zhangjin Wu wrote:
>
> > [..]
>
> > Which one do you prefer? the one with local variables may be more readable (not
> > that much), the one with global variables has smaller text size (and therefore
> > smaller memory footprint).
>
> The one with local variables. But not by much.
>
> > BTW, just found an arch-<ARCH>.h bug with -O0, seems the
> > 'optimize("omit-frame-pointer")' attribute not really work as expected with
> > -O0. It uses frame pointer for _start eventually and breaks the stack pointer
> > variable (a push 'rbp' inserted at the begging of _start, so, the real rsp has
> > an offset), so, therefore, it is not able to get the right argc, argv, environ
> > and _auxv with -O0 currently. A solution is reverting _start to pure assembly.
> >
> > For the above tests, I manually reverted the arch-x86_64.h to:
> >
> >     __asm__(
> >             ".text\n"
> >             ".weak _start\n"
> >             "_start:\n"
> >     #ifdef _NOLIBC_STACKPROTECTOR
> >             "call __stack_chk_init\n" /* initialize stack protector                      */
> >     #endif
> >             "xor  %ebp, %ebp\n"       /* zero the stack frame                            */
> >             "mov  %rsp, %rdi\n"       /* save stack pointer to %rdi, as arg1 of _start_c */
> >             "and  $-16, %rsp\n"       /* %rsp must be 16-byte aligned before call        */
> >             "call _start_c\n"         /* transfer to c runtime                           */
> >             "hlt\n"                   /* ensure it does not return                       */
> >     );
> >
> >
> > 'man gcc' shows:
> >
> >     Most optimizations are completely disabled at -O0 or if an -O level is not set on the command line, even if individual optimization flags are specified.
> >
> > To want -O0 work again, since now we have C _start_c, is it ok for us to revert
> > the commit 7f8548589661 ("tools/nolibc: make compiler and assembler agree on
> > the section around _start") and the later __no_stack_protector changes?
>
> This commit explicitly mentions being tested with -O0 on x86_64.

Yeah, I was worried about that the old tests didn't use any of the startup
variables, but the getpagesize test may be a very old test, It uses _auxv and
should fail If -O0 not work.

> I was also not able to reproduce the issue.
>

Thanks very much for your 'reproduce' result, It is so weird, just
rechecked the toolchain, 13.1.0 from https://mirrors.edge.kernel.org/ is
ok, gcc 9, gcc 10.3 not work.

But even in the page of 13.1.0 [1], we still see this line:

    Most optimizations are completely disabled at -O0 or if an -O level is not set on the command line, even if individual optimization flags are specified.

Not sure if "individual optimization flags" also means the optimize()
flags in gcc attributes. or the doc is not updated yet?

And further found gcc 11.1.0 is ok, gcc 10.4 still not work, so, gcc
11.1.0 may changed something to let the "individual optimization flags"
work with -O0.

We may need to at least document this issue in some files, -O0 is not such a
frequently-used option, not sure if we still need -O0 work with the older gcc <
11.1.0 ;-)

Willy, I'm not sure if the issues solved by the commit 7f8548589661
("tools/nolibc: make compiler and assembler agree on the section around
_start") still exist after we using _start_c()?

Thomas, because we plan to move the stackprotector init to _start_c(), If using
pure assembly _start, we may also not need the __no_stack_protector macro too?

Welcome more discussion. 

[1]: https://gcc.gnu.org/onlinedocs/gcc-13.1.0/gcc/Optimize-Options.html

> Before doing any reverts I think some more investigation is in order.
> Can you provide exact reproduction steps?
>

some startup variables related tests failed with gcc 9 and gcc 10 (even with
gcc 10.4.0):

    $ x86_64-linux-gcc --version
    x86_64-linux-gcc (GCC) 10.4.0
    Copyright (C) 2020 Free Software Foundation, Inc.
    This is free software; see the source for copying conditions.  There is NO
    warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

    $ make run-user CROSS_COMPILE=x86_64-linux-
    0 argc = 0                                                      [FAIL]
    3 argv_total = 0                                                [FAIL]
    4 argv0_addr = <0x1>                                            [FAIL]
    5 argv0_str = <(null)>                                          [FAIL]
    6 argv0_len = 0                                                 [FAIL]
    14 chmod_argv0 = -1 EFAULT                                      [FAIL]
    19 chroot_exe = -1 EFAULT  != (-1 ENOTDIR)                      [FAIL]
    0 getenv_TERM = <(null)>                                        [FAIL]

> > At the same time, to verify such issues, as Thomas suggested, in this series,
> > we may need to add more startup tests to verify argc, argv, environ, _auxv, do
> > we need to add a standalone run_startup (or run_crt) test entry just like
> > run_syscall? or, let's simply add more in the run_stdlib, like the environ test
> > added by Thomas.  seems, the argc test is necessary one currently missing (argc
> > >= 1):
> >
> >     CASE_TEST(argc);               EXPECT_GE(1, test_argc, 1); break;
> >
> > As we summarized before, the related test cases are:
> >
> > argv0:
> >
> >     CASE_TEST(chmod_argv0);       EXPECT_SYSZR(1, chmod(test_argv0, 0555)); break;
> >     CASE_TEST(chroot_exe);        EXPECT_SYSER(1, chroot(test_argv0), -1, ENOTDIR); break;
> >
> > environ:
> >
> >     CASE_TEST(chdir_root);        EXPECT_SYSZR(1, chdir("/")); chdir(getenv("PWD")); break;
> >     CASE_TEST(environ);            EXPECT_PTREQ(1, environ, test_envp); break;
> >     CASE_TEST(getenv_TERM);        EXPECT_STRNZ(1, getenv("TERM")); break;
> >     CASE_TEST(getenv_blah);        EXPECT_STRZR(1, getenv("blah")); break;
> >
> > auxv:
> >
> >     CASE_TEST(getpagesize);       EXPECT_SYSZR(1, test_getpagesize()); break;
> >
> > The above tests are in different test group and are not aimed to startup test,
> > we'd better add a run_startup (or run_crt) test group before any other tests,
> > it is a requiremnt of the others, we at least have these ones:
> >
> >     +int run_startup(int min, int max)
> >     +{
> >     +       int test;
> >     +       int tmp;
> >     +       int ret = 0;
> >     +
> >     +       for (test = min; test >= 0 && test <= max; test++) {
> >     +               int llen = 0; /* line length */
> >     +
> >     +               /* avoid leaving empty lines below, this will insert holes into
> >     +                * test numbers.
> >     +                */
> >     +               switch (test + __LINE__ + 1) {
> >     +               CASE_TEST(argc);               EXPECT_GE(1, test_argc, 1); break;
> >     +               CASE_TEST(argv_addr);          EXPECT_PTRNZ(1, test_argv); break;
> >     +               CASE_TEST(argv_total);         EXPECT_EQ(1, environ - test_argv - 1, test_argc); break;
> >     +               CASE_TEST(argv0_addr);         EXPECT_PTRNZ(1, argv0); break;
> >     +               CASE_TEST(argv0_str);          EXPECT_STRNZ(1, argv0); break;
> >     +               CASE_TEST(argv0_len);          EXPECT_GE(1, strlen(argv0), 1); break;
> >     +               CASE_TEST(environ_addr);       EXPECT_PTRNZ(1, environ); break;
> >     +               CASE_TEST(environ_envp);       EXPECT_PTREQ(1, environ, test_envp); break;
> >     +               CASE_TEST(environ_total);      EXPECT_GE(1, (void *)_auxv - (void *)environ - 1, 1); break;
> >     +               CASE_TEST(_auxv_addr);         EXPECT_PTRNZ(1, _auxv); break;
> >     +               case __LINE__:
> >     +                       return ret; /* must be last */
> >     +               /* note: do not set any defaults so as to permit holes above */
> >     +               }
> >     +       }
> >     +       return ret;
> >     +}
> >
> > Any more?
>
> My original idea was to have tests that exec /proc/self/exe or argv0.
> This way we can actually pass and validate arbitrary argc, argv and
> environ values.
>
> But looking at your list, that should be enough.
>

Ok.

Best regards,
Zhangjin

> > [..]
