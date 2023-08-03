Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76DC276DEA1
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 04:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjHCC7O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 22:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjHCC7N (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 22:59:13 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC741B6;
        Wed,  2 Aug 2023 19:59:09 -0700 (PDT)
X-QQ-mid: bizesmtp73t1691031537tsgoj5ej
Received: from linux-lab-host.localdomain ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 03 Aug 2023 10:58:56 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: wPivafIDGPOgBGJZXumf1D0l+U3XdYDAwtUQg2VLTQKULee6QEo1JUpSROVyy
        HfR1sAPKsbBLezgC1yTtdi0caktub2/fR5jGRKh2+di5fkUxjM1H3JS2hx95CwdzbHm7s3+
        syYJEtgM3jntyYPabT37x9zIp7N9JPisGMYFwk2Jre12QBodeL/wrK1JE0cRcKQfKdRygLk
        +/2AgGOzOovtSu5fIBR1NWZ98IPKlhcn4G5q7+tGm7Ewgg4u1AFONYvyOncO+WXxOLs9u5N
        5bAfBG6GK1yU9yGs6Ge1wg+B8aAEDb8rKo7MXYVAQARVQJpj14VB+nu46NrozK1hXY4xsvj
        MgEqLPtMOYWkz8d4S6ap2Jz1mC6MKa8oyBCzXqMPizSrmHXPYo=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5300737042752940419
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu, thomas@t-8ch.de
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, tanyuan@tinylab.org
Subject: Re: [PATCH v4 08/12] selftests/nolibc: add test support for ppc
Date:   Thu,  3 Aug 2023 10:58:55 +0800
Message-Id: <20230803025855.6925-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230803020533.GA23704@1wt.eu>
References: <20230803020533.GA23704@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

> On Wed, Aug 02, 2023 at 11:36:30PM +0200, Thomas Weißschuh wrote:
> > On 2023-08-03 00:03:58+0800, Zhangjin Wu wrote:
> > > Hi, Willy, Hi Thomas
> > > 
> > > I'm so happy to share with you, we have solved all of the left found
> > > issues, include the ones about ppc and the missing poweroff options for
> > > the tinyconfig series, will renew both series ;-)
> > 
> > Can we stick to one series at a time?
> 
> Yes and please this time, let's stick exclusively to what is sufficiently
> tested for 6.6, otherwise it will have to be delayed.
>

Yes, ppc series at first, will renew it today. let's delay the whole tinyconfig
series (include part1) in v6.7, we have no enough time to test them carefully
for v6.6.

> > > > Further compared the preprocessed files, found the root cause is the new
> > > > compiler using 'no_stack_protector' instead of
> > > > '__optimize__("-fno-stack-protector")'. And the attribute 'no_stack_protector'
> > > > breaks our "omit-frame-pointer" like the failure with '-O0' we fixed before.
> > > > 
> > > > I checked some of the other architectures, they didn't have the same issue, but
> > > > test shows the 'no_stack_protector' attribute does have such compability issue
> > > > here.
> > > > 
> > > > I learned the commit message of tools/include/nolibc/compiler.h, seems
> > > > __optimize__("-fno-stack-protector") is enough for all of the nolibc supported
> > > > architectures? is it ok for us to simply give up 'no_stack_protector'
> > > > eventully? otherwise, we should manually disable 'no_stack_protector' for
> > > > ppc32:
> > > > 
> > > >     #define __no_stack_protector __attribute__((__optimize__("-fno-stack-protector")))
> > > >
> > > 
> > > Hello, any suggestion here? ;-)
> > 
> > Patience :-)
> > 
> > no_stack_protector is the offically documented mechanism to disable
> > stack protector for a function. As it works for all other architectures
> > this seems like a compiler bug.
>
> Or a limitation. To be honest we're playing with compiler limits by
> adjusting their optimizations per function.  But as long as we don't
> break what currently works, we can accept to have some limits in a first
> version (e.g. if ppc32 doesn't support -O0 for now it's not dramatic).
> Also, some other archs use optimize("Os", "omit-frame-pointer")), maybe
> that's needed there as well.
>

Since it is really related, let's summarize yesterdays's further test here for
a reference:

Yesterday's test result on randomly chosen x86_64 and riscv64 shows,
from at least gcc 12.3.0 (may differs from archs), even with
optimize("Os", "omit-frame-pointer")), whatever with or without
'-fno-stack-protector', -O0 forbids the per function's
"omit-frame-pointer" as the doc [1] describes (as we discussed before),
that means some imtermediate gcc versions deviate from their docs and
now, the latest gcc version come back to follow its doc [1] and become
even more strict and then breaks our optimize("Os",
"omit-frame-pointer") workaround eventually:

    Most optimizations are completely disabled at -O0 or if an -O level
    is not set on the command line, even if individual optimization
    flags are specified.

So, it is ok for us to simply ignore -O0 currently, let's work on them
in v6.7.

[1]: https://gcc.gnu.org/onlinedocs/gcc-13.1.0/gcc/Optimize-Options.html

> > If we want to work around it I would prefer to have both attributes.
> 
> Also if you remember we also used to have a work-around for the
> function's entry code consisting in renaming _start and having a _start
> pointer in the asm code itself. That can remain an option to experiment
> with later.

Yes, the 'asm' style of _start may be a choice to prevent gcc touching
our startup code.

> But let's not change everything again at the last minute,

It is reasonable.

> all these series have been sufficiently difficult to follow :-(
>

Thanks,
Zhangjin

> thanks,
> Willy
