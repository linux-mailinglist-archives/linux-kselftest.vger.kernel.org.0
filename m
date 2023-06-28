Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2246C74183E
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 20:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbjF1SvS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 14:51:18 -0400
Received: from bg4.exmail.qq.com ([43.154.54.12]:56757 "EHLO bg4.exmail.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231974AbjF1SvA (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 14:51:00 -0400
X-QQ-mid: bizesmtp76t1687978248tvmfh55f
Received: from linux-lab-host.localdomain ( [116.30.129.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 29 Jun 2023 02:50:47 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: kNiroXLcbYfrJCsBI1sa5E6qtqNyNUUSAPAKfE1it5MbxZO/BaVe/duwUGXKF
        Sm9d/SAmlvYOT+pgc5igmBpIt9S2G4iKsnTlVXEvkaFaHcDNqBQzv2bSp41ULt8iIrDCCnw
        tdsdjVq+IbEYYN7LM3/MDZ3DnO9T5rDy+lL/Yyim/NFIp/+GQWL01mQEGU0Q3mRYtZNu00W
        BmFVKFq2OsmovkZ2/TLDlFljGX9E2juXwgQaKyXF/LfN8W1bXuZJYedEeHDWhOt5FMXxMwz
        2SLVCGCFSefiq1H6yfNBBnHM0QEHRC068sGkE+J52h9ZMmARwFYG5Hn4/VSAttMSijYP9eS
        YlV97yWdOyNmZvtepGpyk/g7CsQIA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12319157307414105420
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v1 00/11] tools/nolibc: shrink arch support
Date:   Thu, 29 Jun 2023 02:50:41 +0800
Message-Id: <cover.1687976753.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

This patchset further improves porting of nolibc to new architectures,
it is based on our previous v5 sysret helper series [1].

It mainly shrinks the assembly _start by moving most of its operations
to a C version of _start_c() function. and also, it removes the old
sys_stat() support by using the sys_statx() instead and therefore,
removes all of the arch specific sys_stat_struct.

Tested 'run' on all of the supported architectures:

               arch/board | result
              ------------|------------
          arm/vexpress-a9 | 141 test(s) passed, 1 skipped, 0 failed. See all results in /labs/linux-lab/logging/nolibc/arm-vexpress-a9-nolibc-test.log
                 arm/virt | 141 test(s) passed, 1 skipped, 0 failed. See all results in /labs/linux-lab/logging/nolibc/arm-virt-nolibc-test.log
             aarch64/virt | 141 test(s) passed, 1 skipped, 0 failed. See all results in /labs/linux-lab/logging/nolibc/aarch64-virt-nolibc-test.log
              ppc/g3beige | not supported
              ppc/ppce500 | not supported
                  i386/pc | 141 test(s) passed, 1 skipped, 0 failed. See all results in /labs/linux-lab/logging/nolibc/i386-pc-nolibc-test.log
                x86_64/pc | 141 test(s) passed, 1 skipped, 0 failed. See all results in /labs/linux-lab/logging/nolibc/x86_64-pc-nolibc-test.log
             mipsel/malta | 141 test(s) passed, 1 skipped, 0 failed. See all results in /labs/linux-lab/logging/nolibc/mipsel-malta-nolibc-test.log
         loongarch64/virt | 141 test(s) passed, 1 skipped, 0 failed. See all results in /labs/linux-lab/logging/nolibc/loongarch64-virt-nolibc-test.log
             riscv64/virt | 141 test(s) passed, 1 skipped, 0 failed. See all results in /labs/linux-lab/logging/nolibc/riscv64-virt-nolibc-test.log
             riscv32/virt | 119 test(s) passed, 1 skipped, 22 failed. See all results in /labs/linux-lab/logging/nolibc/riscv32-virt-nolibc-test.log
    s390x/s390-ccw-virtio | 141 test(s) passed, 1 skipped, 0 failed. See all results in /labs/linux-lab/logging/nolibc/s390x-s390-ccw-virtio-nolibc-test.log

  Notes:
  - ppc support are ready locally, will be sent out later.
  - full riscv32/virt support are ready locally, will be sent out later.

Changes:

* tools/nolibc: remove old arch specific stat support

    Just like the __NR_statx we used in nolibc-test.c, Let's only
    reserve sys_statx() and use it to implement the stat() function.

    Remove the old sys_stat() and sys_stat_struct completely.

* tools/nolibc: add new crt.h with _start_c

    A new C version of _start_c() is added to only require a 'sp' argument
    and find the others (argc, argv, envp/environ, auxv) for us in C.

* tools/nolibc: include crt.h before arch.h

    Include crt.h before arch.h to let _start() be able to call the new
    added _start_c() in arch-<ARCH>.h.

* tools/nolibc: arm: shrink _start with _start_c
  tools/nolibc: aarch64: shrink _start with _start_c
  tools/nolibc: i386: shrink _start with _start_c
  tools/nolibc: x86_64: shrink _start with _start_c
  tools/nolibc: mips: shrink _start with _start_c
  tools/nolibc: loongarch: shrink _start with _start_c
  tools/nolibc: riscv: shrink _start with _start_c
  tools/nolibc: s390: shrink _start with _start_c

    Move most of the operations from the assembly _start() to the C
    _start_c(), only require to do minimal operations in assembly _start
    now.

With this patchset, porting nolibc to a new architecture become easier,
the powerpc porting will be added later.

Best regards,
Zhangjin
---
[1]: https://lore.kernel.org/lkml/cover.1687957589.git.falcon@tinylab.org/

Zhangjin Wu (11):
  tools/nolibc: remove old arch specific stat support
  tools/nolibc: add new crt.h with _start_c
  tools/nolibc: include crt.h before arch.h
  tools/nolibc: arm: shrink _start with _start_c
  tools/nolibc: aarch64: shrink _start with _start_c
  tools/nolibc: i386: shrink _start with _start_c
  tools/nolibc: x86_64: shrink _start with _start_c
  tools/nolibc: mips: shrink _start with _start_c
  tools/nolibc: loongarch: shrink _start with _start_c
  tools/nolibc: riscv: shrink _start with _start_c
  tools/nolibc: s390: shrink _start with _start_c

 tools/include/nolibc/Makefile         |  1 +
 tools/include/nolibc/arch-aarch64.h   | 53 ++----------------
 tools/include/nolibc/arch-arm.h       | 79 ++-------------------------
 tools/include/nolibc/arch-i386.h      | 58 +++-----------------
 tools/include/nolibc/arch-loongarch.h | 42 ++------------
 tools/include/nolibc/arch-mips.h      | 73 +++----------------------
 tools/include/nolibc/arch-riscv.h     | 65 ++--------------------
 tools/include/nolibc/arch-s390.h      | 60 ++------------------
 tools/include/nolibc/arch-x86_64.h    | 54 ++----------------
 tools/include/nolibc/crt.h            | 57 +++++++++++++++++++
 tools/include/nolibc/nolibc.h         |  1 +
 tools/include/nolibc/signal.h         |  1 +
 tools/include/nolibc/stdio.h          |  1 +
 tools/include/nolibc/stdlib.h         |  1 +
 tools/include/nolibc/sys.h            | 64 ++++------------------
 tools/include/nolibc/time.h           |  1 +
 tools/include/nolibc/types.h          |  4 +-
 tools/include/nolibc/unistd.h         |  1 +
 18 files changed, 122 insertions(+), 494 deletions(-)
 create mode 100644 tools/include/nolibc/crt.h

-- 
2.25.1

