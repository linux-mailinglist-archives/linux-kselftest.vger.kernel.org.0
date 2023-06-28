Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBC974127B
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 15:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjF1Nam (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 09:30:42 -0400
Received: from bg4.exmail.qq.com ([43.155.65.254]:50890 "EHLO
        bg4.exmail.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbjF1Nah (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 09:30:37 -0400
X-QQ-mid: bizesmtp62t1687959022tib37q6q
Received: from linux-lab-host.localdomain ( [116.30.129.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 28 Jun 2023 21:30:20 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: LE7C6P2vL8S1CRIbgI3gKZWFO4BCex2pqEfZtd/aX85aJ9sjdLMhw/y0Ap4tA
        7fHeizX68awglr5Opdxyh1pyvulK+J5cwyQFi0jpVR9W0e7iLNrrSLzAjXQI4ptIaAtgkqw
        /mDAJc4sQJ/jhWto1SZoK17Sdg5sHkxCIVC4A2mjnRhn7DE1KV+u0ueg6mOLQu2UP1KeIip
        Uhv/c4Wct8cBN45EWXwkRdNa9OtNasKLSnlrpf2xRniMG+fehkLsV+C4UEonZ+a1i0u9PgT
        NSR4jmWS0jHaPoy0P+3AipY3jTWBpD1iqyZgyEP8yHRyid9F0U5Gbc1GMiiVLg8PCRYV/GT
        Xi8EuPBsiJQ57h33gS9szn2ksgwW9VNGV8xGBOSphhLwE+qm82nrNY1BhQJJg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2723118437991997148
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v5 07/14] tools/nolibc: arch-loongarch.h: shrink with SYSCALL_CLOBBERLIST
Date:   Wed, 28 Jun 2023 21:22:21 +0800
Message-Id: <a906a8e5bb39d88fee89be8f2bca8bf62307d468.1687957589.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687957589.git.falcon@tinylab.org>
References: <cover.1687957589.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

my_syscall<N> share a same long clobber list, define a macro for them.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/arch-loongarch.h | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/tools/include/nolibc/arch-loongarch.h b/tools/include/nolibc/arch-loongarch.h
index 292d6a58dc87..fbb4844f7993 100644
--- a/tools/include/nolibc/arch-loongarch.h
+++ b/tools/include/nolibc/arch-loongarch.h
@@ -23,6 +23,10 @@
  */
 #define __ARCH_WANT_SYS_PSELECT6
 
+#define SYSCALL_CLOBBERLIST			\
+	"memory", "$t0", "$t1", "$t2", "$t3",	\
+	"$t4", "$t5", "$t6", "$t7", "$t8"
+
 #define my_syscall0(num)							\
 ({										\
 	register long _num __asm__ ("a7") = (num);				\
@@ -32,8 +36,7 @@
 		"syscall 0\n"							\
 		: "=r"(_arg1)							\
 		: "r"(_num)							\
-		: "memory", "$t0", "$t1", "$t2", "$t3",				\
-		  "$t4", "$t5", "$t6", "$t7", "$t8"				\
+		: SYSCALL_CLOBBERLIST						\
 	);									\
 	_arg1;									\
 })
@@ -47,8 +50,7 @@
 		"syscall 0\n"							\
 		: "+r"(_arg1)							\
 		: "r"(_num)							\
-		: "memory", "$t0", "$t1", "$t2", "$t3",				\
-		  "$t4", "$t5", "$t6", "$t7", "$t8"				\
+		: SYSCALL_CLOBBERLIST						\
 	);									\
 	_arg1;									\
 })
@@ -64,8 +66,7 @@
 		: "+r"(_arg1)							\
 		: "r"(_arg2),							\
 		  "r"(_num)							\
-		: "memory", "$t0", "$t1", "$t2", "$t3",				\
-		  "$t4", "$t5", "$t6", "$t7", "$t8"				\
+		: SYSCALL_CLOBBERLIST						\
 	);									\
 	_arg1;									\
 })
@@ -82,8 +83,7 @@
 		: "+r"(_arg1)							\
 		: "r"(_arg2), "r"(_arg3),					\
 		  "r"(_num)							\
-		: "memory", "$t0", "$t1", "$t2", "$t3",				\
-		  "$t4", "$t5", "$t6", "$t7", "$t8"				\
+		: SYSCALL_CLOBBERLIST						\
 	);									\
 	_arg1;									\
 })
@@ -101,8 +101,7 @@
 		: "+r"(_arg1)							\
 		: "r"(_arg2), "r"(_arg3), "r"(_arg4),				\
 		  "r"(_num)							\
-		: "memory", "$t0", "$t1", "$t2", "$t3",				\
-		  "$t4", "$t5", "$t6", "$t7", "$t8"				\
+		: SYSCALL_CLOBBERLIST						\
 	);									\
 	_arg1;									\
 })
@@ -121,8 +120,7 @@
 		: "+r"(_arg1)							\
 		: "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5),		\
 		  "r"(_num)							\
-		: "memory", "$t0", "$t1", "$t2", "$t3",				\
-		  "$t4", "$t5", "$t6", "$t7", "$t8"				\
+		: SYSCALL_CLOBBERLIST						\
 	);									\
 	_arg1;									\
 })
@@ -142,8 +140,7 @@
 		: "+r"(_arg1)							\
 		: "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), "r"(_arg6),	\
 		  "r"(_num)							\
-		: "memory", "$t0", "$t1", "$t2", "$t3",				\
-		  "$t4", "$t5", "$t6", "$t7", "$t8"				\
+		: SYSCALL_CLOBBERLIST						\
 	);									\
 	_arg1;									\
 })
-- 
2.25.1

