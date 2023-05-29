Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BC1714FE7
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 May 2023 21:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjE2Tpx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 May 2023 15:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjE2Tpw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 May 2023 15:45:52 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D9FB7;
        Mon, 29 May 2023 12:45:47 -0700 (PDT)
X-QQ-mid: bizesmtp74t1685389534t2pmulyx
Received: from linux-lab-host.localdomain ( [119.123.130.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 30 May 2023 03:45:33 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: q+EIYT+FhZr5npvZn5RUSuCoEjlYjUFY7pH0vfKp8wnTF1d+eR9ArRWdMSotd
        gwHgiQyUkXUekZqHajk39a7kDlXuaLoJHlc/XWlniLk8SPET64nI2ROI+OY87xOMgRWwYXr
        NhzDgVTzfU1GpxKkbdJc9cdOIxbI+1rn1MYb+fdIPiEOgRvoZDPoUc9UdUuldIQe1xoP5j3
        bY40DDiCWS/ZwGdJ14peGqyZo6rIKEw+HxKEAwkXkF8TKA+Xn5174CPxllFTV03bNABvRj8
        3Z2IgCfIgLyo0n43JjOYK99rkJdRr421LHbHID1/Kfg9LepZ9LYCD8fs3g7KBi2/DnorgT/
        sg914fI0HQCCLj1Vu83jLXIfbtTnQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11560036856489134549
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH v2 00/13] nolibc: add part2 of support for rv32
Date:   Tue, 30 May 2023 03:45:23 +0800
Message-Id: <cover.1685387484.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hi, all

Thanks very much for your review suggestions of the v1 series [1], we
just sent out the generic part1 [2], and here is the part2 of the whole
v2 revision.

Changes from v1 -> v2:

* Don't emulate the return values in the new syscalls path, fix up or
  support the new syscalls in the side of the related test cases (1-3)

  selftests/nolibc: remove gettimeofday_bad1/2 completely
  selftests/nolibc: support two errnos with EXPECT_SYSER2()
  selftests/nolibc: waitpid_min: add waitid syscall support

  (Review suggestions from Willy and Thomas)

* Fix up new failure of the state_timestamps test case (4, new)

  tools/nolibc: add missing nanoseconds support for __NR_statx

  (Fixes for the commit a89c937d781a ("tools/nolibc: support nanoseconds in stat()")

* Add new waitstatus macros as a standalone patch for the waitid support (5)

  tools/nolibc: add more wait status related types

  (Split and Cleanup for the waitid syscall based sys_wait4)

* Pure 64bit lseek and time64 select/poll/gettimeofday support (6-11)

  tools/nolibc: add pure 64bit off_t, time_t and blkcnt_t
  tools/nolibc: sys_lseek: add pure 64bit lseek
  tools/nolibc: add pure 64bit time structs
  tools/nolibc: sys_select: add pure 64bit select
  tools/nolibc: sys_poll: add pure 64bit poll
  tools/nolibc: sys_gettimeofday: add pure 64bit gettimeofday

  (Review suggestions from Arnd, Thomas and Willy, time32 variants have
   been removed completely and some fixups)

* waitid syscall support cleanup (12)

  tools/nolibc: sys_wait4: add waitid syscall support

  (Sync with the waitstatus macros update and Removal of emulated code)

* rv32 nolibc-test support, commit message update (13)

  selftests/nolibc: riscv: customize makefile for rv32

  (Review suggestions from Thomas, explain more about the change logic in commit message)

Best regards,
Zhangjin
---

[1]: https://lore.kernel.org/linux-riscv/20230529113143.GB2762@1wt.eu/T/#t
[2]: https://lore.kernel.org/linux-riscv/cover.1685362482.git.falcon@tinylab.org/

Zhangjin Wu (13):
  selftests/nolibc: remove gettimeofday_bad1/2 completely
  selftests/nolibc: support two errnos with EXPECT_SYSER2()
  selftests/nolibc: waitpid_min: add waitid syscall support
  tools/nolibc: add missing nanoseconds support for __NR_statx
  tools/nolibc: add more wait status related types
  tools/nolibc: add pure 64bit off_t, time_t and blkcnt_t
  tools/nolibc: sys_lseek: add pure 64bit lseek
  tools/nolibc: add pure 64bit time structs
  tools/nolibc: sys_select: add pure 64bit select
  tools/nolibc: sys_poll: add pure 64bit poll
  tools/nolibc: sys_gettimeofday: add pure 64bit gettimeofday
  tools/nolibc: sys_wait4: add waitid syscall support
  selftests/nolibc: riscv: customize makefile for rv32

 tools/include/nolibc/arch-aarch64.h          |   3 -
 tools/include/nolibc/arch-loongarch.h        |   3 -
 tools/include/nolibc/arch-riscv.h            |   3 -
 tools/include/nolibc/std.h                   |  28 ++--
 tools/include/nolibc/sys.h                   | 134 +++++++++++++++----
 tools/include/nolibc/types.h                 |  58 +++++++-
 tools/testing/selftests/nolibc/Makefile      |  11 +-
 tools/testing/selftests/nolibc/nolibc-test.c |  20 +--
 8 files changed, 202 insertions(+), 58 deletions(-)

-- 
2.25.1

