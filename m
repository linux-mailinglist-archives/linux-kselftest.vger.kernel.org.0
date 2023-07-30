Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202BF768514
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Jul 2023 13:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjG3LhJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 30 Jul 2023 07:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjG3LhI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 30 Jul 2023 07:37:08 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D10A198B;
        Sun, 30 Jul 2023 04:37:04 -0700 (PDT)
X-QQ-mid: bizesmtp63t1690717014tgd3261d
Received: from linux-lab-host.localdomain ( [61.141.77.223])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 30 Jul 2023 19:36:52 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: QityeSR92A2N5I2UQznh0WlH9UJdZDmHmjA4vMsPMpsFD/fe8OZo2nHTrPYFV
        8s/wNrPrsTN436SvMNg5wfvgyDCuAjLCZ82ok5k5eX0CwOGWlOrzhSmLvsPAvZiMolA3m5u
        w3M4YSexXp+vTLUkyOxyf2mMlmVMFdMWD3JizFxOFqrrLfVAtfNpdMQOcZoIgZLWMluHjaN
        Occ8r6RAwxbkn71/rqf1C2kj2g41IgFqpGpWKeZMAUm/RKZFaosyYGdMoO6Iqa8cQp3LOs6
        RiMfY6bonJaxfz6A8LV07AMIK2F1QeWHRWOK1VGsPtiNEb9eoHzxnlv/dWnkQFZTNCBWVWF
        pSYn1QIq+vibR/6gndXMS7SrvQ8DQRs6tqb9Q6eu1e46bBPl6UXNRw4ldritA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10450196367034135589
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux@weissschuh.net,
        thomas@t-8ch.de
Subject: Re: [PATCH v3 4/7] selftests/nolibc: add XARCH and ARCH mapping support
Date:   Sun, 30 Jul 2023 19:36:51 +0800
Message-Id: <20230730113651.38052-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230730070325.GA8033@1wt.eu>
References: <20230730070325.GA8033@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

> On Sun, Jul 30, 2023 at 02:38:18PM +0800, Zhangjin Wu wrote:
> > with 'override', we are further able to use:
> > 
> >     $ make ARCH=powerpc
> >     Makefile:29: *** ARCH=powerpc, XARCH=ppc.  Stop.
> >     $ make ARCH=ppc
> >     Makefile:29: *** ARCH=powerpc, XARCH=ppc.  Stop.
> >     $ make ARCH=ppc64
> >     Makefile:29: *** ARCH=powerpc, XARCH=ppc64.  Stop.
> >     $ make ARCH=ppc64le
> >     Makefile:29: *** ARCH=powerpc, XARCH=ppc64le.  Stop.
> > 
> > So, with 'override', users will be able to directly use the famous ARCH, it is
> > able to accept powerpc, ppc, ppc64, ppc64le and users can simply ignore XARCH
> > and we are able to only use XARCH as an internal variable to temply save input
> > ARCH and then convert it to an internal ARCH.
> 
> But it's extremely confusing as you can see above: the user passes
> one value and another one is found instead inside the makefile.

Yeah, there really is some deviation and confusion.

> Initially I said that I didn't want that we'd put incorrect values
> in ARCH so that it could be properly propagated through the various
> makefile layers and include files, and that led to XARCH. 
>

I remember the good trick to set a default variant for ARCH.

> > Without 'override', we must carefully document its usage, it may be:
> > 
> >     # XARCH and ARCH mapping
> >     #
> >     # Usage:
> >     #      $ make ARCH=<kernel-supported-ARCH> XARCH=<nolibc-test-supported-variants> ...
> >     #
> >     #      e.g. make ARCH=powerpc XARCH=[ppc|ppc64|ppc64le]
> 
> Please let's do much simpler:
> 
>       # XARCH extends the kernel's ARCH with a few variants of the same
>       # architecture that only differ by the configuration, the toolchain
>       # and the Qemu program used. It is copied as-is into ARCH except for
>       # a few specific values which are mapped like this:
>       #  XARCH        ARCH      config
>       #   ppc        powerpc    32 bits
>       #   ppc64      powerpc    64 bits big endian
>       #   ppc64le    powerpc    64 bits little endian
>       #
>       # It is recommended to only use XARCH, though it does not harm if
>       # ARCH is already set. For simplicity, ARCH is sufficient for all
>       # architectures where both are equal.
>

It is clearer enough, applied.

    # XARCH extends the kernel's ARCH with a few variants of the same
    # architecture that only differ by the configuration, the toolchain
    # and the Qemu program used. It is copied as-is into ARCH except for
    # a few specific values which are mapped like this:
    #
    #  XARCH        | ARCH      | config
    #  -------------|-----------|-------------------------
    #  ppc          | powerpc   | 32 bits
    #  ppc64        | powerpc   | 64 bits big endian
    #  ppc64le      | powerpc   | 64 bits little endian
    #
    # It is recommended to only use XARCH, though it does not harm if
    # ARCH is already set. For simplicity, ARCH is sufficient for all
    # architectures where both are equal.
    
    # configure default variants for target kernel supported architectures
    XARCH_powerpc    = ppc
    XARCH            = $(or $(XARCH_$(ARCH)),$(ARCH))

    # map from user input variants to their kernel supported architectures
    ARCH_ppc         = powerpc
    ARCH_ppc64       = powerpc
    ARCH_ppc64le     = powerpc
    ARCH            := $(or $(ARCH_$(XARCH)),$(XARCH))

Any more discovery?

Note, ':=' above is required to fix up the 'recusive' warning when no
ARCH passed for the default x86.

> This way we'll even have the luxury of adding armv5, armv7 and thumb2
> if we want.
> 
> >     # XARCH is used to save user-input ARCH variant
> >     # configure default variants for target kernel supported architectures
> > 
> > For the help page, if we only use '\$$XARCH or \$$ARCH', it may mislead users:
> > 
> > 	@echo "  run-user               runs the executable under QEMU (uses \$$ARCH or \\$XARCH, \$$TEST)"
> > 
> > That's why I at last add the 'override' keyword to make sure even if users
> > wrongly and only use ARCH as the argument, it must not fail, or we forcely ask
> > user pass ARCH and XARCH together.
> > 
> > 	@echo "  run-user               runs the executable under QEMU (uses \$$ARCH and \\$XARCH, \$$TEST)"
> > 
> > Or we simply only and always ask users to use XARCH (as the first version does)
> > for nolibc-test and let ARCH as the default one from a previous build kernel:
> > 
> > 	@echo "  run-user               runs the executable under QEMU (uses \$$XARCH, \$$TEST)"
> 
> No, no, no, we don't use some defaults from a previous build. That makes
> problems much harder to debug and reproduce. However I'm fine with only
> indicating that QEMU uses XARCH if you want.
>

Ok, hope I have not misunderstood again ;-) so, here is the latest version I prepared:

    help:
    	@echo "Supported targets under selftests/nolibc:"
    	@echo "  all          call the \"run\" target below"
    	@echo "  help         this help"
    	@echo "  sysroot      create the nolibc sysroot here (uses \$$ARCH)"
    	@echo "  nolibc-test  build the executable (uses \$$CC and \$$CROSS_COMPILE)"
    	@echo "  libc-test    build an executable using the compiler's default libc instead"
    	@echo "  run-user     runs the executable under QEMU (uses \$$XARCH, \$$TEST)"
    	@echo "  initramfs    prepare the initramfs with nolibc-test"
    	@echo "  defconfig    create a fresh new default config (uses \$$XARCH)"
    	@echo "  kernel       (re)build the kernel with the initramfs (uses \$$XARCH)"
    	@echo "  run          runs the kernel in QEMU after building it (uses \$$XARCH, \$$TEST)"
    	@echo "  rerun        runs a previously prebuilt kernel in QEMU (uses \$$XARCH, \$$TEST)"
    	@echo "  clean        clean the sysroot, initramfs, build and output files"
    	@echo ""
    	@echo "The output file is \"run.out\". Test ranges may be passed using \$$TEST."
    	@echo ""
    	@echo "Currently using the following variables:"
    	@echo "  ARCH          = $(ARCH)"
    	@echo "  XARCH         = $(XARCH)"
    	@echo "  CROSS_COMPILE = $(CROSS_COMPILE)"
    	@echo "  CC            = $(CC)"
    	@echo "  OUTPUT        = $(OUTPUT)"
    	@echo "  TEST          = $(TEST)"
    	@echo "  QEMU_ARCH     = $(if $(QEMU_ARCH),$(QEMU_ARCH),UNKNOWN_ARCH) [determined from \$$XARCH]"
    	@echo "  IMAGE_NAME    = $(if $(IMAGE_NAME),$(IMAGE_NAME),UNKNOWN_ARCH) [determined from \$$XARCH]"
    	@echo ""

> > That means, the ugly 'override' does help us to save lots of teach work ;-)
> 
> Precisely not. In my opinion you focus a lot on first use but not enough
> on troubleshooting. If someone wastes 20 minutes because they didn't want
> to take 20 seconds to read a help message, it's their problem. But if
> someones wastes one hour trying to debug a horribly inconsistent makefile
> that modifies their most critical variables along the execution, and they
> have to figure how to insert their stuff there to be accepted by the code,
> it's not respectful of their time and it becomes our problem.
>

It is reasonable, we did discuss this before, the critical area is small
but is there, so, it may really introduce risks in the future, let's
give up 'override' completely.

> > I'm ok with 'override' or not, welcome your confirm, which direction do you
> > prefer?
> 
> The one with least complications and which doesn't override ARCH. Also
> please remember the example I provided where the test can be fired from
> the top dir where ARCH has a well-defined set of values. You found yourself
> inconvenient to have to change it between commands and that's why you were
> trying to add menuconfig here to work around this problem.

Best regards,
Zhangjin

> 
> Thanks,
> Willy
