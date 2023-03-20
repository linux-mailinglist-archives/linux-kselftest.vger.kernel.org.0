Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652DD6C1A47
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Mar 2023 16:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjCTPu1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Mar 2023 11:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbjCTPts (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Mar 2023 11:49:48 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF79126E7;
        Mon, 20 Mar 2023 08:41:25 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1679326882;
        bh=ALZVNlFzQbWC29byVLfkuxfsVLHyQCL0ajAaJz9Wghg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=mJXCmWqS/4IZFQHCr46z0tZvRa9YXKQ4aUQNimmk4UpuirJ0BT03sbDdhpmMC90m1
         rGSdZU9Q4HAVm00YEnR1cHqRKQA5USjJ1EynQgafORZqb9q1sywlB7ffbHIymSttrS
         0jgV3+/Bi0nPpSoLuqwL9pUVncmhdtVy+ir3V3uQ=
Date:   Mon, 20 Mar 2023 15:41:07 +0000
Subject: [PATCH v2 7/8] tools/nolibc: i386: add stackprotector support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230223-nolibc-stackprotector-v2-7-4c938e098d67@weissschuh.net>
References: <20230223-nolibc-stackprotector-v2-0-4c938e098d67@weissschuh.net>
In-Reply-To: <20230223-nolibc-stackprotector-v2-0-4c938e098d67@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1679326878; l=1952;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=ALZVNlFzQbWC29byVLfkuxfsVLHyQCL0ajAaJz9Wghg=;
 b=El8yLqzdmLyDrDEodwNEvkP2cW1baetn4H+tMOSptTv+otrxoY/5EA9EDstQjzRl1YDgSNyIs
 XHuoOMWg2rrA9Ax1QVdNjRVKKf5ulR5Z/fYy6JotvCSIeRh4TwMMdnp
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Enable the new stackprotector support for i386.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/arch-i386.h        | 7 ++++++-
 tools/testing/selftests/nolibc/Makefile | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/arch-i386.h b/tools/include/nolibc/arch-i386.h
index e8d0cf545bf1..2d98d78fd3f3 100644
--- a/tools/include/nolibc/arch-i386.h
+++ b/tools/include/nolibc/arch-i386.h
@@ -181,6 +181,8 @@ struct sys_stat_struct {
 char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
+#define __ARCH_SUPPORTS_STACK_PROTECTOR
+
 /* startup code */
 /*
  * i386 System V ABI mandates:
@@ -188,9 +190,12 @@ const unsigned long *_auxv __attribute__((weak));
  * 2) The deepest stack frame should be set to zero
  *
  */
-void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
+void __attribute__((weak,noreturn,optimize("omit-frame-pointer"),no_stack_protector)) _start(void)
 {
 	__asm__ volatile (
+#ifdef NOLIBC_STACKPROTECTOR
+		"call __stack_chk_init\n"   // initialize stack protector
+#endif
 		"pop %eax\n"                // argc   (first arg, %eax)
 		"mov %esp, %ebx\n"          // argv[] (second arg, %ebx)
 		"lea 4(%ebx,%eax,4),%ecx\n" // then a NULL then envp (third arg, %ecx)
diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index b4f818547f35..8f069ebdd124 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -79,6 +79,7 @@ endif
 CFLAGS_STACKPROTECTOR = -DNOLIBC_STACKPROTECTOR \
 			$(call cc-option,-mstack-protector-guard=global) \
 			$(call cc-option,-fstack-protector-all)
+CFLAGS_i386 = $(CFLAGS_STACKPROTECTOR)
 CFLAGS_s390 = -m64
 CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables \
 		$(call cc-option,-fno-stack-protector) \

-- 
2.40.0

