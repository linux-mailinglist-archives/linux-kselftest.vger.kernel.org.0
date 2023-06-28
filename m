Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3DE7411EA
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 15:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjF1NHr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 09:07:47 -0400
Received: from bg4.exmail.qq.com ([43.154.54.12]:25161 "EHLO bg4.exmail.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230517AbjF1NHr (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 09:07:47 -0400
X-QQ-mid: bizesmtp65t1687957648tu9qyfcj
Received: from linux-lab-host.localdomain ( [116.30.129.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 28 Jun 2023 21:07:27 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: 3M0okmaRx3gb4FdeRUhO6aTI0YLKsUxEqUK9Nx/Uxnu07QNHgt2LGMOPoBR/s
        GPh7o8giMgIt60FJvxcE7e5uRKmM3LPCus9zqtpWhLnvkdQpDIxv78aaFlZDtvHnwaZlRvo
        Po9QXf3TC7/3rx5coDBkXBvbt1tlCI+a0AR0zuWB6UpzZymRvSMZJEG8wczWFFQmVIjXUzM
        QxsOGKF/smUpbO48jbVNMpfmAzXtcrI0FYkwdjpyNGAOwkfdM+6yh8VqMf2H5tZdMkT2pOf
        thJyfho1d46/BmsEnLiUTEz0Kk9W10JyVGI7ZXubxvWKJqLPQaj7AQU/oqWmziSroABw4Gf
        g/f0Afn0QLWyXsur/DiDeoSoirimQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15580650534271053015
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v5 00/14] tools/nolibc: add a new syscall helper
Date:   Wed, 28 Jun 2023 21:07:16 +0800
Message-Id: <cover.1687957589.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687187451.git.falcon@tinylab.org>
References: <cover.1687187451.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Willy, Thomas

This is the revision of our 'tools/nolibc: add a new syscall helper'
series [1].

It mainly applies the core part of suggestions from Thomas (Many thanks)
and cleans up the multiple whitespaces issues reported by
scripts/checkpatch.pl.

Changes from v4 --> v5:

* tools/nolibc: sys.h: add a syscall return helper
  tools/nolibc: unistd.h: apply __sysret() helper
  tools/nolibc: sys.h: apply __sysret() helper
  tools/nolibc: unistd.h: reorder the syscall macros
  tools/nolibc: __sysret: support syscalls who return a pointer
  selftests/nolibc: add EXPECT_PTREQ, EXPECT_PTRNE and EXPECT_PTRER
  selftests/nolibc: add sbrk_0 to test current brk getting

    The same to original v4 series, no code change.

* tools/nolibc: string.h: clean up multiple whitespaces with tab
  tools/nolibc: arch-*.h: clean up multiple whitespaces
  tools/nolibc: arch-loongarch.h: shrink with SYSCALL_CLOBBERLIST
  tools/nolibc: arch-mips.h: shrink with SYSCALL_CLOBBERLIST

    Clean up the multiple whitespaces issues reported by
    scripts/checkpatch.pl, prepare for the coming mips my_syscall6()

    This cleanup is also required by another new arch shrink patchset.

    In v4, we didn't touch multiple whitespaces, because the
    changes are huge, but it is really important to do this
    before being always 'complained' by scripts/checkpatch.pl in the
    future.

* tools/nolibc: add missing my_syscall6() for mips

    Use tab instead of multiple whitespaces, let scripts/checkpatch.pl
    happy, also apply SYSCALL_CLOBBERLIST

* tools/nolibc: clean up mmap() support

    Include <linux/mman.h> and remove more macros from nolibc side.

    The return type of sys_mmap() is reserved as before, not changed
    currently.
  
* selftests/nolibc: add mmap and munmap test cases

    Applies some suggestions from Thomas,

    - Rebase length and offset on page_size and file_size

    - make sure the last offset argument is not always zero to test
      my_syscall6()

    - easier the for loop with NULL check

    - use /proc/1/exe and /proc/self/exe for run, run-user and libc-test

      but still reserve the old init files to align our another attempt
      to remove the unnecessary dependency on procfs (this is important
      to let developers happy to do all-architectures-test, the
      accumulated time cost and wait is really appreciable, it is really
      a pain for me to do repeated all-architectures-test for the new
      'minimal' kernel config patchset [2], a v2 is ready for it).

Best regards,
Zhangjin
---
[1]: https://lore.kernel.org/lkml/cover.1687187451.git.falcon@tinylab.org/
[2]: https://lore.kernel.org/lkml/cover.1687706332.git.falcon@tinylab.org/

Zhangjin Wu (14):
  tools/nolibc: sys.h: add a syscall return helper
  tools/nolibc: unistd.h: apply __sysret() helper
  tools/nolibc: sys.h: apply __sysret() helper
  tools/nolibc: unistd.h: reorder the syscall macros
  tools/nolibc: string.h: clean up multiple whitespaces with tab
  tools/nolibc: arch-*.h: clean up multiple whitespaces
  tools/nolibc: arch-loongarch.h: shrink with SYSCALL_CLOBBERLIST
  tools/nolibc: arch-mips.h: shrink with SYSCALL_CLOBBERLIST
  tools/nolibc: add missing my_syscall6() for mips
  tools/nolibc: __sysret: support syscalls who return a pointer
  tools/nolibc: clean up mmap() support
  selftests/nolibc: add EXPECT_PTREQ, EXPECT_PTRNE and EXPECT_PTRER
  selftests/nolibc: add sbrk_0 to test current brk getting
  selftests/nolibc: add mmap and munmap test cases

 tools/include/nolibc/arch-aarch64.h          | 210 +++++-----
 tools/include/nolibc/arch-arm.h              | 240 ++++++------
 tools/include/nolibc/arch-i386.h             | 226 +++++------
 tools/include/nolibc/arch-loongarch.h        | 219 +++++------
 tools/include/nolibc/arch-mips.h             | 241 ++++++------
 tools/include/nolibc/arch-riscv.h            | 208 +++++-----
 tools/include/nolibc/arch-s390.h             | 202 +++++-----
 tools/include/nolibc/arch-x86_64.h           | 222 +++++------
 tools/include/nolibc/nolibc.h                |   9 +-
 tools/include/nolibc/string.h                |   8 +-
 tools/include/nolibc/sys.h                   | 391 +++----------------
 tools/include/nolibc/types.h                 |   6 +
 tools/include/nolibc/unistd.h                |  13 +-
 tools/testing/selftests/nolibc/nolibc-test.c | 115 ++++++
 14 files changed, 1083 insertions(+), 1227 deletions(-)

-- 
2.25.1

