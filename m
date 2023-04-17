Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54076E4DE8
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Apr 2023 18:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjDQQB6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Apr 2023 12:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjDQQBx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Apr 2023 12:01:53 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC76C17B;
        Mon, 17 Apr 2023 09:01:43 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1681747301;
        bh=9096Axbwkb5RULpEWmhmqDxDTfhtR94gJcnvpcVYljc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=hzQwJo69/eMSqc5dq85JLzKI3yUdHw/NvcRfp8mtuU+HYH1DFKD6Xdxi6JDWeqi8M
         AUGR54oBJ7UV7UKIiwWHjFfYlHq0d7lmJgl8YZYVyuQP3CBBu0UU5tWsY8KbX+m9pj
         QlwCFb9z0YOB/U7zSNrt6kTyXZKtCVG4sL9bQI0c=
Date:   Mon, 17 Apr 2023 18:01:32 +0200
Subject: [PATCH 2/6] tools/nolibc: riscv: add stackprotector support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230408-nolibc-stackprotector-archs-v1-2-271f5c859c71@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681747300; l=1984;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=9096Axbwkb5RULpEWmhmqDxDTfhtR94gJcnvpcVYljc=;
 b=G2kyIfSoKVPBz/GbvVu4K6RodfnUF9UYUpy4/vKKzawGKD6LgcM4U5ANPLBC+L0xsG5FO0iA0
 a4UzdbTWSHsBeIc6cRypowKluMPEQ5m7M6apMZsDwFnowwAP53abYcF
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
 tools/include/nolibc/arch-riscv.h       | 7 ++++++-
 tools/testing/selftests/nolibc/Makefile | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/arch-riscv.h b/tools/include/nolibc/arch-riscv.h
index 0d5f15fdedc4..b2ccffcc079f 100644
--- a/tools/include/nolibc/arch-riscv.h
+++ b/tools/include/nolibc/arch-riscv.h
@@ -173,14 +173,19 @@ struct sys_stat_struct {
 char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
+#define __ARCH_SUPPORTS_STACK_PROTECTOR
+
 /* startup code */
-void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
+void __attribute__((weak,noreturn,optimize("omit-frame-pointer"),no_stack_protector)) _start(void)
 {
 	__asm__ volatile (
 		".option push\n"
 		".option norelax\n"
 		"lla   gp, __global_pointer$\n"
 		".option pop\n"
+#ifdef NOLIBC_STACKPROTECTOR
+		"call __stack_chk_init\n"    /* initialize stack protector                          */
+#endif
 		"lw    a0, 0(sp)\n"          /* argc (a0) was in the stack                          */
 		"add   a1, sp, "SZREG"\n"    /* argv (a1) = sp                                      */
 		"slli  a2, a0, "PTRLOG"\n"   /* envp (a2) = SZREG*argc ...                          */
diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 3c8e3a6f8985..0a83ad388a16 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -82,6 +82,7 @@ CFLAGS_STACKPROTECTOR = -DNOLIBC_STACKPROTECTOR \
 CFLAGS_STKP_i386 = $(CFLAGS_STACKPROTECTOR)
 CFLAGS_STKP_x86_64 = $(CFLAGS_STACKPROTECTOR)
 CFLAGS_STKP_x86 = $(CFLAGS_STACKPROTECTOR)
+CFLAGS_STKP_riscv = $(CFLAGS_STACKPROTECTOR)
 CFLAGS_s390 = -m64
 CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 \
 		$(call cc-option,-fno-stack-protector) \

-- 
2.40.0

