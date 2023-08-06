Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F70771437
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Aug 2023 11:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjHFJjm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 6 Aug 2023 05:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjHFJjl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 6 Aug 2023 05:39:41 -0400
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737CA1B3;
        Sun,  6 Aug 2023 02:39:38 -0700 (PDT)
X-QQ-mid: bizesmtp80t1691314767tiuq1r0y
Received: from linux-lab-host.localdomain ( [116.30.130.12])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 06 Aug 2023 17:39:26 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: Nq+POyG2GSpEb8/3lK4WNmAIbWr1gD0CLEgZCmzgiVkuRvdF+f3t3VBpNVG6n
        6h30wyuDStDJ/NDsQtmFNbqQ4a5K/eLOoJ07a22WiNnQyrGra92le02ZxmwGuI294f/icQl
        NdtATgxXtbBwfsgAHArwzH9IRmBvMxOO5KuNvshHIs/ntl6V+mkjJY0c63DnJLTjOPCrcRX
        MCzvezajTlrR3dBaHTzpQUNoetK/TqZfFuHCe9kWvATjA2qCHvg96KX0RfOIV8r3s8IRjk5
        HGSlDngzrgcXoUQQmKWyH4SY6mL3uzTNr4k06pJS8v9JEdJCu72Dg48B22zZLJwgWFKrzXs
        n2MPpbl2FxjrUNIaH3U9wLCAFfuOm6BdC4xr6KGayWWpgeKt8vYV8oAAsim8MndfsF6T9i8
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9856170352400102152
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, tanyuan@tinylab.org,
        thomas@t-8ch.de
Subject: Re: [PATCH v6 7/8] selftests/nolibc: allow customize CROSS_COMPILE by architecture
Date:   Sun,  6 Aug 2023 17:39:21 +0800
Message-Id: <20230806093921.9648-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230806081731.GA10627@1wt.eu>
References: <20230806081731.GA10627@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

> On Sun, Aug 06, 2023 at 02:46:03AM +0800, Zhangjin Wu wrote:
> > Some cross compilers may not just be prefixed with ARCH, customize them
> > by architecture may simplify the test a lot, especially, when iterate
> > with ARCH.
> > 
> > After customizing this for every architecture, the minimal test argument
> > will be architecture itself, no CROSS_COMPILE required to be passed.
> > 
> > If the prefix of installed cross compiler is not the same as the one
> > customized, we can also pass CROSS_COMPILE as before or even pass
> > CROSS_COMPILE_<ARCH>.
> > 
> > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > ---
> >  tools/testing/selftests/nolibc/Makefile | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> > index 452d8e424d28..45d231b9c5c2 100644
> > --- a/tools/testing/selftests/nolibc/Makefile
> > +++ b/tools/testing/selftests/nolibc/Makefile
> > @@ -55,6 +55,12 @@ IMAGE_loongarch  = arch/loongarch/boot/vmlinuz.efi
> >  IMAGE            = $(IMAGE_$(XARCH))
> >  IMAGE_NAME       = $(notdir $(IMAGE))
> >  
> > +# CROSS_COMPILE: cross toolchain prefix by architecture
> > +CROSS_COMPILE           ?= $(CROSS_COMPILE_$(XARCH))
> > +
> > +# make sure CC is prefixed with CROSS_COMPILE
> > +$(call allow-override,CC,$(CROSS_COMPILE)gcc)
> > +
> 
> Note that I feared that it would break my "CC=gcc-5.5.0" and so on but
> fortunately it did not. However I don't understand what it tries to do
> nor the problem it tries to solve (even the commit message is quite
> unclear to me). I'm leaving it aside anyway but I wanted to let you
> know.
>

Thanks you for this note, will add it as a test case in our v2.

These places require the '$(CC)' prefixed with $(CROSS_COMPILE):

    $ grep ")\$(CC)" tools/testing/selftests/nolibc/Makefile
	$(QUIET_CC)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ \
	$(QUIET_CC)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ \
	$(QUIET_CC)$(CC) -o $@ $<

When CROSS_COMPILE come from command line, the first lines we included have
the CROSS_COMPILE knowledge and will add right prefix for CC:

   # Makefile for nolibc tests
   include ../../../scripts/Makefile.include

But the customized $(CROSS_COMPILE) must be added from the XARCH lines, then,
differs from the ones passed from command line, the above lines (before XARCH)
will have no CROSS_COMPILE knowledge, the CC therefore will have no prefix.

   CROSS_COMPILE=xxx                                 <= before, from command line

   include ../../../scripts/Makefile.include         <= CC get the right CROSS_COMPILE prefix

   XARCH            = $(or $(XARCH_$(ARCH)),$(ARCH)) <= XARCH here

   CROSS_COMPILE    ?= $(CROSS_COMPILE_$(XARCH))     <= after, customize ourselves
   (call allow-override,CC,$(CROSS_COMPILE)gcc)      <= CC have no right prefix here 

   $(QUIET_CC)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ \

So, we must add the prefix to CC ourselves after the CROSS_COMPILE lines we
customized, the 'allow-override' helper is also from
../../../scripts/Makefile.include.

But you did find a bug above, we should include it again here to avoid not
break the possibility of using llvm (still require to check if there are some
other regressions):

   include ../../../scripts/Makefile.include

And I have further found there is another cc-cross-prefix helper from:

    $ grep cc-cross-prefix -ur scripts/
    scripts/Makefile.compiler:# cc-cross-prefix
    scripts/Makefile.compiler:# Usage: CROSS_COMPILE := $(call cc-cross-prefix, m68k-linux-gnu- m68k-linux-)
    scripts/Makefile.compiler:cc-cross-prefix = $(firstword $(foreach c, $(1), \

So, we are able to search the toolchains from Arnd's, local toolchains and ...,
may not need to force users to use which one, I will do more tests on it.

Please don't merge this patch too, to avoid break anything, let's tune it
carefully in our v2 and delay the whole stuff to v6.7.

Thanks,
Zhangjin

> Willy
