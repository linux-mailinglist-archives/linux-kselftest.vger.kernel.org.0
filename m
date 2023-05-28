Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5921F71390C
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 May 2023 12:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjE1KkP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 28 May 2023 06:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjE1KkO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 28 May 2023 06:40:14 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E40BD;
        Sun, 28 May 2023 03:40:08 -0700 (PDT)
X-QQ-mid: bizesmtp76t1685270402tn7r9bjp
Received: from linux-lab-host.localdomain ( [119.123.130.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 28 May 2023 18:40:01 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: C46Rb8GPIEc3i9NQbefxus7uJhsbGj7wWQjkM18ZuivPIOs+P2X2tzb9jlSAh
        fm810ccKyTSyEs51zSFavizl+tvu6GCSNqwfh7uIPWKDXX/A0FrnnJR/vbjaEaWizqy49nm
        aN+gGik/zHVoAyDv+59J7GjHnT1T8ReAvCIhMYbCCh3m0V/+rM5WZxAMcJqR1fpPpxUn/7n
        e17IMoNY1FPDk7OtyiWu/hXCKy5830VvtuWSVXFdRfJZ9GZ5xtfPEmanMfTPf9jutlMC+pP
        yh7PvpBjcGA0pFvPemoum2tOtletEMzDLbJL1lTq2pCf5hqHfZhOx+y8hg3mFGJ6WbBqK0u
        S1b4v18//PDXyud+7KaxfqJiWqdbUz3Y2Jr4Lnznmq6W2bWHoo=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17313421512748804189
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, thomas@t-8ch.de
Subject: Re: [PATCH 00/13] tools/nolibc: riscv: Add full rv32 support
Date:   Sun, 28 May 2023 18:39:57 +0800
Message-Id: <20230528103957.318267-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230528075955.GE1956@1wt.eu>
References: <20230528075955.GE1956@1wt.eu>
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

Hi, Willy

> Hi Zhangjin,
> 
> On Thu, May 25, 2023 at 01:33:14AM +0800, Zhangjin Wu wrote:
> > Hi, Willy
> > 
> > Thanks very mush for your kindly review, discuss and suggestion, now we
> > get full rv32 support ;-)
> > 
> > In the first series [1], we have fixed up the compile errors about
> > _start and __NR_llseek for rv32, but left compile errors about tons of
> > time32 syscalls (removed after kernel commit d4c08b9776b3 ("riscv: Use
> > latest system call ABI")) and the missing fstat in nolibc-test.c [2],
> > now we have fixed up all of them.
> 
> (...)
> 
> I have read the comments that others made on the series and overall
> agree. I've seen that you intend to prepare a v2. I think we must
> first decide how to better deal with emulated syscalls as I said in
> an earlier message. Probably that we should just add a specific test
> case for EFAULT in nolibc-test since it's the only one (I think) that
> risks to trigger crashes with emulated syscalls. We could also imagine
> dealing with the signal ourselves but I'm not that keen on going to
> implement signal() & longjmp() for now :-/
>

Yes, user-space signal() may be the right direction, we just need to let
user-space not crash the kernel, what about this 'solution' for current stage
(consider the pure time64 support too):

    #if defined(NOLIBC) && defined(__NR_gettimeofday) && __SIZEOF_LONG__ == 8
		CASE_TEST(gettimeofday_bad1); EXPECT_SYSER(1, gettimeofday((void *)1, NULL), -1, EFAULT); break;
		CASE_TEST(gettimeofday_bad2); EXPECT_SYSER(1, gettimeofday(NULL, (void *)1), -1, EFAULT); break;
    #endif

This idea is from your commit 1da02f51088 ("selftests/nolibc: support glibc as
well") for glibc, but the difference is of course glibc not crashes the kernel.

Btw, since the gettimeofday_null case may be optimized by compiler and not
trigger such errors:

    // rv32
    nolibc-test.c:(.text.run_syscall+0x8c0): undefined reference to `__divdi3'

    // arm32
    nolibc-test.c:(.text.run_syscall+0x820): undefined reference to `__aeabi_ldivmod'

The above errors have been hidden after the disabling of the gettimeofday_bad1
test case, so, still need to solve it before sending v2.

The method used by musl may work, but the high bits may be lost (from long long
to int)?
 
	tv->tv_usec = (int)ts.tv_nsec / 1000;

Perhaps we really need to add the missing __divdi3 and __aeabi_ldivmod and the
ones for the other architectures, or get one from lib/math/div64.c.

Will add such new test cases to detect the above issues:

    CASE_TEST(gettimeofday_tv);   EXPECT_SYSZR(1, gettimeofday(&tv, NULL)); break;
    CASE_TEST(gettimeofday_tz);   EXPECT_SYSZR(1, gettimeofday(NULL, &tz)); break;
    CASE_TEST(gettimeofday_tv_tz);EXPECT_SYSZR(1, gettimeofday(&tv, &tz)); break;

May still require to add 'used' attribute to 'struct timeval tv' and 'struct
timeval tz' to let compiler not optimize them away.

For the waitid syscall based waitpid INT_MIN test case, I have prepared such
code:

    #define IF_TEST(name) \
    	if (strcmp(test, #name) == 0)

    const int _errorno(const char *test)
    {
    #ifdef __NR_wait4
    	IF_TEST(waitpid_min); return ESRCH;
    #else /* __NR_waitid */
    	IF_TEST(waitpid_min); return EINVAL;
    #endif
    	return 0;
    }

    #define errorno(test) _errorno(#test)

    CASE_TEST(waitpid_min);       EXPECT_SYSER(1, waitpid(INT_MIN, &tmp, WNOHANG), -1, errorno(waitpid_min)); break;

Instead of simply disabling this case, the above code allows to return
different values for different syscalls.

is a standalone errorno_waitpid_min() better? I just want to let future test
cases share some code, but it may be slower ;-)

> Regardless, in order to clean the things up and relieve you from the
> non-rv32 stuff, I've just reverted the two patches that your series
> reverts (1 & 2), and added the EOVERFLOW one (3). I'm pushing this to
> branch 20230528-nolibc-rv32+stkp5.
>

Thanks very much and I have seen another two have been pushed too, will rebase
everything on this new branch.

Based on the other suggestions from you and Thomas, I plan to send some generic
and independent changes at first, and then the left hard parts, It may simplify
the whole progress.

Best regards,
Zhangjin
 
> Regards,
> Willy
