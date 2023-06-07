Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC93725456
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jun 2023 08:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235279AbjFGGe3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jun 2023 02:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237447AbjFGGd6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jun 2023 02:33:58 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A7A1FED;
        Tue,  6 Jun 2023 23:33:27 -0700 (PDT)
X-QQ-mid: bizesmtp67t1686119596tf3boez7
Received: from linux-lab-host.localdomain ( [61.141.77.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 07 Jun 2023 14:33:15 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: /XOqoV/ugIFDbT4y2awD+CiNwXw5I6PSTTIzx+mn+CafNu/W3BnUUcHMoLbAp
        Y7B1xRgSjArkir490WuNY7GGD8xEStgaFtxkUNQSpJzLjmZn2vxmdIcFvhBVv60dmv5bMdh
        9VmB6nH+QV1WBPYxJsjmtoXn3iMkeu4PtNBUkRexu92i7G3pkU1J4YEYrZ/2QO9AF1mkpsE
        yREdlpHuSQyo3mHqhCwhQzMKBj7EUEc3yCPqtZgH3/EXO39ZDch/Kk4AyBdhP3sBeKj7JkP
        FVPD4D7OW4j71AIfUdHv9tL5isKV+LRxtjT2X5ig8mZXC6qfS9IDxfIoqT5hHJigyxLIQSy
        1ym+eT0brw/XkWo6peu8dldr5BcYVQuDrfutlZzpWZq3svXKgTqj+sjkaCjM439WEISg8PH
        RnXia1PXPA0=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15709502711661880930
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: Re: [PATCH v3 3/3] selftests/nolibc: riscv: customize makefile for rv32
Date:   Wed,  7 Jun 2023 14:33:14 +0800
Message-Id: <20230607063314.671429-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZIAEybZdXywKv43C@1wt.eu>
References: <ZIAEybZdXywKv43C@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> On Wed, Jun 07, 2023 at 09:20:32AM +0800, Zhangjin Wu wrote:
> > Arnd, Thomas, Willy
> >     ...
> >
> >      LDFLAGS := -s
> >
> >     +# top-level kernel Makefile only accept ARCH=riscv, override ARCH to make kernel happy
> >     +ifneq ($(findstring riscv,$(ARCH)),)
> >     +override ARCH := riscv
> >     +endif
> >     +
>
> That can be one approach indeed. Another one if we continue to face
> difficulties for this one would be to use a distinct KARCH variable
> to assign to ARCH in all kernel-specific operations.
>

Yeah, I have replied that method to Arnd and Thomas too, it looks like this:

    ifneq ($(findstring riscv,$(ARCH)),)
      _ARCH = riscv
    else
      _ARCH = $(ARCH)
    endif

    ...

    sysroot/$(ARCH)/include:
	$(Q)rm -rf sysroot/$(ARCH) sysroot/sysroot
	$(QUIET_MKDIR)mkdir -p sysroot
	$(Q)$(MAKE) -C ../../../include/nolibc ARCH=$(_ARCH) OUTPUT=$(CURDIR)/sysroot/ headers_standalone
	$(Q)mv sysroot/sysroot sysroot/$(ARCH)

    defconfig:
    	$(Q)$(MAKE) -C $(srctree) ARCH=$(_ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare

    kernel: initramfs
    	$(Q)$(MAKE) -C $(srctree) ARCH=$(_ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME) CONFIG_INITRAMFS_SOURCE=$(CURDIR)/initramfs

Using KARCH seems better than _ARCH:

    ifneq ($(findstring riscv,$(ARCH)),)
      KARCH = riscv
    else
      KARCH = $(ARCH)
    endif

    ...

    sysroot/$(ARCH)/include:
	$(Q)rm -rf sysroot/$(ARCH) sysroot/sysroot
	$(QUIET_MKDIR)mkdir -p sysroot
	$(Q)$(MAKE) -C ../../../include/nolibc ARCH=$(KARCH) OUTPUT=$(CURDIR)/sysroot/ headers_standalone
	$(Q)mv sysroot/sysroot sysroot/$(ARCH)

    defconfig:
    	$(Q)$(MAKE) -C $(srctree) ARCH=$(KARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare

    kernel: initramfs
    	$(Q)$(MAKE) -C $(srctree) ARCH=$(KARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME) CONFIG_INITRAMFS_SOURCE=$(CURDIR)/initramfs

but the new method mentioned here differs, it split the whole Makefile
to two 'parts', the before part accept something like ARCH=riscv32,
ARCH=riscv64, ARCH=riscv, the after part use the ARCH=riscv, this avoid
touch the targets context:

    ...
    QEMU_ARCH            = $(QEMU_ARCH_$(ARCH))
    +QEMU_ARCH           := $(QEMU_ARCH_$(ARCH))

     # QEMU_ARGS : some arch-specific args to pass to qemu
     QEMU_ARGS_i386       = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(TEST:%=NOLIBC_TEST=%)"
    @@ -61,10 +67,12 @@ QEMU_ARGS_x86        = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(
     QEMU_ARGS_arm64      = -M virt -cpu cortex-a53 -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
     QEMU_ARGS_arm        = -M virt -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
     QEMU_ARGS_mips       = -M malta -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
    +QEMU_ARGS_riscv32    = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
    +QEMU_ARGS_riscv64    = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
     QEMU_ARGS_riscv      = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
     QEMU_ARGS_s390       = -M s390-ccw-virtio -m 1G -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
     QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
    -QEMU_ARGS            = $(QEMU_ARGS_$(ARCH)) $(QEMU_ARGS_EXTRA)
    +QEMU_ARGS           := $(QEMU_ARGS_$(ARCH)) $(QEMU_ARGS_EXTRA)

     # OUTPUT is only set when run from the main makefile, otherwise
     # it defaults to this nolibc directory.
    @@ -76,13 +84,24 @@ else
     Q=@
     endif

    +CFLAGS_riscv32 = -march=rv32im -mabi=ilp32
     CFLAGS_s390 = -m64
     CFLAGS_STACKPROTECTOR ?= $(call cc-option,-mstack-protector-guard=global $(call cc-option,-fstack-protector-all))
    -CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 \
    +CFLAGS_default := -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 \
                    $(call cc-option,-fno-stack-protector) \
                    $(CFLAGS_$(ARCH)) $(CFLAGS_STACKPROTECTOR)
    +
    +CFLAGS  ?= $(CFLAGS_default)
     LDFLAGS := -s

    ... variable assignments before this line ...

    +# Some architectures share the same arch/<ARCH>/ source code tree among the <ARCH>xyz variants
    +# Top-level kernel Makefile only accepts ARCH=<ARCH>, override <ARCH>xyz variants to make kernel happy
    +ARCHS := riscv
    +_ARCH := $(strip $(foreach arch, $(ARCHS), $(if $(findstring x$(arch),x$(ARCH)),$(arch))))
    +ifneq ($(_ARCH),)
    +override ARCH := $(_ARCH)
    +endif
    +

    ... targets after this line ...

[1]: https://lore.kernel.org/lkml/20230606120755.548017-1-falcon@tinylab.org/#R

> >      help:
> >             @echo "Supported targets under selftests/nolibc:"
> >             @echo "  all          call the \"run\" target below"
> >
> > This change is not that big, and the left changes can keep consistent with the
> > other platforms. but I still need to add a standalone patch to convert the '='
> > to ':=' to avoid the before setting using our new overridded ARCH.
>
> I don't even see why the other ones below are needed, given that as
> long as they remain assigned as macros, they will be replaced in-place
> where they are used, so they will reference the last known assignment
> to ARCH.

The reason is really:

    "they will reference the last known assignment to ARCH"

If we use something like 'KARCH' or '_ARCH' and not override the ARCH in the
middle, then, no need to touch the ':' and '?='. otherwise, the variable will
accept something like QEMU_ARGS_riscv for riscv32, it breaks our requirement.

>
>        ...
> >      CFLAGS_s390 = -m64 CFLAGS_STACKPROTECTOR ?= $(call
> >      cc-option,-mstack-protector-guard=global $(call
> >      cc-option,-fstack-protector-all)) -CFLAGS  ?= -Os -fno-ident
> >      -fno-asynchronous-unwind-tables -std=c89 \ +CFLAGS_default :=
> >      -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 \
> >      $(call cc-option,-fno-stack-protector) \ $(CFLAGS_$(ARCH))
> >      $(CFLAGS_STACKPROTECTOR) + +CFLAGS  ?= $(CFLAGS_default)
>
> Why did you need to split this one like this instead of proceeding
> like for the other ones ? Because of the "?=" maybe ? Please
> double-check that you really need to turn this from a macro to a
> variable, if as I suspect it it's not needed, it would be even
> simpler.

It depends on the method we plan to use, just as explained above.

For a standalone KARCH, no need to touch the assignment, otherwise, we
should let the assignment take effect immediately to avoid they use the
one we plan to override.

For the KARCH method, I will tune it to be more scalable like this:

    ARCHS = riscv
    _ARCH = $(strip $(foreach arch, $(ARCHS), $(if $(findstring x$(arch),x$(ARCH)),$(arch))))
    KARCH = $(or $(_ARCH),$(ARCH))

Willy, Which one do you prefer?

Thanks,
Zhangjin

>
> Thanks, Willy
