Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF9777B412
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 10:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjHNI0N (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 04:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234504AbjHNIZo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 04:25:44 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C4F9170A;
        Mon, 14 Aug 2023 01:25:25 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 37E8P0hi017206;
        Mon, 14 Aug 2023 10:25:00 +0200
Date:   Mon, 14 Aug 2023 10:25:00 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tanyuan@tinylab.org, thomas@t-8ch.de
Subject: Re: [PATCH v2 0/7] selftests/nolibc: customize CROSS_COMPILE for all
 supported architectures
Message-ID: <20230814082500.GB16761@1wt.eu>
References: <20230814071850.GC14322@1wt.eu>
 <20230814073854.13444-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814073854.13444-1-falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 14, 2023 at 03:38:54PM +0800, Zhangjin Wu wrote:
> > On Sun, Aug 13, 2023 at 06:05:03PM +0800, Zhangjin Wu wrote:
> > > > I think that later I'll further extend XARCH with new variants to
> > > > support ARMv5 and Thumb2, because we have different code for this
> > > > and I continue to manually change the CFLAGS to test both.
> > > >
> > > 
> > > Ok, what about further add x86_64 as the default variant for x86 (like ppc for
> > > powerpc)? and then it is able to only resereve the variables for x86_64. I have
> > > prepared a patch for this goal in our new tinyconfig patchset, it will further
> > > avoid adding the same nolibc-test-x86.config and nolibc-test-x86_64.config.
> > 
> > I'm confused, x86 already defaults to x86_64, it's just that it depends
> > on the .config itself to figure whether to produce a 32- or 64-bit kernel.
> > But for example it starts qemu in 64-bit mode. Am I missing anything ?
> >
> 
> In kernel side, it is, but in our nolibc-test, we have added a copy of x86_64
> for x86:
> 
>     $ grep -E "_x86" tools/testing/selftests/nolibc/Makefile 
>     IMAGE_x86_64     = arch/x86/boot/bzImage
>     IMAGE_x86        = arch/x86/boot/bzImage
>     CROSS_COMPILE_x86_64    ?= x86_64-linux- x86_64-linux-gnu-
>     CROSS_COMPILE_x86       ?= x86_64-linux- x86_64-linux-gnu-
>     DEFCONFIG_x86_64     = defconfig
>     DEFCONFIG_x86        = defconfig
>     QEMU_ARCH_x86_64     = x86_64
>     QEMU_ARCH_x86        = x86_64
>     QEMU_ARGS_x86_64     = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(TEST:%=NOLIBC_TEST=%)"
>     QEMU_ARGS_x86        = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(TEST:%=NOLIBC_TEST=%)"
> 
> With 'XARCH', the "_x86" copy of them can be simply replaced with such a line:
> 
>      # configure default variants for target kernel supported architectures
>      XARCH_powerpc    = ppc
>     +XARCH_x86        = x86_64
>      XARCH            = $(or $(XARCH_$(ARCH)),$(ARCH))
> 
> And therefore, the future nolibc-test-x86_64.config is also enough for x86.
> 
> But I have seen the 'x86' exception in tools/include/nolibc/Makefile, just a
> confirm on if this replacement is ok.

Ah I thought you meant the opposite, i.e. that ppc did map to powerpc
that I was not seeing anywhere else. Yes we can probably do that and
remove the x86-specific lines later.

Willy
