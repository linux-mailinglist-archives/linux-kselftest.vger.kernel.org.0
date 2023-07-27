Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59771765D18
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 22:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjG0UVw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 16:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjG0UVv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 16:21:51 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B2319BA;
        Thu, 27 Jul 2023 13:21:48 -0700 (PDT)
X-QQ-mid: bizesmtp70t1690489296tws862vv
Received: from linux-lab-host.localdomain ( [61.141.78.189])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 28 Jul 2023 04:21:34 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: LrCnY+iDm+O9BsCx7wECHlZ1cmX5U7VxpBnSEWEJeHuEudDsYPNN+MIzBnrTE
        uMhMJ4/t9cjVkxE4LNm/hm1E/ulnGHHDfmLReKCltns9Ql4FI46jaD1vD9rVsvVa6Xrq840
        f+XEchByXBKe3iV/Xr8BApGk3H/lszaIO2GO9wD/d3RGdYbhEHL4XG/JA02a3m7uu4+pA+i
        GYIqy1IIfUMzLa54eXrPqOjri2Tjkjkw8HXmGFLGV1N/+fLIDTDjw4fscDD304pEy9klmKy
        JXfUmBT/bD9fmsGt0jMBeJMFEHNqhbsnBM+AEUQVgMrr9afZt/leYNroIhkcHgQR8Q+oDJg
        YGvGO/EsnfMXLWKelAmFRGxc7RM2x6UvT1f5NK4
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1905233204736184143
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v3 00/12] selftests/nolibc: add minimal kernel config support - part1
Date:   Fri, 28 Jul 2023 04:21:34 +0800
Message-Id: <cover.1690489039.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
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

Most of the suggestions of v2 [1] have been applied in this v3 revision,
except the local menuconfig and mrproper targets, as explained in [2].

A fresh run with tinyconfig for ppc, ppc64 and ppc64le:

    $ for arch in ppc ppc64 ppc64le; do \
        mkdir -p $PWD/kernel-$arch;
        time make defconfig run DEFCONFIG=tinyconfig ARCH=$arch O=$PWD/kernel-$arch RUN_OUT=$PWD/run.$arch.out;
      done

rerun for ppc, ppc64 and ppc64le:

    $ for arch in ppc ppc64 ppc64le; do \
        make rerun ARCH=$arch O=$PWD/kernel-$arch RUN_OUT=$PWD/run.$arch.out;
      done
    Running /labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc/kernel-ppc/vmlinux on qemu-system-ppc
    >> [ppc] Kernel command line: console=ttyS0 panic=-1 
    printk: console [ttyS0] enabled
    Run /init as init process
    Running test 'startup'
    Running test 'syscall'
    Running test 'stdlib'
    Running test 'vfprintf'
    Running test 'protection'
    Leaving init with final status: 0
    reboot: Power down
    powered off, test finish
    qemu-system-ppc: terminating on signal 15 from pid 190248 ()

    165 test(s): 156 passed,   9 skipped,   0 failed => status: warning

    See all results in /labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc/run.ppc.out
    Running /labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc/kernel-ppc64/vmlinux on qemu-system-ppc64
    Linux version 6.4.0+ (ubuntu@linux-lab) (powerpc64le-linux-gnu-gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0, GNU ld (GNU Binutils for Ubuntu) 2.34) #2 SMP Fri Jul 28 01:40:55 CST 2023
    Kernel command line: console=hvc0 panic=-1 
    printk: console [hvc0] enabled
    printk: console [hvc0] enabled
    Run /init as init process
    Running test 'startup'
    Running test 'syscall'
    Running test 'stdlib'
    Running test 'vfprintf'
    Running test 'protection'
    Leaving init with final status: 0
    reboot: Power down
    powered off, test finish

    165 test(s): 156 passed,   9 skipped,   0 failed => status: warning

    See all results in /labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc/run.ppc64.out
    Running /labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc/kernel-ppc64le/arch/powerpc/boot/zImage on qemu-system-ppc64le
    Linux version 6.4.0+ (ubuntu@linux-lab) (powerpc64le-linux-gnu-gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0, GNU ld (GNU Binutils for Ubuntu) 2.34) #2 SMP Fri Jul 28 01:41:12 CST 2023
    Kernel command line: console=hvc0 panic=-1 
    Run /init as init process
    Running test 'startup'
    Running test 'syscall'
    Running test 'stdlib'
    Running test 'vfprintf'
    Running test 'protection'
    Leaving init with final status: 0
    reboot: Power down
    powered off, test finish

    165 test(s): 156 passed,   9 skipped,   0 failed => status: warning

    See all results in /labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc/run.ppc64le.out

A fast report on existing test logs:

    $ for arch in ppc ppc64 ppc64le; do \
        make report ARCH=$arch RUN_OUT=$PWD/run.$arch.out | grep status; \
      done
    165 test(s): 156 passed,   9 skipped,   0 failed => status: warning
    165 test(s): 156 passed,   9 skipped,   0 failed => status: warning
    165 test(s): 156 passed,   9 skipped,   0 failed => status: warning

Changes from v2 --> v3:

* selftests/nolibc: allow report with existing test log
  selftests/nolibc: fix up O= option support
  selftests/nolibc: allow customize CROSS_COMPILE by architecture
  selftests/nolibc: customize CROSS_COMPILE for 32/64-bit powerpc
  selftests/nolibc: tinyconfig: add extra common options

    No Change.

* selftests/nolibc: add macros to reduce duplicated changes

    Remove REPORT_RUN_OUT and LOG_OUT.

* selftests/nolibc: string the core targets

    Removed extconfig target from our v3 powerpc patchset [3], the
    operations have been merged into the defconfig target.

    Let kernel depends on $(KERNEL_CONFIG) instead of the removed
    extconfig.

* selftests/nolibc: add menuconfig and mrproper for development

    like the other local nolibc targets, still require local menuconfig
    and mrproper targets for consistent usage with the same ARCH and no -C
    /path/to/srctree

    Merge them together to reduce duplicated entries.

* selftests/nolibc: allow quit qemu-system when poweroff fails

    Enhance timeout logic with more expected strings print and detection
    about the booting of bios, kernel, init and test.

    Add a default 10 seconds of QEMU_TIMEOUT for every architecture to
    detect all of the potential boog hang or failed poweroff.

* selftests/nolibc: customize QEMU_TIMEOUT for ppc64/ppc64le

    Reduce QEMU_TIMEOUT from 60 seconds to a more normal 15 and 20
    seconds for ppc64 and ppc64le respectively. the main time cost is
    the slow bios used.

* selftests/nolibc: tinyconfig: add support for 32/64-bit powerpc

    Rename the file names to shorter ones as suggestions from the powerpc
    patchset.

* selftests/nolibc: speed up some targets with multiple jobs

    New to speed up with -j<N> by default.

Best regards,
Zhangjin
---
[1]: https://lore.kernel.org/lkml/cover.1689759351.git.falcon@tinylab.org/
[2]: https://lore.kernel.org/lkml/20230727132418.117924-1-falcon@tinylab.org/
[3]: https://lore.kernel.org/lkml/8e9e5ac6283c6ec2ecf10a70ce55b219028497c1.1690468707.git.falcon@tinylab.org/


Zhangjin Wu (12):
  selftests/nolibc: allow report with existing test log
  selftests/nolibc: add macros to reduce duplicated changes
  selftests/nolibc: fix up O= option support
  selftests/nolibc: string the core targets
  selftests/nolibc: allow customize CROSS_COMPILE by architecture
  selftests/nolibc: customize CROSS_COMPILE for 32/64-bit powerpc
  selftests/nolibc: add menuconfig and mrproper for development
  selftests/nolibc: allow quit qemu-system when poweroff fails
  selftests/nolibc: customize QEMU_TIMEOUT for ppc64/ppc64le
  selftests/nolibc: tinyconfig: add extra common options
  selftests/nolibc: tinyconfig: add support for 32/64-bit powerpc
  selftests/nolibc: speed up some targets with multiple jobs

 tools/testing/selftests/nolibc/Makefile       | 102 ++++++++++++++----
 .../selftests/nolibc/configs/common.config    |   4 +
 .../selftests/nolibc/configs/ppc.config       |   3 +
 .../selftests/nolibc/configs/ppc64.config     |   3 +
 .../selftests/nolibc/configs/ppc64le.config   |   4 +
 5 files changed, 98 insertions(+), 18 deletions(-)
 create mode 100644 tools/testing/selftests/nolibc/configs/common.config
 create mode 100644 tools/testing/selftests/nolibc/configs/ppc64.config
 create mode 100644 tools/testing/selftests/nolibc/configs/ppc64le.config

-- 
2.25.1

