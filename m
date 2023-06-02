Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAEF71F91D
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 06:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbjFBEIg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 00:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjFBEIf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 00:08:35 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B05128;
        Thu,  1 Jun 2023 21:08:32 -0700 (PDT)
X-QQ-mid: bizesmtp85t1685678786t4wn6335
Received: from linux-lab-host.localdomain ( [119.123.130.226])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 02 Jun 2023 12:06:25 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: BYUemv+qiN00SL9J7hzmONdu3OZstgKNbrJCS/RRwXSBpL7bT/bRmqMRkg8CW
        Ub97Boxh6WfawPQfsJhqZEI6F6nZCq6cTRpbyRS8BJWRqrq39Vw1bAp9JdnBRm+ABFCnEbE
        1yR48jc2hx1tooPYIMDmTEihsV386Mq8NrkyPMqm/HO0fooBT/+XhamhDgH3NvkF0jY1BgQ
        0wxDHC1iiVtUr9tDMXIDCamjBfFm/TrM2IhBFaFEBZ+Uiks7HIp7ojQ9UGeWdSCCGuKjCz2
        BCuOaFXSWkIrZhUPm2CQCjLGOiyMCixD//jSlCrcStjvY4g3cWlk/rXEPx0vzqsqDsKqD9p
        DfAqQ2S8CkI1XvMwTB6/cgeUleZYbvQE+Bf7dGy6h9igC15u98XtBJ1LnaNig==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2670584436313738676
From:   Zhangjin Wu <falcon@tinylab.org>
To:     arnd@arndb.de, thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v2 13/13] selftests/nolibc: riscv: customize makefile for rv32
Date:   Fri,  2 Jun 2023 12:06:25 +0800
Message-Id: <20230602040625.24373-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <6f065441a6be9e63238ffb3d43cf09a6e4ac6773.1685387485.git.falcon@tinylab.org>
References: <6f065441a6be9e63238ffb3d43cf09a6e4ac6773.1685387485.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_PBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Willy, Arnd and Thomas

Based on your suggestions, in the comming v3, I plan to split the whole rv32
support to something like this:

1. Generic part1

   (The old feedbacks are applied with the new Suggested-by lines, welcome your
    additional feedbacks if there are ;-))

    selftests/nolibc: syscall_args: use generic __NR_statx
    tools/nolibc: add missing nanoseconds support for __NR_statx
    selftests/nolibc: allow specify extra arguments for qemu
    selftests/nolibc: fix up compile warning with glibc on x86_64
    selftests/nolibc: not include limits.h for nolibc
    selftests/nolibc: use INT_MAX instead of __INT_MAX__
    tools/nolibc: arm: add missing my_syscall6
    tools/nolibc: open: fix up compile warning for arm
    selftests/nolibc: support two errnos with EXPECT_SYSER2()
    selftests/nolibc: remove gettimeofday_bad1/2 completely
    selftests/nolibc: add new gettimeofday test cases

2. Add Compile support for rv32

   (Convert all of the unsupported syscalls to a return of -ENOSYS, this
    allows us to fix up the test failures one by one not that urgently later)

    tools/nolibc: fix up #error compile failures with -ENOSYS
    tools/nolibc: fix up undeclared syscall macros with #ifdef and -ENOSYS
    selftests/nolibc: riscv: customize makefile for rv32

   (The first two are new but clear enough, based on the idea of suggestion from Arnd [1])

3. Fix up the left test failures one by one

   (Plan to add everyone as a standalone patchset, which will easier the review
    and merge progress)

   wait4 -> waitid
   lseek -> llseek
   gettimeofday -> clock_gettime/clock_gettime64
   select -> pselect6/pselect6_time64
   ppoll -> ppoll_time64

4. Clean up some old test cases one by one

   Like statx ...

Best regards,
Zhangjin

[1]: https://lore.kernel.org/linux-riscv/5e7d2adf-e96f-41ca-a4c6-5c87a25d4c9c@app.fastmail.com/

> Both riscv64 and riscv32 have:
> 
> * the same ARCH value, it is riscv
> * the same arch/riscv source code tree
> 
> The only differences are:
> 
> * riscv64 uses defconfig, riscv32 uses rv32_defconfig
> * riscv64 uses qemu-system-riscv64, riscv32 uses qemu-system-riscv32
> * riscv32 has different compiler options (-march= and -mabi=)
> 
> So, riscv32 can share most of the settings with riscv64, there is no
> need to add it as a whole new architecture but just need a flag to
> record and reflect the difference.
> 
> The 32bit mips and loongarch may be able to use the same method, so,
> let's use a meaningful flag: CONFIG_32BIT. If required in the future,
> this flag can also be automatically loaded from
> include/config/auto.conf.
> 
> With this patch, it is able to run nolibc test for rv32 like this:
> 
>     $ make run ARCH=riscv32 CROSS_COMPILE=riscv64-linux-gnu- ...
> 
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> ---
>  tools/testing/selftests/nolibc/Makefile | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> index 44088535682e..ea434a0acdc1 100644
> --- a/tools/testing/selftests/nolibc/Makefile
> +++ b/tools/testing/selftests/nolibc/Makefile
> @@ -14,6 +14,12 @@ include $(srctree)/scripts/subarch.include
>  ARCH = $(SUBARCH)
>  endif
>  
> +# Allow pass ARCH=riscv|riscv32|riscv64, riscv implies riscv64
> +ifneq ($(findstring xriscv,x$(ARCH)),)
> +  CONFIG_32BIT := $(if $(findstring 32x,$(ARCH)x),1)
> +  override ARCH := riscv
> +endif
> +
>  # kernel image names by architecture
>  IMAGE_i386       = arch/x86/boot/bzImage
>  IMAGE_x86_64     = arch/x86/boot/bzImage
> @@ -34,7 +40,7 @@ DEFCONFIG_x86        = defconfig
>  DEFCONFIG_arm64      = defconfig
>  DEFCONFIG_arm        = multi_v7_defconfig
>  DEFCONFIG_mips       = malta_defconfig
> -DEFCONFIG_riscv      = defconfig
> +DEFCONFIG_riscv      = $(if $(CONFIG_32BIT),rv32_defconfig,defconfig)
>  DEFCONFIG_s390       = defconfig
>  DEFCONFIG_loongarch  = defconfig
>  DEFCONFIG            = $(DEFCONFIG_$(ARCH))
> @@ -49,7 +55,7 @@ QEMU_ARCH_x86        = x86_64
>  QEMU_ARCH_arm64      = aarch64
>  QEMU_ARCH_arm        = arm
>  QEMU_ARCH_mips       = mipsel  # works with malta_defconfig
> -QEMU_ARCH_riscv      = riscv64
> +QEMU_ARCH_riscv      = $(if $(CONFIG_32BIT),riscv32,riscv64)
>  QEMU_ARCH_s390       = s390x
>  QEMU_ARCH_loongarch  = loongarch64
>  QEMU_ARCH            = $(QEMU_ARCH_$(ARCH))
> @@ -76,6 +82,7 @@ else
>  Q=@
>  endif
>  
> +CFLAGS_riscv = $(if $(CONFIG_32BIT),-march=rv32i -mabi=ilp32)
>  CFLAGS_s390 = -m64
>  CFLAGS_STACKPROTECTOR ?= $(call cc-option,-mstack-protector-guard=global $(call cc-option,-fstack-protector-all))
>  CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 \
> -- 
> 2.25.1

