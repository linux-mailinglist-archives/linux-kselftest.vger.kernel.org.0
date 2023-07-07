Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69AB74B62E
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 20:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjGGSVv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 14:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjGGSVu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 14:21:50 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED19D2125;
        Fri,  7 Jul 2023 11:21:47 -0700 (PDT)
X-QQ-mid: bizesmtp80t1688754095t0aq6h5r
Received: from linux-lab-host.localdomain ( [116.30.131.119])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 08 Jul 2023 02:21:34 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: TXoNPSSaW4kv/p7caHiEYxLanebgZwhG2XfKboEcnrrRVllAyJuoDpRhSIlNW
        p+ec62UWjOYu7hyn444lJo2VGEkEzPPwCEoOt0txY/1z2iWbZBgbkyaCsC1fR2k+XoHAjFl
        ZvQ+imAm1VsfxifYsux+YPA7w3iuzhUHFrztW2+8JhUGNgafQUUwixdNQoncP23mEOFkTG2
        2/DiFkPeOSOgAxkU8HoSE48wJnQlu8Qtg9OUxfUHV/cLcDfspdyC7FIddCFruozGeoCdqXs
        rWepzHSfaXGIbIwPGUO6zs3J74rV32Dm4Jzf4HDtvJhTRecwnQVfRr5VL7HkQsYClSpZDJv
        nC+8qlLZgFYrR2QbsmY1iwByR2Mp97ieLcIz23e
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13328391123435046420
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v4 00/18] selftests/nolibc: allow run with minimal kernel config
Date:   Sat,  8 Jul 2023 02:21:20 +0800
Message-Id: <cover.1688750763.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This v4 mainly uses the argv0 suggested by you, at the same time, a new
run-libc-test target is added for glibc and musl, and the RB_ flags are
added for nolibc to allow compile nolibc-test.c without <linux/reboot.h>
for glibc, musl and nolibc (mainly for musl-gcc, without -I
/path/to/sysroot). 

This patchset is based on the 20230705-nolibc-series2 branch of nolibc
repo [2], it must be applied after our v6 __sysret series [3] (argv0
exported there) and Thomas' chmod_net removal patchset [4] (the new
chmod_argv0 is added at the same line of chmod_net, will conflict).

This patchset assumes the chmod_net removal patchset will be applied at
first, if not, the chmod_argv0 added alphabetically will not be applied.
Since our new chmod_argv0 is exactly added to replace chmod_net, so,
Willy, is it ok for you to at least apply the chmod_net removal patch
[5] before this patchset?

    selftests/nolibc: drop test chmod_net

This patchset is tested together with the v6 __sysret series [3]:

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

If use tinyconfig + basic console options (means disable all of the
other options, include procfs, shmem, tmpfs, net and memfd_create, to
save test time, only randomly choose 4 archs):


    ...

    LOG: testing report for loongarch64/virt:

    15 chmod_self                                                   [SKIPPED]
    16 chown_self                                                   [SKIPPED]
    40 link_cross                                                   [SKIPPED]
    0 -fstackprotector not supported                                [SKIPPED]

    139 test(s) passed, 4 skipped, 0 failed.
    See all results in /labs/linux-lab/logging/nolibc/loongarch64-virt-nolibc-test.log

    LOG: testing summary:

          arch/board | result
         ------------|------------
     arm/vexpress-a9 | 139 test(s) passed, 4 skipped, 0 failed.
           x86_64/pc | 139 test(s) passed, 4 skipped, 0 failed.
        mipsel/malta | 139 test(s) passed, 4 skipped, 0 failed.
    loongarch64/virt | 139 test(s) passed, 4 skipped, 0 failed.

Changes from v3 --> v4:

* selftests/nolibc: stat_fault: silence NULL argument warning with glibc
  selftests/nolibc: gettid: restore for glibc and musl
  selftests/nolibc: add _LARGEFILE64_SOURCE for musl
  selftests/nolibc: fix up int_fast16/32_t test cases for musl
  selftests/nolibc: fix up kernel parameters support
  selftests/nolibc: link_cross: use /proc/self/cmdline
  tools/nolibc: add rmdir() support
  selftests/nolibc: add a new rmdir() test case
  selftests/nolibc: fix up failures when CONFIG_PROC_FS=n
  selftests/nolibc: prepare /tmp for tmpfs or ramfs
  selftests/nolibc: vfprintf: remove MEMFD_CREATE dependency

    No change.

* selftests/nolibc: add run-libc-test target

    New run and report for glibc or musl. for musl, we can simply issue:

    $ make run-libc-test CC=/path/to/musl-install/bin/musl-gcc

* tools/nolibc: types.h: add RB_ flags for reboot()
  selftests/nolibc: prefer <sys/reboot.h> to <linux/reboot.h>

    Required by musl to compile nolibc-test.c without -I/path/to/sysroot

* selftests/nolibc: chdir_root: restore current path after test

    restore current path to prevent breakage of using relative path

* selftests/nolibc: stat_timestamps: remove procfs dependency
  selftests/nolibc: chroot_exe: remove procfs dependency
  selftests/nolibc: add chmod_argv0 test

    use argv0 instead of '/init' as before.

Best regards,
Zhangjin
---
[1]: https://lore.kernel.org/lkml/cover.1688134399.git.falcon@tinylab.org/
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git
[3]: https://lore.kernel.org/lkml/cover.1688739492.git.falcon@tinylab.org/
[4]: https://lore.kernel.org/lkml/20230624-proc-net-setattr-v1-0-73176812adee@weissschuh.net/
[5]: https://lore.kernel.org/lkml/20230624-proc-net-setattr-v1-1-73176812adee@weissschuh.net/

Zhangjin Wu (18):
  selftests/nolibc: add run-libc-test target
  selftests/nolibc: stat_fault: silence NULL argument warning with glibc
  selftests/nolibc: gettid: restore for glibc and musl
  selftests/nolibc: add _LARGEFILE64_SOURCE for musl
  selftests/nolibc: fix up int_fast16/32_t test cases for musl
  tools/nolibc: types.h: add RB_ flags for reboot()
  selftests/nolibc: prefer <sys/reboot.h> to <linux/reboot.h>
  selftests/nolibc: fix up kernel parameters support
  selftests/nolibc: link_cross: use /proc/self/cmdline
  tools/nolibc: add rmdir() support
  selftests/nolibc: add a new rmdir() test case
  selftests/nolibc: fix up failures when CONFIG_PROC_FS=n
  selftests/nolibc: prepare /tmp for tmpfs or ramfs
  selftests/nolibc: vfprintf: remove MEMFD_CREATE dependency
  selftests/nolibc: chdir_root: restore current path after test
  selftests/nolibc: stat_timestamps: remove procfs dependency
  selftests/nolibc: chroot_exe: remove procfs dependency
  selftests/nolibc: add chmod_argv0 test

 tools/include/nolibc/sys.h                   | 23 ++++-
 tools/include/nolibc/types.h                 | 12 ++-
 tools/testing/selftests/nolibc/Makefile      |  4 +
 tools/testing/selftests/nolibc/nolibc-test.c | 88 +++++++++++++++-----
 4 files changed, 104 insertions(+), 23 deletions(-)

-- 
2.25.1

