Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E43720E96
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jun 2023 09:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjFCH7z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 3 Jun 2023 03:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjFCH7y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 3 Jun 2023 03:59:54 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E5FE41;
        Sat,  3 Jun 2023 00:59:49 -0700 (PDT)
X-QQ-mid: bizesmtp74t1685779178tv1c2476
Received: from linux-lab-host.localdomain ( [119.123.130.226])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 03 Jun 2023 15:59:37 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: iDzLjIm7mlbPeIpKhf0L/FoYc5sBCuLlmD1uXZ6PLTeLTNqoaWw5vVBt4RZJB
        5nE1u/X8VOHe4a2rR+f7qxdPnaataTsBE75Oo4mGR2USddqN+9RQQPyA/5wd+P1RNg+61hT
        T4ihHHsbzzkJRV4iR5QslKSjQPbWr51ZPYBKeCRHy+oGzp323hJBYRC8MJJxxsCRic62xGL
        ITChxxvvC1tCoY2knphq+S5rHgRqy+N1sUTxEzMkPMc4Wc6gKtQFPqVfzGFhF0AMi3yem4B
        IKCZuEyBe2QNxxuKAHqKATlXoBfkF0tk216ifnrEK8YL3kzCnQLRs5Cbn2P/6+hCCQjQ90i
        YcItibezI442FD77p6lUKtGFX33/1dqqP10oZvk
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8921411248983777273
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH v3 00/12] nolibc: add generic part1 of prepare for rv32
Date:   Sat,  3 Jun 2023 15:59:29 +0800
Message-Id: <cover.1685777982.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hi, Willy

This is the v3 generic part1 for rv32, all of the found issues of v2
part1 [1] have been fixed up, several generic patches have been fixed up
and merged from v2 part2 [2] to this series, the standalone test_fork
patch [4] is merged with a Reviewed-by line into this series too.

This series is based on 20230528-nolibc-rv32+stkp5 branch of [5].

Changes from v2 -> v3:

* selftests/nolibc: fix up compile warning with glibc on x86_64

  Use simpler 'long long' conversion instead of old #ifdef ...
  (Suggestion from Willy)

* tools/nolibc: add missing nanoseconds support for __NR_statx

  Split the compound assignment into two single assignments
  (Suggestion from Thomas)

* selftests/nolibc: add new gettimeofday test cases

  Removed the gettimeofday(NULL, &tz)
  (Suggestion from Thomas)

All of the commit messages have been re-checked, some missing
Suggested-by lines are added.

The whole patchset have been tested on arm, aarch64, rv32 and rv64, no
regressions (the next compile patchset is required to do rv32 test).

The nolibc-test has been tested with glibc on x86_64 too.

Btw, we have found such poll failures on arm (not introduced by this
patchset), this will be fixed in our coming ppoll_time64 patchset:

48 poll_null = -1 ENOSYS                                        [FAIL]
49 poll_stdout = -1 ENOSYS                                      [FAIL]
50 poll_fault = -1 ENOSYS  != (-1 EFAULT)                       [FAIL]

And the gettimeofday_null removal patch from Thomas [3] may conflicts
with the gettimeofday removal and addition patches, but it is not hard
to fix.

Best regards,
Zhangjin
---

[1]: https://lore.kernel.org/linux-riscv/cover.1685362482.git.falcon@tinylab.org/T/#t
[2]: https://lore.kernel.org/linux-riscv/cover.1685387484.git.falcon@tinylab.org/T/#t
[3]: https://lore.kernel.org/lkml/20230530-nolibc-gettimeofday-v1-1-7307441a002b@weissschuh.net/
[4]: https://lore.kernel.org/lkml/61bdfe7bacebdef8aa9195f6f2550a5b0d33aab3.1685426545.git.falcon@tinylab.org/
[5]: https://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git

Zhangjin Wu (12):
  selftests/nolibc: syscall_args: use generic __NR_statx
  tools/nolibc: add missing nanoseconds support for __NR_statx
  selftests/nolibc: allow specify extra arguments for qemu
  selftests/nolibc: fix up compile warning with glibc on x86_64
  selftests/nolibc: not include limits.h for nolibc
  selftests/nolibc: use INT_MAX instead of __INT_MAX__
  tools/nolibc: arm: add missing my_syscall6
  tools/nolibc: open: fix up compile warning for arm
  selftests/nolibc: support two errnos with EXPECT_SYSER2()
  selftests/nolibc: remove gettimeofday_bad1/2 completely
  selftests/nolibc: add new gettimeofday test cases
  selftests/nolibc: test_fork: fix up duplicated print

 tools/include/nolibc/arch-arm.h              | 23 +++++++++++
 tools/include/nolibc/stdint.h                | 14 +++++++
 tools/include/nolibc/sys.h                   | 39 +++++++++---------
 tools/testing/selftests/nolibc/Makefile      |  2 +-
 tools/testing/selftests/nolibc/nolibc-test.c | 42 ++++++++++++--------
 5 files changed, 85 insertions(+), 35 deletions(-)

-- 
2.25.1

