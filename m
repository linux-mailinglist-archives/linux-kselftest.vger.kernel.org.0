Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCDB75320C
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 08:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbjGNGfA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jul 2023 02:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbjGNGel (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jul 2023 02:34:41 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD8E3A84;
        Thu, 13 Jul 2023 23:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1689316456; bh=/1oxjD7nPT975XYDlYAtKoJLteq/wY5FGO95uJus3iU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hIB5d3O8jIlu2qOsSvZv2zg818Pl4/G/mJ8xa1h3D0/27Bc3CvEF0ntx4T+1LC+Xl
         hNLjG3GZ8DObjNHXpoAF/hOo+Ic7b4fEnLQHb4Hahw417UMBmYlQvXK4orjcegPnF1
         zu2iZkPDQX+QTqZ4V4rr2QW6CtYU3Lsz4D5ebGKc=
Date:   Fri, 14 Jul 2023 08:34:15 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     w@1wt.eu, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 02/11] tools/nolibc: add new crt.h with _start_c
Message-ID: <63476acf-9e65-4ab0-8e9b-bc35b12710d5@t-8ch.de>
References: <ZK+a6rEJIUjCnNsZ@1wt.eu>
 <20230714055813.115290-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714055813.115290-1-falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-07-14 13:58:13+0800, Zhangjin Wu wrote:

> [..]

> Which one do you prefer? the one with local variables may be more readable (not
> that much), the one with global variables has smaller text size (and therefore
> smaller memory footprint).

The one with local variables. But not by much.

> BTW, just found an arch-<ARCH>.h bug with -O0, seems the
> 'optimize("omit-frame-pointer")' attribute not really work as expected with
> -O0. It uses frame pointer for _start eventually and breaks the stack pointer
> variable (a push 'rbp' inserted at the begging of _start, so, the real rsp has
> an offset), so, therefore, it is not able to get the right argc, argv, environ
> and _auxv with -O0 currently. A solution is reverting _start to pure assembly.
> 
> For the above tests, I manually reverted the arch-x86_64.h to:
> 
>     __asm__(
>             ".text\n"
>             ".weak _start\n"
>             "_start:\n"
>     #ifdef _NOLIBC_STACKPROTECTOR
>             "call __stack_chk_init\n" /* initialize stack protector                      */
>     #endif
>             "xor  %ebp, %ebp\n"       /* zero the stack frame                            */
>             "mov  %rsp, %rdi\n"       /* save stack pointer to %rdi, as arg1 of _start_c */
>             "and  $-16, %rsp\n"       /* %rsp must be 16-byte aligned before call        */
>             "call _start_c\n"         /* transfer to c runtime                           */
>             "hlt\n"                   /* ensure it does not return                       */
>     );
> 
> 
> 'man gcc' shows:
> 
>     Most optimizations are completely disabled at -O0 or if an -O level is not set on the command line, even if individual optimization flags are specified.
> 
> To want -O0 work again, since now we have C _start_c, is it ok for us to revert
> the commit 7f8548589661 ("tools/nolibc: make compiler and assembler agree on
> the section around _start") and the later __no_stack_protector changes?

This commit explicitly mentions being tested with -O0 on x86_64.
I was also not able to reproduce the issue.

Before doing any reverts I think some more investigation is in order.
Can you provide exact reproduction steps?

> At the same time, to verify such issues, as Thomas suggested, in this series,
> we may need to add more startup tests to verify argc, argv, environ, _auxv, do
> we need to add a standalone run_startup (or run_crt) test entry just like
> run_syscall? or, let's simply add more in the run_stdlib, like the environ test
> added by Thomas.  seems, the argc test is necessary one currently missing (argc
> >= 1):
> 
>     CASE_TEST(argc);               EXPECT_GE(1, test_argc, 1); break;
> 
> As we summarized before, the related test cases are:
> 
> argv0:
> 
>     CASE_TEST(chmod_argv0);       EXPECT_SYSZR(1, chmod(test_argv0, 0555)); break;
>     CASE_TEST(chroot_exe);        EXPECT_SYSER(1, chroot(test_argv0), -1, ENOTDIR); break;
> 
> environ:
> 
>     CASE_TEST(chdir_root);        EXPECT_SYSZR(1, chdir("/")); chdir(getenv("PWD")); break;
>     CASE_TEST(environ);            EXPECT_PTREQ(1, environ, test_envp); break;
>     CASE_TEST(getenv_TERM);        EXPECT_STRNZ(1, getenv("TERM")); break;
>     CASE_TEST(getenv_blah);        EXPECT_STRZR(1, getenv("blah")); break;
> 
> auxv:
> 
>     CASE_TEST(getpagesize);       EXPECT_SYSZR(1, test_getpagesize()); break;
> 
> The above tests are in different test group and are not aimed to startup test,
> we'd better add a run_startup (or run_crt) test group before any other tests,
> it is a requiremnt of the others, we at least have these ones:
> 
>     +int run_startup(int min, int max)
>     +{
>     +       int test;
>     +       int tmp;
>     +       int ret = 0;
>     +
>     +       for (test = min; test >= 0 && test <= max; test++) {
>     +               int llen = 0; /* line length */
>     +
>     +               /* avoid leaving empty lines below, this will insert holes into
>     +                * test numbers.
>     +                */
>     +               switch (test + __LINE__ + 1) {
>     +               CASE_TEST(argc);               EXPECT_GE(1, test_argc, 1); break;
>     +               CASE_TEST(argv_addr);          EXPECT_PTRNZ(1, test_argv); break;
>     +               CASE_TEST(argv_total);         EXPECT_EQ(1, environ - test_argv - 1, test_argc); break;
>     +               CASE_TEST(argv0_addr);         EXPECT_PTRNZ(1, argv0); break;
>     +               CASE_TEST(argv0_str);          EXPECT_STRNZ(1, argv0); break;
>     +               CASE_TEST(argv0_len);          EXPECT_GE(1, strlen(argv0), 1); break;
>     +               CASE_TEST(environ_addr);       EXPECT_PTRNZ(1, environ); break;
>     +               CASE_TEST(environ_envp);       EXPECT_PTREQ(1, environ, test_envp); break;
>     +               CASE_TEST(environ_total);      EXPECT_GE(1, (void *)_auxv - (void *)environ - 1, 1); break;
>     +               CASE_TEST(_auxv_addr);         EXPECT_PTRNZ(1, _auxv); break;
>     +               case __LINE__:
>     +                       return ret; /* must be last */
>     +               /* note: do not set any defaults so as to permit holes above */
>     +               }
>     +       }
>     +       return ret;
>     +}
> 
> Any more?

My original idea was to have tests that exec /proc/self/exe or argv0.
This way we can actually pass and validate arbitrary argc, argv and
environ values.

But looking at your list, that should be enough.

> [..]
