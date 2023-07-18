Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699667589CD
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 01:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjGRX7n (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 19:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbjGRX70 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 19:59:26 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D6B272B;
        Tue, 18 Jul 2023 16:58:14 -0700 (PDT)
X-QQ-mid: bizesmtp72t1689724599tsw8ne5q
Received: from linux-lab-host.localdomain ( [119.123.130.39])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 19 Jul 2023 07:56:38 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: IcCSTr/hHjPuu68BaLBK1x12CbkLdm7VjFyEnbpv6wS3cA1fXvQnP9Pkjxolv
        KD5JRbVlKtPSEctVSQKSXC50WUK4cLV81QkoA0zA9Bt6FVnHXpHpeHRkzeHgltFHZezZh0U
        rVY0zyoy2+PMV0WAF6rCEfJIKBIhs1QfcGKS3sWeDq9iIRsO/DnmHtv9wGZuYoRPSPGe/td
        FyXqj166ke0FCfRBv/Lh222eUhn2SVQAsfBcIXx27KT9DEkI5RSgzpXmAtiBsbArVxEAAkC
        LrxGPC67W9YtAz/gVdHkZwdKx2M7pWn2UK6YgF2n17RdHIqQ2L0Ot/cmU4VQOibpPO0JaT8
        TWLuorFdJarMggtWUn0PVnKzO7RyAxReNesXQVWVV7MSXz0RZfyxRkbYamGNydaBEgpP1s1
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6091079502627717206
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, w@1wt.eu
Subject: Re: [PATCH v1 3/8] selftests/nolibc: select_null: fix up for big endian powerpc64
Date:   Wed, 19 Jul 2023 07:56:37 +0800
Message-Id: <20230718235637.347701-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <be205fbd-31c2-4066-bfb1-65b9d0cb57c2@t-8ch.de>
References: <be205fbd-31c2-4066-bfb1-65b9d0cb57c2@t-8ch.de>
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

Hi, Thomas

> As this would be a generic bugfix it should be at the front of the
> series, but...
>

Yes, moved it but not as the first.

> On 2023-07-19 05:13:01+0800, Zhangjin Wu wrote:
> > The following error reported while running nolibc-test on the big endian
> > 64-bit PowerPC kernel compiled with powerpc64le-linux-gnu-gcc in Ubuntu
> > 20.04.
> > 
> >     56 select_nullinit[1]: illegal instruction (4) at 100042a8 nip 100042a8 lr 100042a8 code 1 in init[10000000+10000]
> >     init[1]: code: 7c6307b4 7c234840 4081f580 7c6300d0 907d0000 3860ffff 4bfff570 3ca2fffe
> >     init[1]: code: 38800038 38a5d547 7fc3f378 4bffcd65 <1000038c> 38c10060 38a00000 38800000
> > 
> > Let's explicitly initialize all of the timeval members to zero.
> > 
> > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > ---
> >  tools/testing/selftests/nolibc/nolibc-test.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> > index 03b1d30f5507..ec2c7774522e 100644
> > --- a/tools/testing/selftests/nolibc/nolibc-test.c
> > +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> > @@ -858,7 +858,7 @@ int run_syscall(int min, int max)
> >  		CASE_TEST(read_badf);         EXPECT_SYSER(1, read(-1, &tmp, 1), -1, EBADF); break;
> >  		CASE_TEST(rmdir_blah);        EXPECT_SYSER(1, rmdir("/blah"), -1, ENOENT); break;
> >  		CASE_TEST(sched_yield);       EXPECT_SYSZR(1, sched_yield()); break;
> > -		CASE_TEST(select_null);       EXPECT_SYSZR(1, ({ struct timeval tv = { 0 }; select(0, NULL, NULL, NULL, &tv); })); break;
> > +		CASE_TEST(select_null);       EXPECT_SYSZR(1, ({ struct timeval tv = { 0, 0 }; select(0, NULL, NULL, NULL, &tv); })); break;
> 
> This doesn't really make sense.
> Firstly, "{ 0 }" zeroes the whole structure.
>

Will compare the difference carefully ...

> Also the warning talks about "illegal instruction" while this structure
> is data and should never be executed as code.
>

Yeah, I'm a little lazy, test shows no issue happen, so, not looked into it, this may really hide some issues.

> Is this failure reproducible?

It could be reproduced with powerpc64le-linux-gnu-gcc (9.3.0) + run:

    $ make run XARCH=powerpc64 CROSS_COMPILE=powerpc64le-linux-gnu-

but not happen with powerpc64le-linux-gnu-gcc (9.3.0) + run-user:

    $ make run-user XARCH=powerpc64 CROSS_COMPILE=powerpc64le-linux-gnu-

And neither reproduce if switch to the big endian powerpc64-linux-gcc 13.1.0
toolchain from https://mirrors.edge.kernel.org/pub/tools/crosstool/

> Maybe the error is actually in the syscall wrapper?
> I'll also take a look tomorrow.
>

ok, just rechecked this, found the nolibc side is:

    int sys_select(int nfds, fd_set *rfds, fd_set *wfds, fd_set *efds, struct timeval *timeout)
        --> return my_syscall5(__NR__newselect, nfds, rfds, wfds, efds, timeout);

And the bad code is (even with -O0):

    1000e3ac:   10 00 03 8c     vspltisw v0,0
    1000e3b0:   39 3f 00 e0     addi    r9,r31,224
    1000e3b4:   7c 00 4f 99     stxvd2x vs32,0,r9
    1000e3b8:   39 3f 00 e0     addi    r9,r31,224
    1000e3bc:   7d 27 4b 78     mr      r7,r9

The error log:

    56 select_nullinit[1]: illegal instruction (4) at 1000e3ac nip 1000e3ac lr 1000e398 code 1 in init[10000000+14000]
    init[1]: code: e93f0076 3ca2fffe 38a5aad0 7d244b78 3c62fffe 3863a630 4bffaedd 7c691b78 
    init[1]: code: 7d2a4b78 813f008c 7d295214 913f008c <1000038c> 393f00e0 7c004f99 393f00e0 
    Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000004

So, the critical info "illegal instruction" means the vspltisw instruction is
not supported by this compiled kernel.

Let's look at the good one (only plus one instruction):

    1000e3ac:   39 20 00 00     li      r9,0
    1000e3b0:   f9 3f 00 e0     std     r9,224(r31)
    1000e3b4:   39 20 00 00     li      r9,0
    1000e3b8:   f9 3f 00 e8     std     r9,232(r31)
    1000e3bc:   39 3f 00 e0     addi    r9,r31,224
    1000e3c0:   7d 27 4b 78     mr      r7,r9

It means, adding one more 0 will let the compiler generate different code, it
will not use the vspltisw instruction any more, so, different result.

It made me recalled I have at last disabled (not enabled for tinyconfig) the following options:

    CONFIG_ALTIVEC
    CONFIG_VSX --> This option enables kernel support for the Vector Scaler extensions

Or we can disable the vsx instructions explicitly:

    -mno-vsx

Both of them work well, but I prefer -mno-vsx for to get a faster build, what about you?

    +CFLAGS_powerpc64 = -m64 -mbig-endian -Wl,-EB,-melf64ppc -mno-vsx
    +CFLAGS_powerpc64le = -m64 -mlittle-endian -Wl,-EL,-melf64ppc -mno-vsx

So, this patch itself is wrong, let's drop it from the next revision.

Thanks very much,
Zhangjin

> >  		CASE_TEST(select_stdout);     EXPECT_SYSNE(1, ({ fd_set fds; FD_ZERO(&fds); FD_SET(1, &fds); select(2, NULL, &fds, NULL, NULL); }), -1); break;
> >  		CASE_TEST(select_fault);      EXPECT_SYSER(1, select(1, (void *)1, NULL, NULL, 0), -1, EFAULT); break;
> >  		CASE_TEST(stat_blah);         EXPECT_SYSER(1, stat("/proc/self/blah", &stat_buf), -1, ENOENT); break;
> > -- 
> > 2.25.1
> > 
