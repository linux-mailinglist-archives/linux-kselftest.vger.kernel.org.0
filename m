Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66923754A9A
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jul 2023 20:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjGOSTI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Jul 2023 14:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjGOSTH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Jul 2023 14:19:07 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDF426AF;
        Sat, 15 Jul 2023 11:19:05 -0700 (PDT)
X-QQ-mid: bizesmtp82t1689445135tgk85grb
Received: from linux-lab-host.localdomain ( [119.123.131.162])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 16 Jul 2023 02:18:54 +0800 (CST)
X-QQ-SSF: 01200000002000D0W000B00A0000000
X-QQ-FEAT: 7jw2iSiCazq340DjDdEZiMhlBe2vl+0NITWIEc5WkzpS4tH5riGZQoC3SIEqa
        SsnIvE5sirfAViFzUf4xtboEfVBzLVmCgo2VzbvbND5R9PvmD4iX3xV1ZEA+boiNZE8of4h
        ELzEHCOXeDggBwc6UDlbbjCfKcEiL432bL7HQqN/erfXNmi6yHC8hyroz4DhxjViDYqZXa3
        79VFtvadw2lfISIZp+TWh/Xz16Z15HiJdR6V6IgUNgeX5GIq9fs7rLcczeFopDZCkRrpkGs
        6aPZTGSs6RtjkEH5//KOpARzRzGXrZ6qkNsKHWqfoczMIdqskxL/rzRR/5pIxcMvkStBbio
        pQIRac8+WKwWg1b0F2fDLuRmKBo/1HAnKv0klQ8whW2ITk6KvVSri3sXp7GtmPpPxb1vI8T
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12656723689235740385
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v4 02/18] tools/nolibc: fix up startup failures for -O0 under gcc < 11.1.0
Date:   Sun, 16 Jul 2023 02:18:54 +0800
Message-Id: <ac46d4fd8cec20a14706f3eed169e570f98024ad.1689444638.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1689444638.git.falcon@tinylab.org>
References: <cover.1689444638.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As gcc doc [1] shows:

  Most optimizations are completely disabled at -O0 or if an -O level is
  not set on the command line, even if individual optimization flags are
  specified.

Test result [2] shows, gcc>=11.1.0 deviates from the above description,
but before gcc 11.1.0, "-O0" still forcely uses frame pointer in the
_start function even if the individual optimize("omit-frame-pointer")
flag is specified.

The frame pointer related operations will change the stack pointer (e.g.
In x86_64, an extra "push %rbp" will be inserted at the beginning of
_start) and make it differs from the one we expected, as a result, break
the whole startup function.

To fix up this issue, as suggested by Thomas, the individual "Os" and
"omit-frame-pointer" optimize flags are used together on _start function
to disable frame pointer completely even if the -O0 is set on the
command line.

[1]: https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html
[2]: https://lore.kernel.org/lkml/20230714094723.140603-1-falcon@tinylab.org/

Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
Link: https://lore.kernel.org/lkml/34b21ba5-7b59-4b3b-9ed6-ef9a3a5e06f7@t-8ch.de/
Fixes: 7f8548589661 ("tools/nolibc: make compiler and assembler agree on the section around _start")
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/arch-aarch64.h   | 2 +-
 tools/include/nolibc/arch-arm.h       | 2 +-
 tools/include/nolibc/arch-i386.h      | 2 +-
 tools/include/nolibc/arch-loongarch.h | 2 +-
 tools/include/nolibc/arch-mips.h      | 2 +-
 tools/include/nolibc/arch-riscv.h     | 2 +-
 tools/include/nolibc/arch-s390.h      | 2 +-
 tools/include/nolibc/arch-x86_64.h    | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/include/nolibc/arch-aarch64.h b/tools/include/nolibc/arch-aarch64.h
index 6151be6cd7a9..21e9482a4235 100644
--- a/tools/include/nolibc/arch-aarch64.h
+++ b/tools/include/nolibc/arch-aarch64.h
@@ -175,7 +175,7 @@ char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
 /* startup code */
-void __attribute__((weak, noreturn, optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
+void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 #ifdef _NOLIBC_STACKPROTECTOR
diff --git a/tools/include/nolibc/arch-arm.h b/tools/include/nolibc/arch-arm.h
index 5b12b6e1c83e..4451bef5f94d 100644
--- a/tools/include/nolibc/arch-arm.h
+++ b/tools/include/nolibc/arch-arm.h
@@ -225,7 +225,7 @@ char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
 /* startup code */
-void __attribute__((weak, noreturn, optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
+void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 #ifdef _NOLIBC_STACKPROTECTOR
diff --git a/tools/include/nolibc/arch-i386.h b/tools/include/nolibc/arch-i386.h
index 35680b4a25d4..4c94a81e860f 100644
--- a/tools/include/nolibc/arch-i386.h
+++ b/tools/include/nolibc/arch-i386.h
@@ -190,7 +190,7 @@ const unsigned long *_auxv __attribute__((weak));
  * 2) The deepest stack frame should be set to zero
  *
  */
-void __attribute__((weak, noreturn, optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
+void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 #ifdef _NOLIBC_STACKPROTECTOR
diff --git a/tools/include/nolibc/arch-loongarch.h b/tools/include/nolibc/arch-loongarch.h
index ada5a69e3fcc..590155a4e543 100644
--- a/tools/include/nolibc/arch-loongarch.h
+++ b/tools/include/nolibc/arch-loongarch.h
@@ -167,7 +167,7 @@ const unsigned long *_auxv __attribute__((weak));
 #endif
 
 /* startup code */
-void __attribute__((weak, noreturn, optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
+void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 #ifdef _NOLIBC_STACKPROTECTOR
diff --git a/tools/include/nolibc/arch-mips.h b/tools/include/nolibc/arch-mips.h
index dd0f12131b55..d3f0bf4c4245 100644
--- a/tools/include/nolibc/arch-mips.h
+++ b/tools/include/nolibc/arch-mips.h
@@ -205,7 +205,7 @@ char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
 /* startup code, note that it's called __start on MIPS */
-void __attribute__((weak, noreturn, optimize("omit-frame-pointer"))) __no_stack_protector __start(void)
+void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_stack_protector __start(void)
 {
 	__asm__ volatile (
 		/*".set nomips16\n"*/
diff --git a/tools/include/nolibc/arch-riscv.h b/tools/include/nolibc/arch-riscv.h
index 1dd7083c2ac8..322c96f4acdb 100644
--- a/tools/include/nolibc/arch-riscv.h
+++ b/tools/include/nolibc/arch-riscv.h
@@ -180,7 +180,7 @@ char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
 /* startup code */
-void __attribute__((weak, noreturn, optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
+void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 		".option push\n"
diff --git a/tools/include/nolibc/arch-s390.h b/tools/include/nolibc/arch-s390.h
index 8254caff8bfa..587cc91295fa 100644
--- a/tools/include/nolibc/arch-s390.h
+++ b/tools/include/nolibc/arch-s390.h
@@ -166,7 +166,7 @@ char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
 /* startup code */
-void __attribute__((weak, noreturn, optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
+void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 		"lg	%r2,0(%r15)\n"		/* argument count */
diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
index fb00ab2e9274..5e950a04bc77 100644
--- a/tools/include/nolibc/arch-x86_64.h
+++ b/tools/include/nolibc/arch-x86_64.h
@@ -190,7 +190,7 @@ const unsigned long *_auxv __attribute__((weak));
  * 2) The deepest stack frame should be zero (the %rbp).
  *
  */
-void __attribute__((weak, noreturn, optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
+void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 #ifdef _NOLIBC_STACKPROTECTOR
-- 
2.25.1

