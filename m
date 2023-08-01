Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048EA76A96E
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 08:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjHAGpL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 02:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjHAGpJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 02:45:09 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93811125;
        Mon, 31 Jul 2023 23:45:06 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 3716isbd030226;
        Tue, 1 Aug 2023 08:44:54 +0200
Date:   Tue, 1 Aug 2023 08:44:54 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     linux@weissschuh.net, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        tanyuan@tinylab.org
Subject: Re: tools/nolibc: RFC: report and drop unused functions/data by
 gc-section
Message-ID: <ZMip5q9C/VuNMrUX@1wt.eu>
References: <20230801045902.37360-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801045902.37360-1-falcon@tinylab.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Zhangjin,

On Tue, Aug 01, 2023 at 12:59:02PM +0800, Zhangjin Wu wrote:
> > > > Most of them could theoretically be turned to static. *But* it causes a
> > > > problem which is that it will multiply their occurrences in multi-unit
> > > > programs, and that's in part why we've started to use weak instead. Also
> > > > if you run through gdb and want to mark a break point, you won't have the
> > > > symbol when it's static,
> 
> Willy, did I misunderstand something again? a simple test shows, seems this is
> not really always like that, static mainly means 'local', the symbol is still
> there if without -O2/-Os and is able to be set a breakpoint at:
> 
>     // test.c: gcc -o test test.c
>     #include <stdio.h>
> 
>     static int test (void)
>     {
>     	printf("hello, world!\n");
>     }
> 
>     int main(void)
>     {
>     	test();
>     
>     	return 0;
>     }
> 
> Even with -Os/-O2, an additional '-g' is able to generate the 'test' symbol for
> debug as we expect.

Please compare this:

  $ cat test.c
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
  
  $ gcc -Os -o test test.c
  $ objdump --disassemble=main  test
  (...)
  Disassembly of section .text:
  
  0000000000401040 <main>:
    401040:       50                      push   %rax
    401041:       bf 04 20 40 00          mov    $0x402004,%edi
    401046:       e8 e5 ff ff ff          call   401030 <puts@plt>
    40104b:       31 c0                   xor    %eax,%eax
    40104d:       5a                      pop    %rdx
    40104e:       c3                      ret    

  $ gdb ./test
  (...)
  Reading symbols from ./test...
  (gdb) b test
  Function "test" not defined.
  (gdb) r
  Starting program: /dev/shm/test 
  hello, world!
  [Inferior 1 (process 8780) exited normally]

To this:

  $ cat test.c
  #include <stdio.h>
  
  /*static*/ int test (void)
  {
      printf("hello, world!\n");
  }
  
  int main(void)
  {
      test();
  
      return 0;
  }
  
  $ gcc -Os -o test test.c
  $ objdump --disassemble=main  test
  (...)
  Disassembly of section .text:
  
  0000000000401040 <main>:
    401040:       50                      push   %rax
    401041:       e8 e0 00 00 00          call   401126 <test>
    401046:       31 c0                   xor    %eax,%eax
    401048:       5a                      pop    %rdx
    401049:       c3                      ret    

  $ gdb ./test
  (...)
  Reading symbols from ./test...
  (gdb) b test
  Breakpoint 1 at 0x401126
  (gdb) r
  Starting program: /dev/shm/test 
  
  Breakpoint 1, 0x0000000000401126 in test ()
  (gdb) 

See the difference ?

> >     and the code will appear at multiple locations,
> > > > which is really painful. I'd instead really prefer to avoid static when
> > > > we don't strictly want to inline the code, and prefer weak when possible
> > > > because we know many of them will be dropped at link time (and that's
> > > > the exact purpose).
> 
> For the empty __stack_chk_init() one (when the arch not support stackprotector)
> we used, when with 'weak', it is not possible drop it during link time even
> with -O3, the weak one will be dropped may be only when there is a global one
> with the same name is used or the 'weak' one is never really used?

If that's the case for this one, it's sufficient to enclose it within a pair
of #if defined(__SSP__).

> 
>     #include <stdio.h>
> 
>     __attribute__((weak,unused,section(".text.nolibc_memset")))
>     int test (void)
>     {
>     	printf("hello, world!\n");
>     }
> 
>     int main(void)
>     {
>     	test();
>     
>     	return 0;
>     }
> 
> 
>     0000000000001060 <main>:
>         1060:       f3 0f 1e fa             endbr64 
>         1064:       48 83 ec 08             sub    $0x8,%rsp
>         1068:       e8 03 01 00 00          callq  1170 <test>
>         106d:       31 c0                   xor    %eax,%eax
>         106f:       48 83 c4 08             add    $0x8,%rsp
>         1073:       c3                      retq   
>         1074:       66 2e 0f 1f 84 00 00    nopw   %cs:0x0(%rax,%rax,1)
>         107b:       00 00 00 
>         107e:       66 90                   xchg   %ax,%ax
> 
> Seems it is either impossible to add a 'inline' keyword again with the 'weak'
> attribute (warned by compiler), so, the _start_c (itself is always called by
> _start) will always add an empty call to the weak empty __stack_chk_init(),
> -Os/-O2/-O3 don't help. for such an empty function, in my opinion, as the size
> we want to care about, the calling place should be simply removed by compiler.

Obviously it's impossible because the precise reason why we're using weak
is when we *need* the symbol, i.e. it's called from asm code or another
unit. We only use weak as an alternative to static to share the symbol.

> Test also shows, with current __inline__ method, the calling place is removed,
> but with c89, the __stack_chk_init() itself will not be droped automatically,
> only if not with -std=c89, it will be dropped and not appear in the
> --print-gc-sections result.
> 
> Even for a supported architecture, the shorter __stack_chk_init() may be better
> to inlined to the _start_c()?

There is not better or worse, it doesn't work like this. What is important
to keep in mind is:
  - if the symbol needs to be exported, it must not be static. If it risks
    to be declared multiple times (since appearing in a .h possibly included
    multiple times), it needs to be marked weak.

  - if the symbol benefits from being reused a lot because it's huge and
    almost always needed, it can benefit as well from being exported so
    that at the end there is only one instead of multiple copies.

  - if the symbol is never needed outside and its duplication is not a
    problem, it's better static.

__stack_chk_init() used to be called directly from asm(). We had no other
option. With _start_c() it seems this has changed so maybe it can now be
static (I have not checked). But *these* are the only valid justifications,
nothing based on preference or being better or whatever. These serve two
completely different goals.

> So, If my above test is ok, then, we'd better simply convert the whole
> __stack_chk_init() to a static one as below (I didn't investigate this deeply
> due to the warning about static and weak conflict at the first time):

Static and weak together make absolutely no sense. Static says "do not export
it, it's local" and weak says "when you find multiple copies of it, keep only
one". By definition they are mutually exclusive.

> > > Thanks for the clarification. I forgot about that completely!
> > > 
> > > The stuff from nolibc-test.c itself (run_foo() and is_settings_valid())
> > > should still be done.
> > 
> > Yes, likely. Nolibc-test should be done just like users expect to use
> > nolibc, and nolibc should be the most flexible possible.
> 
> For the 'static' keyword we tested above, '-g' may help the debug requirement,
> so, is ok for us to apply 'static' for them safely now?

Please, read above and do not speculate but actually try by yourself and
see what doesn't work. I can assure you that it's extremely time consuming
to have to justify everything that was done over the last years to reach
the current situation, so as to make sure we don't go back several years
just due to matters of taste. By definition a libc cannot look nice, and
when implemented exclusively in include files there are strong tradeoffs
that are needed. The vast majority of them are already documented in the
code and others in commit messages. Others will obviously depend on
everyone's experience at recognizing certain patterns. I think I'll spend
some time writing some doc explaining some design rules, some choices that
are imposed to us and certain patterns to adopt or avoid. It will surely
help and save us a lot of review and discussion time in the future (at
least I hope).

> A further test shows, with 'static' on _start_c() doesn't help the size, for it
> is always called from _start(), will never save move instructions, but we need
> a more 'used' attribute to silence the error 'nolibc-test.c:(.text+0x38cd):
> undefined reference to `_start_c'', so, reserve it as the before simpler 'void
> _start_c(void)' may be better?
> 
>     static __attribute__((used)) void _start_c(long *sp)

Again if you test this you'll see that it probably does not work. It's
called from asm so it needs to be public. And it needs the weak
attribute to avoid clashes.

At least you've convinced me about something: we need to split nolibc-test
into multiple files (e.g. one for syscalls, one for stdlib etc) so that we
also catch the cases where we're missing some weak attributes.

Thanks,
Willy
