Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61616E4DF0
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Apr 2023 18:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjDQQCK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Apr 2023 12:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjDQQBz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Apr 2023 12:01:55 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB059CC13;
        Mon, 17 Apr 2023 09:01:47 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1681747302;
        bh=7JAtwI3C3P/xbRS3GHZabYuHj1wyiMQ9ppPE8nh6168=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=WpoZErt0EHw1mQ1j5YnoJf8dhOeV5qO12+XK00Uapv+8i9fhb5pawhHWE+TWthp6O
         k0CkzLh0HaGJOLMPBHbEFeRb7UE5x1MK32yPEUP/P5q4P1lW/5Mmqa1lGNc27sSwkj
         Lg+HfGjj8OQxX+f1hvW0HXBCunDIQl5/Gih+7kYQ=
Date:   Mon, 17 Apr 2023 18:01:36 +0200
Subject: [PATCH 6/6] tools/nolibc: mips: add stackprotector support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230408-nolibc-stackprotector-archs-v1-6-271f5c859c71@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681747300; l=1927;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=7JAtwI3C3P/xbRS3GHZabYuHj1wyiMQ9ppPE8nh6168=;
 b=iozURWBM7REeKZo0rYtfFd1FC9qFdufDUvWCJFMpYA9cdyZYwkyNhkDY4aycsW5EaJEgHllPA
 ZiuL3/UUboiAOCtF1+SCsTQsmkj3cUg4PycI16wiDTxXNluKC8ZobuC
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
 tools/include/nolibc/arch-mips.h        | 8 +++++++-
 tools/testing/selftests/nolibc/Makefile | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/arch-mips.h b/tools/include/nolibc/arch-mips.h
index 8822f150e72f..65c19ccc7f9d 100644
--- a/tools/include/nolibc/arch-mips.h
+++ b/tools/include/nolibc/arch-mips.h
@@ -179,14 +179,20 @@ struct sys_stat_struct {
 char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
+#define __ARCH_SUPPORTS_STACK_PROTECTOR
+
 /* startup code, note that it's called __start on MIPS */
-void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __start(void)
+void __attribute__((weak,noreturn,optimize("omit-frame-pointer"),no_stack_protector)) __start(void)
 {
 	__asm__ volatile (
 		/*".set nomips16\n"*/
 		".set push\n"
 		".set    noreorder\n"
 		".option pic0\n"
+#ifdef NOLIBC_STACKPROTECTOR
+		"jal __stack_chk_init\n" /* initialize stack protector                         */
+		"nop\n"                  /* delayed slot                                       */
+#endif
 		/*".ent __start\n"*/
 		/*"__start:\n"*/
 		"lw $a0,($sp)\n"        /* argc was in the stack                               */
diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index efa7a51e0fcd..a7524445f33c 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -84,6 +84,7 @@ CFLAGS_STKP_x86_64 = $(CFLAGS_STACKPROTECTOR)
 CFLAGS_STKP_x86 = $(CFLAGS_STACKPROTECTOR)
 CFLAGS_STKP_arm64 = $(CFLAGS_STACKPROTECTOR)
 CFLAGS_STKP_arm = $(CFLAGS_STACKPROTECTOR)
+CFLAGS_STKP_mips = $(CFLAGS_STACKPROTECTOR)
 CFLAGS_STKP_riscv = $(CFLAGS_STACKPROTECTOR)
 CFLAGS_STKP_loongarch = $(CFLAGS_STACKPROTECTOR)
 CFLAGS_s390 = -m64

-- 
2.40.0

