Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB1A7356C3
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jun 2023 14:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjFSMY2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Jun 2023 08:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjFSMYR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Jun 2023 08:24:17 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7432A10D7;
        Mon, 19 Jun 2023 05:23:46 -0700 (PDT)
X-QQ-mid: bizesmtp84t1687177368tfq88rp0
Received: from linux-lab-host.localdomain ( [116.30.126.60])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 19 Jun 2023 20:22:46 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: +Fw3Sd5mYDVy5IXdeJE6BIovvKlOnc3GNN6uMuvLeGf2lVehdl147neDdZAXi
        k+b0AfWCP7jJa1yW7vuS3V2NarADU/1SM6jqM/pESBtccHbLq/RLRa/Fl9zyl7PnJ63sMDH
        leUW3mRppM9T0ZdKdznzbdnsmbr/7Tq/CaZzj8VarQ9ZxoW5wmqkVVTHWC/ksz1Zi9mAGfe
        gyca9dSF5Xxo/hqh9ALn+aki21so5d64XUVsvDdnK6RH5LV1I0PDqvMvzh9A5LHOPVK59o5
        btlLHuuuHfAgY4X1GSlBc3NjMdl3aWccB5vyIkR+OvBu3iR9pJ0Lf1J521GQMedrxna1x1J
        uUCCNbuAOUr7XVZbmcnsGfmx2Llhd8rguT46ekwwqZLpqpygtw=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10358423973123995557
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH v5 0/5] nolibc: add part2 of support for rv32
Date:   Mon, 19 Jun 2023 20:22:43 +0800
Message-Id: <cover.1687176996.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

This is the revision of the v4 part2 of support for rv32 [1], this
further split the generic KARCH code out of the old rv32 compile patch
and also add kernel specific KARCH and nolibc specific NARCH for
tools/include/nolibc/Makefile too.

This is rebased on the dev.2023.06.14a branch of linux-rcu repo [2] with
basic run-user and run tests.

Changes from v4 -> v5:

* selftests/nolibc: allow customize kernel specific ARCH variable

  The KARCH customize support part splitted out of the old rv32 compile
  patch and removed the one passed to tools/include/nolibc/Makefile.

* tools/nolibc: add kernel and nolibc specific ARCH variables

  Pass original ARCH to tools/include/nolibc/Makefile, add KARCH and
  NARCH for kernel and nolibc respectively.

* selftests/nolibc: riscv: customize makefile for rv32

  Now, it is rv32 specific, no generic code.

Best regards,
Zhangjin
---
[1]: https://lore.kernel.org/linux-riscv/cover.1686128703.git.falcon@tinylab.org/
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/

Zhangjin Wu (5):
  tools/nolibc: fix up #error compile failures with -ENOSYS
  tools/nolibc: fix up undeclared syscall macros with #ifdef and -ENOSYS
  selftests/nolibc: allow customize kernel specific ARCH variable
  tools/nolibc: add kernel and nolibc specific ARCH variables
  selftests/nolibc: riscv: customize makefile for rv32

 tools/include/nolibc/Makefile           | 18 +++++++++---
 tools/include/nolibc/sys.h              | 38 ++++++++++++++++---------
 tools/testing/selftests/nolibc/Makefile | 18 ++++++++++--
 3 files changed, 55 insertions(+), 19 deletions(-)

-- 
2.25.1

