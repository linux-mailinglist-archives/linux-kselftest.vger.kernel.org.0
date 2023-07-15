Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6D9754A97
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jul 2023 20:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjGOSSA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Jul 2023 14:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjGOSR7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Jul 2023 14:17:59 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6547130DE;
        Sat, 15 Jul 2023 11:17:57 -0700 (PDT)
X-QQ-mid: bizesmtp78t1689445068tl6jg8yu
Received: from linux-lab-host.localdomain ( [119.123.131.162])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 16 Jul 2023 02:17:47 +0800 (CST)
X-QQ-SSF: 01200000002000D0W000B00A0000000
X-QQ-FEAT: hJ5650VbgwCCez5gf50lmXVeXP9ES1Pvanf2lA55JmcMT04izh+3rdGz77p6I
        hSAa/Ws4CvB3sOLsPu9mrZ0H68R5p11yl5G4D4MGNRkcrouaOoArg2E0DhISOFuvc/lRtRt
        FhachWDNECszHq0rdwnte3/JfaiWvUsMg30PSyRBdccBn8hcFRLB//IMSBU1GIFmoczyAay
        2zJWFIXaGQX0nO8TQK9OHjh9uZBJEJw5FhcJZ1cHkQQ4GMiVTUSUU9rF2YH3Uii2zUsXQt4
        SLel7kdBtlH+m56NNFiWvOxfERCSHeu8MVY4HQUUeWvjmopgq6azgd3wEo4E6H/nqvcRIhg
        /fg+mJeiDVdR3buhHEQD6SkdCGcjk2MjGxuq2jqsbwcnga/IhtliW6jDQsB4g==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17201871288852386837
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v4 01/18] tools/nolibc: arch-*.h: add missing space after ','
Date:   Sun, 16 Jul 2023 02:17:43 +0800
Message-Id: <4269a025b6b6aebed1a20fe83bb70f2a42c2f6be.1689444638.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1689444638.git.falcon@tinylab.org>
References: <cover.1689444638.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix up such errors reported by scripts/checkpatch.pl:

    ERROR: space required after that ',' (ctx:VxV)
    #148: FILE: tools/include/nolibc/arch-aarch64.h:148:
    +void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
                             ^

    ERROR: space required after that ',' (ctx:VxV)
    #148: FILE: tools/include/nolibc/arch-aarch64.h:148:
    +void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
                                      ^

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
index 6227b77a4a09..6151be6cd7a9 100644
--- a/tools/include/nolibc/arch-aarch64.h
+++ b/tools/include/nolibc/arch-aarch64.h
@@ -175,7 +175,7 @@ char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
 /* startup code */
-void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
+void __attribute__((weak, noreturn, optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 #ifdef _NOLIBC_STACKPROTECTOR
diff --git a/tools/include/nolibc/arch-arm.h b/tools/include/nolibc/arch-arm.h
index 4d4887a5f04b..5b12b6e1c83e 100644
--- a/tools/include/nolibc/arch-arm.h
+++ b/tools/include/nolibc/arch-arm.h
@@ -225,7 +225,7 @@ char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
 /* startup code */
-void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
+void __attribute__((weak, noreturn, optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 #ifdef _NOLIBC_STACKPROTECTOR
diff --git a/tools/include/nolibc/arch-i386.h b/tools/include/nolibc/arch-i386.h
index 4c6b7c04e2e7..35680b4a25d4 100644
--- a/tools/include/nolibc/arch-i386.h
+++ b/tools/include/nolibc/arch-i386.h
@@ -190,7 +190,7 @@ const unsigned long *_auxv __attribute__((weak));
  * 2) The deepest stack frame should be set to zero
  *
  */
-void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
+void __attribute__((weak, noreturn, optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 #ifdef _NOLIBC_STACKPROTECTOR
diff --git a/tools/include/nolibc/arch-loongarch.h b/tools/include/nolibc/arch-loongarch.h
index 8aa7724fe38e..ada5a69e3fcc 100644
--- a/tools/include/nolibc/arch-loongarch.h
+++ b/tools/include/nolibc/arch-loongarch.h
@@ -167,7 +167,7 @@ const unsigned long *_auxv __attribute__((weak));
 #endif
 
 /* startup code */
-void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
+void __attribute__((weak, noreturn, optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 #ifdef _NOLIBC_STACKPROTECTOR
diff --git a/tools/include/nolibc/arch-mips.h b/tools/include/nolibc/arch-mips.h
index a2bfdf57b957..dd0f12131b55 100644
--- a/tools/include/nolibc/arch-mips.h
+++ b/tools/include/nolibc/arch-mips.h
@@ -205,7 +205,7 @@ char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
 /* startup code, note that it's called __start on MIPS */
-void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector __start(void)
+void __attribute__((weak, noreturn, optimize("omit-frame-pointer"))) __no_stack_protector __start(void)
 {
 	__asm__ volatile (
 		/*".set nomips16\n"*/
diff --git a/tools/include/nolibc/arch-riscv.h b/tools/include/nolibc/arch-riscv.h
index cd958b2f4b1b..1dd7083c2ac8 100644
--- a/tools/include/nolibc/arch-riscv.h
+++ b/tools/include/nolibc/arch-riscv.h
@@ -180,7 +180,7 @@ char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
 /* startup code */
-void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
+void __attribute__((weak, noreturn, optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 		".option push\n"
diff --git a/tools/include/nolibc/arch-s390.h b/tools/include/nolibc/arch-s390.h
index a644ecd361c0..8254caff8bfa 100644
--- a/tools/include/nolibc/arch-s390.h
+++ b/tools/include/nolibc/arch-s390.h
@@ -166,7 +166,7 @@ char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
 /* startup code */
-void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
+void __attribute__((weak, noreturn, optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 		"lg	%r2,0(%r15)\n"		/* argument count */
diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
index e69113742a99..fb00ab2e9274 100644
--- a/tools/include/nolibc/arch-x86_64.h
+++ b/tools/include/nolibc/arch-x86_64.h
@@ -190,7 +190,7 @@ const unsigned long *_auxv __attribute__((weak));
  * 2) The deepest stack frame should be zero (the %rbp).
  *
  */
-void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
+void __attribute__((weak, noreturn, optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 #ifdef _NOLIBC_STACKPROTECTOR
-- 
2.25.1


