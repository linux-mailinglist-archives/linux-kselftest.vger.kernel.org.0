Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE66743DB6
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jun 2023 16:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbjF3Ome (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Jun 2023 10:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbjF3Omd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Jun 2023 10:42:33 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F372EE4C;
        Fri, 30 Jun 2023 07:41:46 -0700 (PDT)
X-QQ-mid: bizesmtp85t1688136094t0q9sslu
Received: from linux-lab-host.localdomain ( [119.123.131.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 30 Jun 2023 22:41:32 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: aBJFcW+uBGZl0+FHzxpPL1G5qDwO+yGHyjib98Q307+eWlL5WU1+x9mU75Kr1
        sMdIiM9Huqr2lyYM8IA8WHq+VYOO7uD3jK1jfeKxZnDg5da6XnV7wuo8nAxrWrM+CLWgtuI
        qaXeAdHzfVbFETS4Q330aC/iMOnLie23SQXME6TG/65gMXsRKlfEk32QxqPSvUkOOmuLXvO
        pv9i50JcFPkOh3FsZiaUNQvlJhLFlx7kV0sne7lCYHnikgnDZMlw8FmHDCtEJ0TVXrPE0T4
        xz3zTi0/w1pf0GqPXbtRPsA8Yhp4AVzJgjwPn6RsDj/9GQLVFQVIHfJGb3HFSeB2P26upAS
        MrEFIf9hGjacb3Sxscj8T2y2ig9zCqLPY38z6KAM9mp4CMCaDDKqCk1Ss2nTmynHzMXTgBQ
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17093662963563239174
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v3 00/14] selftests/nolibc: allow run with minimal kernel config
Date:   Fri, 30 Jun 2023 22:41:31 +0800
Message-Id: <cover.1688134399.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Willy, Thomas

This is v3 to allow run with minimal kernel config, see v2 [1].

Applied further suggestions from Thomas, It is based on our previous v5
sysret helper series [2] and Thomas' chmod_net removal patchset [3].

Now, a test report on arm/vexpress-a9 without procfs, shmem, tmpfs, net
and memfd_create looks like:

    LOG: testing report for arm/vexpress-a9:

    14 chmod_self                                                   [SKIPPED]
    16 chown_self                                                   [SKIPPED]
    40 link_cross                                                   [SKIPPED]
    0 -fstackprotector not supported                                [SKIPPED]

    139 test(s) passed, 4 skipped, 0 failed.
    See all results in /labs/linux-lab/logging/nolibc/arm-vexpress-a9-nolibc-test.log

    LOG: testing summary:

         arch/board | result
        ------------|------------
    arm/vexpress-a9 | 139 test(s) passed, 4 skipped, 0 failed. See all results in /labs/linux-lab/logging/nolibc/arm-vexpress-a9-nolibc-test.log

Changes from v2 --> v3:

* Added Reviewed-by from Thomas for the whole series, Many Thanks

* selftests/nolibc: stat_fault: silence NULL argument warning with glibc
  selftests/nolibc: gettid: restore for glibc and musl
  selftests/nolibc: add _LARGEFILE64_SOURCE for musl
  selftests/nolibc: fix up int_fast16/32_t test cases for musl
  selftests/nolibc: fix up kernel parameters support
  selftests/nolibc: stat_timestamps: remove procfs dependency
  selftests/nolibc: link_cross: use /proc/self/cmdline
  tools/nolibc: add rmdir() support
  selftests/nolibc: add a new rmdir() test case
  selftests/nolibc: fix up failures when CONFIG_PROC_FS=n
  selftests/nolibc: vfprintf: remove MEMFD_CREATE dependency

    No code changes except some commit message cleanups.

* selftests/nolibc: prepare /tmp for tmpfs or ramfs

    As suggested by Thomas, simply calling mkdir() and mount() to
    prepare /tmp can save a stat() call.

* selftests/nolibc: chroot_exe: remove procfs dependency

    As suggested by Thomas, remove the 'weird' get_tmpfile() and use
    the '/init' for !procfs as we did for stat_timestamps.

    For the worst-case scene, when '/init' is not there, add ENOENT to
    the error check list.

    Now, it is a oneline code change.

* selftests/nolibc: add chmod_tmpdir test

    Without get_tmpfile(), let's direct mkdir() a temp directory for
    chmod_tmpdir test, it function as a substitute for the removed
    chmod_net.

    Now, it is a oneline code change.

Best regards,
Zhangjin
---
[1]: https://lore.kernel.org/lkml/cover.1688078604.git.falcon@tinylab.org/

Zhangjin Wu (14):
  selftests/nolibc: stat_fault: silence NULL argument warning with glibc
  selftests/nolibc: gettid: restore for glibc and musl
  selftests/nolibc: add _LARGEFILE64_SOURCE for musl
  selftests/nolibc: fix up int_fast16/32_t test cases for musl
  selftests/nolibc: fix up kernel parameters support
  selftests/nolibc: stat_timestamps: remove procfs dependency
  selftests/nolibc: chroot_exe: remove procfs dependency
  selftests/nolibc: link_cross: use /proc/self/cmdline
  tools/nolibc: add rmdir() support
  selftests/nolibc: add a new rmdir() test case
  selftests/nolibc: fix up failures when CONFIG_PROC_FS=n
  selftests/nolibc: prepare /tmp for tmpfs or ramfs
  selftests/nolibc: add chmod_tmpdir test
  selftests/nolibc: vfprintf: remove MEMFD_CREATE dependency

 tools/include/nolibc/sys.h                   | 22 ++++++
 tools/testing/selftests/nolibc/nolibc-test.c | 83 +++++++++++++++-----
 2 files changed, 87 insertions(+), 18 deletions(-)

-- 
2.25.1

