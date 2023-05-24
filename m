Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC95D70FDD0
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 20:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbjEXSYo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 14:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjEXSYn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 14:24:43 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC5C98;
        Wed, 24 May 2023 11:24:37 -0700 (PDT)
X-QQ-mid: bizesmtp69t1684952672t698hafw
Received: from linux-lab-host.localdomain ( [116.30.125.36])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 25 May 2023 02:24:31 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000B00A0000000
X-QQ-FEAT: hoArX50alxH37NI6MC4teOjwrHk5Adj5XXOQN+5eQDj9V22hwZ8jqWyiUtxA5
        AtMEzlAotcG750fbU9HuGHTGJ56UY8lM9FmZSCQkAMcZMsP6eXxZhzPIjT1nuS1puOd1MiG
        9f/gfYZfoJ4SRpsJRyYa/sLNHVAT91JFtpeFZSnhAzZvAMZuXxDyYX/hamKYykBfDyazG4/
        KldvQ15aEPjBVe4Fr126ZAVKh+pTgpDrCGOK0A+en3nF/FBFlB87hO6EhMD/X1113EQ23TI
        qCNvT9CuatHqG3DOV4fAeEaguqFd+e/IMBEnFIQYR3s/2anYXenr2NN7Y1bdTnPq9xafXGs
        NCVN7seoPYwqpCeJuNvJdI9V5Z2lH9nvPU9p/f3/xYHThZVkq0zCyiVpx3UanusCsIBJXOj
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7505605221969730643
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, thomas@t-8ch.de
Subject: Re: [PATCH 00/13] tools/nolibc: riscv: Add full rv32 support
Date:   Thu, 25 May 2023 02:24:31 +0800
Message-Id: <20230524182431.268908-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1684949267.git.falcon@tinylab.org>
References: <cover.1684949267.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

Just to mention, the 3rd one is missing in the riscv-linux mailing list
[1], but it is ok in the other two [2], [3], it was sent with the same
command ;-(

[1]: https://lore.kernel.org/linux-riscv/cover.1684949267.git.falcon@tinylab.org/T/#m1c2c31ec2f5dfafc7d0067a1e5fe430d591d74b8
[2]: https://lore.kernel.org/lkml/cover.1684949267.git.falcon@tinylab.org/T/#m1c2c31ec2f5dfafc7d0067a1e5fe430d591d74b8
[3]: https://lore.kernel.org/linux-kselftest/cover.1684949267.git.falcon@tinylab.org/T/#t

If required, do we need to resend the 3rd to riscv-linux only?

Thanks,
Zhangjin

> Hi, Willy
> 
> Thanks very mush for your kindly review, discuss and suggestion, now we
> get full rv32 support ;-)
> 
> In the first series [1], we have fixed up the compile errors about
> _start and __NR_llseek for rv32, but left compile errors about tons of
> time32 syscalls (removed after kernel commit d4c08b9776b3 ("riscv: Use
> latest system call ABI")) and the missing fstat in nolibc-test.c [2],
> now we have fixed up all of them.
> 
> Introduction
> ============
> 
> This series is based on the 20230524-nolibc-rv32+stkp4 branch of [3], it
> includes 3 parts, they work together to add full rv32 support:
> 
> * Reverts two old out-of-day patches
>   * Revert "tools/nolibc: riscv: Support __NR_llseek for rv32"
>   * Revert "selftests/nolibc: Fix up compile error for rv32"
> 
>   (these two and the reverted ones:
> 
>     * commit 606343b7478c ("selftests/nolibc: Fix up compile error for rv32") 
>     * commit d2c3acba6d66 ("tools/nolibc: riscv: Support __NR_llseek for rv32")
> 
>   can be removed from the git repo completely, there are two new ones to replace
>   them)
> 
> * Compile and test support patches
>   * selftests/nolibc: print name instead of number for EOVERFLOW
>   * selftests/nolibc: syscall_args: use __NR_statx for rv32
>     * --> replace the old one 606343b7478, use statx instead of read
>   * selftests/nolibc: riscv: customize makefile for rv32
>   * selftests/nolibc: allow specify a bios for qemu
>   * selftests/nolibc: remove the duplicated gettimeofday_bad2
> 
> * Fix up some missing syscalls, mainly time32 syscalls
>   * tools/nolibc: sys_lseek: riscv: use __NR_llseek for rv32
>     * --> replace the old one d2c3acba6d66, cleaned up 
>   * tools/nolibc: sys_poll: riscv: use __NR_ppoll_time64 for rv32
>   * tools/nolibc: ppoll/ppoll_time64: Add a missing argument
>   * tools/nolibc: sys_select: riscv: use __NR_pselect6_time64 for rv32
>   * tools/nolibc: sys_wait4: riscv: use __NR_waitid for rv32
>   * tools/nolibc: sys_gettimeofday: riscv: use __NR_clock_gettime64 for rv32
> 
> Compile
> =======
> 
> For rv64:
> 
>     $ make ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- nolibc-test
>     $ file nolibc-test
>     nolibc-test: ELF 64-bit LSB executable, UCB RISC-V ...
> 
>     $ make ARCH=riscv64 CROSS_COMPILE=riscv64-linux-gnu- nolibc-test
>     $ file nolibc-test
>     nolibc-test: ELF 64-bit LSB executable, UCB RISC-V ...
> 
> For rv32:
> 
>     $ make ARCH=riscv CONFIG_32BIT=1 CROSS_COMPILE=riscv64-linux-gnu- nolibc-test
>     $ file nolibc-test
>     nolibc-test: ELF 32-bit LSB executable, UCB RISC-V ...
> 
>     $ make ARCH=riscv32 CROSS_COMPILE=riscv64-linux-gnu- nolibc-test
>     $ file nolibc-test
>     nolibc-test: ELF 32-bit LSB executable, UCB RISC-V ...
> 
> Testing
> =======
> 
> Environment:
> 
>     // gcc toolchain
>     $ riscv64-linux-gnu-gcc --version
>     riscv64-linux-gnu-gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0
>     Copyright (C) 2019 Free Software Foundation, Inc.
>     This is free software; see the source for copying conditions.  There is NO
>     warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> 
>     // glibc >= 2.33 required, for older glibc, must upgrade include/bits/wordsize.h
>     $ dpkg -l | grep libc6-dev | grep riscv
>     ii  libc6-dev-riscv64-cross                  2.31-0ubuntu7cross1
> 
>     // glibc include/bits/wordsize.h: manually upgraded to >= 2.33
>     // without this, can not build tools/testing/selftests/nolibc/nolibc-test.c
>     $ cat /usr/riscv64-linux-gnu/include/bits/wordsize.h
>     #if __riscv_xlen == (__SIZEOF_POINTER__ * 8)
>     # define __WORDSIZE __riscv_xlen
>     #else
>     # error unsupported ABI
>     #endif
> 
>     # define __WORDSIZE_TIME64_COMPAT32 1
> 
>     #if __WORDSIZE == 32
>     # define __WORDSIZE32_SIZE_ULONG    0
>     # define __WORDSIZE32_PTRDIFF_LONG  0
>     #endif
> 
>     // higher qemu version is better, latest version is v8.0.0+
>     $ qemu-system-riscv64  --version
>     QEMU emulator version 4.2.1 (Debian 1:4.2-3ubuntu6.18)
>     Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers
> 
>     // opensbi version, higher is better, must match kernel version and qemu version
>     // rv64: used version is 1.2, latest is 1.2
>     $ head -2 /labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc/run.out | tail -1
>     OpenSBI v1.2-116-g7919530
>     // rv32: used version is v0.9, latest is 1.2
>     $ head -2 /labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc/run.out | tail -1
>     OpenSBI v0.9-152-g754d511
> 
> For rv64:
> 
>     $ pwd
>     /labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc
>     $ make ARCH=riscv64 CROSS_COMPILE=riscv64-linux-gnu- defconfig
>     $ make ARCH=riscv64 CROSS_COMPILE=riscv64-linux-gnu- BIOS=/labs/linux-lab/boards/riscv64/virt/bsp/bios/opensbi/generic/fw_jump.elf run
>         MKDIR   sysroot/riscv/include
>       make[1]: Entering directory '/labs/linux-lab/src/linux-stable/tools/include/nolibc'
>       make[2]: Entering directory '/labs/linux-lab/src/linux-stable'
>       make[2]: Leaving directory '/labs/linux-lab/src/linux-stable'
>       make[2]: Entering directory '/labs/linux-lab/src/linux-stable'
>         INSTALL /labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc/sysroot/sysroot/include
>       make[2]: Leaving directory '/labs/linux-lab/src/linux-stable'
>       make[1]: Leaving directory '/labs/linux-lab/src/linux-stable/tools/include/nolibc'
>         CC      nolibc-test
>         MKDIR   initramfs
>         INSTALL initramfs/init
>       make[1]: Entering directory '/labs/linux-lab/src/linux-stable'
>         ...
>         LD      vmlinux
>         NM      System.map
>         SORTTAB vmlinux
>         OBJCOPY arch/riscv/boot/Image
>         Kernel: arch/riscv/boot/Image is ready
>       make[1]: Leaving directory '/labs/linux-lab/src/linux-stable'
>       135 test(s) passed.
>     $ file ../../../../vmlinux
>     ../../../../vmlinux: ELF 64-bit LSB executable, UCB RISC-V, version 1 (SYSV), statically linked, BuildID[sha1]=b8e1cea5122b04bce540b4022f0d6f171ffe615a, not stripped
> 
> For rv32:
> 
>     $ pwd
>     /labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc
>     $ make ARCH=riscv32 CROSS_COMPILE=riscv64-linux-gnu- defconfig
>     $ make ARCH=riscv32 CROSS_COMPILE=riscv64-linux-gnu- BIOS=/labs/linux-lab/boards/riscv32/virt/bsp/bios/opensbi/generic/fw_jump.elf run
>           MKDIR   sysroot/riscv/include
>     make[1]: Entering directory '/labs/linux-lab/src/linux-stable/tools/include/nolibc'
>     make[2]: Entering directory '/labs/linux-lab/src/linux-stable'
>     make[2]: Leaving directory '/labs/linux-lab/src/linux-stable'
>     make[2]: Entering directory '/labs/linux-lab/src/linux-stable'
>       INSTALL /labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc/sysroot/sysroot/include
>     make[2]: Leaving directory '/labs/linux-lab/src/linux-stable'
>     make[1]: Leaving directory '/labs/linux-lab/src/linux-stable/tools/include/nolibc'
>       CC      nolibc-test
>       MKDIR   initramfs
>       INSTALL initramfs/init
>     make[1]: Entering directory '/labs/linux-lab/src/linux-stable'
>       CALL    scripts/checksyscalls.sh
>       GEN     usr/initramfs_data.cpio
>       COPY    usr/initramfs_inc_data
>       AS      usr/initramfs_data.o
>       AR      usr/built-in.a
>       GEN     security/selinux/flask.h security/selinux/av_permissions.h
>       CC      security/selinux/avc.o
>       CC      security/selinux/hooks.o
>       CC      security/selinux/selinuxfs.o
>       CC      security/selinux/nlmsgtab.o
>       CC      security/selinux/netif.o
>       CC      security/selinux/netnode.o
>       CC      security/selinux/netport.o
>       CC      security/selinux/status.o
>       CC      security/selinux/ss/services.o
>       AR      security/selinux/built-in.a
>       AR      security/built-in.a
>       AR      built-in.a
>       AR      vmlinux.a
>       LD      vmlinux.o
>       OBJCOPY modules.builtin.modinfo
>       GEN     modules.builtin
>       MODPOST vmlinux.symvers
>       UPD     include/generated/utsversion.h
>       CC      init/version-timestamp.o
>       LD      .tmp_vmlinux.kallsyms1
>       NM      .tmp_vmlinux.kallsyms1.syms
>       KSYMS   .tmp_vmlinux.kallsyms1.S
>       AS      .tmp_vmlinux.kallsyms1.S
>       LD      .tmp_vmlinux.kallsyms2
>       NM      .tmp_vmlinux.kallsyms2.syms
>       KSYMS   .tmp_vmlinux.kallsyms2.S
>       AS      .tmp_vmlinux.kallsyms2.S
>       LD      vmlinux
>       NM      System.map
>       SORTTAB vmlinux
>       OBJCOPY arch/riscv/boot/Image
>       Kernel: arch/riscv/boot/Image is ready
>     make[1]: Leaving directory '/labs/linux-lab/src/linux-stable'
>     135 test(s) passed.
>     $ file ../../../../vmlinux
>     ../../../../vmlinux: ELF 32-bit LSB executable, UCB RISC-V, version 1 (SYSV), statically linked, BuildID[sha1]=bad4c1f3899f47355d2a2010bade56972fd94b9d, not stripped
>  
> The full rv64 testing result (run.out) is uploaded at [4].
> The full rv32 testing result (run.out) is uploaded at [5].
> 
> That's all, thanks!
> 
> Best regards,
> Zhangjin Wu
> ---
> 
> [1]: https://lore.kernel.org/linux-riscv/20230520143154.68663-1-falcon@tinylab.org/T/#mf0e54ee19bd3f94dadbb4420ed9dffa316d1719d
> [2]: https://lore.kernel.org/linux-riscv/20230520135235.68155-1-falcon@tinylab.org/T/#u
> [3]: https://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git
> [4]: https://pastebin.com/3L0nV78u
> [5]: https://pastebin.com/RadrXdta 
> 
> 
> 
> Zhangjin Wu (13):
>   Revert "tools/nolibc: riscv: Support __NR_llseek for rv32"
>   Revert "selftests/nolibc: Fix up compile error for rv32"
>   selftests/nolibc: print name instead of number for EOVERFLOW
>   selftests/nolibc: syscall_args: use __NR_statx for rv32
>   selftests/nolibc: riscv: customize makefile for rv32
>   selftests/nolibc: allow specify a bios for qemu
>   selftests/nolibc: remove the duplicated gettimeofday_bad2
>   tools/nolibc: sys_lseek: riscv: use __NR_llseek for rv32
>   tools/nolibc: sys_poll: riscv: use __NR_ppoll_time64 for rv32
>   tools/nolibc: ppoll/ppoll_time64: Add a missing argument
>   tools/nolibc: sys_select: riscv: use __NR_pselect6_time64 for rv32
>   tools/nolibc: sys_wait4: riscv: use __NR_waitid for rv32
>   tools/nolibc: sys_gettimeofday: riscv: use __NR_clock_gettime64 for
>     rv32
> 
>  tools/include/nolibc/std.h                   |   1 +
>  tools/include/nolibc/sys.h                   | 135 +++++++++++++++++--
>  tools/include/nolibc/types.h                 |  21 ++-
>  tools/testing/selftests/nolibc/Makefile      |  14 +-
>  tools/testing/selftests/nolibc/nolibc-test.c |  15 ++-
>  5 files changed, 167 insertions(+), 19 deletions(-)
> 
> -- 
> 2.25.1
