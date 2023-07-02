Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD24744EB6
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Jul 2023 19:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjGBRR3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 2 Jul 2023 13:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjGBRR3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 2 Jul 2023 13:17:29 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D5328C3;
        Sun,  2 Jul 2023 10:17:27 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 362HHF1L016977;
        Sun, 2 Jul 2023 19:17:15 +0200
Date:   Sun, 2 Jul 2023 19:17:15 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH v5 5/5] selftests/nolibc: riscv: customize makefile for
 rv32
Message-ID: <20230702171715.GD16233@1wt.eu>
References: <cover.1687176996.git.falcon@tinylab.org>
 <2ebfb48c66b18a5fd7d0bd6b7c832a5d8ce6486f.1687176996.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ebfb48c66b18a5fd7d0bd6b7c832a5d8ce6486f.1687176996.git.falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 19, 2023 at 08:29:38PM +0800, Zhangjin Wu wrote:
> Both riscv64 and riscv32 have:
> 
> * the same arch/riscv source code tree
> * the same tools/include/nolibc/arch-riscv.h
> * the same ARCH=riscv value passed to top-level kernel Makefile
> 
> The only differences are:
> 
> * riscv64 uses defconfig, riscv32 uses rv32_defconfig
> * riscv64 uses qemu-system-riscv64, riscv32 uses qemu-system-riscv32
> * riscv32 has different compiler options (-march= and -mabi=)
> 
> So, riscv32 can share most of the settings with riscv64, add riscv32
> support like the original ARCH=riscv support.
> 
> To align with x86, the default riscv is reserved for riscv64 and a new
> riscv64 is also added to allow users pass ARCH=riscv64 directly.
> 
> Since top-level kernel Makefile only accept ARCH=riscv, to make kernel
> happy, let's set kernel specific KARCH as riscv for both riscv32 and
> riscv64.
> 
> And since they share the same arch-riscv.h, let's set nolibc specific
> NARCH as riscv too.
> 
> Usage:
> 
>     $ make defconfig ARCH=riscv32 CROSS_COMPILE=riscv64-linux-gnu- ...
>     $ make run ARCH=riscv32 CROSS_COMPILE=riscv64-linux-gnu- ...

I'm hesitating on this one. Till now the ARCH variable taken on input
was *exactly* the one used by the kernel. We include some scripts very
early and we don't control the possible usage of ARCH. There's also
this at the top of the makefile:

  # when run as make -C tools/ nolibc_<foo> the arch is not set
  ifeq ($(ARCH),)
  include $(srctree)/scripts/subarch.include
  ARCH = $(SUBARCH)
  endif

So as you can see $(ARCH) is still very intimate with the kernel's.
For x86 it's no big deal because the i386 and x86_64 names are real
valid archs. The difficulty we're having with riscv is that 32 and 64
are two distinct archs for all tools but not for the kernel, and it
looks like the only difference is in the config itself.

Given that we call all tools explicitly and that the kernel does a lot
of implicit things with $(ARCH), I'm wondering if it wouldn't be more
robust for the long term to instead add a "VARIANT" variable for the
test only that would enforce "riscv32" or "riscv64" where needed (note
that I'm not sold on this variable's name, it's to illustrate). Because
if you look closely, you'll note that the nolibc source does not use
this difference since its arch is always equal to the kernel's, and
only the test requires it. I wouldn't be shocked by having more test
options than we have architectures, and I noticed in another series
that you were also proposing to extend config options, so I think it
goes in the same direction. Then we could have in the test's Makefile
a check for this VARIANT being set, which would preset ARCH when
defined, and being used to configure Qemu. Maybe it could more or
less look like this (for the selftest Makefile I mean) :

  # maps variants to nominal archs
  ARCH_VARIANT_riscv32 = riscv
  ARCH_VARIANT_riscv64 = riscv

  # default variants for some archs
  DEF_VARIANT_riscv    = riscv64

  VARIANT :=
  ARCH    ?= $(or $(ARCH_VARIANT_$(VARIANT)),$(VARIANT))
  VARIANT ?= $(or $(DEF_VARIANT_$(ARCH)),$(ARCH))

Modulo the possible typos above, you probably get the idea. If ARCH is
set, it will be used and automatically set the variant to the default
one for the arch. And if VARIANT is set, it will set the correct
default ARCH. It's possible to force the two in conflicting ways that
will not work but we don't care, it's like for the rest of the variables.
But at least we're never passing invalid values into ARCH anymore and I
find this much safer.

What do you think ?

Thanks,
Willy
