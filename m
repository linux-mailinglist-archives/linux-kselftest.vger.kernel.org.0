Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A8B77B2AD
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 09:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbjHNHjY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 03:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbjHNHjG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 03:39:06 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5719AE77;
        Mon, 14 Aug 2023 00:39:03 -0700 (PDT)
X-QQ-mid: bizesmtp81t1691998737thw1uylw
Received: from linux-lab-host.localdomain ( [116.30.128.116])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 14 Aug 2023 15:38:55 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: ILHsT53NKPgSYc2MJc8LgfLuQ9xVIs8E0t6Kl0PCU8zSJzGcvbRYI2goUtxYt
        5au0ZM7oybWImKhQsYttCh8pALgLX1+FjjCR+0gb27MUrdFcA3fmgj103AXv/FhkHIvsL4T
        qeXry1LDorRRL/xtNUI0UBvVV2It6vX4vN5eOP8UaQXNnY5I+/ixbYyUWQhtca9rYcTKu9K
        dA36fp2dvzJ959VKWfe/6IGAZ4bfFdIiA5BGnZeAnji0DfM0a7lR2O88h3Kqt9pENRV6j3f
        LlM1uW88XQqpkqVLi3U7FDrKq2mKj97yFF1uXFAd2RI6cy5imHgEyIyhdwNE4aXLyV31lpC
        U7usk9ZS5cuZv3UsAw1lpT++o46Og==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4215077401987166728
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, tanyuan@tinylab.org,
        thomas@t-8ch.de
Subject: Re: [PATCH v2 0/7] selftests/nolibc: customize CROSS_COMPILE for all supported architectures
Date:   Mon, 14 Aug 2023 15:38:54 +0800
Message-Id: <20230814073854.13444-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230814071850.GC14322@1wt.eu>
References: <20230814071850.GC14322@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> On Sun, Aug 13, 2023 at 06:05:03PM +0800, Zhangjin Wu wrote:
> > > I think that later I'll further extend XARCH with new variants to
> > > support ARMv5 and Thumb2, because we have different code for this
> > > and I continue to manually change the CFLAGS to test both.
> > >
> > 
> > Ok, what about further add x86_64 as the default variant for x86 (like ppc for
> > powerpc)? and then it is able to only resereve the variables for x86_64. I have
> > prepared a patch for this goal in our new tinyconfig patchset, it will further
> > avoid adding the same nolibc-test-x86.config and nolibc-test-x86_64.config.
> 
> I'm confused, x86 already defaults to x86_64, it's just that it depends
> on the .config itself to figure whether to produce a 32- or 64-bit kernel.
> But for example it starts qemu in 64-bit mode. Am I missing anything ?
>

In kernel side, it is, but in our nolibc-test, we have added a copy of x86_64
for x86:

    $ grep -E "_x86" tools/testing/selftests/nolibc/Makefile 
    IMAGE_x86_64     = arch/x86/boot/bzImage
    IMAGE_x86        = arch/x86/boot/bzImage
    CROSS_COMPILE_x86_64    ?= x86_64-linux- x86_64-linux-gnu-
    CROSS_COMPILE_x86       ?= x86_64-linux- x86_64-linux-gnu-
    DEFCONFIG_x86_64     = defconfig
    DEFCONFIG_x86        = defconfig
    QEMU_ARCH_x86_64     = x86_64
    QEMU_ARCH_x86        = x86_64
    QEMU_ARGS_x86_64     = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(TEST:%=NOLIBC_TEST=%)"
    QEMU_ARGS_x86        = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(TEST:%=NOLIBC_TEST=%)"

With 'XARCH', the "_x86" copy of them can be simply replaced with such a line:

     # configure default variants for target kernel supported architectures
     XARCH_powerpc    = ppc
    +XARCH_x86        = x86_64
     XARCH            = $(or $(XARCH_$(ARCH)),$(ARCH))

And therefore, the future nolibc-test-x86_64.config is also enough for x86.

But I have seen the 'x86' exception in tools/include/nolibc/Makefile, just a
confirm on if this replacement is ok.

BR,
Zhangjin

> Willy
