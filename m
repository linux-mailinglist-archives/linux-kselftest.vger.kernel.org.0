Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF9F7711F0
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Aug 2023 21:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjHETvh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Aug 2023 15:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHETvg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Aug 2023 15:51:36 -0400
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372E31732;
        Sat,  5 Aug 2023 12:51:33 -0700 (PDT)
X-QQ-mid: bizesmtp67t1691265086t04ajod9
Received: from linux-lab-host.localdomain ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 06 Aug 2023 03:51:25 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: 6/K5pWSRdGrRjODcvNiQftqMfOO2iuufKpsmwsfx8k2oOEX0y0jwaHhX2ETsf
        rx9aOsFRfFMpmmGQhGg7ZnoqsgnzgoX3xMBBdppRyprE2eUfr61jrxqePZmOxeQr67tR7Fc
        AYTVKv1+fTIkEn3loGGbkm8znfzaAeuWPMIF+SzyPr+cUI+Iculjh+vXksSfLlZVV0wvqWA
        9cPejpIknACLC2qSp3Iqb88p58Vbi/xLLTG/aTQ7tNNyIBCSG+k2RS5ujZ9NMIMNFTuy8Ua
        6zgrzkGt4PorpRdcZYLUL9dEFdPAtnOpMKfMj6A0T4xmZ7SJRwF33TrVr/kVKPAOq/qhQaQ
        NYDsiSLVf+SoRRzPFHi2dX2PT4vieUwYcXVQpl0pYhcTYjFYadtHN8zsUKpr2X3ol+8Xz5A
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5326708501739933189
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, tanyuan@tinylab.org,
        thomas@t-8ch.de
Subject: [PATCH v1 4/4] selftests/nolibc: add some notes about qemu tools
Date:   Sun,  6 Aug 2023 03:51:24 +0800
Message-Id: <6de680acbc2d87e13a680d4453ef022568bf489b.1691263493.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1691263493.git.falcon@tinylab.org>
References: <cover.1691263493.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Almost all distributions provide qemu-system-$(XARCH), their firmwares
and qemu-$(XARCH), but for the new riscv and loongarch, users may still
need to download external firmwares or compile qemu from scratch, let's
add some notes about them.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 9cd6dc0e8b75..1e92bb5138db 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -100,6 +100,18 @@ DEFCONFIG            = $(DEFCONFIG_$(XARCH))
 TEST =
 
 # QEMU_ARCH: arch names used by qemu
+#
+# Notes:
+# - qemu-system of riscv may require latest firmware from
+#   https://github.com/riscv-software-src/opensbi/releases/
+# - qemu-system of loongarch may require latest firmware from
+#   https://github.com/loongson/Firmware/tree/main/LoongArchVirtMachine
+#
+# If qemu-$(XARCH) or qemu-system-$(XARCH) is missing from software repository,
+# please compile them with help from https://wiki.qemu.org/Documentation
+#
+# To specify a firmware, please pass QEMU_ARGS_EXTRA="-bios dir/to/firmware"
+
 QEMU_ARCH_i386       = i386
 QEMU_ARCH_x86_64     = x86_64
 QEMU_ARCH_x86        = x86_64
@@ -114,7 +126,7 @@ QEMU_ARCH_s390       = s390x
 QEMU_ARCH_loongarch  = loongarch64
 QEMU_ARCH            = $(QEMU_ARCH_$(XARCH))
 
-# QEMU_ARGS : some arch-specific args to pass to qemu
+# QEMU_ARGS: some arch-specific args to pass to qemu
 QEMU_ARGS_i386       = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_x86_64     = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_x86        = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(TEST:%=NOLIBC_TEST=%)"
-- 
2.25.1

