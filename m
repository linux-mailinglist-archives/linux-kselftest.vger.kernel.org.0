Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9707B743104
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jun 2023 01:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjF2XXO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jun 2023 19:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjF2XXJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jun 2023 19:23:09 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68723595;
        Thu, 29 Jun 2023 16:23:06 -0700 (PDT)
X-QQ-mid: bizesmtp63t1688080975t31acsuq
Received: from linux-lab-host.localdomain ( [119.123.131.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 30 Jun 2023 07:22:54 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: fs34Pe/+C2SE0GOBgcaqUeHJIlFyxVLNr41yHYDYi/7IAsw1R3yfi5P3w3+Ep
        VvQSCYNqD747w+irAS0uzRCHxy8BpaQIdRDd3KjQoNZMRpPE1PZUZjjJ/vapJ+9GzrnhWYU
        du1fxlcxBx7hsuoqYjUgO8F7oZBB2lAqqyJONkT0E/kUDuLXcUVUCT+XZndYXO0+aITM7Ub
        lHm+T4WDiyRdEsq13hWX2W11ECz+RAFFhh6SFMAtLakuzF65bFHqDz9NfxyZsV/xX+VzyWr
        o7KiZIjq2OEf30HcpHo9e/AQx0catEg1rM74HyXQy+a2wdnnbX6+olCKTF7LBr5WBS+4K4H
        /+oJkjz8rme05rSthiYrDpcJp9SYczb4qsyLpnI3gn2q7qcu94NGhnYiMGxyw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 684924656678140548
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v2 00/15] allow run with minimal kernel config
Date:   Fri, 30 Jun 2023 07:22:39 +0800
Message-Id: <cover.1688078604.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Willy, Thomas

This is v2 to allow run with minimal kernel config, see v1 [1].

It mainly applied the suggestions from Thomas. It is based on our
previous v5 sysret helper series [2] and Thomas' chmod_net removal
patchset [3].

Now, a test report on arm/vexpress-a9 without procfs, shmem, tmpfs, net
and memfd_create looks like:

    LOG: testing report for arm/vexpress-a9:

    14 chmod_net                                                    [SKIPPED]
    15 chmod_self                                                   [SKIPPED]
    17 chown_self                                                   [SKIPPED]
    41 link_cross                                                   [SKIPPED]
    0 -fstackprotector not supported                                [SKIPPED]

    139 test(s) passed, 5 skipped, 0 failed.
    See all results in /labs/linux-lab/logging/nolibc/arm-vexpress-a9-nolibc-test.log

    LOG: testing summary:

         arch/board | result
        ------------|------------
    arm/vexpress-a9 | 139 test(s) passed, 5 skipped, 0 failed. See all results in /labs/linux-lab/logging/nolibc/arm-vexpress-a9-nolibc-test.log

Changes from v1 --> v2:

* selftests/nolibc: stat_fault: silence NULL argument warning with glibc
  selftests/nolibc: gettid: restore for glibc and musl
  selftests/nolibc: add _LARGEFILE64_SOURCE for musl
  selftests/nolibc: add a new rmdir() test case
  selftests/nolibc: fix up failures when CONFIG_PROC_FS=n

    The same as v1, only a few of commit message changes.

* selftests/nolibc: fix up int_fast16/32_t test cases for musl

    Applied the method suggested by Thomas, two new macros are added to
    get SINT_MAX_OF_TYPE(type) and SINT_MIN_OF_TYPE(type).

* selftests/nolibc: fix up kernel parameters support

    After discuss with Thomas and with more tests, both of argv[1] and
    NOLIBC_TEST environment variable should be verified to support
    such kernel parameters:

      NOLIBC_TEST=syscall
      noapic NOLIBC_TEST=syscall
      noapic

* selftests/nolibc: stat_timestamps: remove procfs dependency

    Add '/init' and '/' for !procfs, don't skip it.

* selftests/nolibc: link_cross: use /proc/self/cmdline

    Use /proc/self/cmdline instead of /proc/self/net, the ramfs based
    /tmp/file doesn't work as expected (not really crossdev).

* tools/nolibc: add rmdir() support

    Now, rebased on __sysret() from sysret helper patchset [2].

* selftests/nolibc: prepare /tmp for tmpfs or ramfs

    Removed the hugetlbfs prepare part, not really required.

    Don't remove /tmp and reserve it to use ramfs as tmpfs.

* selftests/nolibc: add common get_tmpfile()
  selftests/nolibc: rename chroot_exe to chroot_tmpfile

    Some cleanups.

* selftests/nolibc: add chmod_tmpfile test

    To avoid conflict with Thomas' chmod_net removal patch [3], a new
    chmod_tmpfile is added (in v1, there is a rename patch from
    chmod_net to chmod_good)

    Still to avoid conflict, these two are removed in this series:

    - selftests/nolibc: rename proc variable to has_proc
    - selftests/nolibc: rename euid0 variable to is_root

* selftests/nolibc: vfprintf: remove MEMFD_CREATE dependency

    Many checks are removed, only reserve the direct tmpfs access
    version.

Best regards,
Zhangjin
---
[1]: https://lore.kernel.org/lkml/cover.1687344643.git.falcon@tinylab.org/
[2]: https://lore.kernel.org/lkml/cover.1687976753.git.falcon@tinylab.org/
[3]: https://lore.kernel.org/lkml/20230624-proc-net-setattr-v1-0-73176812adee@weissschuh.net/

Zhangjin Wu (15):
  selftests/nolibc: stat_fault: silence NULL argument warning with glibc
  selftests/nolibc: gettid: restore for glibc and musl
  selftests/nolibc: add _LARGEFILE64_SOURCE for musl
  selftests/nolibc: fix up int_fast16/32_t test cases for musl
  selftests/nolibc: fix up kernel parameters support
  selftests/nolibc: stat_timestamps: remove procfs dependency
  selftests/nolibc: link_cross: use /proc/self/cmdline
  tools/nolibc: add rmdir() support
  selftests/nolibc: add a new rmdir() test case
  selftests/nolibc: fix up failures when CONFIG_PROC_FS=n
  selftests/nolibc: prepare /tmp for tmpfs or ramfs
  selftests/nolibc: add common get_tmpfile()
  selftests/nolibc: rename chroot_exe to chroot_tmpfile
  selftests/nolibc: add chmod_tmpfile test
  selftests/nolibc: vfprintf: remove MEMFD_CREATE dependency

 tools/include/nolibc/sys.h                   |  22 ++++
 tools/testing/selftests/nolibc/nolibc-test.c | 102 +++++++++++++++----
 2 files changed, 106 insertions(+), 18 deletions(-)

-- 
2.25.1

