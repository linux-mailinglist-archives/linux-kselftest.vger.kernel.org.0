Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30EB3713BBD
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 May 2023 20:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjE1SjU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 28 May 2023 14:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjE1SjU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 28 May 2023 14:39:20 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD723BD;
        Sun, 28 May 2023 11:39:14 -0700 (PDT)
X-QQ-mid: bizesmtp86t1685299148tisdqded
Received: from linux-lab-host.localdomain ( [119.123.130.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 29 May 2023 02:39:06 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: 90EFqYDyPxDn0kSe5Rhl/vjuOyf/473PhGd0IKkTilLdoQukI/QUl6jcLnIsM
        i4x6nYp8g5ZArPGbtoEs6M55lqa61WIqJ2XLtJDlf1Mr5xtLU/H3AtZXBX4rjEq3Wa57K6Y
        Dtyk+KY0tPnlr0+tVCGAE85s+oEMzU8w+GHJ2C+Zr0OD/64Lp6eIrLdl4jbaU4AvaZBfoHX
        VQ/vvo2w1sM6Q8MjOEmt7CefajCh9ASmMUe/njX41BVbkNF7xponT9rhgvCQdTYENCu/Ejp
        KuIONO5ZmWI7hCTDZ8LznIILigpIzoXxWGzRKYJ5DS6BRGRGev5wjW8Lv+MYIqXZ3LVu7fS
        5XgRaurnmrixrzshrQEn79dKR2bXg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11645315225004726120
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com
Subject: Re: [PATCH 00/13] tools/nolibc: riscv: Add full rv32 support
Date:   Mon, 29 May 2023 02:39:06 +0800
Message-Id: <20230528183906.22547-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <b25f79f0-a8fb-428a-ad54-fc4afe0df6ff@t-8ch.de>
References: <b25f79f0-a8fb-428a-ad54-fc4afe0df6ff@t-8ch.de>
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

> May 28, 2023 12:40:31 Zhangjin Wu <falcon@tinylab.org>:
>
> > Hi, Willy
> >
> >> Hi Zhangjin,
> >>
> >> On Thu, May 25, 2023 at 01:33:14AM +0800, Zhangjin Wu wrote:
> >>> Hi, Willy
> >>>
> >>> Thanks very mush for your kindly review, discuss and suggestion, now we
> >>> get full rv32 support ;-)
> >>>
> >>> In the first series [1], we have fixed up the compile errors about
> >>> _start and __NR_llseek for rv32, but left compile errors about tons of
> >>> time32 syscalls (removed after kernel commit d4c08b9776b3 ("riscv: Use
> >>> latest system call ABI")) and the missing fstat in nolibc-test.c [2],
> >>> now we have fixed up all of them.
> >>
> >> (...)
> >>
> >> I have read the comments that others made on the series and overall
> >> agree. I've seen that you intend to prepare a v2. I think we must
> >> first decide how to better deal with emulated syscalls as I said in
> >> an earlier message. Probably that we should just add a specific test
> >> case for EFAULT in nolibc-test since it's the only one (I think) that
> >> risks to trigger crashes with emulated syscalls. We could also imagine
> >> dealing with the signal ourselves but I'm not that keen on going to
> >> implement signal() & longjmp() for now :-/
> >>
> >
> > Yes, user-space signal() may be the right direction, we just need to let
> > user-space not crash the kernel, what about this 'solution' for current stage
> > (consider the pure time64 support too):
>
> If you did manage to crash the actual kernel than that would be a bug in the kernel that needs to be fixed.
> Feel free to describe how it happened and I'll take a look.
>

Sorry, my description above is not really right, the sigsegv (11) signal will
be sent to our program when it tries to write something to the address: (void
*)1 for this test case tries to do/test so:

    CASE_TEST(gettimeofday_bad1); EXPECT_SYSER(1, gettimeofday((void *)1, NULL), -1, EFAULT); break;

In the original gettimeofday syscall based implementation, the kernel
side tries to use put_user to copy timespec data to user space timeval:

    kernel/time/time.c:

    if (put_user(ts.tv_sec, &tv->tv_sec) ||
	put_user(ts.tv_nsec / 1000, &tv->tv_usec))
	return -EFAULT;

The put_user() in arch/riscv/include/asm/uaccess.h will trigger the
'fixup' logic and return -EFAULT and let the other test cases continue.

But if add our clock_gettime/time64 syscalls based implementation, we must get
timespec from kernel space and then convert them to timeval in user space, the
address of timespec can be handled by kernel space too, but we must write them
to the address of timeval in user-space:

    tv->tv_sec = ts.tv_sec;
    tv->tv_usec = (unsigned int)ts.tv_nsec / 1000;

In above test case, tv above is something like (void *)1, it is invalid, kernel
will prevent writing and force send a sigsegv and stop the program:

   35 gettimeofday_bad1init[1]: unhandled signal 11 code 0x1 at 0x00000002 in init[10000+5000]
        CPU: 0 PID: 1 Comm: init Not tainted 6.4.0-rc1-00137-gfdc311fa22ed-dirty #60
        Hardware name: riscv-virtio,qemu (DT)
        epc : 00012c90 ra : 00012c6c sp : 9d097d90
         gp : 00016800 tp : 00000000 t0 : 00000000
         t1 : 0000000a t2 : 00000000 s0 : 00000001
         s1 : 00016008 a0 : 00000000 a1 : 9d097da8
         a2 : 00000014 a3 : 00000000 a4 : 00000000
         a5 : 00000000 a6 : 00000001 a7 : 00000193
         s2 : 00000023 s3 : 00000000 s4 : 9d097da4
         s5 : 00000000 s6 : 0000541b s7 : 00000007
         s8 : 9d097dcc s9 : 00014474 s10: 00016000
         s11: 00000006 t3 : 00000000 t4 : ffffffff
         t5 : 00000000 t6 : 00000000
        status: 00000020 badaddr: 00000002 cause: 0000000f
        Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

Because our test run nolibc-test as init of initramfs on qemu, when init exit
but not reboot as normally, then it 'crashes' the kernel (kernel panic above).

If we have sigaction()/sigsetjmp/siglongjump support, then, we can call
'reboot()' in sigsegv signal handler, and event let it continue the other test
cases. sigaction seems only work to trigger when to call siglongjump,
siglongjump ask sigsetjmp to do the real recover action.

I did find some useful urls, and wrote such an exception restore logic, not
completely, not support NOLIBC_TEST environment variables yet.

    diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
    index 001ea789fa39..e7d488722e14 100644
    --- a/tools/testing/selftests/nolibc/nolibc-test.c
    +++ b/tools/testing/selftests/nolibc/nolibc-test.c
    @@ -110,6 +110,47 @@ const char *errorname(int err)
     	}
     }

    +#if !defined(NOLIBC)
    +#include <setjmp.h>
    +int test_base = 0;
    +int test_number = 0;
    +int test_llen = 0;
    +sigjmp_buf mark;
    +typedef int (*func_t)(int min, int max);
    +func_t test_func = NULL;
    +int test_idx = 0;
    +
    +static int pad_spc(int llen, int cnt, const char *fmt, ...);
    +static const struct test test_names[];
    +
    +void continue_run(void)
    +{
    +	int idx;
    +	int err;
    +	int ret;
    +	int min = 0;
    +	int max = INT_MAX;
    +
    +	test_llen += printf(" = %d ", -1);
    +	pad_spc(test_llen, 64, "[FAIL] (continued by sigaction/siglongjmp/sigsetjmp)\n");
    +	test_func = test_names[test_idx].func;
    +	test_func(test_number - test_base + 1, 1000);
    +
    +	for (idx = test_idx + 1; test_names[idx].name; idx++) {
    +		printf("Running test '%s'\n", test_names[idx].name);
    +		err = test_names[idx].func(min, max);
    +		ret += err;
    +		printf("Errors during this test: %d\n\n", err);
    +	}
    +}
    +
    +void action(int sig, siginfo_t *si, void *p)
    +{
    +	if (sig != SIGKILL)
    +		siglongjmp(mark, -1);
    +}
    +#endif
    +
     #define IF_TEST(name) \
     	if (strcmp(test, #name) == 0)

    @@ -447,8 +488,13 @@ static int expect_strne(const char *expr, int llen, const char *cmp)


     /* declare tests based on line numbers. There must be exactly one test per line. */
    +#if !defined(NOLIBC)
    +#define CASE_TEST(name) \
    +	case __LINE__: test_number = __LINE__; if (strcmp(#name, "getpid") == 0) { test_base = test_number; } llen += printf("%d %s", test, #name); test_llen = llen;
    +#else
     #define CASE_TEST(name) \
     	case __LINE__: llen += printf("%d %s", test, #name);
    +#endif

     /* used by some syscall tests below */
     int test_getdents64(const char *dir)
    @@ -582,7 +628,7 @@ int run_syscall(int min, int max)
     		CASE_TEST(gettimeofday_tv);   EXPECT_SYSZR(1, gettimeofday(&tv, NULL)); break;
     		CASE_TEST(gettimeofday_tz);   EXPECT_SYSZR(1, gettimeofday(NULL, &tz)); break;
     		CASE_TEST(gettimeofday_tv_tz);EXPECT_SYSZR(1, gettimeofday(&tv, &tz)); break;
    -#ifdef NOLIBC
    +#if 1
     		CASE_TEST(gettimeofday_bad1); EXPECT_SYSER(1, gettimeofday((void *)1, NULL), -1, EFAULT); break;
     		CASE_TEST(gettimeofday_bad2); EXPECT_SYSER(1, gettimeofday(NULL, (void *)1), -1, EFAULT); break;
     #endif
    @@ -952,6 +998,22 @@ int main(int argc, char **argv, char **envp)
     	if (getpid() == 1)
     		prepare();

    +#if !defined(NOLIBC)
    +	struct sigaction sa = {0};
    +	sa.sa_sigaction = action;
    +	sa.sa_flags = SA_SIGINFO;
    +	ret = sigaction(SIGSEGV, &sa, NULL);
    +	if (ret == -1) {
    +		perror("sigaction");
    +		exit(1);
    +	}
    +
    +	if (sigsetjmp(mark, 1) != 0) {
    +		continue_run();
    +		exit(0);
    +	}
    +#endif
    +
     	/* the definition of a series of tests comes from either argv[1] or the
     	 * "NOLIBC_TEST" environment variable. It's made of a comma-delimited
     	 * series of test names and optional ranges:
    @@ -1008,6 +1070,9 @@ int main(int argc, char **argv, char **envp)

     					/* now's time to call the test */
     					printf("Running test '%s'\n", test_names[idx].name);
    +#if !defined(NOLIBC)
    +					test_idx = idx;
    +#endif
     					err = test_names[idx].func(min, max);
     					ret += err;
     					printf("Errors during this test: %d\n\n", err);
    @@ -1021,6 +1086,9 @@ int main(int argc, char **argv, char **envp)
     		/* no test mentioned, run everything */
     		for (idx = 0; test_names[idx].name; idx++) {
     			printf("Running test '%s'\n", test_names[idx].name);
    +#if !defined(NOLIBC)
    +			test_idx = idx;
    +#endif
     			err = test_names[idx].func(min, max);
     			ret += err;
     			printf("Errors during this test: %d\n\n", err);

usage:

    $ gcc -o nolibc-test tools/testing/selftests/nolibc/nolibc-test.c
    $ ./nolibc-test
    ...
    35 gettimeofday_tz = 0                                           [OK]
    36 gettimeofday_tv_tz = 0                                        [OK]
    37 gettimeofday_bad1 = -1                                       [FAIL] (continued by sigaction/siglongjmp/sigsetjmp)
    38 gettimeofday_bad2 = -1                                       [FAIL] (continued by sigaction/siglongjmp/sigsetjmp)
    39 getpagesize = 0                                               [OK]
    40 ioctl_tiocinq = 0                                             [OK]
    41 ioctl_tiocinq = 0                                             [OK]
    ...

It did work as expected, but for nolibc, we still need to add sigaction/siglongjump/sigsetjmp support.

Will send a patch based on Willy's latest branch, perhaps this may help us to
verify the future sigaction/siglongjump/sigsetjmp for nolibc.

ref: https://www.ibm.com/docs/en/i/7.1?topic=ssw_ibm_i_71/apis/sigsetj.html
     https://www.ibm.com/docs/en/zos/2.1.0?topic=functions-siglongjmp-restore-stack-environment-signal-mask

Best regards,
Zhangjin

> Thomas
