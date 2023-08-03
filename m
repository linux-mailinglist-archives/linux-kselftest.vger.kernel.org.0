Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCAED76DF71
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 06:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjHCEhf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 00:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjHCEhe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 00:37:34 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 52D8310CA;
        Wed,  2 Aug 2023 21:37:32 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3734bKpE024095;
        Thu, 3 Aug 2023 06:37:20 +0200
Date:   Thu, 3 Aug 2023 06:37:20 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     thomas@t-8ch.de, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, tanyuan@tinylab.org
Subject: Re: [PATCH v4 08/12] selftests/nolibc: add test support for ppc
Message-ID: <20230803043720.GA24073@1wt.eu>
References: <20230803020533.GA23704@1wt.eu>
 <20230803025855.6925-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803025855.6925-1-falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 03, 2023 at 10:58:55AM +0800, Zhangjin Wu wrote:
> Yes, ppc series at first, will renew it today. let's delay the whole tinyconfig
> series (include part1) in v6.7, we have no enough time to test them carefully
> for v6.6.

Thanks.

> > > > > Further compared the preprocessed files, found the root cause is the new
> > > > > compiler using 'no_stack_protector' instead of
> > > > > '__optimize__("-fno-stack-protector")'. And the attribute 'no_stack_protector'
> > > > > breaks our "omit-frame-pointer" like the failure with '-O0' we fixed before.
> > > > > 
> > > > > I checked some of the other architectures, they didn't have the same issue, but
> > > > > test shows the 'no_stack_protector' attribute does have such compability issue
> > > > > here.
> > > > > 
> > > > > I learned the commit message of tools/include/nolibc/compiler.h, seems
> > > > > __optimize__("-fno-stack-protector") is enough for all of the nolibc supported
> > > > > architectures? is it ok for us to simply give up 'no_stack_protector'
> > > > > eventully? otherwise, we should manually disable 'no_stack_protector' for
> > > > > ppc32:
> > > > > 
> > > > >     #define __no_stack_protector __attribute__((__optimize__("-fno-stack-protector")))
> > > > >
> > > > 
> > > > Hello, any suggestion here? ;-)
> > > 
> > > Patience :-)
> > > 
> > > no_stack_protector is the offically documented mechanism to disable
> > > stack protector for a function. As it works for all other architectures
> > > this seems like a compiler bug.
> >
> > Or a limitation. To be honest we're playing with compiler limits by
> > adjusting their optimizations per function.  But as long as we don't
> > break what currently works, we can accept to have some limits in a first
> > version (e.g. if ppc32 doesn't support -O0 for now it's not dramatic).
> > Also, some other archs use optimize("Os", "omit-frame-pointer")), maybe
> > that's needed there as well.
> >
> 
> Since it is really related, let's summarize yesterdays's further test here for
> a reference:
> 
> Yesterday's test result on randomly chosen x86_64 and riscv64 shows,
> from at least gcc 12.3.0 (may differs from archs), even with
> optimize("Os", "omit-frame-pointer")), whatever with or without
> '-fno-stack-protector', -O0 forbids the per function's
> "omit-frame-pointer" as the doc [1] describes (as we discussed before),
> that means some imtermediate gcc versions deviate from their docs and
> now, the latest gcc version come back to follow its doc [1] and become
> even more strict and then breaks our optimize("Os",
> "omit-frame-pointer") workaround eventually:
> 
>     Most optimizations are completely disabled at -O0 or if an -O level
>     is not set on the command line, even if individual optimization
>     flags are specified.

Note that the quoted paragraph above is mostly independent. The point
here is that optimize("-Os") seems to be ignored then -O0 is passed
on the command line. But I'm not that much surprised, because as we
said, changing optimizations on the fly is tricky given that some have
effects beyond just a function.

> So, it is ok for us to simply ignore -O0 currently, let's work on them
> in v6.7.

Yeah I'm fine with this. In the worst case those using -O0 can also avoid
using stack-protector.

> > > If we want to work around it I would prefer to have both attributes.
> > 
> > Also if you remember we also used to have a work-around for the
> > function's entry code consisting in renaming _start and having a _start
> > pointer in the asm code itself. That can remain an option to experiment
> > with later.
> 
> Yes, the 'asm' style of _start may be a choice to prevent gcc touching
> our startup code.

That was the case. We had an earlier version where _start was a label
inside the asm statement, resulting in some unused prologue and epilogue
for the function around that code. It was a bit ugly and I think it had
some shortcomings but we may go back to that later if it brings some
value.

Willy
