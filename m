Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B1C770E07
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Aug 2023 08:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjHEGMV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Aug 2023 02:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjHEGMU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Aug 2023 02:12:20 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35F64ED7;
        Fri,  4 Aug 2023 23:12:18 -0700 (PDT)
X-QQ-mid: bizesmtp62t1691215929tog00vde
Received: from linux-lab-host.localdomain ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 05 Aug 2023 14:12:07 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: SFhf6fKhx/8agEErdMFhc7b3CoQDfYYa64dUygiIKK6bfOZW6eaO50gmvgSkJ
        OB2wiuG3XUXSphcBxzDQxJ8KvWYDUBOCG/qoCQhBDcxqxE/86kdeVcccD8qpUqs15yjeJzZ
        exjvN/l5mh7xTgDXFe/PzeMYPSNntJp8E4l9XUXxt+6KIwfohSXa8LlMLWBQrQe5+YvQWr4
        HKdVPxT5hcEAwPGdjf8HubUIfTFKdxHSfAGChvwOPFs0XUk7l/iBSC5psv5GkI9Z+cI1yxc
        9Wu+MJ5k2GW5hkmk0Zvbxi2wgOK5CHoZV3Knytk3+cGpEbkXcYRgQG4eHY64SDUI0DyGccD
        nhNSMAqRrd0rn376xf0rcC+l9pWB7sFcEuTc3fjAbe+9u2CcbprXWHT0bGe4c62rPAherny
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1579897849559597880
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 2/3] tools/nolibc: stackprotector.h: make __stack_chk_init static
Date:   Sat,  5 Aug 2023 14:12:06 +0800
Message-Id: <faf22279ef2c69a18a4fe01c4b4ea82bccc3e74d.1691215074.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1691215074.git.falcon@tinylab.org>
References: <cover.1691215074.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This allows to generate smaller text/data/dec size.

As the _start_c() function added by crt.h, __stack_chk_init() is called
from _start_c() instead of the assembly _start. So, it is able to mark
it with static now.

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
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

