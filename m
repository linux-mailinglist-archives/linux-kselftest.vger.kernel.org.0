Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B310271397A
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 May 2023 14:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjE1Mwd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 28 May 2023 08:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjE1Mwd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 28 May 2023 08:52:33 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6FFBB;
        Sun, 28 May 2023 05:52:29 -0700 (PDT)
X-QQ-mid: bizesmtp65t1685278343tf6pj5go
Received: from linux-lab-host.localdomain ( [119.123.130.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 28 May 2023 20:52:22 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: fp7GbACbaw4NR+lhJTWTL/wpDkrNj8/r0nmxD+rFN8nhvGlyn4TMCc84QMl2L
        sEDaKnVE9mSV3y/do5L0Cf4DWTdpVMFcbHPodF12T6cIFH240c+i1f3Be/+I/T0e/Jg6Ah5
        Mfvt+NyeqM5u/ijKLVm3otwPvzaTpYgXqsDyl7R7yYcDfsHpinsgF898tm7X67bl03RFIUv
        /G3CHJqGlD0ARAg8d1I01mAjrol5s9uNnthSwaqWvrTmasKpz/oacKALZ57G0OLlNW8UOAl
        06eRwAxqx3ghpQCL3lZQsMFRCPheQeDISnA4xbcmv+75Qz5CMp6JdkVJSYRAr8wndwpI05H
        /gnMdKHjWDSPrQUhRKD3aPqiewsrbw0uKZ/Uxo7HT1m2SG8gG8=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17535740481711649659
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, thomas@t-8ch.de
Subject: Re: [PATCH 00/13] tools/nolibc: riscv: Add full rv32 support
Date:   Sun, 28 May 2023 20:52:21 +0800
Message-Id: <20230528125221.319868-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230528113325.GJ1956@1wt.eu>
References: <20230528113325.GJ1956@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> On Sun, May 28, 2023 at 06:39:57PM +0800, Zhangjin Wu wrote:
> > > I have read the comments that others made on the series and overall
> > > agree. I've seen that you intend to prepare a v2. I think we must
> > > first decide how to better deal with emulated syscalls as I said in
> > > an earlier message. Probably that we should just add a specific test
> > > case for EFAULT in nolibc-test since it's the only one (I think) that
> > > risks to trigger crashes with emulated syscalls. We could also imagine
> > > dealing with the signal ourselves but I'm not that keen on going to
> > > implement signal() & longjmp() for now :-/
> > >
> > 
> > Yes, user-space signal() may be the right direction, we just need to let
> > user-space not crash the kernel, what about this 'solution' for current stage
> > (consider the pure time64 support too):
> > 
> >     #if defined(NOLIBC) && defined(__NR_gettimeofday) && __SIZEOF_LONG__ == 8
> > 		CASE_TEST(gettimeofday_bad1); EXPECT_SYSER(1, gettimeofday((void *)1, NULL), -1, EFAULT); break;
> > 		CASE_TEST(gettimeofday_bad2); EXPECT_SYSER(1, gettimeofday(NULL, (void *)1), -1, EFAULT); break;
> >     #endif
> > 
> > This idea is from your commit 1da02f51088 ("selftests/nolibc: support glibc as
> > well") for glibc, but the difference is of course glibc not crashes the kernel.
> 
> Well, I was imagining implementing an EXPECT_EFAULT() macro that would
> rely on whatever other macros we'd set to indicate that a syscall got
> remapped. But I had another check grepping for EFAULT:
> 
>       CASE_TEST(gettimeofday_bad1); EXPECT_SYSER(1, gettimeofday((void *)1, NULL), -1, EFAULT); break;
>       CASE_TEST(gettimeofday_bad2); EXPECT_SYSER(1, gettimeofday(NULL, (void *)1), -1, EFAULT); break;
>       CASE_TEST(poll_fault);        EXPECT_SYSER(1, poll((void *)1, 1, 0), -1, EFAULT); break;
>       CASE_TEST(prctl);             EXPECT_SYSER(1, prctl(PR_SET_NAME, (unsigned long)NULL, 0, 0, 0), -1, EFAULT); break;
>       CASE_TEST(select_fault);      EXPECT_SYSER(1, select(1, (void *)1, NULL, NULL, 0), -1, EFAULT); break;
>       CASE_TEST(stat_fault);        EXPECT_SYSER(1, stat(NULL, &stat_buf), -1, EFAULT); break;
>       CASE_TEST(syscall_args);      EXPECT_SYSER(1, syscall(__NR_fstat, 0, NULL), -1, EFAULT); break;
> 
> In short, they're very few, and several of these could simply be dropped
> as irrelevant once we know that the libc is able to remap them and
> dereference the arguments itself.
> 
> I'd be fine with dropping the two gettimeofday_bad ones, poll_fault,
> select_fault and stat_fault. These ones already have at least one or
> two other tests. These ones were initially added because they were
> easy to implement, but if they're not relevant we can drop them and
> stop wondering how to hack around the tests.
> 
> If that's OK for you as well I can do that.
>

The dropping of the others is not required, since currently, we only
found these two gettimeofday test cases have such issues when we
implement them with clock_gettime/time64, because there is a "timespec
to timeval" conversion in user-space, if the data pointer could be
passed to kernel space, there would be no such issues (kernel will
transfer data via put_user() helpers).

> > Btw, since the gettimeofday_null case may be optimized by compiler and not
> > trigger such errors:
> > 
> >     // rv32
> >     nolibc-test.c:(.text.run_syscall+0x8c0): undefined reference to `__divdi3'
> > 
> >     // arm32
> >     nolibc-test.c:(.text.run_syscall+0x820): undefined reference to `__aeabi_ldivmod'
> > 
> > The above errors have been hidden after the disabling of the gettimeofday_bad1
> > test case, so, still need to solve it before sending v2.
> 
> Sorry, I don't understand what you mean, I'm not seeing such a divide in
> the code. Or maybe you're speaking about what you got after some of your
> proposed changes ?
> 
> > The method used by musl may work, but the high bits may be lost (from long long
> > to int)?
> >  
> > 	tv->tv_usec = (int)ts.tv_nsec / 1000;
> 
> Yes, and it would be even cleaner to use a uint here since tv_nsec is
> always positive. This will simply result in a multiplication and a
> shift on most platforms. Of course that's the type of thing you normally
> don't want on a fast path for some small systems but here code compacity
> counts more and that's fine.
>

Ok, will use uint here.

> > Perhaps we really need to add the missing __divdi3 and __aeabi_ldivmod and the
> > ones for the other architectures, or get one from lib/math/div64.c.
> 
> No, these ones come from the compiler via libgcc_s, we must not try to
> reimplement them. And we should do our best to avoid depending on them
> to avoid the error you got above.
> 
> > Will add such new test cases to detect the above issues:
> > 
> >     CASE_TEST(gettimeofday_tv);   EXPECT_SYSZR(1, gettimeofday(&tv, NULL)); break;
> >     CASE_TEST(gettimeofday_tz);   EXPECT_SYSZR(1, gettimeofday(NULL, &tz)); break;
> >     CASE_TEST(gettimeofday_tv_tz);EXPECT_SYSZR(1, gettimeofday(&tv, &tz)); break;
> > 
> > May still require to add 'used' attribute to 'struct timeval tv' and 'struct
> > timeval tz' to let compiler not optimize them away.
> 
> Maybe, or turn them to volatile as well.
>

Yeah, volatile is better.

> > For the waitid syscall based waitpid INT_MIN test case, I have prepared such
> > code:
> > 
> >     #define IF_TEST(name) \
> >     	if (strcmp(test, #name) == 0)
> > 
> >     const int _errorno(const char *test)
> >     {
> >     #ifdef __NR_wait4
> >     	IF_TEST(waitpid_min); return ESRCH;
> >     #else /* __NR_waitid */
> >     	IF_TEST(waitpid_min); return EINVAL;
> >     #endif
> >     	return 0;
> >     }
> > 
> >     #define errorno(test) _errorno(#test)
> > 
> >     CASE_TEST(waitpid_min);       EXPECT_SYSER(1, waitpid(INT_MIN, &tmp, WNOHANG), -1, errorno(waitpid_min)); break;
> > 
> > Instead of simply disabling this case, the above code allows to return
> > different values for different syscalls.
> 
> I don't like this, it gets particularly complicated to follow, especially
> since it doesn't rely on the underlying syscall but on which ones are
> defined, and supposes that the underlying implementation will use exactly
> these ones. Do not forget that we're not trying to verify that the tests
> provoke a specific syscall return, but that our syscall implementation
> returns the errno the application expects. If we see that one of them
> breaks, it means either that our test is wrong or undefined, or that our
> mapping of the syscall is incorrect. But in either case it indicates that
> an application relying on a specific errno would see a different value.
> 
> Many syscalls can return various values among a set, depending on which
> error is tested first. If that's the case for the ones above, I'd largely
> prefer to have EXPECT_SYSER2() that accepts any errno among a set of two
> (and maybe layer EXPECT_SYSER3() if 3 errno are possible).
>

Ok.

> Also there's something to keep in mind: nolibc-test is just one userland
> application among others. This means that every time you need to modify
> it to shut up an error that pops up after a change to nolibc, it means
> that you're possibly breaking one application living on an edge case and
> explicitly checking for that errno value. It is not necessarily dramatic
> but that's still something to keep in mind. We've all seen some of our
> code fail after a syscall started to report a new errno value we didn't
> expect, so it's important to still be cautious here and not to rely too
> much on the ease of adapting error handling in nolibc-test.
> 
> > Thanks very much and I have seen another two have been pushed too, will rebase
> > everything on this new branch.
> 
> OK.
> 
> > Based on the other suggestions from you and Thomas, I plan to send some generic
> > and independent changes at first, and then the left hard parts, It may simplify
> > the whole progress.
> 
> Yes, thank you! As a general rule of thumb (which makes the handling
> easier for everyone including you), the least controversial changes should
> be proposed first. This often allows to merge the first half of the patches
> at once and saves you from having to reorder what's left.
>

That's true.

Thanks,
Zhangjin

> Willy
