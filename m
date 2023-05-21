Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5B370AF70
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 May 2023 20:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjEUSJE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 May 2023 14:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjEUSIp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 May 2023 14:08:45 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA618AC;
        Sun, 21 May 2023 11:08:41 -0700 (PDT)
X-QQ-mid: bizesmtp62t1684692504txiq7w8d
Received: from linux-lab-host.localdomain ( [116.30.125.36])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 22 May 2023 02:08:23 +0800 (CST)
X-QQ-SSF: 01200000000000D0U000000A0000000
X-QQ-FEAT: nA8mzCjPbKjAyatHOLqVBZWleNML49vMr+sWKoVyh7o6l2YSji7G1wm1SVKxs
        QY/Tyk36sdfw8jpkOj0h2DqgkGeR4T966XMrs9M3WFlRuppMpPQN4duzuVWOmAu7AG8X1qH
        gF2yyOppqomXpYvjj3Aj0104rmcB78h1cRm8Of51Da9uBm8eJvQ5nFjrzDMLzydebkZMnjB
        lGfILk1gY2Yeem5Mbg9wS0AXePV/VmKa+64oHw+W4m/fMaPGqO/kFKVFQnaboPY9PcsKHyf
        805DgbIJF9CSpuucNeK9E/1HFphyuiWx0nZSsJS1cM+ycSHilHq6Jqc+rrg3/mtm5N2nrN9
        l66FU7K/KqBK/euMe+KStFB8ul67e6wh7SWI9Ic
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1011124316858910777
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     aou@eecs.berkeley.edu, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, shuah@kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH] selftests/nolibc: Fix up compile error for rv32
Date:   Mon, 22 May 2023 02:08:23 +0800
Message-Id: <20230521180823.164289-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZGmW1YEUWASzEJ13@1wt.eu>
References: <ZGmW1YEUWASzEJ13@1wt.eu>
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

Willy, Thomas,

> On Sun, May 21, 2023 at 02:30:22AM +0800, Zhangjin Wu wrote:
> > ...
>
> I think what Thomas meant is that he wants to be sure the call doesn't
> end up as read(-1, &tmp, 1). Here you could have -EBADF or -EFAULT, it
> depends. Anyway other solutions can be found if necessary. Another
> approach could be to switch back to __NR_fstat and condition it to its
> definition.
>
> > > > Maybe we can find a new syscall to test with?
> > >
> > > Maybe it would be worth considering pselect() or equivalent which
> > > involve many arguments. I don't know if rv32 has fstatat() or
> > > lstat() for example, that could be used as alternatives ?
> > >
> >
> > Unfortuantely, none of them is available in rv32, we have the same tricks you used in another reply:
> >
> >     $ echo "#include <asm/unistd.h>" | \
> >         riscv64-linux-gnu-gcc -march=rv32im -mabi=ilp32 -Wl,-melf32lriscv_ilp32 -xc - -E -dM | \
> >         grep -E "pselect|fstat|lstat"
> >     #define __NR_pselect6_time64 413
> >     #define __NR3264_fstatfs 44
> >     #define __NR_fstatfs64 __NR3264_fstatfs
>
> Then probably fstatfs should work equally for this test.
>

I tested a change like this (try __NR_fstatfs64, __NR_fstatfs, and __NR_fstat one by one):

    diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
    index 063f9959ac44..0a60e8ca5756 100644
    --- a/tools/testing/selftests/nolibc/nolibc-test.c
    +++ b/tools/testing/selftests/nolibc/nolibc-test.c
    @@ -500,6 +500,16 @@ static int test_fork(void)
     	}
     }

    +#ifdef __NR_fstatfs64
    +#define EXPECT_SYSER_SYSCALL_ARGS() EXPECT_SYSER(1, syscall(__NR_fstatfs64, 0, 0, NULL), -1, EINVAL)
    +#elif defined(__NR_fstatfs)
    +#define EXPECT_SYSER_SYSCALL_ARGS() EXPECT_SYSER(1, syscall(__NR_fstatfs, 0, NULL), -1, EFAULT)
    +#elif defined(__NR_fstat)
    +#define EXPECT_SYSER_SYSCALL_ARGS() EXPECT_SYSER(1, syscall(__NR_fstat, 0, NULL), -1, EFAULT)
    +#else
    +#error None of __NR_fstatfs64, __NR_fstatfs and __NR_fstat defined, cannot implement syscall_args test
    +#endif
    +
     /* Run syscall tests between IDs <min> and <max>.
      * Return 0 on success, non-zero on failure.
      */
    @@ -596,7 +606,7 @@ int run_syscall(int min, int max)
     		CASE_TEST(write_badf);        EXPECT_SYSER(1, write(-1, &tmp, 1), -1, EBADF); break;
     		CASE_TEST(write_zero);        EXPECT_SYSZR(1, write(1, &tmp, 0)); break;
     		CASE_TEST(syscall_noargs);    EXPECT_SYSEQ(1, syscall(__NR_getpid), getpid()); break;
    -		CASE_TEST(syscall_args);      EXPECT_SYSER(1, syscall(__NR_fstat, 0, NULL), -1, EFAULT); break;
    +		CASE_TEST(syscall_args);      EXPECT_SYSER_SYSCALL_ARGS(); break;
     		case __LINE__:
     			return ret; /* must be last */
     		/* note: do not set any defaults so as to permit holes above */

And another change like this (try __NR_statx and then __NR_fstat):

    diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
    index 063f9959ac44..d740ba405cb2 100644
    --- a/tools/testing/selftests/nolibc/nolibc-test.c
    +++ b/tools/testing/selftests/nolibc/nolibc-test.c
    @@ -500,6 +500,17 @@ static int test_fork(void)
     	}
     }

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
    +
     /* Run syscall tests between IDs <min> and <max>.
      * Return 0 on success, non-zero on failure.
      */
    @@ -596,7 +607,7 @@ int run_syscall(int min, int max)
     		CASE_TEST(write_badf);        EXPECT_SYSER(1, write(-1, &tmp, 1), -1, EBADF); break;
     		CASE_TEST(write_zero);        EXPECT_SYSZR(1, write(1, &tmp, 0)); break;
     		CASE_TEST(syscall_noargs);    EXPECT_SYSEQ(1, syscall(__NR_getpid), getpid()); break;
    -		CASE_TEST(syscall_args);      EXPECT_SYSER(1, syscall(__NR_fstat, 0, NULL), -1, EFAULT); break;
    +		CASE_TEST(syscall_args);      EXPECT_SYSER(1, test_syscall_args(), -1, EFAULT); break;
     		case __LINE__:
     			return ret; /* must be last */
     		/* note: do not set any defaults so as to permit holes above */

Which one is acceptable?

> > Or, use the rv32 test result as a crude reference:
> (... trimmed to keep only the failed ones ...)
> >
> >     15 chmod_net = -1 ENOENT                                        [FAIL]
> >     16 chmod_self = -1 ENOENT  != (-1 EPERM)                        [FAIL]
> >     17 chown_self = -1 ENOENT  != (-1 EPERM)                        [FAIL]
> >     20 chroot_exe = -1 ENOENT  != (-1 ENOTDIR)                      [FAIL]
> >     30 fork = 1 ENOSYS                                              [FAIL]
> >     33 gettimeofday_null = -1 ENOSYS                                [FAIL]
> >     35 gettimeofday_bad1 = -1 ENOSYS  != (-1 EFAULT)                [FAIL]
> >     36 gettimeofday_bad2 = -1 ENOSYS  != (-1 EFAULT)                [FAIL]
> >     37 gettimeofday_bad2 = -1 ENOSYS  != (-1 EFAULT)                [FAIL]
> >     45 link_cross = -1 ENOENT  != (-1 EXDEV)                        [FAIL]
> >     51 poll_null = -1 ENOSYS                                        [FAIL]
> >     52 poll_stdout = -1 ENOSYS                                      [FAIL]
> >     53 poll_fault = -1 ENOSYS  != (-1 EFAULT)                       [FAIL]
> >     56 select_null = -1 ENOSYS                                      [FAIL]
> >     57 select_stdout = -1 ENOSYS                                    [FAIL]
> >     58 select_fault = -1 ENOSYS  != (-1 EFAULT)                     [FAIL]
> >     64 wait_child = -1 ENOSYS  != (-1 ECHILD)                       [FAIL]
> >     65 waitpid_min = -1 ENOSYS  != (-1 ESRCH)                       [FAIL]
> >     66 waitpid_child = -1 ENOSYS  != (-1 ECHILD)                    [FAIL]
> >     Errors during this test: 19
>
> So that's a lot of failures and we should start to blindly degrade other
> tests just for the sake of fixing these ones here, it should be done more
> carefully.
>

Removed the config options related failures (will use defconfig to re-check
them, I did use a tiny config for faster compile):

    30 fork = 1 ENOSYS                                              [FAIL]
    33 gettimeofday_null = -1 ENOSYS                                [FAIL]
    35 gettimeofday_bad1 = -1 ENOSYS  != (-1 EFAULT)                [FAIL]
    36 gettimeofday_bad2 = -1 ENOSYS  != (-1 EFAULT)                [FAIL]
    37 gettimeofday_bad2 = -1 ENOSYS  != (-1 EFAULT)                [FAIL]
    51 poll_null = -1 ENOSYS                                        [FAIL]
    52 poll_stdout = -1 ENOSYS                                      [FAIL]
    53 poll_fault = -1 ENOSYS  != (-1 EFAULT)                       [FAIL]
    56 select_null = -1 ENOSYS                                      [FAIL]
    57 select_stdout = -1 ENOSYS                                    [FAIL]
    58 select_fault = -1 ENOSYS  != (-1 EFAULT)                     [FAIL]
    64 wait_child = -1 ENOSYS  != (-1 ECHILD)                       [FAIL]
    65 waitpid_min = -1 ENOSYS  != (-1 ESRCH)                       [FAIL]
    66 waitpid_child = -1 ENOSYS  != (-1 ECHILD)                    [FAIL]

The left failed syscalls may be waitpid, wait4, gettimeofday, poll and select,
it is not too many.

>
> My preference for the short term would be the following:
>   1) make sure we fix build issues for all platforms, including rv32
>   2) make sure Thomas' work on syscall() and STKP works fine where it
>      should, as it used to till now on other platforms
>
>   => this should be added to the 6.5 queue, and for this I don't want
>      to make this series regress as it should be queued quickly so that
>      test code used by other developers working on 6.5 is reasonably
>      stabilized.

Hope one of the above changes meets this goal, if no, perhaps we can simply
revert my '__NR_read' patch and left it together with the other rv32 failures
to next merge window.

>
>   3) evaluate what needs to be done regarding time32, this implies
>      working in the lower abstraction layers to depend on
>      __ARCH_WANT_TIME32_SYSCALLS and use the new syscalls instead.
>
>   => I don't know how much work it requires; if it's trivial this
>      could possibly be for 6.5, otherwise it will have to be postponed.

My suggestion is directly fix up the failures one by one in current stage,
because nolibc currently only uses part of the time32 syscalls, it may be not
that complex to fix up them. Have read the code of musl and glibc today, both
of them have good time64 syscalls support, I plan to fix up the above failures
in several days, hope so but no promise ;-)

And another question: for the new changes, If a platform support both of the
32bit and 64bit syscalls, do we need to put the 64bit syscalls at first?

For example, the __NR_llseek we just added, do we need to check __NR_llseek
before check __NR_lseek? this may support 64bit better but also may generate
bigger size of code, currently, my patch checks __NR_lseek at first and then
__NR_llseek to get smaller size of code, but as I read from the musl and glibc
code, both of them put the 64bit syscalls path before others.

Thanks,
Zhangjin

>
> Thanks,
> Willy
