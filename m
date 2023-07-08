Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FEB74BE24
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jul 2023 17:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjGHPZy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 8 Jul 2023 11:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjGHPZy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 8 Jul 2023 11:25:54 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3D3E43;
        Sat,  8 Jul 2023 08:25:50 -0700 (PDT)
X-QQ-mid: bizesmtp75t1688829938t4ghg9b6
Received: from linux-lab-host.localdomain ( [116.30.131.119])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 08 Jul 2023 23:25:37 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: KvvwR/hcPA1tsLyJ+hoWQ0ptsJnLEnbBCeHAmZywwvMuVpm5dmCLEcyrLby2V
        /SMDdieOQ+TkEilwDH/KSaYLuThGTyZfZfUrK2uYIVfKKu57s6bwwJQss4vHA/my5/f0xoq
        tXSjg065Di6QCn16HBkG0lDE108NQAOI0bu3gxaIuInCDUnCWGNwxhTF8nIlQnjVG/QC9wB
        gO8s8EeLwZxh/gzfz58YjH3r3Nb35vtm4PU1XMCvdSM6y2bP2Fy+JBtiCUPYn2q8RgCnZAa
        /k3f7Gl/6Y9RTbNTSGU5eUlxXnObhgZ8IEFvvU2R5+BDRhcpJ9ynODAXabkYwF42BOFKCAr
        LUDnGJ8js/PWirtkDXoU4PlKgz1Ca6MM6JJ0Njwr7ktGQCeG0UWEUOErGZUTD9gJmiDETv7
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11312659977501803491
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v2 00/12] tools/nolibc: shrink arch support
Date:   Sat,  8 Jul 2023 23:25:37 +0800
Message-Id: <cover.1688828139.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

This is v2 of the "tools/nolibc: shrink arch support" [1].

This v2 has no core code logic change, but applies some suggestions from
Willy and Thomas, one is using post-whitespaces instead of post-tab,
another is restructuring the arch support directory and files [2].

Like musl, this v2 creates <ARCH> directory for every arch and splits
the old arch-<ARCH>.h to <ARCH>/{crt.h, sys.h} and at the same time,
splits the old arch.h to crt_arch.h and sys_arch.h. at last, only need
to include crt_arch.h in crt.h and sys_arch.h in sys.h respectively, and
no longer need to include arch.h in the other common headers:

    crt.h <-- crt_arch.h <-- <ARCH>/crt.h
    sys.h <-- sys_arch.h <-- <ARCH>/sys.h

It is based on the 20230705-nolibc-series2 branch of nolibc repo [3]. It
should be applied after the v6 __sysret helper series [4] and the v4
min config support series [5].

Here is the test report for all of the supported architectures:

               arch/board | result
              ------------|------------
          arm/vexpress-a9 | 142 test(s) passed, 1 skipped, 0 failed.
                 arm/virt | 142 test(s) passed, 1 skipped, 0 failed.
             aarch64/virt | 142 test(s) passed, 1 skipped, 0 failed.
              ppc/g3beige | not supported
              ppc/ppce500 | not supported
                  i386/pc | 142 test(s) passed, 1 skipped, 0 failed.
                x86_64/pc | 142 test(s) passed, 1 skipped, 0 failed.
             mipsel/malta | 142 test(s) passed, 1 skipped, 0 failed.
         loongarch64/virt | 142 test(s) passed, 1 skipped, 0 failed.
             riscv64/virt | 142 test(s) passed, 1 skipped, 0 failed.
             riscv32/virt | 0 test(s) passed, 0 skipped, 0 failed.
    s390x/s390-ccw-virtio | 142 test(s) passed, 1 skipped, 0 failed.

Changes from v1 --> v2:

* tools/nolibc: rename arch-<ARCH>.h to <ARCH>/arch.h
  tools/nolibc: split arch.h to crt.h and sys.h

    Restruct the arch support directory and files.

    Fix up the errors reported by scripts/checkpatch.pl.

* tools/nolibc: sys.h: remove the old sys_stat support

    Rebase on the new arch support directory and files.

* tools/nolibc: crt.h: add _start_c

    Move #include "compiler.h" in the common crt.h too.

* tools/nolibc: arm/crt.h: shrink _start with _start_c
  tools/nolibc: aarch64/crt.h: shrink _start with _start_c
  tools/nolibc: i386/crt.h: shrink _start with _start_c
  tools/nolibc: x86_64/crt.h: shrink _start with _start_c
  tools/nolibc: mips/crt.h: shrink _start with _start_c
  tools/nolibc: loongarch/crt.h: shrink _start with _start_c
  tools/nolibc: riscv/crt.h: shrink _start with _start_c
  tools/nolibc: s390/crt.h: shrink _start with _start_c

    Rebase on the new arch support directory and files.

    Use post-whitespaces instead of post-tab.    

Best regards,
Zhangjin
---
[1]: https://lore.kernel.org/lkml/cover.1687976753.git.falcon@tinylab.org/
[2]: https://lore.kernel.org/lkml/20230703145500.500460-1-falcon@tinylab.org/
[3]: https://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git
[4]: https://lore.kernel.org/lkml/cover.1688739492.git.falcon@tinylab.org/
[5]: https://lore.kernel.org/lkml/cover.1688750763.git.falcon@tinylab.org/

Zhangjin Wu (12):
  tools/nolibc: rename arch-<ARCH>.h to <ARCH>/arch.h
  tools/nolibc: split arch.h to crt.h and sys.h
  tools/nolibc: sys.h: remove the old sys_stat support
  tools/nolibc: crt.h: add _start_c
  tools/nolibc: arm/crt.h: shrink _start with _start_c
  tools/nolibc: aarch64/crt.h: shrink _start with _start_c
  tools/nolibc: i386/crt.h: shrink _start with _start_c
  tools/nolibc: x86_64/crt.h: shrink _start with _start_c
  tools/nolibc: mips/crt.h: shrink _start with _start_c
  tools/nolibc: loongarch/crt.h: shrink _start with _start_c
  tools/nolibc: riscv/crt.h: shrink _start with _start_c
  tools/nolibc: s390/crt.h: shrink _start with _start_c

 tools/include/nolibc/Makefile                 | 36 ++++---
 tools/include/nolibc/aarch64/crt.h            | 24 +++++
 .../nolibc/{arch-aarch64.h => aarch64/sys.h}  | 68 +------------
 tools/include/nolibc/arch.h                   | 36 -------
 tools/include/nolibc/arm/crt.h                | 25 +++++
 .../include/nolibc/{arch-arm.h => arm/sys.h}  | 96 +------------------
 tools/include/nolibc/crt.h                    | 60 ++++++++++++
 tools/include/nolibc/crt_arch.h               | 32 +++++++
 tools/include/nolibc/i386/crt.h               | 33 +++++++
 .../nolibc/{arch-i386.h => i386/sys.h}        | 77 +--------------
 tools/include/nolibc/loongarch/crt.h          | 30 ++++++
 .../{arch-loongarch.h => loongarch/sys.h}     | 64 +------------
 tools/include/nolibc/mips/crt.h               | 32 +++++++
 .../nolibc/{arch-mips.h => mips/sys.h}        | 87 +----------------
 tools/include/nolibc/nolibc.h                 |  2 +-
 tools/include/nolibc/riscv/crt.h              | 28 ++++++
 .../nolibc/{arch-riscv.h => riscv/sys.h}      | 83 +---------------
 tools/include/nolibc/s390/crt.h               | 21 ++++
 .../nolibc/{arch-s390.h => s390/sys.h}        | 74 +-------------
 tools/include/nolibc/signal.h                 |  1 -
 tools/include/nolibc/stdio.h                  |  1 -
 tools/include/nolibc/stdlib.h                 |  2 +-
 tools/include/nolibc/sys.h                    | 65 +++----------
 tools/include/nolibc/sys_arch.h               | 32 +++++++
 tools/include/nolibc/time.h                   |  1 -
 tools/include/nolibc/types.h                  |  4 +-
 tools/include/nolibc/unistd.h                 |  1 -
 tools/include/nolibc/x86_64/crt.h             | 33 +++++++
 .../nolibc/{arch-x86_64.h => x86_64/sys.h}    | 74 +-------------
 29 files changed, 421 insertions(+), 701 deletions(-)
 create mode 100644 tools/include/nolibc/aarch64/crt.h
 rename tools/include/nolibc/{arch-aarch64.h => aarch64/sys.h} (76%)
 delete mode 100644 tools/include/nolibc/arch.h
 create mode 100644 tools/include/nolibc/arm/crt.h
 rename tools/include/nolibc/{arch-arm.h => arm/sys.h} (74%)
 create mode 100644 tools/include/nolibc/crt.h
 create mode 100644 tools/include/nolibc/crt_arch.h
 create mode 100644 tools/include/nolibc/i386/crt.h
 rename tools/include/nolibc/{arch-i386.h => i386/sys.h} (73%)
 create mode 100644 tools/include/nolibc/loongarch/crt.h
 rename tools/include/nolibc/{arch-loongarch.h => loongarch/sys.h} (73%)
 create mode 100644 tools/include/nolibc/mips/crt.h
 rename tools/include/nolibc/{arch-mips.h => mips/sys.h} (74%)
 create mode 100644 tools/include/nolibc/riscv/crt.h
 rename tools/include/nolibc/{arch-riscv.h => riscv/sys.h} (70%)
 create mode 100644 tools/include/nolibc/s390/crt.h
 rename tools/include/nolibc/{arch-s390.h => s390/sys.h} (68%)
 create mode 100644 tools/include/nolibc/sys_arch.h
 create mode 100644 tools/include/nolibc/x86_64/crt.h
 rename tools/include/nolibc/{arch-x86_64.h => x86_64/sys.h} (76%)

-- 
2.25.1

