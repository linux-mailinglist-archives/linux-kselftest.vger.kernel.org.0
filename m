Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D610670A6E5
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 May 2023 11:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjETJxm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 20 May 2023 05:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjETJxl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 20 May 2023 05:53:41 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A253FE46;
        Sat, 20 May 2023 02:53:39 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1684576417;
        bh=4DgNOA9MxUdAC/1KBzMGa1BMYIwEibXuZWjLGIR+M4Y=;
        h=From:Date:Subject:To:Cc:From;
        b=YdfF2wHQeAHvxYdN3D90MRXKyn0mgq3yjtd06cnIPS30c+UHNOpY0Lj6zZCG2aRXE
         R3QCC5C3DuZP8v/hq++VOyLpswTKYYc9s3tHXxLOevzairZCj9bJW3LQdXD9XaENgI
         qhXdmBA7ft2J/LwOQV2IfASy1Mv/MaELdY/A94OY=
Date:   Sat, 20 May 2023 11:53:35 +0200
Subject: [PATCH] tools/nolibc: riscv: add stackprotector support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230520-nolibc-stackprotector-riscv-v1-1-d8912012a034@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAJ6YaGQC/x2NQQrCMBAAv1L27EIaiaJfEQ/JdmsXQ1J2YxFK/
 27wOHOY2cFYhQ3uww7Km5jU0mE8DUBLLC9GmTqDd/7sgndYapZEaC3Se9XamFpVVDHacLw4Srd
 wnWkK0AspGmPSWGjpjfLJuctVeZbvf/l4HscP8js5B4IAAAA=
To:     Willy Tarreau <w@1wt.eu>, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shuah Khan <shuah@kernel.org>
Cc:     Zhangjin Wu <falcon@tinylab.org>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684576416; l=2523;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=4DgNOA9MxUdAC/1KBzMGa1BMYIwEibXuZWjLGIR+M4Y=;
 b=AQlACYthYxoszOZiNGyDJMnuc12eS8SCPgKc8+mKUU7vddLmVS/v0wGmHcxVJhTuTp1cUe+dP
 BrnOmwubpxDBV9w9hmNLbAtIpQb+KGH8KbEZLwivhPgdcHNYJRXZvp4
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---

This was split out from the general stackprotector series[0] to be
rebased on the nolibc rv32 work from Zhangjin.

This was only tested for rv64 as the nolibc rv32 port is not yet
functional.

Based on the nolibc/20230520-nolibc-rv32+stkp branch.

[0] https://lore.kernel.org/lkml/20230408-nolibc-stackprotector-archs-v1-0-271f5c859c71@weissschuh.net/
---
 tools/include/nolibc/arch-riscv.h       | 7 ++++++-
 tools/testing/selftests/nolibc/Makefile | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/arch-riscv.h b/tools/include/nolibc/arch-riscv.h
index 992a1739dd9c..d0439249c9c9 100644
--- a/tools/include/nolibc/arch-riscv.h
+++ b/tools/include/nolibc/arch-riscv.h
@@ -177,14 +177,19 @@ struct sys_stat_struct {
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
 		REG_L" a0, 0(sp)\n"          /* argc (a0) was in the stack                          */
 		"add   a1, sp, "SZREG"\n"    /* argv (a1) = sp                                      */
 		"slli  a2, a0, "PTRLOG"\n"   /* envp (a2) = SZREG*argc ...                          */
diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 6d660d922240..bd41102ea299 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -85,6 +85,7 @@ CFLAGS_STKP_x86 = $(CFLAGS_STACKPROTECTOR)
 CFLAGS_STKP_arm64 = $(CFLAGS_STACKPROTECTOR)
 CFLAGS_STKP_arm = $(CFLAGS_STACKPROTECTOR)
 CFLAGS_STKP_mips = $(CFLAGS_STACKPROTECTOR)
+CFLAGS_STKP_riscv = $(CFLAGS_STACKPROTECTOR)
 CFLAGS_STKP_loongarch = $(CFLAGS_STACKPROTECTOR)
 CFLAGS_s390 = -m64
 CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 \

---
base-commit: 6a1f732e0d753a691e9e787615b9a0dd92e1f3f4
change-id: 20230520-nolibc-stackprotector-riscv-160cb957fcd5

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

