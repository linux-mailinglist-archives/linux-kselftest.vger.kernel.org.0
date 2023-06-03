Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B75720E9D
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jun 2023 10:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbjFCIEf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 3 Jun 2023 04:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjFCIEd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 3 Jun 2023 04:04:33 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADC8E41;
        Sat,  3 Jun 2023 01:04:31 -0700 (PDT)
X-QQ-mid: bizesmtp76t1685779463tf50ulh5
Received: from linux-lab-host.localdomain ( [119.123.130.226])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 03 Jun 2023 16:04:21 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: zT6n3Y95oi1dVQM7LOUCe4ZErci7J0hzthPkaKsmZlRivSBkUu9oKsHTpK5iT
        0ibxDOemCdi1l+T/yHYtBufVQx/bK105xvHta2f1ev1UfOGQW6UR4QI8ILpFABfBDs4Ldez
        PAIAwuuORwFw2j7gb6/FXc65FaEcYepkFvSrRQ+mRb0nTBmRtEeYBQdeoG5IsQTuHg6VWav
        0XZceUgZxFEPKf0G/yYLqWteHLu+lfLWS/+wYVs2QNOYFcxJMAnjdiSQk+lk6r2ocBR3AjR
        QLOOVtbExyU2MM7yVMPK98ZL0kXlKhtPYmONaR6j9SstlAplCc+Pims0s10/tmrw8QxRuiR
        IkIiRQzDdA2jVEQHfKba8VIwrwOw2Q6CM6UeZHSgi5U3tez1D1Ql2UI0yb7HcSFf3/LWydY
        mcX+sxskv5U=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11632177116397536855
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v3 03/12] selftests/nolibc: allow specify extra arguments for qemu
Date:   Sat,  3 Jun 2023 16:04:10 +0800
Message-Id: <6763a735c95fe0fea8109450411c7501e02ce2b6.1685777982.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685777982.git.falcon@tinylab.org>
References: <cover.1685777982.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
Link: https://lore.kernel.org/linux-riscv/2ab94136-d341-4a26-964e-6d6c32e66c9b@t-8ch.de/
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

