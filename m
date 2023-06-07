Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72007725704
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jun 2023 10:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239176AbjFGILW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jun 2023 04:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234278AbjFGILV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jun 2023 04:11:21 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0691C95;
        Wed,  7 Jun 2023 01:11:18 -0700 (PDT)
X-QQ-mid: bizesmtp75t1686125468tf9po345
Received: from linux-lab-host.localdomain ( [61.141.77.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 07 Jun 2023 16:11:07 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: t+YzzcYcY/yIcYJBJAauvIxKKd3tsAr7koUSEaZ8zaovQMdGosVaKCJWd1dp3
        3AznNfz7xPXMB8v22KQ8la1jDw6ACQcuAKPOVu7cB1q7cKLlyIcQZXGavNxuFNICM4jCdPQ
        nZrcg4DQXzkFRYrT/IojBq86LZRVcJQqGP1AScW7qZp08DggRkTsU6bdmqtrIp+BmEtqmkR
        2G2ci7QeoAEVBkMnnD6+HfWm/zydQlvvTIAfL1Vb868dLorSnZjS7qZay+c4VTzR5XLZ7O7
        KLS1kzeO6ZT4y4b3pGClyfonwGhBZ8IrLpFBzwruN8EXA20Q5XX1xsuPUDrl3YmD+9DamKs
        60AenKfN4R3T8cpMJEV+s5zy7QMho8seioMXwWLzM+UGSb69+GuhKP4LxYV01+hKo2YYlq4
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15885581524704403754
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: Re: [PATCH v3 3/3] selftests/nolibc: riscv: customize makefile for rv32
Date:   Wed,  7 Jun 2023 16:11:03 +0800
Message-Id: <20230607081103.746962-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZIAywHvr6UB1J4of@1wt.eu>
References: <ZIAywHvr6UB1J4of@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> On Wed, Jun 07, 2023 at 02:33:14PM +0800, Zhangjin Wu wrote:
> >
> >     ifneq ($(findstring riscv,$(ARCH)),)
> >       KARCH = riscv
> >     else
> >       KARCH = $(ARCH)
> >     endif
> (...)
>
> At least it suggests what it's going to be used for instead of just
> being marked as "special" (something the underscore does).
>

Yeah.

> > but the new method mentioned here differs, it split the whole Makefile
> > to two 'parts', the before part accept something like ARCH=riscv32,
> > ARCH=riscv64, ARCH=riscv, the after part use the ARCH=riscv, this avoid
> > touch the targets context:
>
> We don't care about touching *code*. What is important is that it scales
> and is understandable, thus maintainable. Code that has many exceptions
> or requires a lot of head scratching to figure what's being done is a
> pain to maintain and nobody wants to take the risk to touch it. That was
> exactly the purpose of the enumeration of per-target args, flags etc in
> the makefile: nobody needs to be expert in multiple areas to touch their
> own area. If we face a showstopper, we need to address it, and not work
> around it for the sake of touching less context.
>

Get it clearly.

> >     ... variable assignments before this line ...
> >
> >     +# Some architectures share the same arch/<ARCH>/ source code tree among the <ARCH>xyz variants
> >     +# Top-level kernel Makefile only accepts ARCH=<ARCH>, override <ARCH>xyz variants to make kernel happy
> >     +ARCHS := riscv
> >     +_ARCH := $(strip $(foreach arch, $(ARCHS), $(if $(findstring x$(arch),x$(ARCH)),$(arch))))
> >     +ifneq ($(_ARCH),)
> >     +override ARCH := $(_ARCH)
> >     +endif
> >     +
>
> So actually this is a perfect example of head scratching for me. I suspect
> it would replace x86_64 with x86 if x86 would be placed there for example,
> though it would not change anything for i386. Maybe for s390/s390x,
> arm/arm64 or ppc/ppc64 etc it would act similarly while these are different
> archs. Thus this seems to be trying to generalize a rule around a single
> particular case.
>

It is true, we did worry about when users wrongly add new ARCH in the
list, a generic way is very hard before we really use them.

> Probably that instead this particular case should be addressed explicitly
> until we find a generalization (if ever) to other archs:
>
>   ifeq($(ARCH),riscv32)
>   override ARCH := riscv
>   else ifeq($(ARCH),riscv64)
>   override ARCH := riscv
>   endif
>   endif
>
> Or maybe even better you can decide to remap arch names explicitly:
>
>   # use KARCH_from=to to rename ARCH from $from to $to past this point.
>   KARCH_riscv32 := riscv
>   KARCH_riscv64 := riscv
>   ...
>   ifneq($(KARCH_$(ARCH)),)
>   override ARCH := $(KARCH_$(ARCH))
>   endif
>

This did inspire me a lot, so, what about simply go back to the KARCH
method without any overriding:

    diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
    index 4a3a105e1fdf..bde635b083f4 100644
    --- a/tools/testing/selftests/nolibc/Makefile
    +++ b/tools/testing/selftests/nolibc/Makefile
    @@ -14,6 +14,12 @@ include $(srctree)/scripts/subarch.include
     ARCH = $(SUBARCH)
     endif

    +# kernel supported ARCH names by architecture
    +KARCH_riscv32    = riscv
    +KARCH_riscv64    = riscv
    +KARCH_riscv      = riscv
    +KARCH            = $(or $(KARCH_$(ARCH)),$(ARCH))
    +
     # kernel image names by architecture
     IMAGE_i386       = arch/x86/boot/bzImage
     IMAGE_x86_64     = arch/x86/boot/bzImage
    @@ -21,6 +27,8 @@ IMAGE_x86        = arch/x86/boot/bzImage
     IMAGE_arm64      = arch/arm64/boot/Image
     IMAGE_arm        = arch/arm/boot/zImage
     IMAGE_mips       = vmlinuz

And this:

    @@ -117,7 +132,7 @@ sysroot: sysroot/$(ARCH)/include
     sysroot/$(ARCH)/include:
            $(Q)rm -rf sysroot/$(ARCH) sysroot/sysroot
            $(QUIET_MKDIR)mkdir -p sysroot
    -       $(Q)$(MAKE) -C ../../../include/nolibc ARCH=$(ARCH) OUTPUT=$(CURDIR)/sysroot/ headers_standalone
    +       $(Q)$(MAKE) -C ../../../include/nolibc ARCH=$(KARCH) OUTPUT=$(CURDIR)/sysroot/ headers_standalone
            $(Q)mv sysroot/sysroot sysroot/$(ARCH)

     nolibc-test: nolibc-test.c sysroot/$(ARCH)/include
    @@ -141,10 +156,10 @@ initramfs: nolibc-test
            $(Q)cp nolibc-test initramfs/init

     defconfig:
    -       $(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare
    +       $(Q)$(MAKE) -C $(srctree) ARCH=$(KARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare

     kernel: initramfs
    -       $(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME) CONFIG_INITRAMFS_SOURCE=$(CURDIR)/initramfs
    +       $(Q)$(MAKE) -C $(srctree) ARCH=$(KARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME) CONFIG_INITRAMFS_SOURCE=$(CURDIR)/initramfs

It is almost consistent with the original Makefile now.

I do like this method more than the override method now, the override
method may break the maintainability a lot especially that the
developers may be hard to know which ARCH value it is when he touch a
line of the Makefile.

> And this does deserve an explicit note in the makefile that anything
> using $(ARCH) using a macro will see the renamed arch while anything
> using it as a variable before that line will see the original one.
>
> If you want to avoid the '=' vs ':=' mess you can even keep a copy of
> the original ARCH at the beginning of the makefile:
>
>   # keep a copy of the arch name requested by the user, for use later
>   # when the original form is preferred over the kernel's arch name.
>   USER_ARCH = $(ARCH)
>

Yeah, a copy is good for the override case.

> > Willy, Which one do you prefer?
>
> The most explicit ones like above. Generally speaking when you try to
> add support for your own arch here, you look there for similar ones,
> where commands are called, and read in reverse mode till the beginning,
> hoping to understand the transformations. I think the current ones and
> the proposed ones above are self-explanatory. Anything doing too much
> magic renaming or doing too much hard-coded automatic stuff can quickly
> obfuscate the principle and make things more complicated. I already
> despise "override" because it messes up with macros, but I agree it can
> sometimes have some value. If you dup it into ORIG_ARCH or USER_ARCH,
> and modify the few lines overriding arch in an explicit manner, I think
> it would preserve its maintainability.
>

Agree, let's give up the 'override' stuff.

> What do you think ?

So, let's go with the KARCH method if you agree too.

Best regards,
Zhangjin

>
> thanks,
> Willy
