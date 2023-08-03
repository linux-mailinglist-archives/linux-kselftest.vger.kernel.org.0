Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3554176ED1C
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 16:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbjHCOrj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 10:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235671AbjHCOrh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 10:47:37 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E93C1BE4;
        Thu,  3 Aug 2023 07:47:15 -0700 (PDT)
X-QQ-mid: bizesmtp78t1691074025tkmonxr9
Received: from linux-lab-host.localdomain ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 03 Aug 2023 22:47:04 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: EKa9/5zJOSjEdzda4qaDuVCtg7Ilp8g7uMOnt2Znfu3gOhN23U58dt8i2H0rQ
        wL7+pkiMzvAKuxsqW+rE00MFBYMdyTnHePlHshxwQ/zl6vI/IyQEfs3kKI6VG8Pff13TJaR
        u6BakN1cnrbLslooXXrsyYGIH3Rm+CWvRrE+96D7kdTdSW2e/5zi4nLM1QZ4PKmo3kMkX8B
        nQH69mtUKZEDlygzHvq2A0U2IDAC3ah9yya5qGoNb4Iw0+zV76LxZvO71ZhHTIIWBMMFrwM
        GTpRKl1iVuvFCe24lsUjoJj4X7KgSO7qiaYw/6yt/R4BHwq8FCFA+YyRtEMi7qCfrzh0yTd
        LyIg4XeReqzeXtfo1EZnnMMpLDvrtk8KXiZLihozj35AoYe6/sApd8Ipv+6xpiBeRtF4nU6
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9459210872236914971
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, tanyuan@tinylab.org
Subject: [PATCH v1 3/3] tools/nolibc: stackprotector.h: make __stack_chk_init static
Date:   Thu,  3 Aug 2023 22:47:01 +0800
Message-Id: <d5eb12e6b9238dcb85935cf6af3ed12ff043f900.1691073180.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1691073180.git.falcon@tinylab.org>
References: <cover.1691073180.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This allows to generate smaller text/data/dec size.

As the _start_c() function added by crt.h, __stack_chk_init() is called
from _start_c() instead of the assembly _start. So, it is able to mark
it with static now.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/crt.h            | 2 +-
 tools/include/nolibc/stackprotector.h | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/include/nolibc/crt.h b/tools/include/nolibc/crt.h
index 32e128b0fb62..a5f33fef1672 100644
--- a/tools/include/nolibc/crt.h
+++ b/tools/include/nolibc/crt.h
@@ -10,7 +10,7 @@
 char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
-void __stack_chk_init(void);
+static void __stack_chk_init(void);
 static void exit(int);
 
 void _start_c(long *sp)
diff --git a/tools/include/nolibc/stackprotector.h b/tools/include/nolibc/stackprotector.h
index b620f2b9578d..13f1d0e60387 100644
--- a/tools/include/nolibc/stackprotector.h
+++ b/tools/include/nolibc/stackprotector.h
@@ -37,8 +37,7 @@ void __stack_chk_fail_local(void)
 __attribute__((weak,section(".data.nolibc_stack_chk")))
 uintptr_t __stack_chk_guard;
 
-__attribute__((weak,section(".text.nolibc_stack_chk"))) __no_stack_protector
-void __stack_chk_init(void)
+static __no_stack_protector void __stack_chk_init(void)
 {
 	my_syscall3(__NR_getrandom, &__stack_chk_guard, sizeof(__stack_chk_guard), 0);
 	/* a bit more randomness in case getrandom() fails, ensure the guard is never 0 */
@@ -46,7 +45,7 @@ void __stack_chk_init(void)
 		__stack_chk_guard ^= (uintptr_t) &__stack_chk_guard;
 }
 #else /* !defined(_NOLIBC_STACKPROTECTOR) */
-__inline__ void __stack_chk_init(void) {}
+static void __stack_chk_init(void) {}
 #endif /* defined(_NOLIBC_STACKPROTECTOR) */
 
 #endif /* _NOLIBC_STACKPROTECTOR_H */
-- 
2.25.1

