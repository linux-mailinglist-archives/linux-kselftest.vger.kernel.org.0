Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBF674B34A
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 16:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjGGOvZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 10:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjGGOvY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 10:51:24 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214861FD7;
        Fri,  7 Jul 2023 07:51:21 -0700 (PDT)
X-QQ-mid: bizesmtp71t1688741466tobmojsz
Received: from linux-lab-host.localdomain ( [116.30.131.119])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 07 Jul 2023 22:51:05 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: 83ShfzFP0oCSFJRDmnjjj0j5ekoT4ERXMCO6n6hwcbXs8sil75ni6bvRy75us
        qzguPXnlyVBdf0Wd0CWfXadbv6AptN+1ba5GS+C5Yhc6CgjaRBZWuIYKs+H6cKxImIG5dNV
        kkwEYuHfYioJlOdQXWyUg4cUff0wTc49mOo3K1UaiOhA9xUL5jTbTVINLPvRPKWJZfEKIwy
        fPLBqjiGF4d4IgtTSe2BOW3MbgwfJDbNOCpfVRfB/zZ89LwmzI3WphCAhw+MpfLsAg6YERd
        aSQzICbFdn9aESQUtmfxkFwIM0l1zrcnvL0m99MeQdT/egL41FsoUAp6/hJpu8+IeZqSOaD
        bXizZ/ITicqEMeZqT76lX/A8ZeqH4LnFjE7BbLv3f+HXannpGxpAjHMe9c75A==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1360114949905121606
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, thomas@t-8ch.de
Subject: [PATCH v6 01/15] tools/nolibc: arch-*.h: fix up code indent errors
Date:   Fri,  7 Jul 2023 22:50:34 +0800
Message-Id: <469d9d15a506a58dca5f8ecdcb83c660ee0485c9.1688739492.git.falcon@tinylab.org>
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

More than 8 whitespaces of the code indent are replaced with "tab +
whitespaces" to fix up such errors reported by scripts/checkpatch.pl:

    ERROR: code indent should use tabs where possible
    #64: FILE: tools/include/nolibc/arch-mips.h:64:
    +^I                                                                      \$

    ERROR: code indent should use tabs where possible
    #72: FILE: tools/include/nolibc/arch-mips.h:72:
    +^I          "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"  \$

This command is used:

    $ sed -i -e '/^\t*        /{s/        /\t/g}' tools/include/nolibc/arch-*.h

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/arch-aarch64.h | 14 +++++++-------
 tools/include/nolibc/arch-arm.h     | 14 +++++++-------
 tools/include/nolibc/arch-i386.h    | 12 ++++++------
 tools/include/nolibc/arch-mips.h    | 24 ++++++++++++------------
 tools/include/nolibc/arch-x86_64.h  | 14 +++++++-------
 5 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/tools/include/nolibc/arch-aarch64.h b/tools/include/nolibc/arch-aarch64.h
index 11f294a406b7..c911f61365d1 100644
--- a/tools/include/nolibc/arch-aarch64.h
+++ b/tools/include/nolibc/arch-aarch64.h
@@ -56,7 +56,7 @@ struct sys_stat_struct {
 ({                                                                            \
 	register long _num  __asm__ ("x8") = (num);                           \
 	register long _arg1 __asm__ ("x0");                                   \
-	                                                                      \
+									      \
 	__asm__  volatile (                                                   \
 		"svc #0\n"                                                    \
 		: "=r"(_arg1)                                                 \
@@ -70,7 +70,7 @@ struct sys_stat_struct {
 ({                                                                            \
 	register long _num  __asm__ ("x8") = (num);                           \
 	register long _arg1 __asm__ ("x0") = (long)(arg1);                    \
-	                                                                      \
+									      \
 	__asm__  volatile (                                                   \
 		"svc #0\n"                                                    \
 		: "=r"(_arg1)                                                 \
@@ -86,7 +86,7 @@ struct sys_stat_struct {
 	register long _num  __asm__ ("x8") = (num);                           \
 	register long _arg1 __asm__ ("x0") = (long)(arg1);                    \
 	register long _arg2 __asm__ ("x1") = (long)(arg2);                    \
-	                                                                      \
+									      \
 	__asm__  volatile (                                                   \
 		"svc #0\n"                                                    \
 		: "=r"(_arg1)                                                 \
@@ -103,7 +103,7 @@ struct sys_stat_struct {
 	register long _arg1 __asm__ ("x0") = (long)(arg1);                    \
 	register long _arg2 __asm__ ("x1") = (long)(arg2);                    \
 	register long _arg3 __asm__ ("x2") = (long)(arg3);                    \
-	                                                                      \
+									      \
 	__asm__  volatile (                                                   \
 		"svc #0\n"                                                    \
 		: "=r"(_arg1)                                                 \
@@ -121,7 +121,7 @@ struct sys_stat_struct {
 	register long _arg2 __asm__ ("x1") = (long)(arg2);                    \
 	register long _arg3 __asm__ ("x2") = (long)(arg3);                    \
 	register long _arg4 __asm__ ("x3") = (long)(arg4);                    \
-	                                                                      \
+									      \
 	__asm__  volatile (                                                   \
 		"svc #0\n"                                                    \
 		: "=r"(_arg1)                                                 \
@@ -140,7 +140,7 @@ struct sys_stat_struct {
 	register long _arg3 __asm__ ("x2") = (long)(arg3);                    \
 	register long _arg4 __asm__ ("x3") = (long)(arg4);                    \
 	register long _arg5 __asm__ ("x4") = (long)(arg5);                    \
-	                                                                      \
+									      \
 	__asm__  volatile (                                                   \
 		"svc #0\n"                                                    \
 		: "=r" (_arg1)                                                \
@@ -160,7 +160,7 @@ struct sys_stat_struct {
 	register long _arg4 __asm__ ("x3") = (long)(arg4);                    \
 	register long _arg5 __asm__ ("x4") = (long)(arg5);                    \
 	register long _arg6 __asm__ ("x5") = (long)(arg6);                    \
-	                                                                      \
+									      \
 	__asm__  volatile (                                                   \
 		"svc #0\n"                                                    \
 		: "=r" (_arg1)                                                \
diff --git a/tools/include/nolibc/arch-arm.h b/tools/include/nolibc/arch-arm.h
index ca4c66987497..d5887fd9bc5f 100644
--- a/tools/include/nolibc/arch-arm.h
+++ b/tools/include/nolibc/arch-arm.h
@@ -90,7 +90,7 @@ struct sys_stat_struct {
 ({                                                                            \
 	register long _num  __asm__(_NOLIBC_SYSCALL_REG) = (num);             \
 	register long _arg1 __asm__ ("r0");                                   \
-	                                                                      \
+									      \
 	__asm__  volatile (                                                   \
 		_NOLIBC_THUMB_SET_R7                                          \
 		"svc #0\n"                                                    \
@@ -107,7 +107,7 @@ struct sys_stat_struct {
 ({                                                                            \
 	register long _num  __asm__(_NOLIBC_SYSCALL_REG) = (num);             \
 	register long _arg1 __asm__ ("r0") = (long)(arg1);                    \
-	                                                                      \
+									      \
 	__asm__  volatile (                                                   \
 		_NOLIBC_THUMB_SET_R7                                          \
 		"svc #0\n"                                                    \
@@ -125,7 +125,7 @@ struct sys_stat_struct {
 	register long _num  __asm__(_NOLIBC_SYSCALL_REG) = (num);             \
 	register long _arg1 __asm__ ("r0") = (long)(arg1);                    \
 	register long _arg2 __asm__ ("r1") = (long)(arg2);                    \
-	                                                                      \
+									      \
 	__asm__  volatile (                                                   \
 		_NOLIBC_THUMB_SET_R7                                          \
 		"svc #0\n"                                                    \
@@ -144,7 +144,7 @@ struct sys_stat_struct {
 	register long _arg1 __asm__ ("r0") = (long)(arg1);                    \
 	register long _arg2 __asm__ ("r1") = (long)(arg2);                    \
 	register long _arg3 __asm__ ("r2") = (long)(arg3);                    \
-	                                                                      \
+									      \
 	__asm__  volatile (                                                   \
 		_NOLIBC_THUMB_SET_R7                                          \
 		"svc #0\n"                                                    \
@@ -164,7 +164,7 @@ struct sys_stat_struct {
 	register long _arg2 __asm__ ("r1") = (long)(arg2);                    \
 	register long _arg3 __asm__ ("r2") = (long)(arg3);                    \
 	register long _arg4 __asm__ ("r3") = (long)(arg4);                    \
-	                                                                      \
+									      \
 	__asm__  volatile (                                                   \
 		_NOLIBC_THUMB_SET_R7                                          \
 		"svc #0\n"                                                    \
@@ -185,7 +185,7 @@ struct sys_stat_struct {
 	register long _arg3 __asm__ ("r2") = (long)(arg3);                    \
 	register long _arg4 __asm__ ("r3") = (long)(arg4);                    \
 	register long _arg5 __asm__ ("r4") = (long)(arg5);                    \
-	                                                                      \
+									      \
 	__asm__  volatile (                                                   \
 		_NOLIBC_THUMB_SET_R7                                          \
 		"svc #0\n"                                                    \
@@ -207,7 +207,7 @@ struct sys_stat_struct {
 	register long _arg4 __asm__ ("r3") = (long)(arg4);                    \
 	register long _arg5 __asm__ ("r4") = (long)(arg5);                    \
 	register long _arg6 __asm__ ("r5") = (long)(arg6);                    \
-	                                                                      \
+									      \
 	__asm__  volatile (                                                   \
 		_NOLIBC_THUMB_SET_R7                                          \
 		"svc #0\n"                                                    \
diff --git a/tools/include/nolibc/arch-i386.h b/tools/include/nolibc/arch-i386.h
index 3d672d925e9e..c11a53acf159 100644
--- a/tools/include/nolibc/arch-i386.h
+++ b/tools/include/nolibc/arch-i386.h
@@ -57,7 +57,7 @@ struct sys_stat_struct {
 ({                                                                            \
 	long _ret;                                                            \
 	register long _num __asm__ ("eax") = (num);                           \
-	                                                                      \
+									      \
 	__asm__  volatile (                                                   \
 		"int $0x80\n"                                                 \
 		: "=a" (_ret)                                                 \
@@ -72,7 +72,7 @@ struct sys_stat_struct {
 	long _ret;                                                            \
 	register long _num __asm__ ("eax") = (num);                           \
 	register long _arg1 __asm__ ("ebx") = (long)(arg1);                   \
-	                                                                      \
+									      \
 	__asm__  volatile (                                                   \
 		"int $0x80\n"                                                 \
 		: "=a" (_ret)                                                 \
@@ -89,7 +89,7 @@ struct sys_stat_struct {
 	register long _num __asm__ ("eax") = (num);                           \
 	register long _arg1 __asm__ ("ebx") = (long)(arg1);                   \
 	register long _arg2 __asm__ ("ecx") = (long)(arg2);                   \
-	                                                                      \
+									      \
 	__asm__  volatile (                                                   \
 		"int $0x80\n"                                                 \
 		: "=a" (_ret)                                                 \
@@ -107,7 +107,7 @@ struct sys_stat_struct {
 	register long _arg1 __asm__ ("ebx") = (long)(arg1);                   \
 	register long _arg2 __asm__ ("ecx") = (long)(arg2);                   \
 	register long _arg3 __asm__ ("edx") = (long)(arg3);                   \
-	                                                                      \
+									      \
 	__asm__  volatile (                                                   \
 		"int $0x80\n"                                                 \
 		: "=a" (_ret)                                                 \
@@ -126,7 +126,7 @@ struct sys_stat_struct {
 	register long _arg2 __asm__ ("ecx") = (long)(arg2);                   \
 	register long _arg3 __asm__ ("edx") = (long)(arg3);                   \
 	register long _arg4 __asm__ ("esi") = (long)(arg4);                   \
-	                                                                      \
+									      \
 	__asm__  volatile (                                                   \
 		"int $0x80\n"                                                 \
 		: "=a" (_ret)                                                 \
@@ -146,7 +146,7 @@ struct sys_stat_struct {
 	register long _arg3 __asm__ ("edx") = (long)(arg3);                   \
 	register long _arg4 __asm__ ("esi") = (long)(arg4);                   \
 	register long _arg5 __asm__ ("edi") = (long)(arg5);                   \
-	                                                                      \
+									      \
 	__asm__  volatile (                                                   \
 		"int $0x80\n"                                                 \
 		: "=a" (_ret)                                                 \
diff --git a/tools/include/nolibc/arch-mips.h b/tools/include/nolibc/arch-mips.h
index db24e0837a39..55cd376a98e2 100644
--- a/tools/include/nolibc/arch-mips.h
+++ b/tools/include/nolibc/arch-mips.h
@@ -61,7 +61,7 @@ struct sys_stat_struct {
 ({                                                                            \
 	register long _num __asm__ ("v0") = (num);                            \
 	register long _arg4 __asm__ ("a3");                                   \
-	                                                                      \
+									      \
 	__asm__  volatile (                                                   \
 		"addiu $sp, $sp, -32\n"                                       \
 		"syscall\n"                                                   \
@@ -69,7 +69,7 @@ struct sys_stat_struct {
 		: "=r"(_num), "=r"(_arg4)                                     \
 		: "r"(_num)                                                   \
 		: "memory", "cc", "at", "v1", "hi", "lo",                     \
-	          "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"  \
+		  "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"  \
 	);                                                                    \
 	_arg4 ? -_num : _num;                                                 \
 })
@@ -79,7 +79,7 @@ struct sys_stat_struct {
 	register long _num __asm__ ("v0") = (num);                            \
 	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
 	register long _arg4 __asm__ ("a3");                                   \
-	                                                                      \
+									      \
 	__asm__  volatile (                                                   \
 		"addiu $sp, $sp, -32\n"                                       \
 		"syscall\n"                                                   \
@@ -88,7 +88,7 @@ struct sys_stat_struct {
 		: "0"(_num),                                                  \
 		  "r"(_arg1)                                                  \
 		: "memory", "cc", "at", "v1", "hi", "lo",                     \
-	          "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"  \
+		  "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"  \
 	);                                                                    \
 	_arg4 ? -_num : _num;                                                 \
 })
@@ -99,7 +99,7 @@ struct sys_stat_struct {
 	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
 	register long _arg2 __asm__ ("a1") = (long)(arg2);                    \
 	register long _arg4 __asm__ ("a3");                                   \
-	                                                                      \
+									      \
 	__asm__  volatile (                                                   \
 		"addiu $sp, $sp, -32\n"                                       \
 		"syscall\n"                                                   \
@@ -108,7 +108,7 @@ struct sys_stat_struct {
 		: "0"(_num),                                                  \
 		  "r"(_arg1), "r"(_arg2)                                      \
 		: "memory", "cc", "at", "v1", "hi", "lo",                     \
-	          "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"  \
+		  "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"  \
 	);                                                                    \
 	_arg4 ? -_num : _num;                                                 \
 })
@@ -120,7 +120,7 @@ struct sys_stat_struct {
 	register long _arg2 __asm__ ("a1") = (long)(arg2);                    \
 	register long _arg3 __asm__ ("a2") = (long)(arg3);                    \
 	register long _arg4 __asm__ ("a3");                                   \
-	                                                                      \
+									      \
 	__asm__  volatile (                                                   \
 		"addiu $sp, $sp, -32\n"                                       \
 		"syscall\n"                                                   \
@@ -129,7 +129,7 @@ struct sys_stat_struct {
 		: "0"(_num),                                                  \
 		  "r"(_arg1), "r"(_arg2), "r"(_arg3)                          \
 		: "memory", "cc", "at", "v1", "hi", "lo",                     \
-	          "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"  \
+		  "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"  \
 	);                                                                    \
 	_arg4 ? -_num : _num;                                                 \
 })
@@ -141,7 +141,7 @@ struct sys_stat_struct {
 	register long _arg2 __asm__ ("a1") = (long)(arg2);                    \
 	register long _arg3 __asm__ ("a2") = (long)(arg3);                    \
 	register long _arg4 __asm__ ("a3") = (long)(arg4);                    \
-	                                                                      \
+									      \
 	__asm__  volatile (                                                   \
 		"addiu $sp, $sp, -32\n"                                       \
 		"syscall\n"                                                   \
@@ -150,7 +150,7 @@ struct sys_stat_struct {
 		: "0"(_num),                                                  \
 		  "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4)              \
 		: "memory", "cc", "at", "v1", "hi", "lo",                     \
-	          "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"  \
+		  "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"  \
 	);                                                                    \
 	_arg4 ? -_num : _num;                                                 \
 })
@@ -163,7 +163,7 @@ struct sys_stat_struct {
 	register long _arg3 __asm__ ("a2") = (long)(arg3);                    \
 	register long _arg4 __asm__ ("a3") = (long)(arg4);                    \
 	register long _arg5 = (long)(arg5);                                   \
-	                                                                      \
+									      \
 	__asm__  volatile (                                                   \
 		"addiu $sp, $sp, -32\n"                                       \
 		"sw %7, 16($sp)\n"                                            \
@@ -173,7 +173,7 @@ struct sys_stat_struct {
 		: "0"(_num),                                                  \
 		  "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5)  \
 		: "memory", "cc", "at", "v1", "hi", "lo",                     \
-	          "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"  \
+		  "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"  \
 	);                                                                    \
 	_arg4 ? -_num : _num;                                                 \
 })
diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
index 6fc4d8392742..1ae73d83aad1 100644
--- a/tools/include/nolibc/arch-x86_64.h
+++ b/tools/include/nolibc/arch-x86_64.h
@@ -59,7 +59,7 @@ struct sys_stat_struct {
 ({                                                                            \
 	long _ret;                                                            \
 	register long _num  __asm__ ("rax") = (num);                          \
-	                                                                      \
+									      \
 	__asm__  volatile (                                                   \
 		"syscall\n"                                                   \
 		: "=a"(_ret)                                                  \
@@ -74,7 +74,7 @@ struct sys_stat_struct {
 	long _ret;                                                            \
 	register long _num  __asm__ ("rax") = (num);                          \
 	register long _arg1 __asm__ ("rdi") = (long)(arg1);                   \
-	                                                                      \
+									      \
 	__asm__  volatile (                                                   \
 		"syscall\n"                                                   \
 		: "=a"(_ret)                                                  \
@@ -91,7 +91,7 @@ struct sys_stat_struct {
 	register long _num  __asm__ ("rax") = (num);                          \
 	register long _arg1 __asm__ ("rdi") = (long)(arg1);                   \
 	register long _arg2 __asm__ ("rsi") = (long)(arg2);                   \
-	                                                                      \
+									      \
 	__asm__  volatile (                                                   \
 		"syscall\n"                                                   \
 		: "=a"(_ret)                                                  \
@@ -109,7 +109,7 @@ struct sys_stat_struct {
 	register long _arg1 __asm__ ("rdi") = (long)(arg1);                   \
 	register long _arg2 __asm__ ("rsi") = (long)(arg2);                   \
 	register long _arg3 __asm__ ("rdx") = (long)(arg3);                   \
-	                                                                      \
+									      \
 	__asm__  volatile (                                                   \
 		"syscall\n"                                                   \
 		: "=a"(_ret)                                                  \
@@ -128,7 +128,7 @@ struct sys_stat_struct {
 	register long _arg2 __asm__ ("rsi") = (long)(arg2);                   \
 	register long _arg3 __asm__ ("rdx") = (long)(arg3);                   \
 	register long _arg4 __asm__ ("r10") = (long)(arg4);                   \
-	                                                                      \
+									      \
 	__asm__  volatile (                                                   \
 		"syscall\n"                                                   \
 		: "=a"(_ret)                                                  \
@@ -148,7 +148,7 @@ struct sys_stat_struct {
 	register long _arg3 __asm__ ("rdx") = (long)(arg3);                   \
 	register long _arg4 __asm__ ("r10") = (long)(arg4);                   \
 	register long _arg5 __asm__ ("r8")  = (long)(arg5);                   \
-	                                                                      \
+									      \
 	__asm__  volatile (                                                   \
 		"syscall\n"                                                   \
 		: "=a"(_ret)                                                  \
@@ -169,7 +169,7 @@ struct sys_stat_struct {
 	register long _arg4 __asm__ ("r10") = (long)(arg4);                   \
 	register long _arg5 __asm__ ("r8")  = (long)(arg5);                   \
 	register long _arg6 __asm__ ("r9")  = (long)(arg6);                   \
-	                                                                      \
+									      \
 	__asm__  volatile (                                                   \
 		"syscall\n"                                                   \
 		: "=a"(_ret)                                                  \
-- 
2.25.1

