Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C0E720EA6
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jun 2023 10:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjFCILD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 3 Jun 2023 04:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjFCILC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 3 Jun 2023 04:11:02 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D0C1B3;
        Sat,  3 Jun 2023 01:10:59 -0700 (PDT)
X-QQ-mid: bizesmtp84t1685779850t070pfh4
Received: from linux-lab-host.localdomain ( [119.123.130.226])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 03 Jun 2023 16:10:48 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: OFQdrTmJ2CRHOIPOvPtA3e3sNPsSHx/EuKOIZ/4rlJjrEdoz8zKYkHvsc0a0g
        uVElhx17GeBytasxWjr74uHrLAFmp+cvg7v6zEQSDxFWP6HpzXc7UFvixkc50irMnOQ1Me1
        lbNXYNdCQLzyQig1+Cd5VecTpxTacvtTO+UqOwAYJad0x7TPJCcbgpSvABLqWjhYXCljV4m
        TClILQ1MrAGVoIvZrkY1gANg57tvM20wBNI/U6b/7ga+0lEl1pQmQEB+/+Db4McoyZ+Iyy9
        gEwwBqdKP7S3mJAY8hy6BQKUEB/NZX9drKaKSNugSWr/jD0pRZ/glA5QiZfYdWBrDLRaaBm
        KkCuQ+A1QhNTfHOjLdVXMFG36sDOzck8GP7x3X17LS7yCrUaXus5m0UCVqCs/gNPr/+t88C
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4932993796128682688
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH v3 07/12] tools/nolibc: arm: add missing my_syscall6
Date:   Sat,  3 Jun 2023 16:09:41 +0800
Message-Id: <75c37f86eb9ae5173d136676432d5ace3a8c54df.1685777982.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685777982.git.falcon@tinylab.org>
References: <cover.1685777982.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is required by the coming removal of the oldselect and newselect
support.

pselect6/pselect6_time64 will be used unconditionally, they have 6
arguments.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/linux-riscv/bf3e07c1-75f5-425b-9124-f3f2b230e63a@app.fastmail.com/
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/arch-arm.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/include/nolibc/arch-arm.h b/tools/include/nolibc/arch-arm.h
index 45b89ffe8247..ca4c66987497 100644
--- a/tools/include/nolibc/arch-arm.h
+++ b/tools/include/nolibc/arch-arm.h
@@ -198,6 +198,29 @@ struct sys_stat_struct {
 	_arg1;                                                                \
 })
 
+#define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)                  \
+({                                                                            \
+	register long _num  __asm__(_NOLIBC_SYSCALL_REG) = (num);             \
+	register long _arg1 __asm__ ("r0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("r1") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("r2") = (long)(arg3);                    \
+	register long _arg4 __asm__ ("r3") = (long)(arg4);                    \
+	register long _arg5 __asm__ ("r4") = (long)(arg5);                    \
+	register long _arg6 __asm__ ("r5") = (long)(arg6);                    \
+	                                                                      \
+	__asm__  volatile (                                                   \
+		_NOLIBC_THUMB_SET_R7                                          \
+		"svc #0\n"                                                    \
+		_NOLIBC_THUMB_RESTORE_R7                                      \
+		: "=r"(_arg1), "=r" (_num)                                    \
+		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), \
+		  "r"(_arg6), "r"(_num)                                       \
+		: "memory", "cc", "lr"                                        \
+	);                                                                    \
+	_arg1;                                                                \
+})
+
+
 char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
-- 
2.25.1

