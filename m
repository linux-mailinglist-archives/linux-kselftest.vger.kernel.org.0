Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF6971310D
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 May 2023 02:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjE0A65 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 May 2023 20:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjE0A64 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 May 2023 20:58:56 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B34F135;
        Fri, 26 May 2023 17:58:51 -0700 (PDT)
X-QQ-mid: bizesmtp66t1685149116tihsod3m
Received: from linux-lab-host.localdomain ( [119.123.130.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 27 May 2023 08:58:35 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: q+EIYT+FhZr8kYjxAfV4QeX59imBMjyv13kK8lw49D3SOmIMyDMjczluMyAEG
        8A5dwW5QVIQTJLxVhSxr9es8TCVQ8+y8+SldjzRpWmJ2MxCcwqAP1FeFrQP49enURp82lEH
        RzXUE2HkrjhBlY5/4kYhrOkhgkdQMNp9kvGUgCQTqa2SLGWEhOySAuRxsqSj+MtpKww0fHk
        v+JRUUn9S5mjurm7BXi9orU1Mfl6jEta7lvRDrwCsCk0U89CG3x0IyKCqF6AEhffZhj3h1G
        GOGsK724QNLCis+h9P1cHJfZzfpV7+gdLCf+LfpzvqmiaA0eh19swAP+uyMyODQWK/qmZtL
        j7PUQbz2xTRX6dPaXrI1OZNKzvUcA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10676587627097466729
From:   Zhangjin Wu <falcon@tinylab.org>
To:     arnd@arndb.de
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, thomas@t-8ch.de,
        w@1wt.eu
Subject: Re: [PATCH 04/13] selftests/nolibc: syscall_args: use __NR_statx for rv32
Date:   Sat, 27 May 2023 08:58:35 +0800
Message-Id: <20230527005835.9908-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ee8b1f02-ded1-488b-a3a5-68774f0349b5@app.fastmail.com>
References: <ee8b1f02-ded1-488b-a3a5-68774f0349b5@app.fastmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Arnd

> On Wed, May 24, 2023, at 19:48, Zhangjin Wu wrote:
> 
> > 
> > +static int test_syscall_args(void)
> > +{
> > +#ifdef __NR_fstat
> > +	return syscall(__NR_fstat, 0, NULL);
> > +#elif defined(__NR_statx)
> > +	return syscall(__NR_statx, 0, NULL, 0, 0, NULL);
> > +#else
> > +#error Neither __NR_fstat nor __NR_statx defined, cannot implement 
> > syscall_args test
> > +#endif
> > +}
> 
> Does this need to work on old kernels? My impression was that
> this is only intended to be used with the kernel that ships the
> copy, so you can just rely on statx to be defined and drop

Willy suggested this before, besides the generic unistd.h users, I only
found one __NR_statx in arm64 and forgot the ones in the *.tbl files:

    $ grep -n statx -ur arch/ | cut -d ':' -f1,2 | tr ':' ' ' | awk '{printf("git blame -L %s,%s %s\n",$2,$2,$1);}' | bash
    cabcebd33b8b8 (Firoz Khan 2018-11-13 15:01:52 +0530 453) 522    common  statx                           sys_statx
    a1016e94cce9f (Russell King 2017-03-09 17:14:32 +0000 414) 397  common  statx                   sys_statx
    7349ee3a97edb (Arnd Bergmann 2018-12-30 22:25:07 +0100 338) 326 common  statx                           sys_statx
    fd81414666cf6 (Firoz Khan 2018-11-13 11:30:28 +0530 389) 379    common  statx                           sys_statx
    9bcbf97c62931 (Firoz Khan 2018-12-13 14:37:38 +0530 341) 330    n32     statx                           sys_statx
    9bcbf97c62931 (Firoz Khan 2018-12-13 14:37:38 +0530 337) 326    n64     statx                           sys_statx
    9bcbf97c62931 (Firoz Khan 2018-12-13 14:37:38 +0530 380) 366    o32     statx                           sys_statx
    85e69701f58c9 (Firoz Khan 2018-09-09 07:22:50 +0530 395) 349    common  statx                   sys_statx
    90856087daca9 (Arnd Bergmann 2019-01-16 14:15:23 +0100 389) 379  common statx                   sys_statx                       sys_statx
    d25a122afd437 (Arnd Bergmann 2018-12-30 23:04:30 +0100 393) 383 common  statx                           sys_statx
    6ff645dd683af (Firoz Khan 2018-11-14 10:56:30 +0530 433) 360    common  statx                   sys_statx
    fc06bac35c8c7 (Firoz Khan 2018-11-13 11:34:33 +0530 408) 398    common  statx                           sys_statx
    aff8503932004 (Firoz Khan 2018-12-17 16:10:34 +0530 474) 383    nospu   statx                           sys_statx
    a845a6cf1dad1 (Brian Gerst 2020-03-13 15:51:39 -0400 397) 383   i386    statx                   sys_statx
    cab56d3484d4b (Brian Gerst 2020-03-13 15:51:38 -0400 343) 332   common  statx                   sys_statx
    c7914ef69dbb3 (Firoz Khan 2018-11-13 15:49:29 +0530 374) 351    common  statx                           sys_statx
    713cc9df6473f (Will Deacon 2017-03-21 18:04:26 +0000 807) #define __NR_statx 397
    713cc9df6473f (Will Deacon 2017-03-21 18:04:26 +0000 808) __SYSCALL(__NR_statx, sys_statx)

    (2020: x86 changed the format of the *.tbl)
    (2019: s390 changed the format of the *.tbl)

    $ grep -n asm-generic/unistd.h -ur arch/ | cut -d ':' -f1,2 | tr ':' ' ' | awk '{printf("git blame -L %s,%s %s\n",$2,$2,$1);}' | bash
    4adeefe161a74 arch/arc/include/asm/unistd.h (Vineet Gupta 2013-01-18 15:12:18 +0530 31) #include <asm-generic/unistd.h>
    91e040a79df73 (Vineet Gupta 2016-10-20 07:39:45 -0700 35) /* Generic syscall (fs/filesystems.c - lost in asm-generic/unistd.h */
    4262a727621ce (David Howells 2012-10-11 11:05:13 +0100 25) #include <asm-generic/unistd.h>
    4859bfca11c7d (Guo Ren 2018-09-05 14:25:08 +0800 9) #include <asm-generic/unistd.h>
    b9398a84590be arch/hexagon/include/asm/unistd.h (Richard Kuo 2011-10-31 18:35:16 -0500 40) #include <asm-generic/unistd.h>
    1000197d80132 (Ley Foon Tan 2014-11-06 15:19:57 +0800 27) #include <asm-generic/unistd.h>
    09abb90107202 arch/openrisc/include/asm/unistd.h (Jonas Bonn 2011-06-04 22:26:51 +0300 30) #include <asm-generic/unistd.h>
    27f8899d6002e (David Abdurachmanov 2018-11-08 20:02:39 +0100 26) #include <asm-generic/unistd.h>
    be769645a2aef (Huacai Chen 2022-05-31 18:04:11 +0800 5) #include <asm-generic/unistd.h>

    (2022: the year loongarch added)

    $ grep -n statx, -ur fs/stat.c
    677:SYSCALL_DEFINE5(statx,
    $ git blame -L 677,677 fs/stat.c
    a528d35e8bfcc (David Howells 2017-01-31 16:46:22 +0000 677) SYSCALL_DEFINE5(statx,

So, statx has been added from v4.10 (2017, a528d35e8bfcc) and the last
arch support is at least from v4.20 (2018, aff8503932004), perhaps
it is safe enough to only reserve the statx now, will simply replace
fstat with statx in the coming new revision of this patch, thanks very
much.

> the old fallbacks (same as for pselect6_time64 as I commented).
> 

Did the same search for this:

    $ grep -n pselect6_time64 -ur arch/ | cut -d ':' -f1,2 | tr ':' ' ' | awk '{printf("git blame -L %s,+1 %s\n",$2,$1);}' | bash
    48166e6ea47d2 (Arnd Bergmann 2019-01-10 12:45:11 +0100 430) 413 common  pselect6_time64                 sys_pselect6
    48166e6ea47d2 (Arnd Bergmann 2019-01-10 12:45:11 +0100 416) 413 common  pselect6_time64                 sys_pselect6
    48166e6ea47d2 (Arnd Bergmann 2019-01-10 12:45:11 +0100 355) 413 n32     pselect6_time64                 compat_sys_pselect6_time64
    48166e6ea47d2 (Arnd Bergmann 2019-01-10 12:45:11 +0100 404) 413 o32     pselect6_time64                 sys_pselect6                    compat_sys_pselect6_time64
    48166e6ea47d2 (Arnd Bergmann 2019-01-10 12:45:11 +0100 414) 413 32      pselect6_time64                 sys_pselect6                    compat_sys_pselect6_time64
    48166e6ea47d2 (Arnd Bergmann 2019-01-10 12:45:11 +0100 419) 413 32      pselect6_time64         -                               compat_sys_pselect6_time64
    48166e6ea47d2 (Arnd Bergmann 2019-01-10 12:45:11 +0100 419) 413 common  pselect6_time64                 sys_pselect6
    48166e6ea47d2 (Arnd Bergmann 2019-01-10 12:45:11 +0100 462) 413 32      pselect6_time64                 sys_pselect6                    compat_sys_pselect6_time64
    48166e6ea47d2 (Arnd Bergmann 2019-01-10 12:45:11 +0100 422) 413 common  pselect6_time64                 sys_pselect6
    48166e6ea47d2 (Arnd Bergmann 2019-01-10 12:45:11 +0100 503) 413 32      pselect6_time64                 sys_pselect6                    compat_sys_pselect6_time64
    cab56d3484d4b (Brian Gerst 2020-03-13 15:51:38 -0400 421) 413   i386    pselect6_time64         sys_pselect6                    compat_sys_pselect6_time64
    48166e6ea47d2 (Arnd Bergmann 2019-01-10 12:45:11 +0100 387) 413 common  pselect6_time64                 sys_pselect6
    48166e6ea47d2 (Arnd Bergmann 2019-01-10 12:45:11 +0100 838) #define __NR_pselect6_time64 413
    48166e6ea47d2 (Arnd Bergmann 2019-01-10 12:45:11 +0100 839) __SYSCALL(__NR_pselect6_time64, compat_sys_pselect6_time64)

    (not sure if we have missed some archs)

    $ grep -n pselect6_time64, fs/select.c
    1368:COMPAT_SYSCALL_DEFINE6(pselect6_time64, int, n, compat_ulong_t __user *, inp,
    $ git blame -L 1368,+1 fs/select.c
    e024707bccae1 (Deepa Dinamani 2018-09-19 21:41:07 -0700 1368) COMPAT_SYSCALL_DEFINE6(pselect6_time64, int, n, compat_ulong_t __user *, inp,

pselect6_time64 has been added from v4.20 and the last arch support is
at least from v5.0.0.

As we discussed in another reply, will add pselect6_time64 at first and
reserve the drop patch of the already added oldselect, newselect in the
future.

Thanks very much,
Zhangjin

> 
>       Arnd
