Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31F2768414
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Jul 2023 09:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjG3HDg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 30 Jul 2023 03:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjG3HDf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 30 Jul 2023 03:03:35 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9AB5710FE;
        Sun, 30 Jul 2023 00:03:33 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 36U73PO2008085;
        Sun, 30 Jul 2023 09:03:25 +0200
Date:   Sun, 30 Jul 2023 09:03:25 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux@weissschuh.net,
        thomas@t-8ch.de
Subject: Re: [PATCH v3 4/7] selftests/nolibc: add XARCH and ARCH mapping
 support
Message-ID: <20230730070325.GA8033@1wt.eu>
References: <45cc24c1cf8794782be2ae631ca01bcd136da6d9.1690468707.git.falcon@tinylab.org>
 <20230730063818.10573-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230730063818.10573-1-falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Jul 30, 2023 at 02:38:18PM +0800, Zhangjin Wu wrote:
> with 'override', we are further able to use:
> 
>     $ make ARCH=powerpc
>     Makefile:29: *** ARCH=powerpc, XARCH=ppc.  Stop.
>     $ make ARCH=ppc
>     Makefile:29: *** ARCH=powerpc, XARCH=ppc.  Stop.
>     $ make ARCH=ppc64
>     Makefile:29: *** ARCH=powerpc, XARCH=ppc64.  Stop.
>     $ make ARCH=ppc64le
>     Makefile:29: *** ARCH=powerpc, XARCH=ppc64le.  Stop.
> 
> So, with 'override', users will be able to directly use the famous ARCH, it is
> able to accept powerpc, ppc, ppc64, ppc64le and users can simply ignore XARCH
> and we are able to only use XARCH as an internal variable to temply save input
> ARCH and then convert it to an internal ARCH.

But it's extremely confusing as you can see above: the user passes
one value and another one is found instead inside the makefile.
Initially I said that I didn't want that we'd put incorrect values
in ARCH so that it could be properly propagated through the various
makefile layers and include files, and that led to XARCH. 

> Without 'override', we must carefully document its usage, it may be:
> 
>     # XARCH and ARCH mapping
>     #
>     # Usage:
>     #      $ make ARCH=<kernel-supported-ARCH> XARCH=<nolibc-test-supported-variants> ...
>     #
>     #      e.g. make ARCH=powerpc XARCH=[ppc|ppc64|ppc64le]

Please let's do much simpler:

      # XARCH extends the kernel's ARCH with a few variants of the same
      # architecture that only differ by the configuration, the toolchain
      # and the Qemu program used. It is copied as-is into ARCH except for
      # a few specific values which are mapped like this:
      #  XARCH        ARCH      config
      #   ppc        powerpc    32 bits
      #   ppc64      powerpc    64 bits big endian
      #   ppc64le    powerpc    64 bits little endian
      #
      # It is recommended to only use XARCH, though it does not harm if
      # ARCH is already set. For simplicity, ARCH is sufficient for all
      # architectures where both are equal.

This way we'll even have the luxury of adding armv5, armv7 and thumb2
if we want.

>     # XARCH is used to save user-input ARCH variant
>     # configure default variants for target kernel supported architectures
> 
> For the help page, if we only use '\$$XARCH or \$$ARCH', it may mislead users:
> 
> 	@echo "  run-user               runs the executable under QEMU (uses \$$ARCH or \\$XARCH, \$$TEST)"
> 
> That's why I at last add the 'override' keyword to make sure even if users
> wrongly and only use ARCH as the argument, it must not fail, or we forcely ask
> user pass ARCH and XARCH together.
> 
> 	@echo "  run-user               runs the executable under QEMU (uses \$$ARCH and \\$XARCH, \$$TEST)"
> 
> Or we simply only and always ask users to use XARCH (as the first version does)
> for nolibc-test and let ARCH as the default one from a previous build kernel:
> 
> 	@echo "  run-user               runs the executable under QEMU (uses \$$XARCH, \$$TEST)"

No, no, no, we don't use some defaults from a previous build. That makes
problems much harder to debug and reproduce. However I'm fine with only
indicating that QEMU uses XARCH if you want.

> That means, the ugly 'override' does help us to save lots of teach work ;-)

Precisely not. In my opinion you focus a lot on first use but not enough
on troubleshooting. If someone wastes 20 minutes because they didn't want
to take 20 seconds to read a help message, it's their problem. But if
someones wastes one hour trying to debug a horribly inconsistent makefile
that modifies their most critical variables along the execution, and they
have to figure how to insert their stuff there to be accepted by the code,
it's not respectful of their time and it becomes our problem.

> I'm ok with 'override' or not, welcome your confirm, which direction do you
> prefer?

The one with least complications and which doesn't override ARCH. Also
please remember the example I provided where the test can be fired from
the top dir where ARCH has a well-defined set of values. You found yourself
inconvenient to have to change it between commands and that's why you were
trying to add menuconfig here to work around this problem.

Thanks,
Willy
