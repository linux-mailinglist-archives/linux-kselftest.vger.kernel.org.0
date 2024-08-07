Return-Path: <linux-kselftest+bounces-14982-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 160BB94B25F
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 23:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A16B1C21043
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 21:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA76155382;
	Wed,  7 Aug 2024 21:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="kizJW0Fq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8668145B01;
	Wed,  7 Aug 2024 21:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723067522; cv=none; b=AXxIW7KUm0W/IvP9IXN4bX2H6ZRnf7Iv37KX2+OyhUrH7EXBOqPi4++9TRJMXMlX2nbMZJWRBK84rgdKmTnl/l251e5TS0gb2CwM0pGotHZP305N3ob1EB620FAD19oAwuxGp0Gacvf0yWZBrOWx3IKP5kmiXMjG7lVbuReUSUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723067522; c=relaxed/simple;
	bh=qcCzNZ25Nghxp314kg906hORmJEk3Keo6loE3mI2Bqg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N2muhp4DUFFYL/iAvZsajMoYbzdr501e6GLX/PyvRI6Yhb4wNlikPuyfJ72g5pGfNbltJrNAkBEgtLMWErUZepTWrcdmghEkvFg6KM2curbx+E6+j051a0muYXEbK4EDS0zh9ovzg+i+gsMMnI1b2kIhfYYM2pi2gA3LvYFRfj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=kizJW0Fq; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1723067510;
	bh=qcCzNZ25Nghxp314kg906hORmJEk3Keo6loE3mI2Bqg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kizJW0FqR6s2abRpwZVzinLfWnuQz+F99iHpjXoyGcCkkYmv4LNMRxEstgEIqDSJe
	 DhgQ6+EEhdgkE5NfocJIhIWJJ9ykU++rD98JYGBtV+4M7uB5BO9YBvOb1tJBG+ySVr
	 +90H0rScB76TWksin3LLZ3MRpm4z1pHO0uHzoHU0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 07 Aug 2024 23:51:41 +0200
Subject: [PATCH v2 05/15] tools/nolibc: move entrypoint specifics to
 compiler.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240807-nolibc-llvm-v2-5-c20f2f5fc7c2@weissschuh.net>
References: <20240807-nolibc-llvm-v2-0-c20f2f5fc7c2@weissschuh.net>
In-Reply-To: <20240807-nolibc-llvm-v2-0-c20f2f5fc7c2@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723067509; l=9633;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=qcCzNZ25Nghxp314kg906hORmJEk3Keo6loE3mI2Bqg=;
 b=/B0RKN79ZLUZsQmPt6VRgkC82XdsLsggyt/rA/lMv+nYXKgiD92O1DkmXZgR50QYS/RWW5WqY
 wYjp1Swg3H8Dft3MVv8LUShaUsvxRHgsHWu1A6+g5iRoTd6JzFCGeVx
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The specific attributes for the _start entrypoint are duplicated for
each architecture.
Deduplicate it into a dedicated #define into compiler.h.
The macros are similar to attribute((naked)), so adopt that naming.
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
index b23ac1f04035..eb77de57e7ca 100644
--- a/tools/include/nolibc/arch-aarch64.h
+++ b/tools/include/nolibc/arch-aarch64.h
@@ -142,13 +142,13 @@
 })
 
 /* startup code */
-void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_stack_protector _start(void)
+void __attribute__((weak, noreturn)) __nolibc_naked __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 		"mov x0, sp\n"          /* save stack pointer to x0, as arg1 of _start_c */
 		"and sp, x0, -16\n"     /* sp must be 16-byte aligned in the callee      */
 		"bl  _start_c\n"        /* transfer to c runtime                         */
 	);
-	__builtin_unreachable();
+	__nolibc_naked_epilogue();
 }
 #endif /* _NOLIBC_ARCH_AARCH64_H */
diff --git a/tools/include/nolibc/arch-arm.h b/tools/include/nolibc/arch-arm.h
index d1c19d973e55..d22aa4d469d4 100644
--- a/tools/include/nolibc/arch-arm.h
+++ b/tools/include/nolibc/arch-arm.h
@@ -185,7 +185,7 @@
 })
 
 /* startup code */
-void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_stack_protector _start(void)
+void __attribute__((weak, noreturn)) __nolibc_naked __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 		"mov r0, sp\n"          /* save stack pointer to %r0, as arg1 of _start_c */
@@ -193,7 +193,7 @@ void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_
 		"mov sp, ip\n"
 		"bl  _start_c\n"        /* transfer to c runtime                          */
 	);
-	__builtin_unreachable();
+	__nolibc_naked_epilogue();
 }
 
 #endif /* _NOLIBC_ARCH_ARM_H */
diff --git a/tools/include/nolibc/arch-i386.h b/tools/include/nolibc/arch-i386.h
index 28c26a00a762..054babfe41f8 100644
--- a/tools/include/nolibc/arch-i386.h
+++ b/tools/include/nolibc/arch-i386.h
@@ -162,7 +162,7 @@
  * 2) The deepest stack frame should be set to zero
  *
  */
-void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_stack_protector _start(void)
+void __attribute__((weak, noreturn)) __nolibc_naked __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 		"xor  %ebp, %ebp\n"       /* zero the stack frame                                */
@@ -174,7 +174,7 @@ void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_
 		"call _start_c\n"         /* transfer to c runtime                               */
 		"hlt\n"                   /* ensure it does not return                           */
 	);
-	__builtin_unreachable();
+	__nolibc_naked_epilogue();
 }
 
 #endif /* _NOLIBC_ARCH_I386_H */
diff --git a/tools/include/nolibc/arch-loongarch.h b/tools/include/nolibc/arch-loongarch.h
index 3f8ef8f86c0f..8cacf03cbdf4 100644
--- a/tools/include/nolibc/arch-loongarch.h
+++ b/tools/include/nolibc/arch-loongarch.h
@@ -149,14 +149,14 @@
 #endif
 
 /* startup code */
-void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_stack_protector _start(void)
+void __attribute__((weak, noreturn)) __nolibc_naked __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 		"move          $a0, $sp\n"         /* save stack pointer to $a0, as arg1 of _start_c */
 		LONG_BSTRINS " $sp, $zero, 3, 0\n" /* $sp must be 16-byte aligned                    */
 		"bl            _start_c\n"         /* transfer to c runtime                          */
 	);
-	__builtin_unreachable();
+	__nolibc_naked_epilogue();
 }
 
 #endif /* _NOLIBC_ARCH_LOONGARCH_H */
diff --git a/tools/include/nolibc/arch-mips.h b/tools/include/nolibc/arch-mips.h
index a2ee77ed2fbb..cca3e325ef94 100644
--- a/tools/include/nolibc/arch-mips.h
+++ b/tools/include/nolibc/arch-mips.h
@@ -179,7 +179,7 @@
 })
 
 /* startup code, note that it's called __start on MIPS */
-void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_stack_protector __start(void)
+void __attribute__((weak, noreturn)) __nolibc_naked __no_stack_protector __start(void)
 {
 	__asm__ volatile (
 		".set push\n"
@@ -200,7 +200,7 @@ void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_
 		" nop\n"                 /* delayed slot                                   */
 		".set pop\n"
 	);
-	__builtin_unreachable();
+	__nolibc_naked_epilogue();
 }
 
 #endif /* _NOLIBC_ARCH_MIPS_H */
diff --git a/tools/include/nolibc/arch-powerpc.h b/tools/include/nolibc/arch-powerpc.h
index 41ebd394b90c..a5b2a0403a80 100644
--- a/tools/include/nolibc/arch-powerpc.h
+++ b/tools/include/nolibc/arch-powerpc.h
@@ -184,7 +184,7 @@
 #endif /* !__powerpc64__ */
 
 /* startup code */
-void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_stack_protector _start(void)
+void __attribute__((weak, noreturn)) __nolibc_naked __no_stack_protector _start(void)
 {
 #ifdef __powerpc64__
 #if _CALL_ELF == 2
@@ -215,7 +215,7 @@ void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_
 		"bl     _start_c\n"     /* transfer to c runtime                         */
 	);
 #endif
-	__builtin_unreachable();
+	__nolibc_naked_epilogue();
 }
 
 #endif /* _NOLIBC_ARCH_POWERPC_H */
diff --git a/tools/include/nolibc/arch-riscv.h b/tools/include/nolibc/arch-riscv.h
index 1927c643c739..3b0392353e4d 100644
--- a/tools/include/nolibc/arch-riscv.h
+++ b/tools/include/nolibc/arch-riscv.h
@@ -140,7 +140,7 @@
 })
 
 /* startup code */
-void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_stack_protector _start(void)
+void __attribute__((weak, noreturn)) __nolibc_naked __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 		".option push\n"
@@ -151,7 +151,7 @@ void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_
 		"andi sp, a0, -16\n"      /* sp must be 16-byte aligned                    */
 		"call _start_c\n"         /* transfer to c runtime                         */
 	);
-	__builtin_unreachable();
+	__nolibc_naked_epilogue();
 }
 
 #endif /* _NOLIBC_ARCH_RISCV_H */
diff --git a/tools/include/nolibc/arch-s390.h b/tools/include/nolibc/arch-s390.h
index 5d60fd43f883..cfb3956365d8 100644
--- a/tools/include/nolibc/arch-s390.h
+++ b/tools/include/nolibc/arch-s390.h
@@ -139,7 +139,7 @@
 })
 
 /* startup code */
-void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_stack_protector _start(void)
+void __attribute__((weak, noreturn)) __nolibc_naked __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 		"lgr	%r2, %r15\n"          /* save stack pointer to %r2, as arg1 of _start_c */
@@ -147,7 +147,7 @@ void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_
 		"xc	0(8,%r15), 0(%r15)\n" /* clear backchain                                */
 		"brasl	%r14, _start_c\n"     /* transfer to c runtime                          */
 	);
-	__builtin_unreachable();
+	__nolibc_naked_epilogue();
 }
 
 struct s390_mmap_arg_struct {
diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
index 68609f421934..3c3b703d9b0c 100644
--- a/tools/include/nolibc/arch-x86_64.h
+++ b/tools/include/nolibc/arch-x86_64.h
@@ -161,7 +161,7 @@
  * 2) The deepest stack frame should be zero (the %rbp).
  *
  */
-void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_stack_protector _start(void)
+void __attribute__((weak, noreturn)) __nolibc_naked __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 		"xor  %ebp, %ebp\n"       /* zero the stack frame                            */
@@ -170,7 +170,7 @@ void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_
 		"call _start_c\n"         /* transfer to c runtime                           */
 		"hlt\n"                   /* ensure it does not return                       */
 	);
-	__builtin_unreachable();
+	__nolibc_naked_epilogue();
 }
 
 #define NOLIBC_ARCH_HAS_MEMMOVE
diff --git a/tools/include/nolibc/compiler.h b/tools/include/nolibc/compiler.h
index 1730d0454a55..14a854929910 100644
--- a/tools/include/nolibc/compiler.h
+++ b/tools/include/nolibc/compiler.h
@@ -12,6 +12,9 @@
 #  define __nolibc_has_attribute(attr) 0
 #endif
 
+#define __nolibc_naked __attribute__((optimize("Os", "omit-frame-pointer")))
+#define __nolibc_naked_epilogue() __builtin_unreachable()
+
 #if defined(__SSP__) || defined(__SSP_STRONG__) || defined(__SSP_ALL__) || defined(__SSP_EXPLICIT__)
 
 #define _NOLIBC_STACKPROTECTOR

-- 
2.46.0


