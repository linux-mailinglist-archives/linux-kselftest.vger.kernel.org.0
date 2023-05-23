Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576F070E44D
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 May 2023 20:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238070AbjEWSED (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 May 2023 14:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238028AbjEWSEC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 May 2023 14:04:02 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2194AC2;
        Tue, 23 May 2023 11:03:58 -0700 (PDT)
X-QQ-mid: bizesmtp71t1684865022tcxah01h
Received: from linux-lab-host.localdomain ( [116.30.125.36])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 24 May 2023 02:03:41 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000B00A0000000
X-QQ-FEAT: swyrzWPvyR0MduXpVglWqnX/F5HbgaaQRtAemZVP+sG0/GJZ2D1Y/ShFZ8m7+
        ziR3C6JHZMUzvcAn2FwvU648OVTDIxR4ZJYfKygUbbeMPfvz3ccq3CKNE64aCcEq9+CCn0q
        CiFhW82vl2CW0rnJ89xQJLaOf4AnSnB1nFzruLcHLazA5iZHRefcLmVGCSnfLohCMb14uh8
        Dqy6oCARHkBhf58RZyuHqP6VQj6FGIG91XExRJffbaM0xxWFA/56fJYzS6hgl9URmJQjHup
        1/AB5I3hQEDTSVrksGlevBahKLR8aiEtXT6GhGb816t/Pepo2YvLvONJFiXjl7YaO6A3oX1
        n5T+gFHCX3N7qPbIcZCvkprKTpJHw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17320655173653481143
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, aou@eecs.berkeley.edu, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, shuah@kernel.org
Subject: Re: [PATCH] selftests/nolibc: Fix up compile error for rv32
Date:   Wed, 24 May 2023 02:03:40 +0800
Message-Id: <20230523180340.466619-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230521180823.164289-1-falcon@tinylab.org>
References: <20230521180823.164289-1-falcon@tinylab.org>
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

Hi, Willy, Thomas

Good news, I just fixed up all of the time32 syscalls related build and
test failures for rv32 and plan to send out the whole patchset tomorrow.

The patchset is based on 20230520-nolibc-rv32+stkp2 of [1] and the new
statckprotect patchset [2] (If v2 is ready, I prefer to rebase on v2).

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git
[2]: https://lore.kernel.org/linux-riscv/20230521100818.GA29408@1wt.eu/T/#t

For the fstat compile issue, I prefer to use a __NR_statx for rv32
instead of using fstatfs, because of different fstatfs* have different
errno's, it is ugly to use lots of macros ;-) what's your suggestion?

Here is the __NR_statx version:

    +static int test_syscall_args(void)
    +{
    +#ifdef __NR_statx
    +	return syscall(__NR_statx, 0, NULL, 0, 0, NULL);
    +#elif defined(__NR_fstat)
    +	return syscall(__NR_fstat, 0, NULL);
    +#else
    +#error Neither __NR_statx nor __NR_fstat defined, cannot implement syscall_args test
    +#endif
    +}

And the fstatfs version:

    +#ifdef __NR_fstatfs64
    +#define EXPECT_SYSER_SYSCALL_ARGS() EXPECT_SYSER(1, syscall(__NR_fstatfs64, 0, 0, NULL), -1, EINVAL)
    +#elif defined(__NR_fstatfs)
    +#define EXPECT_SYSER_SYSCALL_ARGS() EXPECT_SYSER(1, syscall(__NR_fstatfs, 0, NULL), -1, EFAULT)
    +#elif defined(__NR_fstat)
    +#define EXPECT_SYSER_SYSCALL_ARGS() EXPECT_SYSER(1, syscall(__NR_fstat, 0, NULL), -1, EFAULT)
    +#else
    +#error None of __NR_fstatfs64, __NR_fstatfs and __NR_fstat defined, cannot implement syscall_args test
    +#endif

And I plan to move __NR_fstat as the first branch to make sure it works
as before on the other platforms.

>     30 fork = 1 ENOSYS                                              [FAIL]
>     33 gettimeofday_null = -1 ENOSYS                                [FAIL]
>     35 gettimeofday_bad1 = -1 ENOSYS  != (-1 EFAULT)                [FAIL]
>     36 gettimeofday_bad2 = -1 ENOSYS  != (-1 EFAULT)                [FAIL]
>     37 gettimeofday_bad2 = -1 ENOSYS  != (-1 EFAULT)                [FAIL]
>     51 poll_null = -1 ENOSYS                                        [FAIL]
>     52 poll_stdout = -1 ENOSYS                                      [FAIL]
>     53 poll_fault = -1 ENOSYS  != (-1 EFAULT)                       [FAIL]
>     56 select_null = -1 ENOSYS                                      [FAIL]
>     57 select_stdout = -1 ENOSYS                                    [FAIL]
>     58 select_fault = -1 ENOSYS  != (-1 EFAULT)                     [FAIL]
>     64 wait_child = -1 ENOSYS  != (-1 ECHILD)                       [FAIL]
>     65 waitpid_min = -1 ENOSYS  != (-1 ESRCH)                       [FAIL]
>     66 waitpid_child = -1 ENOSYS  != (-1 ECHILD)                    [FAIL]
>

All of the above failures have been fixed up, some of them are very
easy, some of them are a little hard.

1. 30, 64-66 depends on wait4, use waitid instead
2. 33-37 depends on gettimeofday, use clock_gettime64 instead
3. 51-53 depends on ppoll, use ppoll_time64 instead
4. 56-58 depends on pselect*, use pselect_time64 instead

And I have found there are two same 'gettimeofday_bad2', is it designed?
If no, I will send a patch to dedup it:

    CASE_TEST(gettimeofday_bad2); EXPECT_SYSER(1, gettimeofday(NULL, (void *)1), -1, EFAULT); break;
    CASE_TEST(gettimeofday_bad2); EXPECT_SYSER(1, gettimeofday(NULL, (void *)1), -1, EFAULT); break;

> 
> My suggestion is directly fix up the failures one by one in current stage,
> because nolibc currently only uses part of the time32 syscalls, it may be not
> that complex to fix up them. Have read the code of musl and glibc today, both
> of them have good time64 syscalls support, I plan to fix up the above failures
> in several days, hope so but no promise ;-)
>

both musl and glibc help a lot, but also encounter some critical issues, for
example, to pass some test cases, it is required to emulate the same path of
the target syscalls and return the same errno's for them, the code comment will
exaplain the details.

> And another question: for the new changes, If a platform support both of the
> 32bit and 64bit syscalls, do we need to put the 64bit syscalls at first?
>

To make sure not touch too much on the code and reduce test cost, the patchset
just kept the default code order and let the old code in the first branch.

I plan to send the whole patchset tomorrow.

Thanks,
Zhangjin
