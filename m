Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E757412A5
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 15:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbjF1Ngu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 09:36:50 -0400
Received: from bg4.exmail.qq.com ([43.154.54.12]:28837 "EHLO bg4.exmail.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231555AbjF1Ngm (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 09:36:42 -0400
X-QQ-mid: bizesmtp68t1687959386tfk2bzmm
Received: from linux-lab-host.localdomain ( [116.30.129.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 28 Jun 2023 21:36:24 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: znfcQSa1hKaTu/Ha7ZQ1+V2pKPKgcx9n9xqgBcc+SOYAX8h6kkRGQ1foUBAeE
        kncvdehoqJs9juDKWFcfnf91v40tNFH0eQpUaw2087LC37IxT3o70ShZHzxi4qbU8j9f4Jf
        OjQC38WI2V8z38rxPbae6PLJ7uZIFfF0g0UWlirZRWVd7RAIUtlkOg0YAdNOG7nAc701TXf
        g0LWaq6rxYsTiXEGw5rt3bGahKrMMBKAxfA1Z220RnBaJ+5lds/fz4bTaMuZjVqYqdKB4vJ
        CYpmXXl+DIMJE2YeOLonC/ZLLx35FWmy08Mx6wHrLSe8+5+1VVxXmzDcJcJDFWG5D/R9cFA
        zUiGHVhsiY0vSp2vIBMvWK7tymqDyhYUVoV5h3yHFMWKg9BnCvyvWng45N1mA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10609451260477278999
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v5 08/14] tools/nolibc: arch-mips.h: shrink with SYSCALL_CLOBBERLIST
Date:   Wed, 28 Jun 2023 21:31:25 +0800
Message-Id: <9e932ce3fdba8ed744319b170ce094a916ac71be.1687957589.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687957589.git.falcon@tinylab.org>
References: <cover.1687957589.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

my_syscall<N> share a same long clobber list, define a macro for them.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/arch-mips.h | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/tools/include/nolibc/arch-mips.h b/tools/include/nolibc/arch-mips.h
index 1fd1eedc12a6..55a9f01825e0 100644
--- a/tools/include/nolibc/arch-mips.h
+++ b/tools/include/nolibc/arch-mips.h
@@ -57,6 +57,10 @@ struct sys_stat_struct {
  *     don't have to experience issues with register constraints.
  */
 
+#define SYSCALL_CLOBBERLIST			\
+	"memory", "cc", "at", "v1", "hi", "lo",	\
+	"t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"
+
 #define my_syscall0(num)							\
 ({										\
 	register long _num __asm__ ("v0") = (num);				\
@@ -68,8 +72,7 @@ struct sys_stat_struct {
 		"addiu $sp, $sp, 32\n"						\
 		: "=r"(_num), "=r"(_arg4)					\
 		: "r"(_num)							\
-		: "memory", "cc", "at", "v1", "hi", "lo",			\
-		  "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"	\
+		: SYSCALL_CLOBBERLIST						\
 	);									\
 	_arg4 ? -_num : _num;							\
 })
@@ -87,8 +90,7 @@ struct sys_stat_struct {
 		: "=r"(_num), "=r"(_arg4)					\
 		: "0"(_num),							\
 		  "r"(_arg1)							\
-		: "memory", "cc", "at", "v1", "hi", "lo",			\
-		  "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"	\
+		: SYSCALL_CLOBBERLIST						\
 	);									\
 	_arg4 ? -_num : _num;							\
 })
@@ -107,8 +109,7 @@ struct sys_stat_struct {
 		: "=r"(_num), "=r"(_arg4)					\
 		: "0"(_num),							\
 		  "r"(_arg1), "r"(_arg2)					\
-		: "memory", "cc", "at", "v1", "hi", "lo",			\
-		  "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"	\
+		: SYSCALL_CLOBBERLIST						\
 	);									\
 	_arg4 ? -_num : _num;							\
 })
@@ -128,8 +129,7 @@ struct sys_stat_struct {
 		: "=r"(_num), "=r"(_arg4)					\
 		: "0"(_num),							\
 		  "r"(_arg1), "r"(_arg2), "r"(_arg3)				\
-		: "memory", "cc", "at", "v1", "hi", "lo",			\
-		  "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"	\
+		: SYSCALL_CLOBBERLIST						\
 	);									\
 	_arg4 ? -_num : _num;							\
 })
@@ -149,8 +149,7 @@ struct sys_stat_struct {
 		: "=r" (_num), "=r"(_arg4)					\
 		: "0"(_num),							\
 		  "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4)		\
-		: "memory", "cc", "at", "v1", "hi", "lo",			\
-		  "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"	\
+		: SYSCALL_CLOBBERLIST						\
 	);									\
 	_arg4 ? -_num : _num;							\
 })
@@ -172,8 +171,7 @@ struct sys_stat_struct {
 		: "=r" (_num), "=r"(_arg4)					\
 		: "0"(_num),							\
 		  "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5)	\
-		: "memory", "cc", "at", "v1", "hi", "lo",			\
-		  "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"	\
+		: SYSCALL_CLOBBERLIST						\
 	);									\
 	_arg4 ? -_num : _num;							\
 })
-- 
2.25.1

