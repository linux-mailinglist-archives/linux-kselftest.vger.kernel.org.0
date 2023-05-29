Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7427149BF
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 May 2023 14:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjE2M4g (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 May 2023 08:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjE2M4f (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 May 2023 08:56:35 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDC4DC;
        Mon, 29 May 2023 05:56:33 -0700 (PDT)
X-QQ-mid: bizesmtp70t1685364975tgu8b8nk
Received: from linux-lab-host.localdomain ( [119.123.130.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 29 May 2023 20:56:14 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: FVl8EHhfVR783a8W9cyjlbwbl8mKgDbq7E9fTAhEP/OvspzBBX5yVruB4eMmw
        ghv1uWTKdn3WWnfuPirBiJXTDIoLu4+zRicOyy51cEaBDTfX/44GdqG2l5NZILUSeeU6y/V
        4nd0bq9QznBIvumYMoPS1IJhTI+h4UZjFJzTkhfnat3GT8dXP6j4ZHLsH7N5xuCxnlR5i+N
        tViOrP/UytFGRtN5fuWrvTNRAFCFO9vcJkY0hSLR7kWLQqHQlgwIb2njMNj3g9mx/Q3VaKx
        Wne2knqx3TEbzRHOxPzAikzLPgS8dOE0aAI7qSy+aUfJaB6ijw98ePU52ffTHXNfn+5d2J7
        imguZhQn65iyk9XF7fsKZRTLg+vA5KqQtHQty4xBuie5vmK5jd7+JzpqmkwnnSYkYZa6DZl
        HTaaZ9JP8dI=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 561798749906670459
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de, conor@kernel.org
Subject: [PATCH v2 2/7] selftests/nolibc: allow specify extra arguments for qemu
Date:   Mon, 29 May 2023 20:56:08 +0800
Message-Id: <209c75f2c15992e95bca4f6c2f96ef7f23ab3fcc.1685362482.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685362482.git.falcon@tinylab.org>
References: <cover.1685362482.git.falcon@tinylab.org>
MIME-Version: 1.0
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

The opensbi package from Ubuntu 20.04 only provides rv64 firmwares:

    $ dpkg -S opensbi | grep -E "fw_.*bin|fw_.*elf" | uniq
    opensbi: /usr/lib/riscv64-linux-gnu/opensbi/generic/fw_dynamic.bin
    opensbi: /usr/lib/riscv64-linux-gnu/opensbi/generic/fw_jump.bin
    opensbi: /usr/lib/riscv64-linux-gnu/opensbi/generic/fw_dynamic.elf
    opensbi: /usr/lib/riscv64-linux-gnu/opensbi/generic/fw_jump.elf

To run this nolibc test for rv32, users must build opensbi or download a
prebuilt one from qemu repository:

    https://gitlab.com/qemu-project/qemu/-/blob/master/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin

And then use -bios to tell qemu use it to avoid such failure:

    $ qemu-system-riscv32 -display none -no-reboot -kernel /path/to/arch/riscv/boot/Image -serial stdio -M virt -append "console=ttyS0 panic=-1"
    qemu-system-riscv32: Unable to load the RISC-V firmware "opensbi-riscv32-generic-fw_dynamic.bin"

To run from makefile, QEMU_ARGS_EXTRA is added to allow pass extra
arguments like -bios:

    $ make run QEMU_ARGS_EXTRA="-bios /path/to/opensbi-riscv32-generic-fw_dynamic.bin" ...

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 47c3c89092e4..44088535682e 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -64,7 +64,7 @@ QEMU_ARGS_mips       = -M malta -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_riscv      = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_s390       = -M s390-ccw-virtio -m 1G -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
-QEMU_ARGS            = $(QEMU_ARGS_$(ARCH))
+QEMU_ARGS            = $(QEMU_ARGS_$(ARCH)) $(QEMU_ARGS_EXTRA)
 
 # OUTPUT is only set when run from the main makefile, otherwise
 # it defaults to this nolibc directory.
-- 
2.25.1


