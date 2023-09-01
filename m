Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F38E790252
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Sep 2023 21:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbjIATDo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 Sep 2023 15:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjIATDo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 Sep 2023 15:03:44 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E633E56;
        Fri,  1 Sep 2023 12:03:37 -0700 (PDT)
X-QQ-mid: bizesmtp79t1693595000t3c0w880
Received: from linux-lab-host.localdomain ( [116.30.129.10])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 02 Sep 2023 03:03:18 +0800 (CST)
X-QQ-SSF: 01200000000000E0Y000000A0000000
X-QQ-FEAT: ILHsT53NKPgpAflxUqw3ksSZZ9THKMnj7MD+DAUD8c57DE8MgSTnQXAhSHtdi
        O5KpqihaDf/0I/t+LbcP3aTaHSxIMet4ya4HCRK+BizA/g6ZQw8MgkY4vj0g0zvYpcbWZiL
        DfL8KJfMMRVussoe54D5byWYEXS7PZnz2ePt03dI3tVW8CeeJgcRh1lnactyP6j96A1T7Jn
        g3cV2Q6lK9z6b9t/5J6tp+bFCWvu+3ZfWNvMRNhwd3aPx9iql1xMTMTSTsYkMAuBLUiRH/+
        Zet2wBMkFiXTAvaB6hYAExjADdORr/cy12c7Qh9V88/NK+X8LNqJjwjPjhv6DFd18S+TOGb
        WFErv1bWa3lxdGe9CJc+dSraw55V1USBWehmXKW2d+DH3kWW/65XKAPHWwiZg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10444200227745507649
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, david.laight@aculab.com, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tanyuan@tinylab.org, thomas@t-8ch.de
Subject: Re: [RFC] tools/nolibc: replace duplicated -ENOSYS return with single -ENOSYS return
Date:   Sat,  2 Sep 2023 03:03:17 +0800
Message-Id: <20230901190317.6114-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZO62q1lm7HSdcILu@1wt.eu>
References: <ZO62q1lm7HSdcILu@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RCVD_IN_PBL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

> On Wed, Aug 30, 2023 at 08:19:07AM +0800, Zhangjin Wu wrote:
> > Yes, as also suggested by Willy, the old proposed method redefined
> > NOLIBC__NR_* macros for every __NR_* and it must be avoided, and now,
> > the __is_nr_defined() and __get_nr() macros will simply avoid defining
> > new NOLIBC__NR_* for exisitng __NR_*, they can be used to test and get
> > the existing __NR_* directly.
> > 
> > In my local repo, we have saved 500+ lines ;-)
> > 
> >     $ git show nolibc/next:tools/include/nolibc/sys.h | wc -l
> >     1190
> >     $ cat tools/include/nolibc/sys.h | wc -l
> >     690
> > 
> > Including all of the -ENOSYS and #ifdef's:
> > 
> >     $ git grep -r ENOSYS nolibc/next:tools/include/nolibc/sys.h | wc -l
> >     17
> >     $ git grep -Er "#ifdef|#el|#endif" nolibc/next:tools/include/nolibc/sys.h | wc -l
> >     77
> 
> And how many hacks or bugs for the rare special cases ? I'm not kidding,
> this obsession for removing lines has already caused us quite some trouble
> around sysret() in the previous cycle, and I yet have to see the gain for
> maintenance.
>

Agree very much, Willy, I must clarify again about why I'm working on
this and that ;-)

Almost all of current work are preparation for rv32 support (exactly, time64
and size64 syscalls), some are for basic compiling support, some are for test
speed up (for fast verification of changes), and the one sysret() you mentioned
above and this RFC discuss are preparation for our new time64 syscalls and
size64 syscalls, removing lines is just a side effect and I have no interest
and no time in removing lines ;-) it is not the original goal.

Although the sysret() has introduced a size regression but perhaps we could
reserve more review and test cycles (or even more test cases, for example, size
test, -O0,1,2,3,s test, different toolchains test, I'm interested in opening a
standalone github repo to do so and perhaps Yuan could work on this too ...)
for such new changes in the future, and this RFC also targets the above goal,
discuss before real patchset.

To be honest, although I do understand your worry, this is only a RFC, it is
far far from killing the maintainability, I'm not expecting the coming RFC
patchset will happen in v6.7, v6.8 or even any future versions, I'm just
posting a discussion for some comments on a possibility and David did proposed
a very good suggestion and we are discussing and verifying its correctness and
performance carefully and we did get some important progress ;-)

Now let's back to the background behind this RFC, before sending the new
time64 syscalls and the size64 syscalls, perhaps we need to clear some
of these questions:

1. Where should we put #ifdef in the new syscalls? libc-level funcs or
   sys_* funcs?

   Currently, multiple my_syscall* are called in sys_* funcs, so, the
   name of sys_* doesn't really reflect the kernel-level syscall, as
   Arnd suggested before (Willy also replied), it may be possible to map
   my_syscall* to sys_* one by one, and then call differnt variants of
   sys_* funcs in libc-level funcs. And also, as we discussed before, #ifdef
   generates smaller binary size than -ENOSYS check. 

   There are three possible ways:

   - one is aligning with the current style, and reorg them in the future,
     but many new syscalls coming means more reorg work in the future.
  
   - another is adding new syscalls with new method, but this will mix
     two different styles together.

   - the third one is thinking about reorg in this stage, that is why
     this RFC is talking about if it is possible to remove #ifdef's
     completely, if possible, then, no need to move any of the #ifdef's,
     the reorg will not become that simply moving #ifdef's from sys_* to
     their libc-level interfaces.

2. Is it possible to clear more about the relationship between sys_* and
   libc-level interfaces?

   The relationship among my_syscall*, sys_* and libc-level interfaces are
   documented very well in tools/include/nolibc/nolibc.h.

   As Yuan asked me in the last month, the prototype of sys_* is almost
   the same as libc-level interfaces, they almost share the same input
   arguments, return the same type, that's why I proposed the __sysdef()
   macro to simply inherit the arguments from libc-level interfaces and
   return the same return types from my_syscall* (only brk and mmap
   requires (void *) conversions currently).

   The issues of __sysdef() pointed out by you require to be solved is
   making sure people not lose one of the tailing arguments accidentally,
   so, instead of using .../__VA_ARGS, let's use explicit arguments
   instead, but it may still avoid some unnecessary input types and
   return types conversions or passing and also save lots of boring copy
   and paste.

   This is also related to the first question, that is this __sysdef()
   also helps to clear the sys_* roles, it is possible to only map sys_*
   to the low-level kernel syscall with the same name and not mix them
   with its variants, and it is possible to do some normalization among
   architectures or among different kernel versions, at last, try the
   best to provide the same sys_* interfaces to higher libc-level ones,
   but doing minimal normalization here may be better, perhaps only for
   sys_* with the same name is ok, then, sys_* will be very clean and
   with very few exceptions (such as select, mmap and clone, we have
   seen s390 defined its own variants, we should do this in sys_* level
   and let architecture choose a right version via __ARCH_WANT_SYS_*),
   as a result, the sys_* will become a very thin and unified layer
   between kernel and libc-level interfaces, and the libc-level interfaces
   should take over the work to choose the right sys_* or their variants
   the target architectures provided.

3. Is it possible to tune the order of #ifdef's to get smaller binary

   As local test shows, benifit from the types inherit of the above
   __sysdef(), less type conversions generate smaller binary, besides, I
   have found, tuning #ifdef's order also helps size optimization. sys_*
   with less arguments and smaller arguments has smaller binary size,
   but it is not that attractive if only want to get smaller binary size
   because the changing of the #ifdef's will be very ugly, but the
   possibility of removing them completely may be another situation.
   Will measure and report the size reduce percentage in our RFC patchset.

I will back to the time64 and size64 syscalls (necessary for rv32) soon,
the above questions are generic to all of them, that's why I post this
RFC discussion (perhaps, the RFC title should be something like
tools/nolibc: preparation for time64 and size64 syscalls).

And we may have more questions, for example, we may need to wrap all
size64 syscalls under _LARGEFILE64_SOURCE to allow get smaller size, but
time64 syscalls should be compellent for the coming y2038 issues, before
sending the syscalls one be one, some generic issues should be discussed
and cleared.

> I do have comparable macros that I never employed in my projects just
> because each time I needed them I found a corner case at one particular
> optimization level or with a particular compiler version where you manage
> to break them, and suddenly all the world falls apart.

Willy, based on nolibc-test, we do need a standalone testsuite, as I
mentioned above and the issues we have encountered before (for example,
_start regression with -O0), this is really an urgent task. Perhaps,
your local test scripts is a very good base.

And seems both David and Ammar are using https://godbolt.org/
frequently, a local godbolt.org may be good for toolchains coverage, and
it is a very good test platform for some code pieces under different
toolchain versions and different compiler options, I have used it to
tune the __nrtoi() macro for some randomly chosen clang and gcc versions
but it is not enough, it must be at first right at language level and
then fix up the implementation issues reported by toolchains or review.

A test robot may be important, especially for a new feature or a big
change, test coverage is required.

> I'm fine for taking
> that risk when there is a *real* benefit, but here we're speaking about
> replacing existing, readable and auditable code by something more compact
> that becomes completely unauditable. I could understand that if it was
> a specific required step in a more long-term project of factorizing
> something, but there still hasn't been any such project defined, so all
> we're doing is "let's see if we can do this or that and see if it looks
> better". I continue to strongly disagree with this approach, it causes
> all of us a lot of extra work, introduces regressions and nobody sees
> the benefits in the end.
>

It is a long-term project, it is a very long preparation for adding the new
time64 and size64 syscalls, all of my work in past weeks are for this goal, but
it is very hard to define everything clearly before we really work on the real
patchsets, sometimes, new status, new suggestions ... I'm trying to discuss
before sending any new patchsets.

> Instead of using tricks here and there to remove lines, I'd rather have
> an approach centered on the code's architecture and modularity to see
> what are the current problems and how they should be addressed.
>

That's true, again, removing lines is only a side effect ;-)

> For now I still find it complicated to explain other maintainers how
> to test their changes on all architectures.

The same to me, that is why I'm working on tinyconfig, O=, and
CROSS_COMPILE customize support, tinyconfig is 10+ times faster than
defconfig, for all of the architectures, it may save us by one day ...

And also, as we discussed before, perhaps the test repo should also
provide the prebuilt qemu-user, qemu-system and qemu bios for a target
architecture, especially when the architecture is very new.

> I've found it difficult to
> switch between arm and thumb modes for arm when trying to explain it
> lately (now with more analysis I'm seeing that I could have placed it
> into CFLAGS_arm for example)

I used CFLAGS_i386 with x86_64 toolchain before, perhaps it is time to
add more variants with our new XARCH variable.

> so it means we're missing some doc in the
> makefile itself or on the usage in general. I've faced the problem you
> met with some builds failing on "you need to run mrproper first", which
> makes me think that in fact it should probably be "make defconfig" or
> "make prepare" that does this. Just checking the makefile and that's
> already the case, yet I faced the issue, so maybe it's caused by -j
> being passed through all the chain and we need to serialize the
> operations, I don't know.
>

Perhaps we should fix up this issue before docing it, I have asked Yuan
helping me to analyze the O= issue, that may be something about the
top-level kernel headers_install target, the generic-y in
scripts/Makefile.asm-generic may require to be revised to make it work
well with O= when the top-level source code is not clean (and I have
seen kselftest itself also not support O= very well when I'm trying to
run nolibc from kselftest, that means O= is not that a always stable
argument).  Thomas' -nostdinc patchset is a good start to avoid hiding
the kernel or nolibc issues from the toolchain sides.

> I would also like that we clarify some use cases. Originally the project
> started as the single-file zero-installation file that allowed to build
> static binaries, retrieving the linux/ subdir from wherever it was (i.e.
> from the local system libc for native builds or from the toolchain used
> for cross-builds). Since we've started to focus a bit too much on the
> nolibc-test program only with its preparation stages, I think we've lost
> this focus a little bit, and I'd like to add some tests to make sure this
> continues to work (I know that my primary usage already got broken by
> the statx change with the toolchain I was using).
>

Seems we have discussed this before, to get zero-installation, musl is a
good idea, it has no need to install sysroot, but it may increase the
size of nolibc source code for it requires to define our own structures
and therefore not depends on the others.

> Also, maybe it could be useful to make it easier to produce tar.gz
> sysroots form tools/include/nolibc for various (even all?) archs to
> make it easier for users to test their own code against it.
> 
> So in short, we need to make it easier to use and easier to test, not
> to just remove lines that nobody needs to maintain.
> 
> > Yeah, for the sys_* definitions, it is ok for us to use explicit arguments
> > intead of the '...'/__VA_ARGS__ to avoid losing some arguments sometimes, let's
> > do it in the RFC patchset but it should come after the tinyconfig patchset.
> > 
> > BTW, Willy, when will you prepare the branch for v6.7 developmlent? ;-)
> 
> You can continue to use the latest branch as a starting point, we'll create
> the new for-6.7 branch once 6.6-rc1 is out.
>

Ok, will wait for 6.6-rc1.

Thanks,
Zhangjin
 
> Thanks,
> Willy
