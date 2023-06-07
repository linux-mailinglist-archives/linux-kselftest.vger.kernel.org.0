Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9DCF725BC7
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jun 2023 12:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237979AbjFGKpr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jun 2023 06:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237700AbjFGKpY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jun 2023 06:45:24 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5FBCBAA;
        Wed,  7 Jun 2023 03:45:21 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 357AixTA001922;
        Wed, 7 Jun 2023 12:44:59 +0200
Date:   Wed, 7 Jun 2023 12:44:59 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: Re: [PATCH v3 3/3] selftests/nolibc: riscv: customize makefile for
 rv32
Message-ID: <ZIBfq3p29Z5QlIcj@1wt.eu>
References: <ZIAywHvr6UB1J4of@1wt.eu>
 <20230607081103.746962-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607081103.746962-1-falcon@tinylab.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 07, 2023 at 04:11:03PM +0800, Zhangjin Wu wrote:
> This did inspire me a lot, so, what about simply go back to the KARCH
> method without any overriding:
> 
>     diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
>     index 4a3a105e1fdf..bde635b083f4 100644
>     --- a/tools/testing/selftests/nolibc/Makefile
>     +++ b/tools/testing/selftests/nolibc/Makefile
>     @@ -14,6 +14,12 @@ include $(srctree)/scripts/subarch.include
>      ARCH = $(SUBARCH)
>      endif
> 
>     +# kernel supported ARCH names by architecture
>     +KARCH_riscv32    = riscv
>     +KARCH_riscv64    = riscv
>     +KARCH_riscv      = riscv
>     +KARCH            = $(or $(KARCH_$(ARCH)),$(ARCH))
>     +
>      # kernel image names by architecture
>      IMAGE_i386       = arch/x86/boot/bzImage
>      IMAGE_x86_64     = arch/x86/boot/bzImage
>     @@ -21,6 +27,8 @@ IMAGE_x86        = arch/x86/boot/bzImage
>      IMAGE_arm64      = arch/arm64/boot/Image
>      IMAGE_arm        = arch/arm/boot/zImage
>      IMAGE_mips       = vmlinuz
> 
> And this:
> 
>     @@ -117,7 +132,7 @@ sysroot: sysroot/$(ARCH)/include
>      sysroot/$(ARCH)/include:
>             $(Q)rm -rf sysroot/$(ARCH) sysroot/sysroot
>             $(QUIET_MKDIR)mkdir -p sysroot
>     -       $(Q)$(MAKE) -C ../../../include/nolibc ARCH=$(ARCH) OUTPUT=$(CURDIR)/sysroot/ headers_standalone
>     +       $(Q)$(MAKE) -C ../../../include/nolibc ARCH=$(KARCH) OUTPUT=$(CURDIR)/sysroot/ headers_standalone
>             $(Q)mv sysroot/sysroot sysroot/$(ARCH)
> 
>      nolibc-test: nolibc-test.c sysroot/$(ARCH)/include
>     @@ -141,10 +156,10 @@ initramfs: nolibc-test
>             $(Q)cp nolibc-test initramfs/init
> 
>      defconfig:
>     -       $(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare
>     +       $(Q)$(MAKE) -C $(srctree) ARCH=$(KARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare
> 
>      kernel: initramfs
>     -       $(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME) CONFIG_INITRAMFS_SOURCE=$(CURDIR)/initramfs
>     +       $(Q)$(MAKE) -C $(srctree) ARCH=$(KARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME) CONFIG_INITRAMFS_SOURCE=$(CURDIR)/initramfs
> 
> It is almost consistent with the original Makefile now.

If it works, I like it!

> I do like this method more than the override method now, the override
> method may break the maintainability a lot especially that the
> developers may be hard to know which ARCH value it is when he touch a
> line of the Makefile.

Yes definitely, add to this the risk that a patch applies at the wrong
line and only breaks one or two archs, etc.

> > Generally speaking when you try to
> > add support for your own arch here, you look there for similar ones,
> > where commands are called, and read in reverse mode till the beginning,
> > hoping to understand the transformations. I think the current ones and
> > the proposed ones above are self-explanatory. Anything doing too much
> > magic renaming or doing too much hard-coded automatic stuff can quickly
> > obfuscate the principle and make things more complicated. I already
> > despise "override" because it messes up with macros, but I agree it can
> > sometimes have some value. If you dup it into ORIG_ARCH or USER_ARCH,
> > and modify the few lines overriding arch in an explicit manner, I think
> > it would preserve its maintainability.
> >
> 
> Agree, let's give up the 'override' stuff.
> 
> > What do you think ?
> 
> So, let's go with the KARCH method if you agree too.

I'm fine with it!

Thanks,
Willy
