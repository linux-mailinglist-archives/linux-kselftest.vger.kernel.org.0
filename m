Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88CE754810
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jul 2023 11:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjGOJ5m (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Jul 2023 05:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGOJ5l (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Jul 2023 05:57:41 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 832E5E4A;
        Sat, 15 Jul 2023 02:57:39 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 36F9vT8s025595;
        Sat, 15 Jul 2023 11:57:29 +0200
Date:   Sat, 15 Jul 2023 11:57:29 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v3 02/11] tools/nolibc: add new crt.h with _start_c
Message-ID: <20230715095729.GC24086@1wt.eu>
References: <ZK+a6rEJIUjCnNsZ@1wt.eu>
 <20230714055813.115290-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714055813.115290-1-falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Zhangjin,

On Fri, Jul 14, 2023 at 01:58:13PM +0800, Zhangjin Wu wrote:
> > or:
> >
> >     for (_auxv = (void*)environ; *_auxv++; )
> >          ;
> >
> > Please also have a look at the output code, because at low optimization
> > levels, compilers sometimes produce a better code with a local variable
> > than with a global variable in a loop. Thus I wouldn't be that much
> > surprised if at -O0 or -O1 you'd see slightly more compact code using:
> >
> 
> Very good suggestion, I did find some interesting results, after
> removing some local variables, although the text size shrinks, but the
> total size is the same with -O0/1/2/3/s.
> 
> Here is the diff with -O0/1/2/3/s (a REPORT_SIZE macro may be required for
> this):
> 
>     $ diff -Nubr startup.old.txt startup.new.txt
>     --- startup.old.txt	2023-07-14 10:22:45.990413661 +0800
>     +++ startup.new.txt	2023-07-14 10:22:52.278869146 +0800
>     @@ -2,34 +2,34 @@
>      sudo strip -s nolibc-test
>      size nolibc-test
>         text    data     bss     dec     hex filename
>     -  46872      88      80   47040    b7c0 nolibc-test
>     +  46836      88      80   47004    b79c nolibc-test
(...)

I meant only checking the function's size, not the whole program :-)

Here's what I'm having for the function:

  $ for opt in O0 O1 O2 Os O3; do
      echo "## $opt"
      for file in global local local2; do
        gcc -$opt -c startc-$file.c
      done
      nm -o --size startc-*.o | grep _start_c
      echo
    done
  
  ## O0
  startc-global.o:0000000000000089 T _start_c
  startc-local.o:00000000000000ad T _start_c
  startc-local2.o:0000000000000090 T _start_c
  
  ## O1
  startc-global.o:0000000000000048 T _start_c
  startc-local.o:0000000000000054 T _start_c
  startc-local2.o:000000000000003a T _start_c
  
  ## O2
  startc-global.o:0000000000000044 T _start_c
  startc-local.o:000000000000004d T _start_c
  startc-local2.o:0000000000000040 T _start_c
  
  ## Os
  startc-global.o:0000000000000041 T _start_c
  startc-local.o:0000000000000040 T _start_c
  startc-local2.o:000000000000003a T _start_c
  
  ## O3
  startc-global.o:0000000000000044 T _start_c
  startc-local.o:000000000000004d T _start_c
  startc-local2.o:0000000000000040 T _start_c

In local2 that's always smaller I've just used a local auxv variable
instead of iterating over the global one, and it's cheaper than using
an index since 1) the instructions are shorter, and 2) the value is
already available, no need to initialize one register to zero:

    void _start_c(long *sp)   
    {                 
        long argc;                                 
        char **argv;                                    
        char **envp;                                    
        const unsigned long *auxv;                                    
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
        for (auxv = (void*)envp; *auxv++; )
                ;
        _auxv = auxv;

        /* go to application */
        exit(_nolibc_main(argc, argv, envp));
    }

I'm not showing how ugly it is at -O1, as I suspected the global version
does indeed perform a write to _auxv for each turn. At -Os it's
interesting:

In the global version it looks like this (rdx has envp):

  13:   48 8d 42 08             lea    0x8(%rdx),%rax
  17:   48 89 15 00 00 00 00    mov    %rdx,0x0(%rip)        # environ
  1e:   48 89 c7                mov    %rax,%rdi
  21:   48 83 c0 08             add    $0x8,%rax
  25:   48 83 78 f0 00          cmpq   $0x0,-0x10(%rax)
  2a:   75 f2                   jne    1e <_start_c+0x1e>

In your local version with the index, it looks like this (rdx has envp):

  13:   31 c0                   xor    %eax,%eax
  15:   48 89 15 00 00 00 00    mov    %rdx,0x0(%rip)        # environ
  1c:   48 ff c0                inc    %rax
  1f:   48 83 7c c2 f8 00       cmpq   $0x0,-0x8(%rdx,%rax,8)
  25:   75 f5                   jne    1c <_start_c+0x1c>
  27:   48 8d 04 c2             lea    (%rdx,%rax,8),%rax    # rax now has auxv

In the one without index it's like this:

  13:   48 89 15 00 00 00 00    mov    %rdx,0x0(%rip)        # environ
  1a:   48 89 d0                mov    %rdx,%rax
  1d:   48 83 c0 08             add    $0x8,%rax
  21:   48 83 78 f8 00          cmpq   $0x0,-0x8(%rax)
  26:   75 f5                   jne    1d <_start_c+0x1d>

Finally, since argc is used in pointer computation while being taken from
a long*, it experiences a double conversion while doing so. Storing it as
a long avoids this saving 3 extra bytes.

> Which one do you prefer? the one with local variables may be more readable (not
> that much), the one with global variables has smaller text size (and therefore
> smaller memory footprint).

The smaller one with local variables and no index ;-)

> BTW, just found an arch-<ARCH>.h bug with -O0, seems the
> 'optimize("omit-frame-pointer")' attribute not really work as expected with
> -O0. It uses frame pointer for _start eventually and breaks the stack pointer
> variable (a push 'rbp' inserted at the begging of _start, so, the real rsp has
> an offset), so, therefore, it is not able to get the right argc, argv, environ
> and _auxv with -O0 currently. A solution is reverting _start to pure assembly.

I didn't notice this one.

> 'man gcc' shows:
> 
>     Most optimizations are completely disabled at -O0 or if an -O level is
>     not set on the command line, even if individual optimization flags are
>     specified.

Indeed, that's pretty clear!

> To want -O0 work again, since now we have C _start_c, is it ok for us to revert
> the commit 7f8548589661 ("tools/nolibc: make compiler and assembler agree on
> the section around _start") and the later __no_stack_protector changes?

As Thomas said in somewhere else in the thread, let's analyze deeper first.
Maybe passing optimize("O") in addition will be sufficient.

> At the same time, to verify such issues, as Thomas suggested, in this series,
> we may need to add more startup tests to verify argc, argv, environ, _auxv, do

Yep!

> we need to add a standalone run_startup (or run_crt) test entry just like
> run_syscall? or, let's simply add more in the run_stdlib, like the environ test
> added by Thomas.  seems, the argc test is necessary one currently missing (argc
> >= 1):

Yes it could be a good idea to add a startup test category. Some of the
stuff we've placed into "stdlib" are more about startup code (provided
by the lib) that tends to be very sensitive to the architecture and
optimizations.
 

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

I quickly glanced over this but I tend to like it, indeed.

Thanks!
Willy
