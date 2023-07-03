Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D7174601E
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jul 2023 17:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjGCPvx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jul 2023 11:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjGCPvw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jul 2023 11:51:52 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778E1E6B;
        Mon,  3 Jul 2023 08:51:46 -0700 (PDT)
X-QQ-mid: bizesmtp74t1688399495t3coozev
Received: from linux-lab-host.localdomain ( [119.123.131.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 03 Jul 2023 23:51:34 +0800 (CST)
X-QQ-SSF: 01200000002000D0W000B00A0000000
X-QQ-FEAT: LI9frMOdTzi74vtepOhraDFrC/riy2tqrBIrymCS+9r3A8+1vMTGnCnd1U2Ta
        yqJBEK0KgPjGVtcHUt/FjnIWkGQU6dhonDp5QZRs5D/X3FYF7cxjfx3wRP4tBkh1xrIAjfG
        MFRslggMfIXrZmIl59HtxWKP1acrlZ/BQiBNXKFT1L/ZH0csq2DmVDItEugTFnneHKGeYAr
        Q13/EKEPj/o4o+Dc+58tk85vssr3Uazv1sdr0VAUv66Srk+1JnX7OLHq+vQ/KVqpm+UjVGo
        V2OCE+Bt9Ap4bx+k+V/wo13qbQMffeHdoAfE+rwdwAwrmbwkDSuEMVPqybdDFKcL+SHvZTk
        4iHZiAKsiWETEjDqRenjVD+pDseuD3suhDQGrkp3MrKD1glbXlf1c1Ze3d3DZ5ywGT9EkSu
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6305770625938334413
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux@weissschuh.net, thomas@t-8ch.de
Subject: Re: [PATCH v5 5/5] selftests/nolibc: riscv: customize makefile for rv32
Date:   Mon,  3 Jul 2023 23:51:30 +0800
Message-Id: <20230703155130.501214-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230702171715.GD16233@1wt.eu>
References: <20230702171715.GD16233@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> On Mon, Jun 19, 2023 at 08:29:38PM +0800, Zhangjin Wu wrote:
> > Both riscv64 and riscv32 have:
> > 
> > * the same arch/riscv source code tree
> > * the same tools/include/nolibc/arch-riscv.h
> > * the same ARCH=riscv value passed to top-level kernel Makefile
> > 
> > The only differences are:
> > 
> > * riscv64 uses defconfig, riscv32 uses rv32_defconfig
> > * riscv64 uses qemu-system-riscv64, riscv32 uses qemu-system-riscv32
> > * riscv32 has different compiler options (-march= and -mabi=)
> > 
> > So, riscv32 can share most of the settings with riscv64, add riscv32
> > support like the original ARCH=riscv support.
> > 
> > To align with x86, the default riscv is reserved for riscv64 and a new
> > riscv64 is also added to allow users pass ARCH=riscv64 directly.
> > 
> > Since top-level kernel Makefile only accept ARCH=riscv, to make kernel
> > happy, let's set kernel specific KARCH as riscv for both riscv32 and
> > riscv64.
> > 
> > And since they share the same arch-riscv.h, let's set nolibc specific
> > NARCH as riscv too.
> > 
> > Usage:
> > 
> >     $ make defconfig ARCH=riscv32 CROSS_COMPILE=riscv64-linux-gnu- ...
> >     $ make run ARCH=riscv32 CROSS_COMPILE=riscv64-linux-gnu- ...
> 
> I'm hesitating on this one. Till now the ARCH variable taken on input
> was *exactly* the one used by the kernel. We include some scripts very
> early and we don't control the possible usage of ARCH. There's also
> this at the top of the makefile:
> 
>   # when run as make -C tools/ nolibc_<foo> the arch is not set
>   ifeq ($(ARCH),)
>   include $(srctree)/scripts/subarch.include
>   ARCH = $(SUBARCH)
>   endif
> 
> So as you can see $(ARCH) is still very intimate with the kernel's.
> For x86 it's no big deal because the i386 and x86_64 names are real
> valid archs. The difficulty we're having with riscv is that 32 and 64
> are two distinct archs for all tools but not for the kernel, and it
> looks like the only difference is in the config itself.
> 
> Given that we call all tools explicitly and that the kernel does a lot
> of implicit things with $(ARCH), I'm wondering if it wouldn't be more
> robust for the long term to instead add a "VARIANT" variable for the
> test only that would enforce "riscv32" or "riscv64" where needed (note
> that I'm not sold on this variable's name, it's to illustrate). Because
> if you look closely, you'll note that the nolibc source does not use
> this difference since its arch is always equal to the kernel's, and
> only the test requires it. I wouldn't be shocked by having more test
> options than we have architectures, and I noticed in another series
> that you were also proposing to extend config options, so I think it
> goes in the same direction. Then we could have in the test's Makefile
> a check for this VARIANT being set, which would preset ARCH when
> defined, and being used to configure Qemu. Maybe it could more or
> less look like this (for the selftest Makefile I mean) :
> 
>   # maps variants to nominal archs
>   ARCH_VARIANT_riscv32 = riscv
>   ARCH_VARIANT_riscv64 = riscv
> 
>   # default variants for some archs
>   DEF_VARIANT_riscv    = riscv64
> 
>   VARIANT :=
>   ARCH    ?= $(or $(ARCH_VARIANT_$(VARIANT)),$(VARIANT))
>   VARIANT ?= $(or $(DEF_VARIANT_$(ARCH)),$(ARCH))
> 
> Modulo the possible typos above, you probably get the idea. If ARCH is
> set, it will be used and automatically set the variant to the default
> one for the arch. And if VARIANT is set, it will set the correct
> default ARCH. It's possible to force the two in conflicting ways that
> will not work but we don't care, it's like for the rest of the variables.
> But at least we're never passing invalid values into ARCH anymore and I
> find this much safer.
>
> What do you think ?
>

agree, to distinguish the user input one and the kernel accepted one. If want
to reserve ARCH as the default Kernel ARCH, what about use something like UARCH
(User input ARCH) or XARCH (eXtended ARCH), it is shorter than VARIANT.

    # UARCH and ARCH mapping, ARCH is supported by kernel, UARCH is input from user
    UARCH_riscv      = riscv64
    UARCH           ?= $(or $(UARCH_$(ARCH)),$(ARCH))
    
    ARCH_riscv32     = riscv
    ARCH_riscv64     = riscv
    ARCH            ?= $(or $(ARCH_$(UARCH)),$(UARCH)

With this, we can simply customize the variables with UARCH or XARCH and left
the others as before.

We can delay this after the minimal config patchset, I'm still preparing the v2
of the tinyconfig patchset, it is almost ready. these two have some conflicts.

With the v2 tinyconfig patchset, we are able to run nolibc-test for different
architectures independently.

Best regards,
Zhangjin
 
> Thanks,
> Willy
