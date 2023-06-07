Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24EC7252C3
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jun 2023 06:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbjFGEVl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jun 2023 00:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234126AbjFGEVT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jun 2023 00:21:19 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB106273A;
        Tue,  6 Jun 2023 21:18:13 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 3574HDVJ030768;
        Wed, 7 Jun 2023 06:17:13 +0200
Date:   Wed, 7 Jun 2023 06:17:13 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, thomas@t-8ch.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 3/3] selftests/nolibc: riscv: customize makefile for
 rv32
Message-ID: <ZIAEybZdXywKv43C@1wt.eu>
References: <20230606120755.548017-1-falcon@tinylab.org>
 <20230607012032.585223-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607012032.585223-1-falcon@tinylab.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On Wed, Jun 07, 2023 at 09:20:32AM +0800, Zhangjin Wu wrote:
> Arnd, Thomas, Willy
> 
> > > >     +# Additional ARCH settings for riscv
> > > >     +ifeq ($(ARCH),riscv32)
> > > >     +        SRCARCH := riscv
> > > >     +endif
> > > >     +ifeq ($(ARCH),riscv64)
> > > >     +        SRCARCH := riscv
> > > >     +endif
> > > >     +
> > > >      export cross_compiling :=
> > > >      ifneq ($(SRCARCH),$(SUBARCH))
> > > >      cross_compiling := 1
> > >
> > > I've never been a big fan of the top-level $(ARCH) setting
> > > in the kernel, is there a reason this has to be the same
> > > as the variable in tools/include/nolibc? If not, I'd just
> > > leave the Linux Makefile unchanged.
> > >
> > > For userspace we have a lot more target names than
> > > arch/*/ directories in the kernel, and I don't think
> > > I'd want to enumerate all the possibilities in the
> > > build system globally.

Actually it's not exactly used by nolibc, except to pass to the kernel
for the install part to extract kernel headers (make headers_install).
It's one of the parts that has required to stick to most of the kernel's
variables very closely (the other one being for nolibc-test which needs
to build a kernel).

> Good news, I did find a better solution without touching the top-level
> Makefile, that is overriding the ARCH to 'riscv' just before the targets
> and after we got the necessary settings with the original ARCH=riscv32
> or ARCH=riscv64, but it requires to convert the '=' assignments to ':=',
> which is not that hard to do and it is more acceptable, just verified it
> and it worked well.
> 
>     ...
> 
>      LDFLAGS := -s
> 
>     +# top-level kernel Makefile only accept ARCH=riscv, override ARCH to make kernel happy
>     +ifneq ($(findstring riscv,$(ARCH)),)
>     +override ARCH := riscv
>     +endif
>     +

That can be one approach indeed. Another one if we continue to face
difficulties for this one would be to use a distinct KARCH variable
to assign to ARCH in all kernel-specific operations.

>      help:
>             @echo "Supported targets under selftests/nolibc:"
>             @echo "  all          call the \"run\" target below"
> 
> This change is not that big, and the left changes can keep consistent with the
> other platforms. but I still need to add a standalone patch to convert the '='
> to ':=' to avoid the before setting using our new overridded ARCH.

I don't even see why the other ones below are needed, given that as
long as they remain assigned as macros, they will be replaced in-place
where they are used, so they will reference the last known assignment
to ARCH.

>     ++ b/tools/testing/selftests/nolibc/Makefile
>     @@ -26,7 +26,7 @@ IMAGE_riscv64    = arch/riscv/boot/Image
>      IMAGE_riscv      = arch/riscv/boot/Image
>      IMAGE_s390       = arch/s390/boot/bzImage
>      IMAGE_loongarch  = arch/loongarch/boot/vmlinuz.efi
>     -IMAGE            = $(IMAGE_$(ARCH))
>     +IMAGE           := $(IMAGE_$(ARCH))
>      IMAGE_NAME       = $(notdir $(IMAGE))
> 
>      # default kernel configurations that appear to be usable
>     @@ -41,7 +41,7 @@ DEFCONFIG_riscv64    = defconfig
>      DEFCONFIG_riscv      = defconfig
>      DEFCONFIG_s390       = defconfig
>      DEFCONFIG_loongarch  = defconfig
>     -DEFCONFIG            = $(DEFCONFIG_$(ARCH))
>     +DEFCONFIG           := $(DEFCONFIG_$(ARCH))
> 
>      # optional tests to run (default = all)
>      TEST =
>     @@ -58,7 +58,7 @@ QEMU_ARCH_riscv64    = riscv64
>      QEMU_ARCH_riscv      = riscv64
>      QEMU_ARCH_s390       = s390x
>      QEMU_ARCH_loongarch  = loongarch64
>     -QEMU_ARCH            = $(QEMU_ARCH_$(ARCH))
>     +QEMU_ARCH           := $(QEMU_ARCH_$(ARCH))
> 
>      # QEMU_ARGS : some arch-specific args to pass to qemu
>      QEMU_ARGS_i386       = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(TEST:%=NOLIBC_TEST=%)"
>     @@ -72,7 +72,7 @@ QEMU_ARGS_riscv64    = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_T
>      QEMU_ARGS_riscv      = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
>      QEMU_ARGS_s390       = -M s390-ccw-virtio -m 1G -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
>      QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
>     -QEMU_ARGS            = $(QEMU_ARGS_$(ARCH)) $(QEMU_ARGS_EXTRA)
>     +QEMU_ARGS           := $(QEMU_ARGS_$(ARCH)) $(QEMU_ARGS_EXTRA)
> 
>      # OUTPUT is only set when run from the main makefile, otherwise
>      # it defaults to this nolibc directory.
>     @@ -87,11 +87,18 @@ endif
>      CFLAGS_riscv32 = -march=rv32im -mabi=ilp32
>      CFLAGS_s390 = -m64
>      CFLAGS_STACKPROTECTOR ?= $(call cc-option,-mstack-protector-guard=global $(call cc-option,-fstack-protector-all))
>     -CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 \
>     +CFLAGS_default := -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 \
>                     $(call cc-option,-fno-stack-protector) \
>                     $(CFLAGS_$(ARCH)) $(CFLAGS_STACKPROTECTOR)
>     +
>     +CFLAGS  ?= $(CFLAGS_default)

Why did you need to split this one like this instead of proceeding
like for the other ones ? Because of the "?=" maybe ? Please
double-check that you really need to turn this from a macro to a
variable, if as I suspect it it's not needed, it would be even
simpler.

Thanks,
Willy
