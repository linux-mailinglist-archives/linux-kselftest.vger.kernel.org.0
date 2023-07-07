Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B1274B358
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 16:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjGGOyu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 10:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjGGOyt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 10:54:49 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D343211C;
        Fri,  7 Jul 2023 07:54:46 -0700 (PDT)
X-QQ-mid: bizesmtp74t1688741672t4vg896o
Received: from linux-lab-host.localdomain ( [116.30.131.119])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 07 Jul 2023 22:54:31 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: Xz3VOcA7Mr3gnW13Mz7SkboIep4UxV/SucUK86192TK31+GR1/gFj4OOvj6fx
        +bH2BPikj/AX30RQHBZf3cNqBVb49OmRMvtvus7UF6BqrXLwg3xey2y9AhQKmAPFHVev69f
        ErK63Q3C9GNXsW+TbKtvYG0hKJt7oL6GhJxEHWf40w4lWMOFukWapJagciCTvd4/pYH0dxC
        Wqsqculf/+nBZkuztTci4N9bIlNAW/avjblu8lA7u9x7/RhXtc1btXTp+ayjqaWuQ0WOVqx
        kU7mioJpKsGBEFxYDurdJAHrZnDpDrUTGHGTwxcN9OSFLC7OxwYbgwXdezoymakZaCeP02Q
        Kj0T5ubFQuquSn4mPUVQ0t49LeHGYT4HETOnmh0nKKMen0bCqN1ugnDSRKjlg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4053769286691536026
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, thomas@t-8ch.de
Subject: [PATCH v6 04/15] tools/nolibc: arch-mips.h: shrink with _NOLIBC_SYSCALL_CLOBBERLIST
Date:   Fri,  7 Jul 2023 22:54:26 +0800
Message-Id: <3ba25ebd88fcef91a6a411472684b4b30e6018ef.1688739492.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688739492.git.falcon@tinylab.org>
References: <cover.1688739492.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

my_syscall<N> share the same long clobber list, define a macro for them.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/arch-mips.h | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/tools/include/nolibc/arch-mips.h b/tools/include/nolibc/arch-mips.h
index 22aacc07b1fc..1848f57777c4 100644
--- a/tools/include/nolibc/arch-mips.h
+++ b/tools/include/nolibc/arch-mips.h
@@ -57,6 +57,10 @@ struct sys_stat_struct {
  *     don't have to experience issues with register constraints.
  */
 
+#define _NOLIBC_SYSCALL_CLOBBERLIST \
+	"memory", "cc", "at", "v1", "hi", "lo", \
+	"t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"
+
 #define my_syscall0(num)                                                      \
 ({                                                                            \
 	register long _num __asm__ ("v0") = (num);                            \
@@ -68,8 +72,7 @@ struct sys_stat_struct {
 		"addiu $sp, $sp, 32\n"                                        \
 		: "=r"(_num), "=r"(_arg4)                                     \
 		: "r"(_num)                                                   \
-		: "memory", "cc", "at", "v1", "hi", "lo",                     \
-		  "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"  \
+		: _NOLIBC_SYSCALL_CLOBBERLIST                                 \
 	);                                                                    \
 	_arg4 ? -_num : _num;                                                 \
 })
@@ -87,8 +90,7 @@ struct sys_stat_struct {
 		: "=r"(_num), "=r"(_arg4)                                     \
 		: "0"(_num),                                                  \
 		  "r"(_arg1)                                                  \
-		: "memory", "cc", "at", "v1", "hi", "lo",                     \
-		  "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"  \
+		: _NOLIBC_SYSCALL_CLOBBERLIST                                 \
 	);                                                                    \
 	_arg4 ? -_num : _num;                                                 \
 })
@@ -107,8 +109,7 @@ struct sys_stat_struct {
 		: "=r"(_num), "=r"(_arg4)                                     \
 		: "0"(_num),                                                  \
 		  "r"(_arg1), "r"(_arg2)                                      \
-		: "memory", "cc", "at", "v1", "hi", "lo",                     \
-		  "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"  \
+		: _NOLIBC_SYSCALL_CLOBBERLIST                                 \
 	);                                                                    \
 	_arg4 ? -_num : _num;                                                 \
 })
@@ -128,8 +129,7 @@ struct sys_stat_struct {
 		: "=r"(_num), "=r"(_arg4)                                     \
 		: "0"(_num),                                                  \
 		  "r"(_arg1), "r"(_arg2), "r"(_arg3)                          \
-		: "memory", "cc", "at", "v1", "hi", "lo",                     \
-		  "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"  \
+		: _NOLIBC_SYSCALL_CLOBBERLIST                                 \
 	);                                                                    \
 	_arg4 ? -_num : _num;                                                 \
 })
@@ -149,8 +149,7 @@ struct sys_stat_struct {
 		: "=r" (_num), "=r"(_arg4)                                    \
 		: "0"(_num),                                                  \
 		  "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4)              \
-		: "memory", "cc", "at", "v1", "hi", "lo",                     \
-		  "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"  \
+		: _NOLIBC_SYSCALL_CLOBBERLIST                                 \
 	);                                                                    \
 	_arg4 ? -_num : _num;                                                 \
 })
@@ -172,8 +171,7 @@ struct sys_stat_struct {
 		: "=r" (_num), "=r"(_arg4)                                    \
 		: "0"(_num),                                                  \
 		  "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5)  \
-		: "memory", "cc", "at", "v1", "hi", "lo",                     \
-		  "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"  \
+		: _NOLIBC_SYSCALL_CLOBBERLIST                                 \
 	);                                                                    \
 	_arg4 ? -_num : _num;                                                 \
 })
-- 
2.25.1

