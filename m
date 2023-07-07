Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48CF74B345
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 16:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjGGOuB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 10:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjGGOuA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 10:50:00 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20C61FE1;
        Fri,  7 Jul 2023 07:49:50 -0700 (PDT)
X-QQ-mid: bizesmtp62t1688741371t0rnd6is
Received: from linux-lab-host.localdomain ( [116.30.131.119])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 07 Jul 2023 22:49:30 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: eSZ1CZgv+JAwAJkI8FYXTx4ksYAsemeAQTurvaB6LTavwvYKFyY/Q79bZX+kf
        WcNSonHl3f9YliNF/p7RBbIDaK75z3f+4qrd0b+0OBLnva8vPUhNeRNnee4NfEhL+cxq+YQ
        25mAxnyygTMo30Dyk+EnVDgjSKMOx3AkoroCL+0CqCcWhzw85ptYmYeUKI38KMRgvHUnU42
        mX71XcxAHe8FTeQnY+Y4fVuLq2ldsicok6K54xDltfdkVvosSh2ZgTkgJfYSkO2m6eZd7Qh
        CymWenTCKhqpXgNOAVoOPyp1blHJrVLsUFMC+0kQkU20r6LO1Z2Ggr4TP87hftH3Ea5vhi/
        dE6ibEMZ+0Ei2TkfutYXCzGX9ORDg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14084673947367091734
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, thomas@t-8ch.de
Subject: [PATCH v6 00/15] tools/nolibc: add a new syscall helper
Date:   Fri,  7 Jul 2023 22:49:28 +0800
Message-Id: <cover.1688739492.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

Here is the v6 of the __sysret series [1], applies your suggestions.
additionally, the sbrk() also uses the __sysret helper.

These patches are tested (together with the coming v4 selftests/nolibc
patches) for all of the supported architectures:

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

Changes from v5 --> v6:

* tools/nolibc: arch-*.h: fix up code indent errors
  toolc/nolibc: arch-*.h: clean up whitespaces after __asm__

    Fix up the code indent errors and whitespaces between __asm__ and volatile.

    The post-whitespaces are reserved as before.

* tools/nolibc: arch-loongarch.h: shrink with _NOLIBC_SYSCALL_CLOBBERLIST
  tools/nolibc: arch-mips.h: shrink with _NOLIBC_SYSCALL_CLOBBERLIST

    Add _NOLIBC_ prefix for SYSCALL_CLOBBERLIST.

* tools/nolibc: add missing my_syscall6() for mips

    Use post-whitespaces instead of post-tab.

    The above 4 patches are preparation for this one.

* tools/nolibc: __sysret: support syscalls who return a pointer

    Add comments about the new errno range [-MAX_ERRNOR, -1], add ref to
    the musl and glibc.

* tools/nolibc: clean up mmap() routine

    Comment the MAP_FAILED return info.

* tools/nolibc: clean up sbrk() routine

    New patch, applies __sysret() helper too and also fixes up an error
    reported by scripts/checkpatch.pl.

* selftests/nolibc: export argv0 for some tests
  selftests/nolibc: prepare: create /dev/zero

    Prepare /dev/zero and argv0 for mmap test cases.

* selftests/nolibc: add EXPECT_PTREQ, EXPECT_PTRNE and EXPECT_PTRER
  selftests/nolibc: add sbrk_0 to test current brk getting

    No change.

* selftests/nolibc: add mmap_bad test case
  selftests/nolibc: add munmap_bad test case
  selftests/nolibc: add mmap_munmap_good test case

    Split the first two out to standalone patches.

    Add /dev/zero and argv0 to the file list and assigns a file_size
    manually for /dev/zero.

Best regards,
Zhangjin
---
[1]: https://lore.kernel.org/lkml/cover.1687957589.git.falcon@tinylab.org/

Zhangjin Wu (15):
  tools/nolibc: arch-*.h: fix up code indent errors
  toolc/nolibc: arch-*.h: clean up whitespaces after __asm__
  tools/nolibc: arch-loongarch.h: shrink with _NOLIBC_SYSCALL_CLOBBERLIST
  tools/nolibc: arch-mips.h: shrink with _NOLIBC_SYSCALL_CLOBBERLIST
  tools/nolibc: add missing my_syscall6() for mips
  tools/nolibc: __sysret: support syscalls who return a pointer
  tools/nolibc: clean up mmap() routine
  tools/nolibc: clean up sbrk() routine
  selftests/nolibc: export argv0 for some tests
  selftests/nolibc: prepare: create /dev/zero
  selftests/nolibc: add EXPECT_PTREQ, EXPECT_PTRNE and EXPECT_PTRER
  selftests/nolibc: add sbrk_0 to test current brk getting
  selftests/nolibc: add mmap_bad test case
  selftests/nolibc: add munmap_bad test case
  selftests/nolibc: add mmap_munmap_good test case

 tools/include/nolibc/arch-aarch64.h          |  28 ++--
 tools/include/nolibc/arch-arm.h              |  28 ++--
 tools/include/nolibc/arch-i386.h             |  24 ++--
 tools/include/nolibc/arch-loongarch.h        |  37 +++---
 tools/include/nolibc/arch-mips.h             |  73 +++++++----
 tools/include/nolibc/arch-riscv.h            |  14 +-
 tools/include/nolibc/arch-s390.h             |  14 +-
 tools/include/nolibc/arch-x86_64.h           |  28 ++--
 tools/include/nolibc/nolibc.h                |   9 +-
 tools/include/nolibc/sys.h                   |  55 ++++----
 tools/include/nolibc/types.h                 |   6 +
 tools/testing/selftests/nolibc/nolibc-test.c | 129 ++++++++++++++++++-
 12 files changed, 292 insertions(+), 153 deletions(-)

--
2.25.1

