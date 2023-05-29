Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C98C7149B6
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 May 2023 14:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjE2Mww (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 May 2023 08:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjE2Mww (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 May 2023 08:52:52 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440FABE;
        Mon, 29 May 2023 05:52:47 -0700 (PDT)
X-QQ-mid: bizesmtp87t1685364752tbqd3nqk
Received: from linux-lab-host.localdomain ( [119.123.130.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 29 May 2023 20:52:31 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: OtIeQkg1QQGBD0iLBToup91HWAyjlJVY4fLjrHRj7q8MuyQZoj33NImKcbBeW
        p9vltkf7/0x2zbr4+mAilzBanNznpBNtFIuFw0H1F2pL4EG2JiS9QHW+fvR2lzuKpU30WVE
        WH+RQJj+PFCq21EloybALD0VUiXVMilk+fQlL9XuebAJl8nt/pKkYYzrpU2Ma5AUZ0hRDAQ
        L78DyIuAVd2XnluRAE1GEvz8DeLa9HtBJpaTn90pq2+hMK3W8dgtNRElM69OKWJtdrDLiJG
        iWj2m+ixqt7Zi5gn5PAAADGr9EEthMhTEf8zWR0fcouVnPppFlqvkPrPw9+EWSgroYt+6AT
        4jmwCtoHH7LOqxjQ5k42+Bsc5tmVCBcMc6gHPdTdCJKUxAaSqkJyxRLgWHGzw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12237914147384625680
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH v2 0/7] nolibc: add generic part1 of prepare for rv32
Date:   Mon, 29 May 2023 20:52:24 +0800
Message-Id: <cover.1685362482.git.falcon@tinylab.org>
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

Hi, All

Thanks very much for your review suggestions of the v1 series [1], this
is the generic part1 of the v2 revison.

* selftests/nolibc: syscall_args: use generic __NR_statx

    A more generic statx is used instead of fstat

    (Review suggestions from Willy, Arnd)

* selftests/nolibc: allow specify extra arguments for qemu

    Besides BIOS, QEMU_ARGS_EXTRA is better for more requirements

    (Review suggestions from Thomas, Willy)

* selftests/nolibc: fix up compile warning with glibc on x86_64

    Definition of uint64_t differs from glibc and nolibc, use the right
    print format here

* selftests/nolibc: not include limits.h for nolibc

    Remove the requirement of limits.h for nolibc can let us use older
    glibc for rv32

    (Review suggestions from thomas)

* selftests/nolibc: use INT_MAX instead of __INT_MAX__

    A trivial cleanup, based on the previous patch

* tools/nolibc: arm: add missing my_syscall6

    Required by future forced pselect6/pselect6_time64, tested on arm/vexpress-a9

    (Review suggestions from Arnd)

* tools/nolibc: open: fix up compile warning for arm

    A trivial fixup based on compiler's suggestion and glibc code

Best regards,
Zhangjin

----
[1]: https://lore.kernel.org/linux-riscv/20230529113143.GB2762@1wt.eu/T/#t

Zhangjin Wu (7):
  selftests/nolibc: syscall_args: use __NR_statx for rv32
  selftests/nolibc: allow specify extra arguments for qemu
  selftests/nolibc: fix up compile warning with glibc on x86_64
  selftests/nolibc: not include limits.h for nolibc
  selftests/nolibc: use INT_MAX instead of __INT_MAX__
  tools/nolibc: arm: add missing my_syscall6
  tools/nolibc: open: fix up compile warning for arm

 tools/include/nolibc/arch-arm.h              | 23 ++++++++++++++++++++
 tools/include/nolibc/stdint.h                | 14 ++++++++++++
 tools/include/nolibc/sys.h                   |  2 +-
 tools/testing/selftests/nolibc/Makefile      |  2 +-
 tools/testing/selftests/nolibc/nolibc-test.c | 14 +++++++-----
 5 files changed, 47 insertions(+), 8 deletions(-)

-- 
2.25.1

