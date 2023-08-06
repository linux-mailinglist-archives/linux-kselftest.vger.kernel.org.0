Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C794D77144A
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Aug 2023 12:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjHFKEY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 6 Aug 2023 06:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjHFKEW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 6 Aug 2023 06:04:22 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B7441BEF;
        Sun,  6 Aug 2023 03:04:18 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 376A4AcX012345;
        Sun, 6 Aug 2023 12:04:10 +0200
Date:   Sun, 6 Aug 2023 12:04:10 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, tanyuan@tinylab.org,
        thomas@t-8ch.de
Subject: Re: [PATCH v6 7/8] selftests/nolibc: allow customize CROSS_COMPILE
 by architecture
Message-ID: <20230806100410.GC10627@1wt.eu>
References: <20230806081731.GA10627@1wt.eu>
 <20230806093921.9648-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230806093921.9648-1-falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Aug 06, 2023 at 05:39:21PM +0800, Zhangjin Wu wrote:
> > > +# CROSS_COMPILE: cross toolchain prefix by architecture
> > > +CROSS_COMPILE           ?= $(CROSS_COMPILE_$(XARCH))
> > > +
> > > +# make sure CC is prefixed with CROSS_COMPILE
> > > +$(call allow-override,CC,$(CROSS_COMPILE)gcc)
> > > +
> > 
> > Note that I feared that it would break my "CC=gcc-5.5.0" and so on but
> > fortunately it did not. However I don't understand what it tries to do
> > nor the problem it tries to solve (even the commit message is quite
> > unclear to me). I'm leaving it aside anyway but I wanted to let you
> > know.
> >
> 
> Thanks you for this note, will add it as a test case in our v2.
> 
> These places require the '$(CC)' prefixed with $(CROSS_COMPILE):
> 
>     $ grep ")\$(CC)" tools/testing/selftests/nolibc/Makefile
> 	$(QUIET_CC)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ \
> 	$(QUIET_CC)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ \
> 	$(QUIET_CC)$(CC) -o $@ $<
> 
> When CROSS_COMPILE come from command line, the first lines we included have
> the CROSS_COMPILE knowledge and will add right prefix for CC:
> 
>    # Makefile for nolibc tests
>    include ../../../scripts/Makefile.include
> 
> But the customized $(CROSS_COMPILE) must be added from the XARCH lines, then,
> differs from the ones passed from command line, the above lines (before XARCH)
> will have no CROSS_COMPILE knowledge, the CC therefore will have no prefix.
> 
>    CROSS_COMPILE=xxx                                 <= before, from command line
> 
>    include ../../../scripts/Makefile.include         <= CC get the right CROSS_COMPILE prefix
> 
>    XARCH            = $(or $(XARCH_$(ARCH)),$(ARCH)) <= XARCH here
> 
>    CROSS_COMPILE    ?= $(CROSS_COMPILE_$(XARCH))     <= after, customize ourselves
>    (call allow-override,CC,$(CROSS_COMPILE)gcc)      <= CC have no right prefix here 
> 
>    $(QUIET_CC)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ \
> 
> So, we must add the prefix to CC ourselves after the CROSS_COMPILE lines we
> customized, the 'allow-override' helper is also from
> ../../../scripts/Makefile.include.

OK, I feared it would overwrite the command-line one.

> But you did find a bug above, we should include it again here to avoid not
> break the possibility of using llvm (still require to check if there are some
> other regressions):
> 
>    include ../../../scripts/Makefile.include
> 
> And I have further found there is another cc-cross-prefix helper from:
> 
>     $ grep cc-cross-prefix -ur scripts/
>     scripts/Makefile.compiler:# cc-cross-prefix
>     scripts/Makefile.compiler:# Usage: CROSS_COMPILE := $(call cc-cross-prefix, m68k-linux-gnu- m68k-linux-)
>     scripts/Makefile.compiler:cc-cross-prefix = $(firstword $(foreach c, $(1), \
> 
> So, we are able to search the toolchains from Arnd's, local toolchains and ...,
> may not need to force users to use which one, I will do more tests on it.
> 
> Please don't merge this patch too, to avoid break anything, let's tune it
> carefully in our v2 and delay the whole stuff to v6.7.

OK. Note that in the end it might be less difficult to try to set
CROSS_COMPILE *before* including the general include instead of
after: we could preset CROSS_COMPILE based on the ARCH/XARCH we know
at this step, as this is not expected to rely on auto-detection.

Willy
