Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CD7724093
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 13:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjFFLMi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 07:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjFFLMh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 07:12:37 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7301E9E;
        Tue,  6 Jun 2023 04:12:33 -0700 (PDT)
X-QQ-mid: bizesmtp64t1686049941tvjrfox8
Received: from linux-lab-host.localdomain ( [61.141.77.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 06 Jun 2023 19:12:20 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: jGGC4gWX7WGiyxZFST6mYk2LI09TK5ikUO8A+xhGsS8XBORF7YrkbrWG7KTah
        KT0EeQC26ai1k/jDdHO21eldP321stPsrG9QitYblYJWOkZ9LGrOWikH3KMmf1EBT2tcXgR
        5aK9y54nKiQ8Zws54tm6EGk7M9t4qnmF0a+DdkStPjBBHXVpUM5E6Z8xlRworlzvY1hwcAM
        39YT9yzGelHvOt+1+uczcBIPlhoC94ZHkkQMWED+38iVuaS+ytGSvvOlHrAfVqm7GCxfcah
        ooixHWb+m+f8X7R4tj9B1MTtj0MhJkf/0QjJzBttAZNFtQVKGMRSoEhcn8xuthRCDVOwUOJ
        f5AL/3ROjzTeTPv3YS1zK2fo4sDtPHkWtmhQTYA+UxBvJntYk+lhSaCv2LJwjBaHJSxqA5H
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3071599484531106158
From:   Zhangjin Wu <falcon@tinylab.org>
To:     arnd@arndb.de, thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 3/3] selftests/nolibc: riscv: customize makefile for rv32
Date:   Tue,  6 Jun 2023 19:12:16 +0800
Message-Id: <20230606111216.524384-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <d1c83340-af4c-4780-a101-b9d22b47379c@app.fastmail.com>
References: <d1c83340-af4c-4780-a101-b9d22b47379c@app.fastmail.com>
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

> On Sat, Jun 3, 2023, at 11:05, Zhangjin Wu wrote:
> > Both riscv64 and riscv32 have:
> >
> > * the same ARCH value, it is riscv
> > * the same arch/riscv source code tree
> >
> > The only differences are:
> >
> > * riscv64 uses defconfig, riscv32 uses rv32_defconfig
> > * riscv64 uses qemu-system-riscv64, riscv32 uses qemu-system-riscv32
> > * riscv32 has different compiler options (-march= and -mabi=)
> >
> > So, riscv32 can share most of the settings with riscv64, there is no
> > need to add it as a whole new architecture but just need a flag to
> > record and reflect the difference.
> >
> > The 32bit mips and loongarch may be able to use the same method, so,
> > let's use a meaningful flag: CONFIG_32BIT. If required in the future,
> > this flag can also be automatically loaded from
> > include/config/auto.conf.
>
> If we use a CONFIG_* symbol, I think it should be the other way
> round, for consistency with the kernel, which uses CONFIG_64BIT
> on all architectures, but only uses CONFIG_32BIT on mips, loongarch
> powerpc and riscv.
>
>
> >  # kernel image names by architecture
> >  IMAGE_i386       = arch/x86/boot/bzImage
> >  IMAGE_x86_64     = arch/x86/boot/bzImage
> > @@ -34,7 +40,7 @@ DEFCONFIG_x86        = defconfig
> >  DEFCONFIG_arm64      = defconfig
> >  DEFCONFIG_arm        = multi_v7_defconfig
> >  DEFCONFIG_mips       = malta_defconfig
> > -DEFCONFIG_riscv      = defconfig
> > +DEFCONFIG_riscv      = $(if $(CONFIG_32BIT),rv32_defconfig,defconfig)
> >  DEFCONFIG_s390       = defconfig
> >  DEFCONFIG_loongarch  = defconfig
> >  DEFCONFIG            = $(DEFCONFIG_$(ARCH))
>
> This feels slightly odd, as we otherwise have a fixed defconfig
> per target, so doing
>
> DEFCONFIG_riscv      = defconfig
> DEFCONFIG_riscv64    = defconfig
> DEFCONFIG_riscv32    = rv32_defconfig
>
> would seem more consistent with how x86 is handled, and would
> probably be more easily extensible if we want to also make
> this work with other sub-targets like mipseb, armv5 or ppc32
> in the future.

As Arnd and Thomas suggested to align with x86, I just tried to find a
solution to avoid mixing the use of _ARCH and ARCH in this Makefile.

Since both riscv32 and riscv64 share the same SRCARCH=riscv (arch/riscv),
and the kernel side doesn't accept riscv32 or riscv64 currently, we need to
manually convert them to _ARCH=riscv and pass them to the kernel makefile
like this: ARCH=$(_ARCH), it mixes the use of _ARCH and ARCH, this is why I
used the '$(if' method currently.

The solution is adding something like x86 in the kernel Makefile:

    diff --git a/Makefile b/Makefile
    index 9d765ebcccf1..a442c893d795 100644
    --- a/Makefile
    +++ b/Makefile
    @@ -415,6 +415,14 @@ ifeq ($(ARCH),parisc64)
            SRCARCH := parisc
     endif

    +# Additional ARCH settings for riscv
    +ifeq ($(ARCH),riscv32)
    +        SRCARCH := riscv
    +endif
    +ifeq ($(ARCH),riscv64)
    +        SRCARCH := riscv
    +endif
    +
     export cross_compiling :=
     ifneq ($(SRCARCH),$(SUBARCH))
     cross_compiling := 1

And also, we need to let both of them use the arch-riscv.h in
tools/include/nolibc/Makefile:

    diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
    index 64d67b080744..459eaddb230f 100644
    --- a/tools/include/nolibc/Makefile
    +++ b/tools/include/nolibc/Makefile
    @@ -24,6 +24,7 @@ Q=@
     endif

     nolibc_arch := $(patsubst arm64,aarch64,$(ARCH))
    +nolibc_arch := $(patsubst riscv%,riscv,$(ARCH))
     arch_file := arch-$(nolibc_arch).h
     all_files := \
                    compiler.h \

So, the left parts can be added like x86 too:

    diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
    index 4a3a105e1fdf..1b2247a6365d 100644
    --- a/tools/testing/selftests/nolibc/Makefile
    +++ b/tools/testing/selftests/nolibc/Makefile
    @@ -21,6 +21,8 @@ IMAGE_x86        = arch/x86/boot/bzImage
     IMAGE_arm64      = arch/arm64/boot/Image
     IMAGE_arm        = arch/arm/boot/zImage
     IMAGE_mips       = vmlinuz
    +IMAGE_riscv32    = arch/riscv/boot/Image
    +IMAGE_riscv64    = arch/riscv/boot/Image
     IMAGE_riscv      = arch/riscv/boot/Image
     IMAGE_s390       = arch/s390/boot/bzImage
     IMAGE_loongarch  = arch/loongarch/boot/vmlinuz.efi
    @@ -34,6 +36,8 @@ DEFCONFIG_x86        = defconfig
     DEFCONFIG_arm64      = defconfig
     DEFCONFIG_arm        = multi_v7_defconfig
     DEFCONFIG_mips       = malta_defconfig
    +DEFCONFIG_riscv32    = rv32_defconfig
    +DEFCONFIG_riscv64    = defconfig
     DEFCONFIG_riscv      = defconfig
     DEFCONFIG_s390       = defconfig
     DEFCONFIG_loongarch  = defconfig
    @@ -49,6 +53,8 @@ QEMU_ARCH_x86        = x86_64
     QEMU_ARCH_arm64      = aarch64
     QEMU_ARCH_arm        = arm
     QEMU_ARCH_mips       = mipsel  # works with malta_defconfig
    +QEMU_ARCH_riscv32    = riscv32
    +QEMU_ARCH_riscv64    = riscv64
     QEMU_ARCH_riscv      = riscv64
     QEMU_ARCH_s390       = s390x
     QEMU_ARCH_loongarch  = loongarch64
    @@ -61,6 +67,8 @@ QEMU_ARGS_x86        = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(
     QEMU_ARGS_arm64      = -M virt -cpu cortex-a53 -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
     QEMU_ARGS_arm        = -M virt -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
     QEMU_ARGS_mips       = -M malta -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
    +QEMU_ARGS_riscv32    = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
    +QEMU_ARGS_riscv64    = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
     QEMU_ARGS_riscv      = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
     QEMU_ARGS_s390       = -M s390-ccw-virtio -m 1G -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
     QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
    @@ -76,6 +84,7 @@ else
     Q=@
     endif

    +CFLAGS_riscv32 = -march=rv32im -mabi=ilp32
     CFLAGS_s390 = -m64
     CFLAGS_STACKPROTECTOR ?= $(call cc-option,-mstack-protector-guard=global $(call cc-option,-fstack-protector-all))
     CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 \

And just found the 'm' extension (-march=rv32im) is necessary to avoid linking
libgcc, especially, my local compiler has no rv32 libgcc (target emulation
`elf64-littleriscv' does not match `elf32-littleriscv'), so, added the 'm'
extension back, this is supported by the generic riscv chips. The atomic and
float extensions (include single and double) are not added, keep it as minimal
currently.

Just tested rv32 and rv64 on 20230606-nolibc-rv32+stkp7a with a trivial fixup
of rcu (the problematic code is not in v6.4-rc4, so, this can be ignored, see
below, what about rebase the new branch on a newer rc?), it works as expected.

    diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
    index ce02bb09651b..72bd8fe0cad6 100644
    --- a/kernel/rcu/tasks.h
    +++ b/kernel/rcu/tasks.h
    @@ -1934,11 +1934,13 @@ void show_rcu_tasks_gp_kthreads(void)
     }
     #endif /* #ifndef CONFIG_TINY_RCU */

    +#ifdef CONFIG_TASKS_RCU
     struct task_struct *get_rcu_tasks_gp_kthread(void)
     {
            return rcu_tasks.kthread_ptr;
     }
     EXPORT_SYMBOL_GPL(get_rcu_tasks_gp_kthread);
    +#endif

     #ifdef CONFIG_PROVE_RCU
     struct rcu_tasks_test_desc {

The steps I tested:

    $ history | grep make
     // riscv32 test
     1416  make defconfig ARCH=riscv32 CROSS_COMPILE=riscv64-linux-gnu-
     1430  make run ARCH=riscv32 CROSS_COMPILE=riscv64-linux-gnu- QEMU_ARGS_EXTRA="-bios /labs/linux-lab/opensbi-riscv32-generic-fw_dynamic.bin"
     1438  make run-user ARCH=riscv32 CROSS_COMPILE=riscv64-linux-gnu-
           113 test(s) passed, 3 skipped, 22 failed. See all results in /labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc/run.out

     // riscv64 test (old options)
     1432  make defconfig ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu-
     1433  make run ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu-
     1443  make run-user ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu-
           135 test(s) passed, 3 skipped, 0 failed. See all results in /labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc/run.out

     // riscv64 test (new options)
     1441  make run ARCH=riscv64 CROSS_COMPILE=riscv64-linux-gnu-
     1439  make run-user ARCH=riscv64 CROSS_COMPILE=riscv64-linux-gnu-

Thanks Arnd and Thomas for your persistence, If you agree, will send this as a
new revision.

@Willy, I plan to send v4 immediately, since the first two has not been
merged yet, so, I will send them together as v4.

Best regards,
Zhangjin

>
>      Arnd
