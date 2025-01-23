Return-Path: <linux-kselftest+bounces-25036-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C83DFA1AAEC
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 21:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12CC7164018
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 20:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA85F1C3BF8;
	Thu, 23 Jan 2025 20:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="HsaZvH4A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8207C1ADC77;
	Thu, 23 Jan 2025 20:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737663092; cv=none; b=Vq4NGvu9nJLSg1BuViL532WyEhh4AwQ519Zn+HdaKIVEmhz0lMi7hS0bngqMn5DtMpQfonbdQA0y9P2gJyRiaNNrpZi17OknZGBHSFu3/74j9NN4tBprg+qt7CwFRzenUyh4DPd1ZEokdCJWMwfmfTatfIUADyPi1g0dEwl/lTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737663092; c=relaxed/simple;
	bh=tjNoJsUvnxlLj6FzN9eM7bOeqk7TAcjPVmF48ZpBBYw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GpB99vjHKJapioBdRHYfTtSxP2pBwJOT1h4i5QKCqTl6Gu0p0e8ldGwYGGFdBemcHTU2wFFd74BIACKetH0EXlogM4F0P1MSe56YtjFDD3zRVS0uCnsmdnlcEcCVHNudDcCrxBhrfC/nFfMG++ASUORBkBe3Fgdm+Apx3WNxsQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=HsaZvH4A; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1737663088;
	bh=tjNoJsUvnxlLj6FzN9eM7bOeqk7TAcjPVmF48ZpBBYw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HsaZvH4A6PQ+rI9W6UaPfGTVDSEKwyINxVLDEmykuzPyIRR9cQg+KG1vhe30+fZRM
	 WOVMeaAqOc44LHPsTsGlJCcpZJk9cHS6jNVKZo3O5uxDNcV2+si3RnpYyRPnHsbwAc
	 V3i+ljUxjH0m7WU7qadfoOE5qNlsM3rHbpcZyZU8=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 23 Jan 2025 21:10:42 +0100
Subject: [PATCH 1/3] tools/nolibc: add prototypes for non-static functions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250123-nolibc-prototype-v1-1-e1afc5c1999a@weissschuh.net>
References: <20250123-nolibc-prototype-v1-0-e1afc5c1999a@weissschuh.net>
In-Reply-To: <20250123-nolibc-prototype-v1-0-e1afc5c1999a@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737663088; l=5271;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=tjNoJsUvnxlLj6FzN9eM7bOeqk7TAcjPVmF48ZpBBYw=;
 b=Xamj1T9uNAj8hL/LJgpi8tfLZs7sBpq5miSl/LNyuxoyEbWy0Fx7yoqrUy9Ol4LrVqWGCSELS
 6JJtQrnAa+oB9y8XId++qrRZGnO0YppvzuLQYNaiaQEJ7Piatcitq/O
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

With -Wmissing-prototypes the compiler will warn about non-static
functions which don't have a prototype defined.
This warning doesn't make much sense for nolibc itself but for user code
it is still useful.
To pacify the compiler add prototypes next to the function definitions,
similar to how it is handled elsewhere in the kernel.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/arch-mips.h      | 1 +
 tools/include/nolibc/crt.h            | 2 ++
 tools/include/nolibc/signal.h         | 1 +
 tools/include/nolibc/stackprotector.h | 2 ++
 tools/include/nolibc/stdlib.h         | 1 +
 tools/include/nolibc/string.h         | 4 ++++
 6 files changed, 11 insertions(+)

diff --git a/tools/include/nolibc/arch-mips.h b/tools/include/nolibc/arch-mips.h
index 1791a8ce58da6f72d305498957aaad489d4c143c..753a8ed2cf695f0b5eac4b5e4d317fdb383ebf93 100644
--- a/tools/include/nolibc/arch-mips.h
+++ b/tools/include/nolibc/arch-mips.h
@@ -179,6 +179,7 @@
 })
 
 /* startup code, note that it's called __start on MIPS */
+void __start(void);
 void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector __start(void)
 {
 	__asm__ volatile (
diff --git a/tools/include/nolibc/crt.h b/tools/include/nolibc/crt.h
index bbcd5fd09806be67749118cbe1f3ed11adab1c4e..c4b10103bbec50f1a3a0a4562e34fdbd1b43ce6f 100644
--- a/tools/include/nolibc/crt.h
+++ b/tools/include/nolibc/crt.h
@@ -10,6 +10,7 @@
 char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
+void _start(void);
 static void __stack_chk_init(void);
 static void exit(int);
 
@@ -22,6 +23,7 @@ extern void (*const __init_array_end[])(int, char **, char**) __attribute__((wea
 extern void (*const __fini_array_start[])(void) __attribute__((weak));
 extern void (*const __fini_array_end[])(void) __attribute__((weak));
 
+void _start_c(long *sp);
 __attribute__((weak,used))
 void _start_c(long *sp)
 {
diff --git a/tools/include/nolibc/signal.h b/tools/include/nolibc/signal.h
index 137552216e46960dc8baa1e25759daa1f152c3c9..cdcc5904c51e93c524f9afc7d49a17feda3d9af2 100644
--- a/tools/include/nolibc/signal.h
+++ b/tools/include/nolibc/signal.h
@@ -13,6 +13,7 @@
 #include "sys.h"
 
 /* This one is not marked static as it's needed by libgcc for divide by zero */
+int raise(int signal);
 __attribute__((weak,unused,section(".text.nolibc_raise")))
 int raise(int signal)
 {
diff --git a/tools/include/nolibc/stackprotector.h b/tools/include/nolibc/stackprotector.h
index 1d0d5259ec417ca7c853aba55519c65aa504b52b..c71a2c257177aac9dbf4541b2e104944efa2182c 100644
--- a/tools/include/nolibc/stackprotector.h
+++ b/tools/include/nolibc/stackprotector.h
@@ -18,6 +18,7 @@
  * triggering stack protector errors themselves
  */
 
+void __stack_chk_fail(void);
 __attribute__((weak,used,noreturn,section(".text.nolibc_stack_chk")))
 void __stack_chk_fail(void)
 {
@@ -28,6 +29,7 @@ void __stack_chk_fail(void)
 	for (;;);
 }
 
+void __stack_chk_fail_local(void);
 __attribute__((weak,noreturn,section(".text.nolibc_stack_chk")))
 void __stack_chk_fail_local(void)
 {
diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
index 75aa273c23a6153db6a32facaea16457a522703b..86ad378ab1ea220559d5ab1adc4bb9972977ba9e 100644
--- a/tools/include/nolibc/stdlib.h
+++ b/tools/include/nolibc/stdlib.h
@@ -30,6 +30,7 @@ static __attribute__((unused)) char itoa_buffer[21];
  */
 
 /* must be exported, as it's used by libgcc for various divide functions */
+void abort(void);
 __attribute__((weak,unused,noreturn,section(".text.nolibc_abort")))
 void abort(void)
 {
diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index 9ec9c24f38c092dee93fab3762c579bffd35ce2f..ba84ab700e3001a7d105e1c9e40c01bf45db9d8c 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -32,6 +32,7 @@ int memcmp(const void *s1, const void *s2, size_t n)
 /* might be ignored by the compiler without -ffreestanding, then found as
  * missing.
  */
+void *memmove(void *dst, const void *src, size_t len);
 __attribute__((weak,unused,section(".text.nolibc_memmove")))
 void *memmove(void *dst, const void *src, size_t len)
 {
@@ -56,6 +57,7 @@ void *memmove(void *dst, const void *src, size_t len)
 
 #ifndef NOLIBC_ARCH_HAS_MEMCPY
 /* must be exported, as it's used by libgcc on ARM */
+void *memcpy(void *dst, const void *src, size_t len);
 __attribute__((weak,unused,section(".text.nolibc_memcpy")))
 void *memcpy(void *dst, const void *src, size_t len)
 {
@@ -73,6 +75,7 @@ void *memcpy(void *dst, const void *src, size_t len)
 /* might be ignored by the compiler without -ffreestanding, then found as
  * missing.
  */
+void *memset(void *dst, int b, size_t len);
 __attribute__((weak,unused,section(".text.nolibc_memset")))
 void *memset(void *dst, int b, size_t len)
 {
@@ -124,6 +127,7 @@ char *strcpy(char *dst, const char *src)
  * thus itself, hence the asm() statement below that's meant to disable this
  * confusing practice.
  */
+size_t strlen(const char *str);
 __attribute__((weak,unused,section(".text.nolibc_strlen")))
 size_t strlen(const char *str)
 {

-- 
2.48.1


