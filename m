Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB75725175
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jun 2023 03:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbjFGBUw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 21:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234417AbjFGBUu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 21:20:50 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6890C172E;
        Tue,  6 Jun 2023 18:20:45 -0700 (PDT)
X-QQ-mid: bizesmtp66t1686100833tz2j48dv
Received: from linux-lab-host.localdomain ( [61.141.77.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 07 Jun 2023 09:20:32 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: 7L1V3dHhUFMsfd35czEmyWETdLhMVp6SYRjgwRWVg9MmptT9JY9519xTNirDi
        RvxCPeIRNFYA1zr82KGsW0uilN6omuKDe+odKZWD7UYDOw5L4ZjZBEliz9PyyRQYe/DRPKN
        cYc/vXHBFtRDYcB7kZ3bSHEHhQ4C4ntPeTQPNm0kMRXZxj8OD2TGwzKfJFK3wPiqjqKm67r
        Bx8mN+x8RWESUtgL5rpCSexyw2q0L5+LLi37NVgIdgZaHSlnOLoPm2rkm1TO2O3f7Qrdp2F
        toEihqiEjsk+sHDVece2x7laAgbNDaTGi9s+PR/xViJGAxvbtiVPjeJpByQTRQTw/Nxp257
        50w+u9sJlc2hKqdPJmwB/F1ivDKCza4EV1sbnTHxnCnjhjwd5IyrgT+iMnqEg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4645098387505124349
From:   Zhangjin Wu <falcon@tinylab.org>
To:     arnd@arndb.de, thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 3/3] selftests/nolibc: riscv: customize makefile for rv32
Date:   Wed,  7 Jun 2023 09:20:32 +0800
Message-Id: <20230607012032.585223-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230606120755.548017-1-falcon@tinylab.org>
References: <20230606120755.548017-1-falcon@tinylab.org>
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

Arnd, Thomas, Willy

> > >     +# Additional ARCH settings for riscv
> > >     +ifeq ($(ARCH),riscv32)
> > >     +        SRCARCH := riscv
> > >     +endif
> > >     +ifeq ($(ARCH),riscv64)
> > >     +        SRCARCH := riscv
> > >     +endif
> > >     +
> > >      export cross_compiling :=
> > >      ifneq ($(SRCARCH),$(SUBARCH))
> > >      cross_compiling := 1
> >
> > I've never been a big fan of the top-level $(ARCH) setting
> > in the kernel, is there a reason this has to be the same
> > as the variable in tools/include/nolibc? If not, I'd just
> > leave the Linux Makefile unchanged.
> >
> > For userspace we have a lot more target names than
> > arch/*/ directories in the kernel, and I don't think
> > I'd want to enumerate all the possibilities in the
> > build system globally.
>

Good news, I did find a better solution without touching the top-level
Makefile, that is overriding the ARCH to 'riscv' just before the targets
and after we got the necessary settings with the original ARCH=riscv32
or ARCH=riscv64, but it requires to convert the '=' assignments to ':=',
which is not that hard to do and it is more acceptable, just verified it
and it worked well.

    ...

     LDFLAGS := -s

    +# top-level kernel Makefile only accept ARCH=riscv, override ARCH to make kernel happy
    +ifneq ($(findstring riscv,$(ARCH)),)
    +override ARCH := riscv
    +endif
    +
     help:
            @echo "Supported targets under selftests/nolibc:"
            @echo "  all          call the \"run\" target below"

This change is not that big, and the left changes can keep consistent with the
other platforms. but I still need to add a standalone patch to convert the '='
to ':=' to avoid the before setting using our new overridded ARCH.

    ++ b/tools/testing/selftests/nolibc/Makefile
    @@ -26,7 +26,7 @@ IMAGE_riscv64    = arch/riscv/boot/Image
     IMAGE_riscv      = arch/riscv/boot/Image
     IMAGE_s390       = arch/s390/boot/bzImage
     IMAGE_loongarch  = arch/loongarch/boot/vmlinuz.efi
    -IMAGE            = $(IMAGE_$(ARCH))
    +IMAGE           := $(IMAGE_$(ARCH))
     IMAGE_NAME       = $(notdir $(IMAGE))

     # default kernel configurations that appear to be usable
    @@ -41,7 +41,7 @@ DEFCONFIG_riscv64    = defconfig
     DEFCONFIG_riscv      = defconfig
     DEFCONFIG_s390       = defconfig
     DEFCONFIG_loongarch  = defconfig
    -DEFCONFIG            = $(DEFCONFIG_$(ARCH))
    +DEFCONFIG           := $(DEFCONFIG_$(ARCH))

     # optional tests to run (default = all)
     TEST =
    @@ -58,7 +58,7 @@ QEMU_ARCH_riscv64    = riscv64
     QEMU_ARCH_riscv      = riscv64
     QEMU_ARCH_s390       = s390x
     QEMU_ARCH_loongarch  = loongarch64
    -QEMU_ARCH            = $(QEMU_ARCH_$(ARCH))
    +QEMU_ARCH           := $(QEMU_ARCH_$(ARCH))

     # QEMU_ARGS : some arch-specific args to pass to qemu
     QEMU_ARGS_i386       = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(TEST:%=NOLIBC_TEST=%)"
    @@ -72,7 +72,7 @@ QEMU_ARGS_riscv64    = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_T
     QEMU_ARGS_riscv      = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
     QEMU_ARGS_s390       = -M s390-ccw-virtio -m 1G -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
     QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
    -QEMU_ARGS            = $(QEMU_ARGS_$(ARCH)) $(QEMU_ARGS_EXTRA)
    +QEMU_ARGS           := $(QEMU_ARGS_$(ARCH)) $(QEMU_ARGS_EXTRA)

     # OUTPUT is only set when run from the main makefile, otherwise
     # it defaults to this nolibc directory.
    @@ -87,11 +87,18 @@ endif
     CFLAGS_riscv32 = -march=rv32im -mabi=ilp32
     CFLAGS_s390 = -m64
     CFLAGS_STACKPROTECTOR ?= $(call cc-option,-mstack-protector-guard=global $(call cc-option,-fstack-protector-all))
    -CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 \
    +CFLAGS_default := -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 \
                    $(call cc-option,-fno-stack-protector) \
                    $(CFLAGS_$(ARCH)) $(CFLAGS_STACKPROTECTOR)
    +
    +CFLAGS  ?= $(CFLAGS_default)

Thanks a lot, will send v4 later.

Best regards,
Zhangjin

> Ok, agree very much, it is the root cause why we used the old method
> before, because I don't want to touch the top-level Makefile, here
> explains the details again just as did for Thomas and Willy [1] ;-)
>
> Without the top-level makefile change, we must add something in
> selftests/nolibc/Makefile like this, because the kernel makefile doesn't
> accept something like ARCH=riscv32 and ARCH=riscv64 currently, it only
> accepts ARCH=riscv (will paste the code later).
>
>     ifneq ($(findstring riscv,$(ARCH)),)
>       _ARCH = riscv
>     else
>       _ARCH = $(ARCH)
>     endif
>
>     ...
>
>     sysroot/$(ARCH)/include:
> 	$(Q)rm -rf sysroot/$(ARCH) sysroot/sysroot
> 	$(QUIET_MKDIR)mkdir -p sysroot
> 	$(Q)$(MAKE) -C ../../../include/nolibc ARCH=$(_ARCH) OUTPUT=$(CURDIR)/sysroot/ headers_standalone
> 	$(Q)mv sysroot/sysroot sysroot/$(ARCH)
>
>     defconfig:
>     	$(Q)$(MAKE) -C $(srctree) ARCH=$(_ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare
>
>     kernel: initramfs
>     	$(Q)$(MAKE) -C $(srctree) ARCH=$(_ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME) CONFIG_INITRAMFS_SOURCE=$(CURDIR)/initramfs
>
> The above change really works, but it looks not that good, this is the
> mixing use of _ARCH and ARCH I mentioned in last reply.
>
> Otherwise, we will get such error:
>
>     $ make run ARCH=riscv64 CROSS_COMPILE=riscv64-linux-gnu-
>       MKDIR   sysroot/riscv64/include
>     make[1]: Entering directory '/labs/linux-lab/src/linux-stable/tools/include/nolibc'
>     make[2]: Entering directory '/labs/linux-lab/src/linux-stable'
>     Makefile:763: arch/riscv64/Makefile: No such file or directory
>     make[2]: *** No rule to make target 'arch/riscv64/Makefile'.  Stop.
>     make[2]: Leaving directory '/labs/linux-lab/src/linux-stable'
>     make[1]: *** [Makefile:87: headers_standalone] Error 2
>     make[1]: Leaving directory '/labs/linux-lab/src/linux-stable/tools/include/nolibc'
>     make: *** [Makefile:129: sysroot/riscv64/include] Error 2
>     $ make run ARCH=riscv32 CROSS_COMPILE=riscv64-linux-gnu-
>       MKDIR   sysroot/riscv32/include
>     make[1]: Entering directory '/labs/linux-lab/src/linux-stable/tools/include/nolibc'
>     make[2]: Entering directory '/labs/linux-lab/src/linux-stable'
>     Makefile:763: arch/riscv32/Makefile: No such file or directory
>     make[2]: *** No rule to make target 'arch/riscv32/Makefile'.  Stop.
>     make[2]: Leaving directory '/labs/linux-lab/src/linux-stable'
>     make[1]: *** [Makefile:87: headers_standalone] Error 2
>     make[1]: Leaving directory '/labs/linux-lab/src/linux-stable/tools/include/nolibc'
>     make: *** [Makefile:129: sysroot/riscv32/include] Error 2
>
> That's because in top-level Makefile, it doesn't accept ARCH=riscv32 and
> ARCH=riscv64, but x86 and sparc and even parisc support such variants,
> this allows the ARCH variants share the same arch/<SRCARCH>/ source code
> tree, otherwise, they will directly find the arch/<ARCH>/ source code,
> then fails.
>
>     top-level Makefile:
>
>     ...
>     ARCH            ?= $(SUBARCH)
>
>     # Architecture as present in compile.h
>     UTS_MACHINE     := $(ARCH)
>     SRCARCH         := $(ARCH)   ---> SRCARCH is assigned as ARCH by default
>
>     # Additional ARCH settings for x86
>     ifeq ($(ARCH),i386)
>             SRCARCH := x86
>     endif
>     ifeq ($(ARCH),x86_64)
>             SRCARCH := x86
>     endif
>
>     # Additional ARCH settings for sparc
>     ifeq ($(ARCH),sparc32)
>            SRCARCH := sparc
>     endif
>     ifeq ($(ARCH),sparc64)
>            SRCARCH := sparc
>     endif
>
>     # Additional ARCH settings for parisc
>     ifeq ($(ARCH),parisc64)
>            SRCARCH := parisc
>     endif
>
> So, to really align with x86, we should let the top-level makefile be
> able to get the right SRCARCH for riscv32 and riscv64 too ;-)
>
> I even tried to pass SRCARCH=riscv to the top-level Makefile, but it
> failed:
>
>     diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
>     index 1b2247a6365d..04067776b569 100644
>     --- a/tools/testing/selftests/nolibc/Makefile
>     +++ b/tools/testing/selftests/nolibc/Makefile
>     @@ -14,6 +14,10 @@ include $(srctree)/scripts/subarch.include
>      ARCH = $(SUBARCH)
>      endif
>
>     +ifneq ($(findstring riscv,$(ARCH)),)
>     +SRCARCH := SRCARCH=riscv
>     +endif
>     +
>      # kernel image names by architecture
>      IMAGE_i386       = arch/x86/boot/bzImage
>      IMAGE_x86_64     = arch/x86/boot/bzImage
>     @@ -126,7 +130,7 @@ sysroot: sysroot/$(ARCH)/include
>      sysroot/$(ARCH)/include:
>             $(Q)rm -rf sysroot/$(ARCH) sysroot/sysroot
>             $(QUIET_MKDIR)mkdir -p sysroot
>     -       $(Q)$(MAKE) -C ../../../include/nolibc ARCH=$(ARCH) OUTPUT=$(CURDIR)/sysroot/ headers_standalone
>     +       $(Q)$(MAKE) -C ../../../include/nolibc ARCH=$(ARCH) $(SRCARCH) OUTPUT=$(CURDIR)/sysroot/ headers_standalone
>             $(Q)mv sysroot/sysroot sysroot/$(ARCH)
>
>      nolibc-test: nolibc-test.c sysroot/$(ARCH)/include
>     @@ -150,10 +154,10 @@ initramfs: nolibc-test
>             $(Q)cp nolibc-test initramfs/init
>
>      defconfig:
>     -       $(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare
>     +       $(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) $(SRCARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare
>
>      kernel: initramfs
>     -       $(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME) CONFIG_INITRAMFS_SOURCE=$(CURDIR)/initramfs
>     +       $(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) $(SRCARCH )CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME) CONFIG_INITRAMFS_SOURCE=$(CURDIR)/initramfs
>
>      # run the tests after building the kernel
>      run: kernel
>
>     $ make run ARCH=riscv32 CROSS_COMPILE=riscv64-linux-gnu- QEMU_ARGS_EXTRA="-bios /labs/linux-lab/opensbi-riscv32-generic-fw_dynamic.bin"
>       MKDIR   sysroot/riscv32/include
>     make[1]: Entering directory '/labs/linux-lab/src/linux-stable/tools/include/nolibc'
>     make[2]: Entering directory '/labs/linux-lab/src/linux-stable'
>     Makefile:397: srcarch: riscv
>     make[2]: Leaving directory '/labs/linux-lab/src/linux-stable'
>     make[2]: Entering directory '/labs/linux-lab/src/linux-stable'
>     Makefile:397: srcarch: riscv
>       INSTALL /labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc/sysroot/sysroot/include
>     make[2]: Leaving directory '/labs/linux-lab/src/linux-stable'
>     make[1]: Leaving directory '/labs/linux-lab/src/linux-stable/tools/include/nolibc'
>       CC      nolibc-test
>       MKDIR   initramfs
>       INSTALL initramfs/init
>     make[1]: Entering directory '/labs/linux-lab/src/linux-stable'
>     Makefile:397: srcarch: riscv32
>       SYNC    include/config/auto.conf.cmd
>     Makefile:397: srcarch: riscv32
>     Makefile:687: arch/riscv32/Makefile: No such file or directory
>     make[2]: *** No rule to make target 'arch/riscv32/Makefile'.  Stop.
>     make[1]: *** [Makefile:795: include/config/auto.conf.cmd] Error 2
>     make[1]: Leaving directory '/labs/linux-lab/src/linux-stable'
>
> So, to keep consistent eventually, perhaps we do need to touch the
> top-level Makefile.
>
> Best regards,
> Zhangjin
>
> [1]: https://lore.kernel.org/linux-riscv/20230526092029.149351-1-falcon@tinylab.org/
>
> >     Arnd
