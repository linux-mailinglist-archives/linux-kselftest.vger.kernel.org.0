Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEF87149DC
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 May 2023 15:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjE2NH6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 May 2023 09:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjE2NH5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 May 2023 09:07:57 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693B091;
        Mon, 29 May 2023 06:07:55 -0700 (PDT)
X-QQ-mid: bizesmtp85t1685365665tgzca5zc
Received: from linux-lab-host.localdomain ( [119.123.130.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 29 May 2023 21:07:44 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: hvKw+PyJ8U6+uRVu/0AXG0i6+eBsNcwRbz2CZsT5niaVOLEjABKXMEbu2AisN
        uImWTWIWpl/bgpjuSuZqGv9sxOil3B8sj88KJEHleCbTRcmkdCIZoLB6KuLdqDUTW/bfNHC
        qcNmAe1dPOSnMPzWdJrTK1Ms82OBZOdRa1pz17Cotzmwgaz+8DZqQVeH3+/EUj/1QaNFLGz
        b2cbQLpbMgX9/StyBR2UmwLCa8hQ3pd50wYkdVem43lLqUAUknVygFLGVgwnoRvuXt9XlD+
        WyFHJ5lc3V/61Lo3BiaP/0HyPHI9bUnvaaUqXjUNVMv/vv4BLH2GeBCvf6tk9glgdi9gP0O
        rWlZSsaWPXG4mlGnUKp0F+MP099LijaKfcqzPbPVlQN2SixFKEGVRTrwrpVqUAPa09QjuW9
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13225124570130202105
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH v2 6/7] tools/nolibc: arm: add missing my_syscall6
Date:   Mon, 29 May 2023 21:07:42 +0800
Message-Id: <ba91771d72f9a9dc869513155240deab196e4fd7.1685362482.git.falcon@tinylab.org>
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

This is required by the coming removal of the oldselect and newselect
support.

pselect6/pselect6_time64 will be used unconditionally, they have 6
arguments.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/linux-riscv/20230524182431.268908-1-falcon@tinylab.org/T/#t
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

