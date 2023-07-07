Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1490874B34F
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 16:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjGGOxj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 10:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjGGOxj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 10:53:39 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE1C1FE1;
        Fri,  7 Jul 2023 07:53:37 -0700 (PDT)
X-QQ-mid: bizesmtp62t1688741604t1m5yidp
Received: from linux-lab-host.localdomain ( [116.30.131.119])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 07 Jul 2023 22:53:23 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: RumxddD8MdDoCupDu61PsFdnODRCtUmvZyeNJY1kEp4RpqJHc+ft0WnnMTIMl
        8E1IBp9KiQV/4Avrm24T6ReRHju3wRp/EAlp6VfplODJn88CSPwt5Hj27c/7mENQXkqeWP/
        P5icrX8GIU+X80kAmC05Iwm1qu+Z6czaDJClR1LN5Ie8oFBwT7Lens4Ftz0+Ytp+9vzlVAQ
        KIwE+Ifb3ea0bF5boi2yusAJRFWWF6WnNd9OyIiRggyyGkCuHWs7NtJ+SMwndFp0d3S331T
        7v1LN26Z7mqjG+HQNvcfKOACHySIeoz8hoDN3eQm0XRw0/P/i0CL7LszpTsjEAUjpCve+DQ
        QHwzRV0Z0bXvNPGlE/id2smOyitCsXV1ACIAjTHRO9mlbvGaRh0YqDNpH7gTg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13151235364426953370
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, thomas@t-8ch.de
Subject: [PATCH v6 03/15] tools/nolibc: arch-loongarch.h: shrink with _NOLIBC_SYSCALL_CLOBBERLIST
Date:   Fri,  7 Jul 2023 22:53:20 +0800
Message-Id: <83b89f7e2935c0708d92dc473c8434d0d304c74b.1688739492.git.falcon@tinylab.org>
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
 tools/include/nolibc/arch-loongarch.h | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/tools/include/nolibc/arch-loongarch.h b/tools/include/nolibc/arch-loongarch.h
index 8df42268e578..8aa7724fe38e 100644
--- a/tools/include/nolibc/arch-loongarch.h
+++ b/tools/include/nolibc/arch-loongarch.h
@@ -22,6 +22,8 @@
  * On LoongArch, select() is not implemented so we have to use pselect6().
  */
 #define __ARCH_WANT_SYS_PSELECT6
+#define _NOLIBC_SYSCALL_CLOBBERLIST \
+	"memory", "$t0", "$t1", "$t2", "$t3", "$t4", "$t5", "$t6", "$t7", "$t8"
 
 #define my_syscall0(num)                                                      \
 ({                                                                            \
@@ -32,8 +34,7 @@
 		"syscall 0\n"                                                 \
 		: "=r"(_arg1)                                                 \
 		: "r"(_num)                                                   \
-		: "memory", "$t0", "$t1", "$t2", "$t3",                       \
-		  "$t4", "$t5", "$t6", "$t7", "$t8"                           \
+		: _NOLIBC_SYSCALL_CLOBBERLIST                                 \
 	);                                                                    \
 	_arg1;                                                                \
 })
@@ -47,8 +48,7 @@
 		"syscall 0\n"                                                 \
 		: "+r"(_arg1)                                                 \
 		: "r"(_num)                                                   \
-		: "memory", "$t0", "$t1", "$t2", "$t3",                       \
-		  "$t4", "$t5", "$t6", "$t7", "$t8"                           \
+		: _NOLIBC_SYSCALL_CLOBBERLIST                                 \
 	);                                                                    \
 	_arg1;                                                                \
 })
@@ -64,8 +64,7 @@
 		: "+r"(_arg1)                                                 \
 		: "r"(_arg2),                                                 \
 		  "r"(_num)                                                   \
-		: "memory", "$t0", "$t1", "$t2", "$t3",                       \
-		  "$t4", "$t5", "$t6", "$t7", "$t8"                           \
+		: _NOLIBC_SYSCALL_CLOBBERLIST                                 \
 	);                                                                    \
 	_arg1;                                                                \
 })
@@ -82,8 +81,7 @@
 		: "+r"(_arg1)                                                 \
 		: "r"(_arg2), "r"(_arg3),                                     \
 		  "r"(_num)                                                   \
-		: "memory", "$t0", "$t1", "$t2", "$t3",                       \
-		  "$t4", "$t5", "$t6", "$t7", "$t8"                           \
+		: _NOLIBC_SYSCALL_CLOBBERLIST                                 \
 	);                                                                    \
 	_arg1;                                                                \
 })
@@ -101,8 +99,7 @@
 		: "+r"(_arg1)                                                 \
 		: "r"(_arg2), "r"(_arg3), "r"(_arg4),                         \
 		  "r"(_num)                                                   \
-		: "memory", "$t0", "$t1", "$t2", "$t3",                       \
-		  "$t4", "$t5", "$t6", "$t7", "$t8"                           \
+		: _NOLIBC_SYSCALL_CLOBBERLIST                                 \
 	);                                                                    \
 	_arg1;                                                                \
 })
@@ -121,8 +118,7 @@
 		: "+r"(_arg1)                                                 \
 		: "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5),             \
 		  "r"(_num)                                                   \
-		: "memory", "$t0", "$t1", "$t2", "$t3",                       \
-		  "$t4", "$t5", "$t6", "$t7", "$t8"                           \
+		: _NOLIBC_SYSCALL_CLOBBERLIST                                 \
 	);                                                                    \
 	_arg1;                                                                \
 })
@@ -142,8 +138,7 @@
 		: "+r"(_arg1)                                                 \
 		: "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), "r"(_arg6), \
 		  "r"(_num)                                                   \
-		: "memory", "$t0", "$t1", "$t2", "$t3",                       \
-		  "$t4", "$t5", "$t6", "$t7", "$t8"                           \
+		: _NOLIBC_SYSCALL_CLOBBERLIST                                 \
 	);                                                                    \
 	_arg1;                                                                \
 })
-- 
2.25.1

