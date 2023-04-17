Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD026E4DE7
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Apr 2023 18:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjDQQB5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Apr 2023 12:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjDQQBx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Apr 2023 12:01:53 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11143C17C;
        Mon, 17 Apr 2023 09:01:44 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1681747301;
        bh=SV0Pfjea32iU3JBvNhAyFOVe6JmW/5ny34KehlAaMpA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=lWv1JXoYtakTyiNDYa/TeNwAU31PURgcwCqVsGD4/q5qFlBxCY0h1y5ejdkSCnJ20
         Z47/xWEwPa+FMm80bhxbU9c0OFjQ4UrcO43l81++9ogfrn57E4iYrX1B5yAu6GAIir
         FaaxpWRVks96uRnB9CIAWnH6AEOpZM/37KEuCDDA=
Date:   Mon, 17 Apr 2023 18:01:34 +0200
Subject: [PATCH 4/6] tools/nolibc: arm: add stackprotector support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230408-nolibc-stackprotector-archs-v1-4-271f5c859c71@weissschuh.net>
References: <20230408-nolibc-stackprotector-archs-v1-0-271f5c859c71@weissschuh.net>
In-Reply-To: <20230408-nolibc-stackprotector-archs-v1-0-271f5c859c71@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681747300; l=1785;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=SV0Pfjea32iU3JBvNhAyFOVe6JmW/5ny34KehlAaMpA=;
 b=EB+dNZdkDJrv6azXMGBN10cFMiivbrmQOw2HL0nVG2U9hWxrpdzMeQwV5Sy22HibCOaIooGPb
 JxG5x4qjtw+Dv3Db1ADLT9rS6NSajpzDvv2Uwu+cMIcxCwn+uhuvHGN
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/arch-arm.h         | 7 ++++++-
 tools/testing/selftests/nolibc/Makefile | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/arch-arm.h b/tools/include/nolibc/arch-arm.h
index 2eab1aef321b..202e64f537dc 100644
--- a/tools/include/nolibc/arch-arm.h
+++ b/tools/include/nolibc/arch-arm.h
@@ -199,10 +199,15 @@ struct sys_stat_struct {
 char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
+#define __ARCH_SUPPORTS_STACK_PROTECTOR
+
 /* startup code */
-void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
+void __attribute__((weak,noreturn,optimize("omit-frame-pointer"),no_stack_protector)) _start(void)
 {
 	__asm__ volatile (
+#ifdef NOLIBC_STACKPROTECTOR
+		"bl __stack_chk_init\n"       /* initialize stack protector                          */
+#endif
 		"pop {%r0}\n"                 /* argc was in the stack                               */
 		"mov %r1, %sp\n"              /* argv = sp                                           */
 
diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index d68e96afea80..8feffc790a31 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -83,6 +83,7 @@ CFLAGS_STKP_i386 = $(CFLAGS_STACKPROTECTOR)
 CFLAGS_STKP_x86_64 = $(CFLAGS_STACKPROTECTOR)
 CFLAGS_STKP_x86 = $(CFLAGS_STACKPROTECTOR)
 CFLAGS_STKP_arm64 = $(CFLAGS_STACKPROTECTOR)
+CFLAGS_STKP_arm = $(CFLAGS_STACKPROTECTOR)
 CFLAGS_STKP_riscv = $(CFLAGS_STACKPROTECTOR)
 CFLAGS_s390 = -m64
 CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 \

-- 
2.40.0

