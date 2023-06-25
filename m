Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8EA273D27F
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 Jun 2023 18:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjFYQkc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 25 Jun 2023 12:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjFYQkb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 25 Jun 2023 12:40:31 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F27B9;
        Sun, 25 Jun 2023 09:40:29 -0700 (PDT)
X-QQ-mid: bizesmtp83t1687711219tx6hnmn1
Received: from linux-lab-host.localdomain ( [116.30.129.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 26 Jun 2023 00:40:18 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: znfcQSa1hKZqkmvXmtk4w2PqRZkl6g8YSFZFLRaCCD2Q9Qr0cKHfrxz1j5Oc7
        qrqCMPwRHqHkl11Msd8LYesoCQIlP+Q+Fx9dLpcPU0/07y9SlF9d34z/l9arx1QkrsLh6S5
        eylyhUe0Ulm9cHjqbtDv2QGbH1VT0l5qF0x1Q1EqLZj6ShuaRRhdWDduoBADK40lNAS5aKE
        QjdPqx9LmVcpGN6iGbzxbTXpv8eArmXIRy+CvdTWOPiMz8+S7TSsjByBKz1ca90xi9mNJ68
        L3kF6gi1mMxDtXCQKY39ncXHB3pOtFQ3oxpVbrhFwnR7HKp6kfFxkE9oyaOpKEC0d3doxqg
        Sk+p/1Ci+XA1QZSMlhDDPo750RP2Zigg/olwBCAVUXFdUrOTvvWqMrIIDHZ7A==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6776819239009598717
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v1 19/22] selftests/nolibc: config default CROSS_COMPILE
Date:   Mon, 26 Jun 2023 00:39:39 +0800
Message-Id: <0ef9f42e04b8b62b8d53c0f3106f5e50629e01d5.1687706332.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687706332.git.falcon@tinylab.org>
References: <cover.1687706332.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This further simplify the 'make' commands, only require an ARCH now.

Almost all distributions provide toolchains for i386, x86_64, arm64,
arm, mips, riscv32, riscv64 and s390x.

If can not find toolchains from the distribution repositories, we can
download them from https://mirrors.edge.kernel.org/pub/tools/crosstool/
and then customize CROSS_COMPILE_<ARCH> for the testing.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 9092d209ebd0..a847a2264fed 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -74,6 +74,25 @@ EXTCONFIG_ARCH       = $(EXTCONFIG_$(ARCH))
 # extra kernel configs, include common + architecture specific
 EXTCONFIG            = $(EXTCONFIG_ARCH) $(EXTCONFIG_COMMON)
 
+# CROSS_COMPILE by architecture
+CROSS_COMPILE_i386      ?= x86_64-linux-gnu-
+CROSS_COMPILE_x86_64    ?= x86_64-linux-gnu-
+CROSS_COMPILE_x86       ?= x86_64-linux-gnu-
+CROSS_COMPILE_arm64     ?= aarch64-linux-gnu-
+CROSS_COMPILE_arm       ?= arm-linux-gnueabi-
+CROSS_COMPILE_mips      ?= mipsel-linux-gnu-
+CROSS_COMPILE_riscv32   ?= riscv64-linux-gnu-
+CROSS_COMPILE_riscv64   ?= riscv64-linux-gnu-
+CROSS_COMPILE_riscv     ?= riscv64-linux-gnu-
+CROSS_COMPILE_s390      ?= s390x-linux-gnu-
+CROSS_COMPILE_loongarch ?= loongarch64-linux-
+CROSS_COMPILE           ?= $(CROSS_COMPILE_$(ARCH))
+
+# Make sure CC has $(CROSS_COMPILE) prefix
+ifneq ($(CC),$(CROSS_COMPILE)$(CC))
+CC                      := $(CROSS_COMPILE)$(CC)
+endif
+
 # optional tests to run (default = all)
 TEST =
 
-- 
2.25.1

