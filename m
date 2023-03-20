Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC2F6C1A45
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Mar 2023 16:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjCTPuZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Mar 2023 11:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbjCTPtt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Mar 2023 11:49:49 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0012B9F7;
        Mon, 20 Mar 2023 08:41:25 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1679326882;
        bh=i20Oh7UPtMkF7KR9AMHb1kh7uhEQ1eEVn8pe6hGS0IY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=IEEumZMhOJj7/5fO9M78jnYjwF6vw43+TOAY/TOfIzzevHlcJgYEvXOpVK4hK6WzL
         DYbYEfL2viDF9VD4rWWIpw6yBSn5zYJYUlTIWXC0fgSIrv1eEYwV0CA922VvWoljCG
         eIoaLVFeQNfCsVOAedKa5p8UBoO3TjLpsAssyeTc=
Date:   Mon, 20 Mar 2023 15:41:08 +0000
Subject: [PATCH v2 8/8] tools/nolibc: x86_64: add stackprotector support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230223-nolibc-stackprotector-v2-8-4c938e098d67@weissschuh.net>
References: <20230223-nolibc-stackprotector-v2-0-4c938e098d67@weissschuh.net>
In-Reply-To: <20230223-nolibc-stackprotector-v2-0-4c938e098d67@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1679326878; l=1856;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=i20Oh7UPtMkF7KR9AMHb1kh7uhEQ1eEVn8pe6hGS0IY=;
 b=yBKpZLIhD2oLBnMhKGSP33SljC5XJO6L5jLzsIMP1QRDWF8qpnRzP3lO5IRVQgThoA/S0AcOs
 KcMpHjuFCsHCZygA9AsMyhp/qPX/l1LhHvKCsQg759Tph36y0IVFjve
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

Enable the new stackprotector support for x86_64.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/arch-x86_64.h      | 5 +++++
 tools/testing/selftests/nolibc/Makefile | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
index 17f6751208e7..f7f2a11d4c3b 100644
--- a/tools/include/nolibc/arch-x86_64.h
+++ b/tools/include/nolibc/arch-x86_64.h
@@ -181,6 +181,8 @@ struct sys_stat_struct {
 char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
+#define __ARCH_SUPPORTS_STACK_PROTECTOR
+
 /* startup code */
 /*
  * x86-64 System V ABI mandates:
@@ -191,6 +193,9 @@ const unsigned long *_auxv __attribute__((weak));
 void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
 {
 	__asm__ volatile (
+#ifdef NOLIBC_STACKPROTECTOR
+		"call __stack_chk_init\n"   // initialize stack protector
+#endif
 		"pop %rdi\n"                // argc   (first arg, %rdi)
 		"mov %rsp, %rsi\n"          // argv[] (second arg, %rsi)
 		"lea 8(%rsi,%rdi,8),%rdx\n" // then a NULL then envp (third arg, %rdx)
diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 8f069ebdd124..543555f4cbdc 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -80,6 +80,8 @@ CFLAGS_STACKPROTECTOR = -DNOLIBC_STACKPROTECTOR \
 			$(call cc-option,-mstack-protector-guard=global) \
 			$(call cc-option,-fstack-protector-all)
 CFLAGS_i386 = $(CFLAGS_STACKPROTECTOR)
+CFLAGS_x86_64 = $(CFLAGS_STACKPROTECTOR)
+CFLAGS_x86 = $(CFLAGS_STACKPROTECTOR)
 CFLAGS_s390 = -m64
 CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables \
 		$(call cc-option,-fno-stack-protector) \

-- 
2.40.0

