Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C450E753194
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 07:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbjGNF6d (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jul 2023 01:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234972AbjGNF63 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jul 2023 01:58:29 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94402D53;
        Thu, 13 Jul 2023 22:58:26 -0700 (PDT)
X-QQ-mid: bizesmtp76t1689314294t4wks5we
Received: from linux-lab-host.localdomain ( [116.30.126.249])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 14 Jul 2023 13:58:13 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: QityeSR92A1r0dZYKysvswa6YLF7AQCfxPyw6eJ4k2jvak6VqohPpQMFByqbW
        VFV67C+tfxsadz74XZpdRm/ortWTBW4OAADis6YBsYcjt3pxmi0/MKAbXH8XQ9EElcnpj5s
        ujTD/ZekXp28HtcKrXY3QHxxjB1+oqqk4CGRNzI/8tSFaBwtoOBKm/pvHQwFNUQanbbQqyw
        IFGmJuaWLMNBOeA/WSEZIJEUBzzlnXRsY4Wj4EGp9VzJrwSEA1nKazZ1YXECXeN5qmSng37
        GHug2dGYTBzs7y7RpCjKqmJqX+IUpdIEA1zDipRq9fx+OBrNnDMKwWfP413onOqXWlNQx28
        u2jmUYLLHkDUYnPYeuZF8E71BK0Uw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1345825097609930773
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v3 02/11] tools/nolibc: add new crt.h with _start_c
Date:   Fri, 14 Jul 2023 13:58:13 +0800
Message-Id: <20230714055813.115290-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZK+a6rEJIUjCnNsZ@1wt.eu>
References: <ZK+a6rEJIUjCnNsZ@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy, Thomas

> Hi Zhangjin,
>
> I haven't reviewed the rest yet but regarding this point:
>
> On Thu, Jul 13, 2023 at 02:12:27PM +0800, Zhangjin Wu wrote:
> > > > +	/* find auxv */
> > > > +	i = 0;
> > > > +	while (envp[i])
> > > > +		i++;
> > > > +	_auxv = (void *)(envp + i + 1);
> > >
> > > Could be simplified a bit:
> > >
> > > _auxv = (void *) envp;
> > > while (_auxv)
> > > 	_auxv++;
> > >
> >
> > Yeah, it is better, but needs a little change.
> >
> >     _auxv = (void *) envp;
> >     while (*_auxv)
> > 	_auxv++;
> >     _auxv++;
>
> Or just:
>
>     _auxv = (void*)environ;
>     while (*_auxv++)
>          ;
>
> or:
>
>     for (_auxv = (void*)environ; *_auxv++; )
>          ;
>
> Please also have a look at the output code, because at low optimization
> levels, compilers sometimes produce a better code with a local variable
> than with a global variable in a loop. Thus I wouldn't be that much
> surprised if at -O0 or -O1 you'd see slightly more compact code using:
>

Very good suggestion, I did find some interesting results, after
removing some local variables, although the text size shrinks, but the
total size is the same with -O0/1/2/3/s.

Here is the diff with -O0/1/2/3/s (a REPORT_SIZE macro may be required for
this):

    $ diff -Nubr startup.old.txt startup.new.txt
    --- startup.old.txt	2023-07-14 10:22:45.990413661 +0800
    +++ startup.new.txt	2023-07-14 10:22:52.278869146 +0800
    @@ -2,34 +2,34 @@
     sudo strip -s nolibc-test
     size nolibc-test
        text    data     bss     dec     hex filename
    -  46872      88      80   47040    b7c0 nolibc-test
    +  46836      88      80   47004    b79c nolibc-test
     wc -c nolibc-test
     58016 nolibc-test
      O1:
     sudo strip -s nolibc-test
     size nolibc-test
        text    data     bss     dec     hex filename
    -  27298      88      72   27458    6b42 nolibc-test
    +  27287      88      72   27447    6b37 nolibc-test
     wc -c nolibc-test
     37536 nolibc-test
      O2:
     sudo strip -s nolibc-test
     size nolibc-test
        text    data     bss     dec     hex filename
    -  25688      88      72   25848    64f8 nolibc-test
    +  25672      88      72   25832    64e8 nolibc-test
     wc -c nolibc-test
     37536 nolibc-test
      O3:
     sudo strip -s nolibc-test
     size nolibc-test
        text    data     bss     dec     hex filename
    -  44020      88      72   44180    ac94 nolibc-test
    +  44004      88      72   44164    ac84 nolibc-test
     wc -c nolibc-test
     53920 nolibc-test
      Os:
     sudo strip -s nolibc-test
     size nolibc-test
        text    data     bss     dec     hex filename
    -  20887      88      72   21047    5237 nolibc-test
    +  20884      88      72   21044    5234 nolibc-test
     wc -c nolibc-test
     33440 nolibc-test

The code with local variables:

    void _start_c(long *sp)
    {
    	int argc, i;
    	char **argv;
    	char **envp;
    	/* silence potential warning: conflicting types for 'main' */
    	int _nolibc_main(int, char **, char **) __asm__ ("main");
    
    	/*
    	 * sp  :    argc          <-- argument count, required by main()
    	 * argv:    argv[0]       <-- argument vector, required by main()
    	 *          argv[1]
    	 *          ...
    	 *          argv[argc-1]
    	 *          null
    	 * environ: environ[0]    <-- environment variables, required by main() and getenv()
    	 *          environ[1]
    	 *          ...
    	 *          null
    	 * _auxv:   _auxv[0]      <-- auxiliary vector, required by getauxval()
    	 *          _auxv[1]
    	 *          ...
    	 *          null
    	 */
    
    	/* assign argc and argv */
    	argc = *sp;
    	argv = (void *)(sp + 1);
    
    	/* find environ */
    	environ = envp = argv + argc + 1;
    
    	/* find _auxv */
    	for (i = 0; *(envp + i); i++)
    		;
    	_auxv = (void *)(envp + i + 1);
    
    	/* go to application */
    	exit(_nolibc_main(argc, argv, envp));
    }

The code with global variables:

    void _start_c(long *sp)
    {
    	int argc;
    	char **argv;
    	/* silence potential warning: conflicting types for 'main' */
    	int _nolibc_main(int, char **, char **) __asm__ ("main");

    	/*
    	 * sp  :    argc          <-- argument count, required by main()
    	 * argv:    argv[0]       <-- argument vector, required by main()
    	 *          argv[1]
    	 *          ...
    	 *          argv[argc-1]
    	 *          null
    	 * environ: environ[0]    <-- environment variables, required by main() and getenv()
    	 *          environ[1]
    	 *          ...
    	 *          null
    	 * _auxv:   _auxv[0]      <-- auxiliary vector, required by getauxval()
    	 *          _auxv[1]
    	 *          ...
    	 *          null
    	 */

    	/* assign argc and argv */
    	argc = *sp;
    	argv = (void *)(sp + 1);

    	/* find environ */
    	environ = argv + argc + 1;

    	/* find _auxv */
    	for (_auxv = (void *)environ; *_auxv++;)
    		;

    	/* go to application */
    	exit(_nolibc_main(argc, argv, environ));
    }

Which one do you prefer? the one with local variables may be more readable (not
that much), the one with global variables has smaller text size (and therefore
smaller memory footprint).

BTW, just found an arch-<ARCH>.h bug with -O0, seems the
'optimize("omit-frame-pointer")' attribute not really work as expected with
-O0. It uses frame pointer for _start eventually and breaks the stack pointer
variable (a push 'rbp' inserted at the begging of _start, so, the real rsp has
an offset), so, therefore, it is not able to get the right argc, argv, environ
and _auxv with -O0 currently. A solution is reverting _start to pure assembly.

For the above tests, I manually reverted the arch-x86_64.h to:

    __asm__(
            ".text\n"
            ".weak _start\n"
            "_start:\n"
    #ifdef _NOLIBC_STACKPROTECTOR
            "call __stack_chk_init\n" /* initialize stack protector                      */
    #endif
            "xor  %ebp, %ebp\n"       /* zero the stack frame                            */
            "mov  %rsp, %rdi\n"       /* save stack pointer to %rdi, as arg1 of _start_c */
            "and  $-16, %rsp\n"       /* %rsp must be 16-byte aligned before call        */
            "call _start_c\n"         /* transfer to c runtime                           */
            "hlt\n"                   /* ensure it does not return                       */
    );


'man gcc' shows:

    Most optimizations are completely disabled at -O0 or if an -O level is not set on the command line, even if individual optimization flags are specified.

To want -O0 work again, since now we have C _start_c, is it ok for us to revert
the commit 7f8548589661 ("tools/nolibc: make compiler and assembler agree on
the section around _start") and the later __no_stack_protector changes?

At the same time, to verify such issues, as Thomas suggested, in this series,
we may need to add more startup tests to verify argc, argv, environ, _auxv, do
we need to add a standalone run_startup (or run_crt) test entry just like
run_syscall? or, let's simply add more in the run_stdlib, like the environ test
added by Thomas.  seems, the argc test is necessary one currently missing (argc
>= 1):

    CASE_TEST(argc);               EXPECT_GE(1, test_argc, 1); break;

As we summarized before, the related test cases are:

argv0:

    CASE_TEST(chmod_argv0);       EXPECT_SYSZR(1, chmod(test_argv0, 0555)); break;
    CASE_TEST(chroot_exe);        EXPECT_SYSER(1, chroot(test_argv0), -1, ENOTDIR); break;

environ:

    CASE_TEST(chdir_root);        EXPECT_SYSZR(1, chdir("/")); chdir(getenv("PWD")); break;
    CASE_TEST(environ);            EXPECT_PTREQ(1, environ, test_envp); break;
    CASE_TEST(getenv_TERM);        EXPECT_STRNZ(1, getenv("TERM")); break;
    CASE_TEST(getenv_blah);        EXPECT_STRZR(1, getenv("blah")); break;

auxv:

    CASE_TEST(getpagesize);       EXPECT_SYSZR(1, test_getpagesize()); break;

The above tests are in different test group and are not aimed to startup test,
we'd better add a run_startup (or run_crt) test group before any other tests,
it is a requiremnt of the others, we at least have these ones:

    +int run_startup(int min, int max)
    +{
    +       int test;
    +       int tmp;
    +       int ret = 0;
    +
    +       for (test = min; test >= 0 && test <= max; test++) {
    +               int llen = 0; /* line length */
    +
    +               /* avoid leaving empty lines below, this will insert holes into
    +                * test numbers.
    +                */
    +               switch (test + __LINE__ + 1) {
    +               CASE_TEST(argc);               EXPECT_GE(1, test_argc, 1); break;
    +               CASE_TEST(argv_addr);          EXPECT_PTRNZ(1, test_argv); break;
    +               CASE_TEST(argv_total);         EXPECT_EQ(1, environ - test_argv - 1, test_argc); break;
    +               CASE_TEST(argv0_addr);         EXPECT_PTRNZ(1, argv0); break;
    +               CASE_TEST(argv0_str);          EXPECT_STRNZ(1, argv0); break;
    +               CASE_TEST(argv0_len);          EXPECT_GE(1, strlen(argv0), 1); break;
    +               CASE_TEST(environ_addr);       EXPECT_PTRNZ(1, environ); break;
    +               CASE_TEST(environ_envp);       EXPECT_PTREQ(1, environ, test_envp); break;
    +               CASE_TEST(environ_total);      EXPECT_GE(1, (void *)_auxv - (void *)environ - 1, 1); break;
    +               CASE_TEST(_auxv_addr);         EXPECT_PTRNZ(1, _auxv); break;
    +               case __LINE__:
    +                       return ret; /* must be last */
    +               /* note: do not set any defaults so as to permit holes above */
    +               }
    +       }
    +       return ret;
    +}

Any more?

>        /* find envp */
>        environ = argv + argc + 1;
>
>        /* find auxv */
>        for (auxv = environ; *auxv++)
>                 ;
>        _auxv = auxv;
>
> than:
>        /* find envp */
>        envp = argv + argc + 1;
>        environ = envp;
>
>        /* find auxv */
>        for (_auxv = environ; *_auxv++)
>                 ;
>

Great, `*_auxv++` is a very good trick to avoid duplicated _auxv++, although it
is a little hard to read (not that hard in reality) ;-)

> Since it's going to become generic code, it's worth running a few tests
> to see how to best polish it.
>

Yes, I focused on the big shrinking itself but forgot to polish the _start_c
itself ;-)

Best regards,
Zhangjin

> Thanks,
> Willy
