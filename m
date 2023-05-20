Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4132B70AA78
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 May 2023 20:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbjETSco (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 20 May 2023 14:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbjETScc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 20 May 2023 14:32:32 -0400
X-Greylist: delayed 16751 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 20 May 2023 11:31:56 PDT
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6596E171F;
        Sat, 20 May 2023 11:31:56 -0700 (PDT)
X-QQ-mid: bizesmtp83t1684607424td49ha04
Received: from linux-lab-host.localdomain ( [116.30.125.36])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 21 May 2023 02:30:22 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: zT6n3Y95oi0NmUS36tYSQOjYs6VJ7KDVPODVJ0vry8tqIF7HizXkKycl/scta
        5P8AEN/qjkkCPoRPGtIHzCJa5VldVpBJIGA030ZeWl+zLhKSsq0pw93eQYuQ5JQ9LVQ8Mt4
        pe36lpfwA3LoouBri8EV48yrbTwnLwtPhZRiHN3wI/npFmlGmmQIVBAzxqopwxQxfq96hSX
        gxIo3iB5Hx6mI5rNyCLtA87u1qqFzIpfjr8Pr6ij0nMSOfvJ001Fz4PNYqxPSSF9HWcuVUH
        92oLxEAEJ0m8B9IhegpQeFsE1bEBqyqShCEdFCBiQhzPMxkPG+XT+ZVvD5DNHEqj0n7JO2k
        7TUdgub/UUAnZfHwFPqnAmyG0LOW9ANm+bE5aB6
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10666012441370075782
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu, thomas@t-8ch.de
Cc:     aou@eecs.berkeley.edu, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, shuah@kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] selftests/nolibc: Fix up compile error for rv32
Date:   Sun, 21 May 2023 02:30:22 +0800
Message-Id: <20230520183022.35929-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230520140949.GA27611@1wt.eu>
References: <20230520140949.GA27611@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Willy, Thomas

> On Sat, May 20, 2023 at 04:00:54PM +0200, Thomas Weißschuh wrote:
> > > diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> > > index 063f9959ac44..d8b59c8f6c03 100644
> > > --- a/tools/testing/selftests/nolibc/nolibc-test.c
> > > +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> > > @@ -596,7 +596,7 @@ int run_syscall(int min, int max)
> > >  		CASE_TEST(write_badf);        EXPECT_SYSER(1, write(-1, &tmp, 1), -1, EBADF); break;
> > >  		CASE_TEST(write_zero);        EXPECT_SYSZR(1, write(1, &tmp, 0)); break;
> > >  		CASE_TEST(syscall_noargs);    EXPECT_SYSEQ(1, syscall(__NR_getpid), getpid()); break;
> > > -		CASE_TEST(syscall_args);      EXPECT_SYSER(1, syscall(__NR_fstat, 0, NULL), -1, EFAULT); break;
> > > +		CASE_TEST(syscall_args);      EXPECT_SYSER(1, syscall(__NR_read, -1, &tmp, 1), -1, EBADF); break;
> > 
> > The goal of this second test was to make sure that arguments are passed
> > in the correct order. For this I tried to have a syscall were the
> > checked error is generated from a non-first argument.
> > (The NULL generating the EFAULT).
> > So the new check does not fullfil this goal anymore.
> 
> Ah OK good to know.
>

does this meet the requirement? the 3rd argument shouldn't < 0, otherwise, there is an EFAULT. 

    CASE_TEST(syscall_args);      EXPECT_SYSER(1, syscall(__NR_read, 1, &tmp, -1), -1, EFAULT); break;

It get such test result:

    70 syscall_args = -1 EFAULT                                      [OK]

> > Maybe we can find a new syscall to test with?
> 
> Maybe it would be worth considering pselect() or equivalent which
> involve many arguments. I don't know if rv32 has fstatat() or
> lstat() for example, that could be used as alternatives ?
>

Unfortuantely, none of them is available in rv32, we have the same tricks you used in another reply:

    $ echo "#include <asm/unistd.h>" | \
        riscv64-linux-gnu-gcc -march=rv32im -mabi=ilp32 -Wl,-melf32lriscv_ilp32 -xc - -E -dM | \
        grep -E "pselect|fstat|lstat"
    #define __NR_pselect6_time64 413
    #define __NR3264_fstatfs 44
    #define __NR_fstatfs64 __NR3264_fstatfs

Or, use the rv32 test result as a crude reference:

    Running test 'syscall'
    0 getpid = 1                                                     [OK]
    1 getppid = 0                                                    [OK]
    3 gettid = 1                                                     [OK]
    5 getpgid_self = 0                                               [OK]
    6 getpgid_bad = -1 ESRCH                                         [OK]
    7 kill_0 = 0                                                     [OK]
    8 kill_CONT = 0                                                  [OK]
    9 kill_BADPID = -1 ESRCH                                         [OK]
    10 sbrk = 0                                                      [OK]
    11 brk = 0                                                       [OK]
    12 chdir_root = 0                                                [OK]
    13 chdir_dot = 0                                                 [OK]
    14 chdir_blah = -1 ENOENT                                        [OK]
    15 chmod_net = -1 ENOENT                                        [FAIL]
    16 chmod_self = -1 ENOENT  != (-1 EPERM)                        [FAIL]
    17 chown_self = -1 ENOENT  != (-1 EPERM)                        [FAIL]
    18 chroot_root = 0                                               [OK]
    19 chroot_blah = -1 ENOENT                                       [OK]
    20 chroot_exe = -1 ENOENT  != (-1 ENOTDIR)                      [FAIL]
    21 close_m1 = -1 EBADF                                           [OK]
    22 close_dup = 0                                                 [OK]
    23 dup_0 = 3                                                     [OK]
    24 dup_m1 = -1 EBADF                                             [OK]
    25 dup2_0 = 100                                                  [OK]
    26 dup2_m1 = -1 EBADF                                            [OK]
    27 dup3_0 = 100                                                  [OK]
    28 dup3_m1 = -1 EBADF                                            [OK]
    29 execve_root = -1 EACCES                                       [OK]
    30 fork = 1 ENOSYS                                              [FAIL]
    31 getdents64_root = 120                                         [OK]
    32 getdents64_null = -1 ENOTDIR                                  [OK]
    33 gettimeofday_null = -1 ENOSYS                                [FAIL]
    35 gettimeofday_bad1 = -1 ENOSYS  != (-1 EFAULT)                [FAIL]
    36 gettimeofday_bad2 = -1 ENOSYS  != (-1 EFAULT)                [FAIL]
    37 gettimeofday_bad2 = -1 ENOSYS  != (-1 EFAULT)                [FAIL]
    39 getpagesize = 0                                               [OK]
    40 ioctl_tiocinq = 0                                             [OK]
    41 ioctl_tiocinq = 0                                             [OK]
    42 link_root1 = -1 EEXIST                                        [OK]
    43 link_blah = -1 ENOENT                                         [OK]
    44 link_dir = -1 EPERM                                           [OK]
    45 link_cross = -1 ENOENT  != (-1 EXDEV)                        [FAIL]
    46 lseek_m1 = -1 EBADF                                           [OK]
    47 lseek_0 = -1 ESPIPE                                           [OK]
    48 mkdir_root = -1 EEXIST                                        [OK]
    49 open_tty = 3                                                  [OK]
    50 open_blah = -1 ENOENT                                         [OK]
    51 poll_null = -1 ENOSYS                                        [FAIL]
    52 poll_stdout = -1 ENOSYS                                      [FAIL]
    53 poll_fault = -1 ENOSYS  != (-1 EFAULT)                       [FAIL]
    54 read_badf = -1 EBADF                                          [OK]
    55 sched_yield = 0                                               [OK]
    56 select_null = -1 ENOSYS                                      [FAIL]
    57 select_stdout = -1 ENOSYS                                    [FAIL]
    58 select_fault = -1 ENOSYS  != (-1 EFAULT)                     [FAIL]
    59 stat_blah = -1 ENOENT                                         [OK]
    60 stat_fault = -1 EFAULT                                        [OK]
    61 symlink_root = -1 EEXIST                                      [OK]
    62 unlink_root = -1 EISDIR                                       [OK]
    63 unlink_blah = -1 ENOENT                                       [OK]
    64 wait_child = -1 ENOSYS  != (-1 ECHILD)                       [FAIL]
    65 waitpid_min = -1 ENOSYS  != (-1 ESRCH)                       [FAIL]
    66 waitpid_child = -1 ENOSYS  != (-1 ECHILD)                    [FAIL]
    67 write_badf = -1 EBADF                                         [OK]
    68 write_zero = 0                                                [OK]
    69 syscall_noargs = 1                                            [OK]
    70 syscall_args = -1 EFAULT                                      [OK]
    Errors during this test: 19
 
> > The code should have had a comment I guess.
> 
> Indeed ;-)
> 
> With that said, if rv32 is missing some essential syscalls, my question
> regarding its relevance here still holds!
> 

As my latest reply here [1] explains, this error is not really rv32 specific,
all of the time32 based syscalls and even the other 32bit syscalls have been
disabled by default for new architectures (add the author of commit
"c8ce48f06503" in the cc list), rv32 here is a very good test case for such
trend.

[1]: https://lore.kernel.org/linux-riscv/20230520143154.68663-1-falcon@tinylab.org/T/#m8b40b6e0f09de661bbae1d8a4cbd25f2730ae519

Best regards,
Zhangjin Wu

> Willy

