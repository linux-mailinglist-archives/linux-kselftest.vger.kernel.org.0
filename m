Return-Path: <linux-kselftest+bounces-14331-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 218D193E463
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jul 2024 12:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73928B2102B
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jul 2024 10:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100D92BB04;
	Sun, 28 Jul 2024 10:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="oDXNA0V+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC97923776;
	Sun, 28 Jul 2024 10:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722161417; cv=none; b=eBtqg83ipEFeDDm1H3awqB7TBCuv80pZcVts8MgiHLVzBn53yEaiAJm15Q0RwxZ0bHbjC9GQmM3w5hS/5YgDvpes6tVV0QdA80+I+cNtjek1Orp6+qKYRPQ+3HE/NLo9lF/Bw6VOzQ0MoyabNm7DO4Hov3Ee2jYVmRBmS7lFg80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722161417; c=relaxed/simple;
	bh=pI+x6cfc3CM2BKGrZPpdw/rz5+r1qGR4nRV3usuJ5tk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UYZlwIq7pRZcuWkoXlJIIB2UPpeWP2aNSn3g+/XbjkVuE7xphrLTw+NpcE0LFCAreRh7k3/LM0vGtcpVmh0QS0hfqiSe9ZbRLkAOaMLndaV6FF9cT53NLhpmnZqTfAqAd4j4tfGSIXLLP0vJhQIT36NuCbznFn2V6S2GraYjnEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=oDXNA0V+; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1722161406;
	bh=pI+x6cfc3CM2BKGrZPpdw/rz5+r1qGR4nRV3usuJ5tk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oDXNA0V+e8Yn32TLCDfURXpxrXPGuX16VnrD6njGsAN3R+TZtVk6qPDVyDuaRRaP3
	 9OPfq0yNygK1Hi5w4FDO8HLFWWlINYvD9AlMKKCEhsqOVaO0YrHEaa29y32TRxg3pV
	 cWpyEQn7hGTX4NxMLAL75zUrWrW0DUD2HGS5sRbo=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 28 Jul 2024 12:09:57 +0200
Subject: [PATCH 03/12] tools/nolibc: move entrypoint specifics to
 compiler.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240728-nolibc-llvm-v1-3-bc384269bc35@weissschuh.net>
References: <20240728-nolibc-llvm-v1-0-bc384269bc35@weissschuh.net>
In-Reply-To: <20240728-nolibc-llvm-v1-0-bc384269bc35@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722161405; l=9528;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=pI+x6cfc3CM2BKGrZPpdw/rz5+r1qGR4nRV3usuJ5tk=;
 b=Xd7Cj5HjBHpB/0rozx/xwNba9KmOcId88wGhbp8IR/L58SQhaqkxJ3Uqh7vtfPR7/nh9CiMfS
 qvtN6qJAqpsAhZyzNna5RdMvqOAIeg7zT3xAan61JehPt7bK00iIVbZ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The specific attributes for the _start entrypoint are duplicated for
each architecture.
Deduplicate it into a dedicated #define into compiler.h.
This make the code shorter and will make it easier to adapt for clang
compatibility.

For clang compatibility, the epilogue will also need to be adapted, so
move that one, too.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/arch-aarch64.h   | 4 ++--
 tools/include/nolibc/arch-arm.h       | 4 ++--
 tools/include/nolibc/arch-i386.h      | 4 ++--
 tools/include/nolibc/arch-loongarch.h | 4 ++--
 tools/include/nolibc/arch-mips.h      | 4 ++--
 tools/include/nolibc/arch-powerpc.h   | 4 ++--
 tools/include/nolibc/arch-riscv.h     | 4 ++--
 tools/include/nolibc/arch-s390.h      | 4 ++--
 tools/include/nolibc/arch-x86_64.h    | 4 ++--
 tools/include/nolibc/compiler.h       | 3 +++
 10 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/tools/include/nolibc/arch-aarch64.h b/tools/include/nolibc/arch-aarch64.h
index b23ac1f04035..d5b182115664 100644
--- a/tools/include/nolibc/arch-aarch64.h
+++ b/tools/include/nolibc/arch-aarch64.h
@@ -142,13 +142,13 @@
 })
 
 /* startup code */
-void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_stack_protector _start(void)
+void __attribute__((weak, noreturn)) __entrypoint __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 		"mov x0, sp\n"          /* save stack pointer to x0, as arg1 of _start_c */
 		"and sp, x0, -16\n"     /* sp must be 16-byte aligned in the callee      */
 		"bl  _start_c\n"        /* transfer to c runtime                         */
 	);
-	__builtin_unreachable();
+	__entrypoint_epilogue();
 }
 #endif /* _NOLIBC_ARCH_AARCH64_H */
diff --git a/tools/include/nolibc/arch-arm.h b/tools/include/nolibc/arch-arm.h
index d1c19d973e55..8e8a681a0740 100644
--- a/tools/include/nolibc/arch-arm.h
+++ b/tools/include/nolibc/arch-arm.h
@@ -185,7 +185,7 @@
 })
 
 /* startup code */
-void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_stack_protector _start(void)
+void __attribute__((weak, noreturn)) __entrypoint __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 		"mov r0, sp\n"          /* save stack pointer to %r0, as arg1 of _start_c */
@@ -193,7 +193,7 @@ void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_
 		"mov sp, ip\n"
 		"bl  _start_c\n"        /* transfer to c runtime                          */
 	);
-	__builtin_unreachable();
+	__entrypoint_epilogue();
 }
 
 #endif /* _NOLIBC_ARCH_ARM_H */
diff --git a/tools/include/nolibc/arch-i386.h b/tools/include/nolibc/arch-i386.h
index 28c26a00a762..a464e3ae17fd 100644
--- a/tools/include/nolibc/arch-i386.h
+++ b/tools/include/nolibc/arch-i386.h
@@ -162,7 +162,7 @@
  * 2) The deepest stack frame should be set to zero
  *
  */
-void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_stack_protector _start(void)
+void __attribute__((weak, noreturn)) __entrypoint __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 		"xor  %ebp, %ebp\n"       /* zero the stack frame                                */
@@ -174,7 +174,7 @@ void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_
 		"call _start_c\n"         /* transfer to c runtime                               */
 		"hlt\n"                   /* ensure it does not return                           */
 	);
-	__builtin_unreachable();
+	__entrypoint_epilogue();
 }
 
 #endif /* _NOLIBC_ARCH_I386_H */
diff --git a/tools/include/nolibc/arch-loongarch.h b/tools/include/nolibc/arch-loongarch.h
index 3f8ef8f86c0f..b3edb10be4c7 100644
--- a/tools/include/nolibc/arch-loongarch.h
+++ b/tools/include/nolibc/arch-loongarch.h
@@ -149,14 +149,14 @@
 #endif
 
 /* startup code */
-void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_stack_protector _start(void)
+void __attribute__((weak, noreturn)) __entrypoint __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 		"move          $a0, $sp\n"         /* save stack pointer to $a0, as arg1 of _start_c */
 		LONG_BSTRINS " $sp, $zero, 3, 0\n" /* $sp must be 16-byte aligned                    */
 		"bl            _start_c\n"         /* transfer to c runtime                          */
 	);
-	__builtin_unreachable();
+	__entrypoint_epilogue();
 }
 
 #endif /* _NOLIBC_ARCH_LOONGARCH_H */
diff --git a/tools/include/nolibc/arch-mips.h b/tools/include/nolibc/arch-mips.h
index 62cc50ef3288..afa5adc8c76b 100644
--- a/tools/include/nolibc/arch-mips.h
+++ b/tools/include/nolibc/arch-mips.h
@@ -179,7 +179,7 @@
 })
 
 /* startup code, note that it's called __start on MIPS */
-void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_stack_protector __start(void)
+void __attribute__((weak, noreturn)) __entrypoint __no_stack_protector __start(void)
 {
 	__asm__ volatile (
 		".set push\n"
@@ -198,7 +198,7 @@ void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_
 		" nop\n"                 /* delayed slot                                   */
 		".set pop\n"
 	);
-	__builtin_unreachable();
+	__entrypoint_epilogue();
 }
 
 #endif /* _NOLIBC_ARCH_MIPS_H */
diff --git a/tools/include/nolibc/arch-powerpc.h b/tools/include/nolibc/arch-powerpc.h
index 41ebd394b90c..c0a2d08e4e51 100644
--- a/tools/include/nolibc/arch-powerpc.h
+++ b/tools/include/nolibc/arch-powerpc.h
@@ -184,7 +184,7 @@
 #endif /* !__powerpc64__ */
 
 /* startup code */
-void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_stack_protector _start(void)
+void __attribute__((weak, noreturn)) __entrypoint __no_stack_protector _start(void)
 {
 #ifdef __powerpc64__
 #if _CALL_ELF == 2
@@ -215,7 +215,7 @@ void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_
 		"bl     _start_c\n"     /* transfer to c runtime                         */
 	);
 #endif
-	__builtin_unreachable();
+	__entrypoint_epilogue();
 }
 
 #endif /* _NOLIBC_ARCH_POWERPC_H */
diff --git a/tools/include/nolibc/arch-riscv.h b/tools/include/nolibc/arch-riscv.h
index 1927c643c739..90da3b328f6f 100644
--- a/tools/include/nolibc/arch-riscv.h
+++ b/tools/include/nolibc/arch-riscv.h
@@ -140,7 +140,7 @@
 })
 
 /* startup code */
-void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_stack_protector _start(void)
+void __attribute__((weak, noreturn)) __entrypoint __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 		".option push\n"
@@ -151,7 +151,7 @@ void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_
 		"andi sp, a0, -16\n"      /* sp must be 16-byte aligned                    */
 		"call _start_c\n"         /* transfer to c runtime                         */
 	);
-	__builtin_unreachable();
+	__entrypoint_epilogue();
 }
 
 #endif /* _NOLIBC_ARCH_RISCV_H */
diff --git a/tools/include/nolibc/arch-s390.h b/tools/include/nolibc/arch-s390.h
index 5d60fd43f883..09123861a140 100644
--- a/tools/include/nolibc/arch-s390.h
+++ b/tools/include/nolibc/arch-s390.h
@@ -139,7 +139,7 @@
 })
 
 /* startup code */
-void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_stack_protector _start(void)
+void __attribute__((weak, noreturn)) __entrypoint __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 		"lgr	%r2, %r15\n"          /* save stack pointer to %r2, as arg1 of _start_c */
@@ -147,7 +147,7 @@ void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_
 		"xc	0(8,%r15), 0(%r15)\n" /* clear backchain                                */
 		"brasl	%r14, _start_c\n"     /* transfer to c runtime                          */
 	);
-	__builtin_unreachable();
+	__entrypoint_epilogue();
 }
 
 struct s390_mmap_arg_struct {
diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
index 68609f421934..98cb693cc38c 100644
--- a/tools/include/nolibc/arch-x86_64.h
+++ b/tools/include/nolibc/arch-x86_64.h
@@ -161,7 +161,7 @@
  * 2) The deepest stack frame should be zero (the %rbp).
  *
  */
-void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_stack_protector _start(void)
+void __attribute__((weak, noreturn)) __entrypoint __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 		"xor  %ebp, %ebp\n"       /* zero the stack frame                            */
@@ -170,7 +170,7 @@ void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_
 		"call _start_c\n"         /* transfer to c runtime                           */
 		"hlt\n"                   /* ensure it does not return                       */
 	);
-	__builtin_unreachable();
+	__entrypoint_epilogue();
 }
 
 #define NOLIBC_ARCH_HAS_MEMMOVE
diff --git a/tools/include/nolibc/compiler.h b/tools/include/nolibc/compiler.h
index beddc3665d69..fe3701863634 100644
--- a/tools/include/nolibc/compiler.h
+++ b/tools/include/nolibc/compiler.h
@@ -6,6 +6,9 @@
 #ifndef _NOLIBC_COMPILER_H
 #define _NOLIBC_COMPILER_H
 
+#define __entrypoint __attribute__((optimize("Os", "omit-frame-pointer")))
+#define __entrypoint_epilogue() __builtin_unreachable()
+
 #if defined(__SSP__) || defined(__SSP_STRONG__) || defined(__SSP_ALL__) || defined(__SSP_EXPLICIT__)
 
 #define _NOLIBC_STACKPROTECTOR

-- 
2.45.2


