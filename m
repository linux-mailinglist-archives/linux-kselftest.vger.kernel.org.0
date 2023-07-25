Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829A6761DFD
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 18:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjGYQFP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 12:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjGYQFO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 12:05:14 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C359FE77;
        Tue, 25 Jul 2023 09:05:08 -0700 (PDT)
X-QQ-mid: bizesmtp85t1690301096tgcf16c2
Received: from linux-lab-host.localdomain ( [61.141.78.189])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 26 Jul 2023 00:04:55 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: D2GZf6M6C/gt/I6s939WW9wB2EPde0d82Sb1JxuaSSI7oGW697837bss1R1eg
        IKgK/opSd3p+2jgHQ22YGuRkrxRbDvBONXtSd1W+PwtS82uG4fc1TIVOMKTS7knmfkuFc7Z
        QaTVDy2djvMOKr04xEVnJkO/SLL/1BOZWwrwm05z+WGblON+ZnKJnSaezlL4EOhUUsDQoFS
        LO9qAQQyF1++JYnkR72m2MGyDqRGPSlPs7ZA52UdXQozDbN8tJo7Cq7O8mp3SpZe0jaROBv
        jCNQsPxzByG+GHhFStrBwb0oFmFq8I4rixzDT8QZXlme5LywG5tFuDk+TgxJsWXDhdTYyNr
        LZfGBFZgvawjQb/NTePvNWCEelNHw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17678625331418614737
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v2 14/14] selftests/nolibc: tinyconfig: add support for 32/64-bit powerpc
Date:   Wed, 26 Jul 2023 00:04:53 +0800
Message-Id: <20230725160453.40605-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230722131728.GM17311@1wt.eu>
References: <20230722131728.GM17311@1wt.eu>
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

> On Wed, Jul 19, 2023 at 09:32:46PM +0800, Zhangjin Wu wrote:
> > Firstly, add extra config files for powerpc, powerpc64le and powerpc64.
> > 
> > Second, QEMU_TIMEOUT is configured as 60 seconds for powerpc to allow
> > quit qemu-system-ppc even if poweroff fails. In normal host machine, ~20
> > seconds may be enough for boot+test+poweroff, but 60 seconds is used
> > here to gurantee it at least finish even in a very slow host machine or
> > the host machine is too busy. Both powerpc64le and powerpc64 can
> > poweroff normally, no need to configure QEMU_TIMEOUT for them.
> 
> Hmmm call me annoying, but this started with tinyconfig "in order to
> save build time" and now it's enforcing a 1-minute timeout on a single
> test. When I run the tests, they hardly last more than a few seconds
> and sometimes even just about one second. If some tests last too long
> doing nothing, we should adjust their config (e.g. useless probe of a
> driver). If they can't power off due to a config option we need to fix
> that option. If it can't power off due to the architecture, we can also
> try the reboot (qemu is started with --no-reboot to stop instead of
> rebooting), and as a last resort we should rely on the timeout in case
> everything else fails. But then this timeout should be quite short
> because we'll then have guaranteed from the choice of config options
> that it boots and executes fast by default.
>

As I just explained in this reply [1], our current timeout logic will
detect the 'power off' string at first, so, the 1-minute is the worst
case when the qemu even not print a 'power off' string, that should be a
bug, normally, after the 'power off' string detected, qemu will quit as
expected. the 1-minute is just configured here as a last watchdog to
detect a real hang (may be bios related or may be kernel realted) ;-)

So, the 60 seconds will never be reached, even there is a failed
poweroff, but a smaller one may be ok, what about 30 seconds?

[1]: https://lore.kernel.org/lkml/20230725145955.37685-1-falcon@tinylab.org/

> Finally, if we need to implement a timeout enforcement for at least
> one arch because we do not control every failure case, then there's no
> reason for considering that certain archs are safe against this and
> others not. This means that we can (should?) implement the timeout by
> default for every arch,

Agree, so, what your suggestion about the default timeout? ;-)

10 or 15 seconds may be not enough especially when running on a very
slow host machine, for example, my host will be very slow when the
battery is not in charging status ;-(

And also, the architectures like PowerPC using a very slow SLOF will
boot very slowly, sometimes 20 seconds may be not enough and it may cost
30+ seconds on a very slow machine.

> and make sure that the timeout is never hit by
> default

Yeah, it is the current behavior.

> , unless there's really absolutely no way to fix the arch that
> cannot power down nor reboot,

Even when the kernel not support poweroff, the 'power off' string will
be printed after our 'reboot' syscall, our current timeout logic will
detect this and let qemu quit. We even plan to detect the 'Leaving
init with final status' line.

so, it is not necessary to spend too much time to find out and enable
the kernel power off support for every architecture. and some
architectures may simply not support power-off, and also, some
architectures require too many 'heavy' options to let power-off work,
which may increase build time for tinyconfig a lot, for example, the
ACPI+PCI support are required for power-off for x86.

> in which case the timeout should remain
> short enough.
> 
> What's your opinion ?
>

As a summary, with current timeout logic, a big timeout is only hit when
a real hang happen. Even when the kernel not support power-off, the
power-off string will be detected by us and qemu will quit by pkill.

So, a not that big timeout for every architecture by default, but still
allow the architecture to configure a bigger one?

    QEMU_TIMEOUT_powerpc     = 35
    QEMU_TIMEOUT             = $(or $(QEMU_TIMEOUT_$(XARCH),30)

I will retest them carefully, I'm still worried about that a too small timeout
may kill qemu during test or even before running test, but it would run tests
and power-off normally if we not kill them.

And even further, I'm thinking about the detecting of the boot hang as
earier as we can, for example, these lines are good for us:

    // first line to detect bios hang, may be 5 seconds?
    Linux version 6.4.0+ ...

    // second line to detect kernel boot hang, may be 10 or 15 seconds?
    Run /init as init process

    // third line to detect test hang, ...
    Leaving init with final status

    // forth line to detect power-off
    reboot: Power down

So, even we configure a big timeout, but we can use a smaller default hang
detect setting for bios hang, kernel hang and test hang, it will kill qemu as
earier as we can, even hang happens, no need to wait for the timeout value we
configured.

Best regards,
Zhangjin

> Willy
