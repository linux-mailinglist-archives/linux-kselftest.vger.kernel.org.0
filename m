Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D6B74B34D
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 16:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjGGOwg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 10:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjGGOwg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 10:52:36 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6371FF9;
        Fri,  7 Jul 2023 07:52:33 -0700 (PDT)
X-QQ-mid: bizesmtp72t1688741537txgey93i
Received: from linux-lab-host.localdomain ( [116.30.131.119])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 07 Jul 2023 22:52:16 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: znfcQSa1hKb1XUkvo8eX0HWlL+yR7wAWFiK0QzruRKVMnt7mEdtksu7tih+7X
        YjW6kbScnRE3aYMeztgoXEnJownNCDy+TOUpdsuMx2B5WbvP72jV8YlquZO5G5ckE8nLpKb
        pbiDLjDvXaK0KnYewnR2qSYRWKStTYtn14eRTY1wOr1tAuDfGyld8eXh43jc+4A3fonLD3b
        Mh9HWvnUCdV2YTCNwbUzhpKlI55c2XtHWmJtGcI0424F7ZhME40W8SiTFjAwdMfiQQhCUos
        kr84tjhRwzVvKSN5QO9bHUa9CMz1SW263f4GXppMnh3MrxUP9hOrf6QXZqcpuCtyxg8osyN
        XtNeF3nUuVYEP1dhu/SYI8NAVJqmnGX2gcjSUR56zrpje4Jeaz+/66yzWAGEg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4808279286737028793
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, thomas@t-8ch.de
Subject: [PATCH v6 02/15] toolc/nolibc: arch-*.h: clean up whitespaces after __asm__
Date:   Fri,  7 Jul 2023 22:52:09 +0800
Message-Id: <d140446a0fc6767b181bca9984b315fe5f407278.1688739492.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688739492.git.falcon@tinylab.org>
References: <cover.1688739492.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

replace "__asm__  volatile" with "__asm__ volatile" and insert necessary
whitespace before "\" to make sure the lines are aligned.

    $ sed -i -e 's/__asm__  volatile ( /__asm__ volatile (  /g' tools/include/nolibc/*.h

Note, arch-s390.h uses post-tab instead of post-whitespaces, must avoid
insert whitespace just before the tabs:

    $ sed -i -e 's/__asm__  volatile (\t/__asm__ volatile (\t/g' tools/include/nolibc/arch-*.h

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/arch-aarch64.h   | 14 +++++++-------
 tools/include/nolibc/arch-arm.h       | 14 +++++++-------
 tools/include/nolibc/arch-i386.h      | 12 ++++++------
 tools/include/nolibc/arch-loongarch.h | 14 +++++++-------
 tools/include/nolibc/arch-mips.h      | 12 ++++++------
 tools/include/nolibc/arch-riscv.h     | 14 +++++++-------
 tools/include/nolibc/arch-s390.h      | 14 +++++++-------
 tools/include/nolibc/arch-x86_64.h    | 14 +++++++-------
 8 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/tools/include/nolibc/arch-aarch64.h b/tools/include/nolibc/arch-aarch64.h
index c911f61365d1..6227b77a4a09 100644
--- a/tools/include/nolibc/arch-aarch64.h
+++ b/tools/include/nolibc/arch-aarch64.h
@@ -57,7 +57,7 @@ struct sys_stat_struct {
 	register long _num  __asm__ ("x8") = (num);                           \
 	register long _arg1 __asm__ ("x0");                                   \
 									      \
-	__asm__  volatile (                                                   \
+	__asm__ volatile (                                                    \
 		"svc #0\n"                                                    \
 		: "=r"(_arg1)                                                 \
 		: "r"(_num)                                                   \
@@ -71,7 +71,7 @@ struct sys_stat_struct {
 	register long _num  __asm__ ("x8") = (num);                           \
 	register long _arg1 __asm__ ("x0") = (long)(arg1);                    \
 									      \
-	__asm__  volatile (                                                   \
+	__asm__ volatile (                                                    \
 		"svc #0\n"                                                    \
 		: "=r"(_arg1)                                                 \
 		: "r"(_arg1),                                                 \
@@ -87,7 +87,7 @@ struct sys_stat_struct {
 	register long _arg1 __asm__ ("x0") = (long)(arg1);                    \
 	register long _arg2 __asm__ ("x1") = (long)(arg2);                    \
 									      \
-	__asm__  volatile (                                                   \
+	__asm__ volatile (                                                    \
 		"svc #0\n"                                                    \
 		: "=r"(_arg1)                                                 \
 		: "r"(_arg1), "r"(_arg2),                                     \
@@ -104,7 +104,7 @@ struct sys_stat_struct {
 	register long _arg2 __asm__ ("x1") = (long)(arg2);                    \
 	register long _arg3 __asm__ ("x2") = (long)(arg3);                    \
 									      \
-	__asm__  volatile (                                                   \
+	__asm__ volatile (                                                    \
 		"svc #0\n"                                                    \
 		: "=r"(_arg1)                                                 \
 		: "r"(_arg1), "r"(_arg2), "r"(_arg3),                         \
@@ -122,7 +122,7 @@ struct sys_stat_struct {
 	register long _arg3 __asm__ ("x2") = (long)(arg3);                    \
 	register long _arg4 __asm__ ("x3") = (long)(arg4);                    \
 									      \
-	__asm__  volatile (                                                   \
+	__asm__ volatile (                                                    \
 		"svc #0\n"                                                    \
 		: "=r"(_arg1)                                                 \
 		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4),             \
@@ -141,7 +141,7 @@ struct sys_stat_struct {
 	register long _arg4 __asm__ ("x3") = (long)(arg4);                    \
 	register long _arg5 __asm__ ("x4") = (long)(arg5);                    \
 									      \
-	__asm__  volatile (                                                   \
+	__asm__ volatile (                                                    \
 		"svc #0\n"                                                    \
 		: "=r" (_arg1)                                                \
 		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), \
@@ -161,7 +161,7 @@ struct sys_stat_struct {
 	register long _arg5 __asm__ ("x4") = (long)(arg5);                    \
 	register long _arg6 __asm__ ("x5") = (long)(arg6);                    \
 									      \
-	__asm__  volatile (                                                   \
+	__asm__ volatile (                                                    \
 		"svc #0\n"                                                    \
 		: "=r" (_arg1)                                                \
 		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), \
diff --git a/tools/include/nolibc/arch-arm.h b/tools/include/nolibc/arch-arm.h
index d5887fd9bc5f..4d4887a5f04b 100644
--- a/tools/include/nolibc/arch-arm.h
+++ b/tools/include/nolibc/arch-arm.h
@@ -91,7 +91,7 @@ struct sys_stat_struct {
 	register long _num  __asm__(_NOLIBC_SYSCALL_REG) = (num);             \
 	register long _arg1 __asm__ ("r0");                                   \
 									      \
-	__asm__  volatile (                                                   \
+	__asm__ volatile (                                                    \
 		_NOLIBC_THUMB_SET_R7                                          \
 		"svc #0\n"                                                    \
 		_NOLIBC_THUMB_RESTORE_R7                                      \
@@ -108,7 +108,7 @@ struct sys_stat_struct {
 	register long _num  __asm__(_NOLIBC_SYSCALL_REG) = (num);             \
 	register long _arg1 __asm__ ("r0") = (long)(arg1);                    \
 									      \
-	__asm__  volatile (                                                   \
+	__asm__ volatile (                                                    \
 		_NOLIBC_THUMB_SET_R7                                          \
 		"svc #0\n"                                                    \
 		_NOLIBC_THUMB_RESTORE_R7                                      \
@@ -126,7 +126,7 @@ struct sys_stat_struct {
 	register long _arg1 __asm__ ("r0") = (long)(arg1);                    \
 	register long _arg2 __asm__ ("r1") = (long)(arg2);                    \
 									      \
-	__asm__  volatile (                                                   \
+	__asm__ volatile (                                                    \
 		_NOLIBC_THUMB_SET_R7                                          \
 		"svc #0\n"                                                    \
 		_NOLIBC_THUMB_RESTORE_R7                                      \
@@ -145,7 +145,7 @@ struct sys_stat_struct {
 	register long _arg2 __asm__ ("r1") = (long)(arg2);                    \
 	register long _arg3 __asm__ ("r2") = (long)(arg3);                    \
 									      \
-	__asm__  volatile (                                                   \
+	__asm__ volatile (                                                    \
 		_NOLIBC_THUMB_SET_R7                                          \
 		"svc #0\n"                                                    \
 		_NOLIBC_THUMB_RESTORE_R7                                      \
@@ -165,7 +165,7 @@ struct sys_stat_struct {
 	register long _arg3 __asm__ ("r2") = (long)(arg3);                    \
 	register long _arg4 __asm__ ("r3") = (long)(arg4);                    \
 									      \
-	__asm__  volatile (                                                   \
+	__asm__ volatile (                                                    \
 		_NOLIBC_THUMB_SET_R7                                          \
 		"svc #0\n"                                                    \
 		_NOLIBC_THUMB_RESTORE_R7                                      \
@@ -186,7 +186,7 @@ struct sys_stat_struct {
 	register long _arg4 __asm__ ("r3") = (long)(arg4);                    \
 	register long _arg5 __asm__ ("r4") = (long)(arg5);                    \
 									      \
-	__asm__  volatile (                                                   \
+	__asm__ volatile (                                                    \
 		_NOLIBC_THUMB_SET_R7                                          \
 		"svc #0\n"                                                    \
 		_NOLIBC_THUMB_RESTORE_R7                                      \
@@ -208,7 +208,7 @@ struct sys_stat_struct {
 	register long _arg5 __asm__ ("r4") = (long)(arg5);                    \
 	register long _arg6 __asm__ ("r5") = (long)(arg6);                    \
 									      \
-	__asm__  volatile (                                                   \
+	__asm__ volatile (                                                    \
 		_NOLIBC_THUMB_SET_R7                                          \
 		"svc #0\n"                                                    \
 		_NOLIBC_THUMB_RESTORE_R7                                      \
diff --git a/tools/include/nolibc/arch-i386.h b/tools/include/nolibc/arch-i386.h
index c11a53acf159..4c6b7c04e2e7 100644
--- a/tools/include/nolibc/arch-i386.h
+++ b/tools/include/nolibc/arch-i386.h
@@ -58,7 +58,7 @@ struct sys_stat_struct {
 	long _ret;                                                            \
 	register long _num __asm__ ("eax") = (num);                           \
 									      \
-	__asm__  volatile (                                                   \
+	__asm__ volatile (                                                    \
 		"int $0x80\n"                                                 \
 		: "=a" (_ret)                                                 \
 		: "0"(_num)                                                   \
@@ -73,7 +73,7 @@ struct sys_stat_struct {
 	register long _num __asm__ ("eax") = (num);                           \
 	register long _arg1 __asm__ ("ebx") = (long)(arg1);                   \
 									      \
-	__asm__  volatile (                                                   \
+	__asm__ volatile (                                                    \
 		"int $0x80\n"                                                 \
 		: "=a" (_ret)                                                 \
 		: "r"(_arg1),                                                 \
@@ -90,7 +90,7 @@ struct sys_stat_struct {
 	register long _arg1 __asm__ ("ebx") = (long)(arg1);                   \
 	register long _arg2 __asm__ ("ecx") = (long)(arg2);                   \
 									      \
-	__asm__  volatile (                                                   \
+	__asm__ volatile (                                                    \
 		"int $0x80\n"                                                 \
 		: "=a" (_ret)                                                 \
 		: "r"(_arg1), "r"(_arg2),                                     \
@@ -108,7 +108,7 @@ struct sys_stat_struct {
 	register long _arg2 __asm__ ("ecx") = (long)(arg2);                   \
 	register long _arg3 __asm__ ("edx") = (long)(arg3);                   \
 									      \
-	__asm__  volatile (                                                   \
+	__asm__ volatile (                                                    \
 		"int $0x80\n"                                                 \
 		: "=a" (_ret)                                                 \
 		: "r"(_arg1), "r"(_arg2), "r"(_arg3),                         \
@@ -127,7 +127,7 @@ struct sys_stat_struct {
 	register long _arg3 __asm__ ("edx") = (long)(arg3);                   \
 	register long _arg4 __asm__ ("esi") = (long)(arg4);                   \
 									      \
-	__asm__  volatile (                                                   \
+	__asm__ volatile (                                                    \
 		"int $0x80\n"                                                 \
 		: "=a" (_ret)                                                 \
 		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4),             \
@@ -147,7 +147,7 @@ struct sys_stat_struct {
 	register long _arg4 __asm__ ("esi") = (long)(arg4);                   \
 	register long _arg5 __asm__ ("edi") = (long)(arg5);                   \
 									      \
-	__asm__  volatile (                                                   \
+	__asm__ volatile (                                                    \
 		"int $0x80\n"                                                 \
 		: "=a" (_ret)                                                 \
 		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), \
diff --git a/tools/include/nolibc/arch-loongarch.h b/tools/include/nolibc/arch-loongarch.h
index ad3f266e7093..8df42268e578 100644
--- a/tools/include/nolibc/arch-loongarch.h
+++ b/tools/include/nolibc/arch-loongarch.h
@@ -28,7 +28,7 @@
 	register long _num  __asm__ ("a7") = (num);                           \
 	register long _arg1 __asm__ ("a0");                                   \
 									      \
-	__asm__  volatile (                                                   \
+	__asm__ volatile (                                                    \
 		"syscall 0\n"                                                 \
 		: "=r"(_arg1)                                                 \
 		: "r"(_num)                                                   \
@@ -43,7 +43,7 @@
 	register long _num  __asm__ ("a7") = (num);                           \
 	register long _arg1 __asm__ ("a0") = (long)(arg1);		      \
 									      \
-	__asm__  volatile (                                                   \
+	__asm__ volatile (                                                    \
 		"syscall 0\n"                                                 \
 		: "+r"(_arg1)                                                 \
 		: "r"(_num)                                                   \
@@ -59,7 +59,7 @@
 	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
 	register long _arg2 __asm__ ("a1") = (long)(arg2);                    \
 									      \
-	__asm__  volatile (                                                   \
+	__asm__ volatile (                                                    \
 		"syscall 0\n"                                                 \
 		: "+r"(_arg1)                                                 \
 		: "r"(_arg2),                                                 \
@@ -77,7 +77,7 @@
 	register long _arg2 __asm__ ("a1") = (long)(arg2);                    \
 	register long _arg3 __asm__ ("a2") = (long)(arg3);                    \
 									      \
-	__asm__  volatile (                                                   \
+	__asm__ volatile (                                                    \
 		"syscall 0\n"                                                 \
 		: "+r"(_arg1)                                                 \
 		: "r"(_arg2), "r"(_arg3),                                     \
@@ -96,7 +96,7 @@
 	register long _arg3 __asm__ ("a2") = (long)(arg3);                    \
 	register long _arg4 __asm__ ("a3") = (long)(arg4);                    \
 									      \
-	__asm__  volatile (                                                   \
+	__asm__ volatile (                                                    \
 		"syscall 0\n"                                                 \
 		: "+r"(_arg1)                                                 \
 		: "r"(_arg2), "r"(_arg3), "r"(_arg4),                         \
@@ -116,7 +116,7 @@
 	register long _arg4 __asm__ ("a3") = (long)(arg4);                    \
 	register long _arg5 __asm__ ("a4") = (long)(arg5);                    \
 									      \
-	__asm__  volatile (                                                   \
+	__asm__ volatile (                                                    \
 		"syscall 0\n"                                                 \
 		: "+r"(_arg1)                                                 \
 		: "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5),             \
@@ -137,7 +137,7 @@
 	register long _arg5 __asm__ ("a4") = (long)(arg5);                    \
 	register long _arg6 __asm__ ("a5") = (long)(arg6);                    \
 									      \
-	__asm__  volatile (                                                   \
+	__asm__ volatile (                                                    \
 		"syscall 0\n"                                                 \
 		: "+r"(_arg1)                                                 \
 		: "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), "r"(_arg6), \
diff --git a/tools/include/nolibc/arch-mips.h b/tools/include/nolibc/arch-mips.h
index 55cd376a98e2..22aacc07b1fc 100644
--- a/tools/include/nolibc/arch-mips.h
+++ b/tools/include/nolibc/arch-mips.h
@@ -62,7 +62,7 @@ struct sys_stat_struct {
 	register long _num __asm__ ("v0") = (num);                            \
 	register long _arg4 __asm__ ("a3");                                   \
 									      \
-	__asm__  volatile (                                                   \
+	__asm__ volatile (                                                    \
 		"addiu $sp, $sp, -32\n"                                       \
 		"syscall\n"                                                   \
 		"addiu $sp, $sp, 32\n"                                        \
@@ -80,7 +80,7 @@ struct sys_stat_struct {
 	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
 	register long _arg4 __asm__ ("a3");                                   \
 									      \
-	__asm__  volatile (                                                   \
+	__asm__ volatile (                                                    \
 		"addiu $sp, $sp, -32\n"                                       \
 		"syscall\n"                                                   \
 		"addiu $sp, $sp, 32\n"                                        \
@@ -100,7 +100,7 @@ struct sys_stat_struct {
 	register long _arg2 __asm__ ("a1") = (long)(arg2);                    \
 	register long _arg4 __asm__ ("a3");                                   \
 									      \
-	__asm__  volatile (                                                   \
+	__asm__ volatile (                                                    \
 		"addiu $sp, $sp, -32\n"                                       \
 		"syscall\n"                                                   \
 		"addiu $sp, $sp, 32\n"                                        \
@@ -121,7 +121,7 @@ struct sys_stat_struct {
 	register long _arg3 __asm__ ("a2") = (long)(arg3);                    \
 	register long _arg4 __asm__ ("a3");                                   \
 									      \
-	__asm__  volatile (                                                   \
+	__asm__ volatile (                                                    \
 		"addiu $sp, $sp, -32\n"                                       \
 		"syscall\n"                                                   \
 		"addiu $sp, $sp, 32\n"                                        \
@@ -142,7 +142,7 @@ struct sys_stat_struct {
 	register long _arg3 __asm__ ("a2") = (long)(arg3);                    \
 	register long _arg4 __asm__ ("a3") = (long)(arg4);                    \
 									      \
-	__asm__  volatile (                                                   \
+	__asm__ volatile (                                                    \
 		"addiu $sp, $sp, -32\n"                                       \
 		"syscall\n"                                                   \
 		"addiu $sp, $sp, 32\n"                                        \
@@ -164,7 +164,7 @@ struct sys_stat_struct {
 	register long _arg4 __asm__ ("a3") = (long)(arg4);                    \
 	register long _arg5 = (long)(arg5);                                   \
 									      \
-	__asm__  volatile (                                                   \
+	__asm__ volatile (                                                    \
 		"addiu $sp, $sp, -32\n"                                       \
 		"sw %7, 16($sp)\n"                                            \
 		"syscall\n  "                                                 \
diff --git a/tools/include/nolibc/arch-riscv.h b/tools/include/nolibc/arch-riscv.h
index a2e8564e66d6..cd958b2f4b1b 100644
--- a/tools/include/nolibc/arch-riscv.h
+++ b/tools/include/nolibc/arch-riscv.h
@@ -63,7 +63,7 @@ struct sys_stat_struct {
 	register long _num  __asm__ ("a7") = (num);                           \
 	register long _arg1 __asm__ ("a0");                                   \
 									      \
-	__asm__  volatile (                                                   \
+	__asm__ volatile (                                                    \
 		"ecall\n\t"                                                   \
 		: "=r"(_arg1)                                                 \
 		: "r"(_num)                                                   \
@@ -77,7 +77,7 @@ struct sys_stat_struct {
 	register long _num  __asm__ ("a7") = (num);                           \
 	register long _arg1 __asm__ ("a0") = (long)(arg1);		      \
 									      \
-	__asm__  volatile (                                                   \
+	__asm__ volatile (                                                    \
 		"ecall\n"                                                     \
 		: "+r"(_arg1)                                                 \
 		: "r"(_num)                                                   \
@@ -92,7 +92,7 @@ struct sys_stat_struct {
 	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
 	register long _arg2 __asm__ ("a1") = (long)(arg2);                    \
 									      \
-	__asm__  volatile (                                                   \
+	__asm__ volatile (                                                    \
 		"ecall\n"                                                     \
 		: "+r"(_arg1)                                                 \
 		: "r"(_arg2),                                                 \
@@ -109,7 +109,7 @@ struct sys_stat_struct {
 	register long _arg2 __asm__ ("a1") = (long)(arg2);                    \
 	register long _arg3 __asm__ ("a2") = (long)(arg3);                    \
 									      \
-	__asm__  volatile (                                                   \
+	__asm__ volatile (                                                    \
 		"ecall\n\t"                                                   \
 		: "+r"(_arg1)                                                 \
 		: "r"(_arg2), "r"(_arg3),                                     \
@@ -127,7 +127,7 @@ struct sys_stat_struct {
 	register long _arg3 __asm__ ("a2") = (long)(arg3);                    \
 	register long _arg4 __asm__ ("a3") = (long)(arg4);                    \
 									      \
-	__asm__  volatile (                                                   \
+	__asm__ volatile (                                                    \
 		"ecall\n"                                                     \
 		: "+r"(_arg1)                                                 \
 		: "r"(_arg2), "r"(_arg3), "r"(_arg4),                         \
@@ -146,7 +146,7 @@ struct sys_stat_struct {
 	register long _arg4 __asm__ ("a3") = (long)(arg4);                    \
 	register long _arg5 __asm__ ("a4") = (long)(arg5);                    \
 									      \
-	__asm__  volatile (                                                   \
+	__asm__ volatile (                                                    \
 		"ecall\n"                                                     \
 		: "+r"(_arg1)                                                 \
 		: "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5),             \
@@ -166,7 +166,7 @@ struct sys_stat_struct {
 	register long _arg5 __asm__ ("a4") = (long)(arg5);                    \
 	register long _arg6 __asm__ ("a5") = (long)(arg6);                    \
 									      \
-	__asm__  volatile (                                                   \
+	__asm__ volatile (                                                    \
 		"ecall\n"                                                     \
 		: "+r"(_arg1)                                                 \
 		: "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), "r"(_arg6), \
diff --git a/tools/include/nolibc/arch-s390.h b/tools/include/nolibc/arch-s390.h
index 516dff5bff8b..a644ecd361c0 100644
--- a/tools/include/nolibc/arch-s390.h
+++ b/tools/include/nolibc/arch-s390.h
@@ -52,7 +52,7 @@ struct sys_stat_struct {
 	register long _num __asm__ ("1") = (num);			\
 	register long _rc __asm__ ("2");				\
 									\
-	__asm__  volatile (						\
+	__asm__ volatile (						\
 		"svc 0\n"						\
 		: "=d"(_rc)						\
 		: "d"(_num)						\
@@ -66,7 +66,7 @@ struct sys_stat_struct {
 	register long _num __asm__ ("1") = (num);			\
 	register long _arg1 __asm__ ("2") = (long)(arg1);		\
 									\
-	__asm__  volatile (						\
+	__asm__ volatile (						\
 		"svc 0\n"						\
 		: "+d"(_arg1)						\
 		: "d"(_num)						\
@@ -81,7 +81,7 @@ struct sys_stat_struct {
 	register long _arg1 __asm__ ("2") = (long)(arg1);		\
 	register long _arg2 __asm__ ("3") = (long)(arg2);		\
 									\
-	__asm__  volatile (						\
+	__asm__ volatile (						\
 		"svc 0\n"						\
 		: "+d"(_arg1)						\
 		: "d"(_arg2), "d"(_num)					\
@@ -97,7 +97,7 @@ struct sys_stat_struct {
 	register long _arg2 __asm__ ("3") = (long)(arg2);		\
 	register long _arg3 __asm__ ("4") = (long)(arg3);		\
 									\
-	__asm__  volatile (						\
+	__asm__ volatile (						\
 		"svc 0\n"						\
 		: "+d"(_arg1)						\
 		: "d"(_arg2), "d"(_arg3), "d"(_num)			\
@@ -114,7 +114,7 @@ struct sys_stat_struct {
 	register long _arg3 __asm__ ("4") = (long)(arg3);		\
 	register long _arg4 __asm__ ("5") = (long)(arg4);		\
 									\
-	__asm__  volatile (						\
+	__asm__ volatile (						\
 		"svc 0\n"						\
 		: "+d"(_arg1)						\
 		: "d"(_arg2), "d"(_arg3), "d"(_arg4), "d"(_num)		\
@@ -132,7 +132,7 @@ struct sys_stat_struct {
 	register long _arg4 __asm__ ("5") = (long)(arg4);		\
 	register long _arg5 __asm__ ("6") = (long)(arg5);		\
 									\
-	__asm__  volatile (						\
+	__asm__ volatile (						\
 		"svc 0\n"						\
 		: "+d"(_arg1)						\
 		: "d"(_arg2), "d"(_arg3), "d"(_arg4), "d"(_arg5),	\
@@ -152,7 +152,7 @@ struct sys_stat_struct {
 	register long _arg5 __asm__ ("6") = (long)(arg5);		\
 	register long _arg6 __asm__ ("7") = (long)(arg6);		\
 									\
-	__asm__  volatile (						\
+	__asm__ volatile (						\
 		"svc 0\n"						\
 		: "+d"(_arg1)						\
 		: "d"(_arg2), "d"(_arg3), "d"(_arg4), "d"(_arg5),	\
diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
index 1ae73d83aad1..e69113742a99 100644
--- a/tools/include/nolibc/arch-x86_64.h
+++ b/tools/include/nolibc/arch-x86_64.h
@@ -60,7 +60,7 @@ struct sys_stat_struct {
 	long _ret;                                                            \
 	register long _num  __asm__ ("rax") = (num);                          \
 									      \
-	__asm__  volatile (                                                   \
+	__asm__ volatile (                                                    \
 		"syscall\n"                                                   \
 		: "=a"(_ret)                                                  \
 		: "0"(_num)                                                   \
@@ -75,7 +75,7 @@ struct sys_stat_struct {
 	register long _num  __asm__ ("rax") = (num);                          \
 	register long _arg1 __asm__ ("rdi") = (long)(arg1);                   \
 									      \
-	__asm__  volatile (                                                   \
+	__asm__ volatile (                                                    \
 		"syscall\n"                                                   \
 		: "=a"(_ret)                                                  \
 		: "r"(_arg1),                                                 \
@@ -92,7 +92,7 @@ struct sys_stat_struct {
 	register long _arg1 __asm__ ("rdi") = (long)(arg1);                   \
 	register long _arg2 __asm__ ("rsi") = (long)(arg2);                   \
 									      \
-	__asm__  volatile (                                                   \
+	__asm__ volatile (                                                    \
 		"syscall\n"                                                   \
 		: "=a"(_ret)                                                  \
 		: "r"(_arg1), "r"(_arg2),                                     \
@@ -110,7 +110,7 @@ struct sys_stat_struct {
 	register long _arg2 __asm__ ("rsi") = (long)(arg2);                   \
 	register long _arg3 __asm__ ("rdx") = (long)(arg3);                   \
 									      \
-	__asm__  volatile (                                                   \
+	__asm__ volatile (                                                    \
 		"syscall\n"                                                   \
 		: "=a"(_ret)                                                  \
 		: "r"(_arg1), "r"(_arg2), "r"(_arg3),                         \
@@ -129,7 +129,7 @@ struct sys_stat_struct {
 	register long _arg3 __asm__ ("rdx") = (long)(arg3);                   \
 	register long _arg4 __asm__ ("r10") = (long)(arg4);                   \
 									      \
-	__asm__  volatile (                                                   \
+	__asm__ volatile (                                                    \
 		"syscall\n"                                                   \
 		: "=a"(_ret)                                                  \
 		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4),             \
@@ -149,7 +149,7 @@ struct sys_stat_struct {
 	register long _arg4 __asm__ ("r10") = (long)(arg4);                   \
 	register long _arg5 __asm__ ("r8")  = (long)(arg5);                   \
 									      \
-	__asm__  volatile (                                                   \
+	__asm__ volatile (                                                    \
 		"syscall\n"                                                   \
 		: "=a"(_ret)                                                  \
 		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), \
@@ -170,7 +170,7 @@ struct sys_stat_struct {
 	register long _arg5 __asm__ ("r8")  = (long)(arg5);                   \
 	register long _arg6 __asm__ ("r9")  = (long)(arg6);                   \
 									      \
-	__asm__  volatile (                                                   \
+	__asm__ volatile (                                                    \
 		"syscall\n"                                                   \
 		: "=a"(_ret)                                                  \
 		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), \
-- 
2.25.1

