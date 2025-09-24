Return-Path: <linux-kselftest+bounces-42186-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3E3B9A37E
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 16:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91BBB19C7D7F
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 14:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD0030BB9E;
	Wed, 24 Sep 2025 14:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="VNAvVfqp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0187A30AABE;
	Wed, 24 Sep 2025 14:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758723721; cv=none; b=fbHwwpDWeah6X5x1jeXwqVW+qRwJE0XTAPqeHzz7MLU7oR3FnHfkKL5uK83SMae0qMRgpkiDyKKNgiNZ9Dl2+cPrLsy+cjpVsse98Lwv+VdZFItGFYgBziUDuIKisd/Jx1TPGescLcwLdtxu4f0eGp9YNsuMIYPmKgagYzvAehE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758723721; c=relaxed/simple;
	bh=GrnSWl/l6y6I1yY3ttS/AbrG2ZKFPiMaWugibMXrygQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZB+KoC1hjGrivFTbWhLzafunxiqt0x6GAkoveDcEcIfgrfN361Cmt4ua5uFuTAStFiGnBafxgqwSYLZquOA/hfnuQ/Wd9Wzra+w+pAkdtELG4WXedwT9KVhUK+gjHsu7LMUNdlEfO+KxkxtC7302nGy4Yw8T7JuFKc2AGwVWC2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=VNAvVfqp; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Wyrt4ywsUa30dSsyTR71hnWg6bMqqctOayCDw74qBv4=;
	t=1758723719; x=1759933319; b=VNAvVfqp95RH8Ow6+yY5gAD/cQLMtMmxBO9JKZuK5oFT71Z
	OgIxjLcwtkcs2jiFijH12928i6Z0wylqyQ+OuUjdqe0fknrTLcVLmzX1TkjF7P4RuV4lichDYneIj
	TTEtsJSTKNRFbWbUPq6yIP5lwpqQk0usmLE+MXjEDJHo/K1wtq6Fmbia9nyrnchsul9YVQY3vSFW2
	ffpWe/3/lPZQ6ms0Qn32SGAygnFrFOq30m5ZW8y+zp0hx1bIO1hWRB2BbFfkP9ISCx4Z9AnJNSXiy
	6BsMsa+2ZXmYdTg8bgvpa2JH3bAJkoIVokiR0SoSkDFdSql4AD7ejo0/6OJjvvlg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1v1QNY-000000090Bz-01ju;
	Wed, 24 Sep 2025 16:21:56 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v3 07/12] tools/nolibc: add option to disable runtime
Date: Wed, 24 Sep 2025 16:20:54 +0200
Message-ID: <20250924142059.527768-8-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924142059.527768-1-benjamin@sipsolutions.net>
References: <20250924142059.527768-1-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned

From: Benjamin Berg <benjamin.berg@intel.com>

In principle, it is possible to use nolibc for only some object files in
a program. In that case, the startup code in _start and _start_c is not
going to be used. Add the NOLIBC_NO_RUNTIME compile time option to
disable it entirely and also remove anything that depends on it.

Doing this avoids warnings from modpost for UML as the _start_c code
references the main function from the .init.text section while it is not
inside .init itself.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Acked-by: Thomas Weißschuh <linux@weissschuh.net>

---
v2:
- Renamed from NOLIBC_NO_STARTCODE to NOLIBC_NO_RUNTIME
- Put the #ifdef around relevant comments
---
 tools/include/nolibc/arch-arm.h       | 2 ++
 tools/include/nolibc/arch-arm64.h     | 2 ++
 tools/include/nolibc/arch-loongarch.h | 2 ++
 tools/include/nolibc/arch-m68k.h      | 2 ++
 tools/include/nolibc/arch-mips.h      | 2 ++
 tools/include/nolibc/arch-powerpc.h   | 2 ++
 tools/include/nolibc/arch-riscv.h     | 2 ++
 tools/include/nolibc/arch-s390.h      | 2 ++
 tools/include/nolibc/arch-sh.h        | 2 ++
 tools/include/nolibc/arch-sparc.h     | 2 ++
 tools/include/nolibc/arch-x86.h       | 4 ++++
 tools/include/nolibc/crt.h            | 3 +++
 tools/include/nolibc/stackprotector.h | 2 ++
 tools/include/nolibc/stdlib.h         | 2 ++
 tools/include/nolibc/sys.h            | 3 ++-
 tools/include/nolibc/sys/auxv.h       | 3 +++
 16 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/arch-arm.h b/tools/include/nolibc/arch-arm.h
index 1f66e7e5a444..251c42579028 100644
--- a/tools/include/nolibc/arch-arm.h
+++ b/tools/include/nolibc/arch-arm.h
@@ -184,6 +184,7 @@
 	_arg1;                                                                \
 })
 
+#ifndef NOLIBC_NO_RUNTIME
 /* startup code */
 void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _start(void)
 {
@@ -193,5 +194,6 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _s
 	);
 	__nolibc_entrypoint_epilogue();
 }
+#endif /* NOLIBC_NO_RUNTIME */
 
 #endif /* _NOLIBC_ARCH_ARM_H */
diff --git a/tools/include/nolibc/arch-arm64.h b/tools/include/nolibc/arch-arm64.h
index 02a3f74c8ec8..080a55a7144e 100644
--- a/tools/include/nolibc/arch-arm64.h
+++ b/tools/include/nolibc/arch-arm64.h
@@ -141,6 +141,7 @@
 	_arg1;                                                                \
 })
 
+#ifndef NOLIBC_NO_RUNTIME
 /* startup code */
 void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _start(void)
 {
@@ -150,4 +151,5 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _s
 	);
 	__nolibc_entrypoint_epilogue();
 }
+#endif /* NOLIBC_NO_RUNTIME */
 #endif /* _NOLIBC_ARCH_ARM64_H */
diff --git a/tools/include/nolibc/arch-loongarch.h b/tools/include/nolibc/arch-loongarch.h
index 5511705303ea..c894176c3f89 100644
--- a/tools/include/nolibc/arch-loongarch.h
+++ b/tools/include/nolibc/arch-loongarch.h
@@ -142,6 +142,7 @@
 	_arg1;                                                                \
 })
 
+#ifndef NOLIBC_NO_RUNTIME
 /* startup code */
 void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _start(void)
 {
@@ -151,5 +152,6 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _s
 	);
 	__nolibc_entrypoint_epilogue();
 }
+#endif /* NOLIBC_NO_RUNTIME */
 
 #endif /* _NOLIBC_ARCH_LOONGARCH_H */
diff --git a/tools/include/nolibc/arch-m68k.h b/tools/include/nolibc/arch-m68k.h
index 6dac1845f298..2a4fbada5e79 100644
--- a/tools/include/nolibc/arch-m68k.h
+++ b/tools/include/nolibc/arch-m68k.h
@@ -128,6 +128,7 @@
 	_num;                                                                 \
 })
 
+#ifndef NOLIBC_NO_RUNTIME
 void _start(void);
 void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _start(void)
 {
@@ -137,5 +138,6 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _s
 	);
 	__nolibc_entrypoint_epilogue();
 }
+#endif /* NOLIBC_NO_RUNTIME */
 
 #endif /* _NOLIBC_ARCH_M68K_H */
diff --git a/tools/include/nolibc/arch-mips.h b/tools/include/nolibc/arch-mips.h
index 0cbac63b249a..a72506ceec6b 100644
--- a/tools/include/nolibc/arch-mips.h
+++ b/tools/include/nolibc/arch-mips.h
@@ -245,6 +245,7 @@
 
 #endif /* _ABIO32 */
 
+#ifndef NOLIBC_NO_RUNTIME
 /* startup code, note that it's called __start on MIPS */
 void __start(void);
 void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector __start(void)
@@ -266,5 +267,6 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector __
 	);
 	__nolibc_entrypoint_epilogue();
 }
+#endif /* NOLIBC_NO_RUNTIME */
 
 #endif /* _NOLIBC_ARCH_MIPS_H */
diff --git a/tools/include/nolibc/arch-powerpc.h b/tools/include/nolibc/arch-powerpc.h
index 204564bbcd32..e0c7e0b81f7c 100644
--- a/tools/include/nolibc/arch-powerpc.h
+++ b/tools/include/nolibc/arch-powerpc.h
@@ -183,6 +183,7 @@
 #endif
 #endif /* !__powerpc64__ */
 
+#ifndef NOLIBC_NO_RUNTIME
 /* startup code */
 void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _start(void)
 {
@@ -215,5 +216,6 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _s
 #endif
 	__nolibc_entrypoint_epilogue();
 }
+#endif /* NOLIBC_NO_RUNTIME */
 
 #endif /* _NOLIBC_ARCH_POWERPC_H */
diff --git a/tools/include/nolibc/arch-riscv.h b/tools/include/nolibc/arch-riscv.h
index 885383a86c38..1c00cacf57e1 100644
--- a/tools/include/nolibc/arch-riscv.h
+++ b/tools/include/nolibc/arch-riscv.h
@@ -139,6 +139,7 @@
 	_arg1;                                                                \
 })
 
+#ifndef NOLIBC_NO_RUNTIME
 /* startup code */
 void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _start(void)
 {
@@ -152,5 +153,6 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _s
 	);
 	__nolibc_entrypoint_epilogue();
 }
+#endif /* NOLIBC_NO_RUNTIME */
 
 #endif /* _NOLIBC_ARCH_RISCV_H */
diff --git a/tools/include/nolibc/arch-s390.h b/tools/include/nolibc/arch-s390.h
index df4c3cc713ac..6237211385c0 100644
--- a/tools/include/nolibc/arch-s390.h
+++ b/tools/include/nolibc/arch-s390.h
@@ -139,6 +139,7 @@
 	_arg1;								\
 })
 
+#ifndef NOLIBC_NO_RUNTIME
 /* startup code */
 void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _start(void)
 {
@@ -155,6 +156,7 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _s
 	);
 	__nolibc_entrypoint_epilogue();
 }
+#endif /* NOLIBC_NO_RUNTIME */
 
 struct s390_mmap_arg_struct {
 	unsigned long addr;
diff --git a/tools/include/nolibc/arch-sh.h b/tools/include/nolibc/arch-sh.h
index a96b8914607e..7a421197d104 100644
--- a/tools/include/nolibc/arch-sh.h
+++ b/tools/include/nolibc/arch-sh.h
@@ -140,6 +140,7 @@
 	_ret;                                                                 \
 })
 
+#ifndef NOLIBC_NO_RUNTIME
 /* startup code */
 void _start_wrapper(void);
 void __attribute__((weak,noreturn)) __nolibc_entrypoint __no_stack_protector _start_wrapper(void)
@@ -158,5 +159,6 @@ void __attribute__((weak,noreturn)) __nolibc_entrypoint __no_stack_protector _st
 	);
 	__nolibc_entrypoint_epilogue();
 }
+#endif /* NOLIBC_NO_RUNTIME */
 
 #endif /* _NOLIBC_ARCH_SH_H */
diff --git a/tools/include/nolibc/arch-sparc.h b/tools/include/nolibc/arch-sparc.h
index ca420d843e25..2ebb5686e105 100644
--- a/tools/include/nolibc/arch-sparc.h
+++ b/tools/include/nolibc/arch-sparc.h
@@ -152,6 +152,7 @@
 	_arg1;                                                                \
 })
 
+#ifndef NOLIBC_NO_RUNTIME
 /* startup code */
 void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _start(void)
 {
@@ -169,6 +170,7 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _s
 	);
 	__nolibc_entrypoint_epilogue();
 }
+#endif /* NOLIBC_NO_RUNTIME */
 
 static pid_t getpid(void);
 
diff --git a/tools/include/nolibc/arch-x86.h b/tools/include/nolibc/arch-x86.h
index d3efc0c3b8ad..11abb8bd7eec 100644
--- a/tools/include/nolibc/arch-x86.h
+++ b/tools/include/nolibc/arch-x86.h
@@ -157,6 +157,7 @@
 	_eax;							\
 })
 
+#ifndef NOLIBC_NO_RUNTIME
 /* startup code */
 /*
  * i386 System V ABI mandates:
@@ -176,6 +177,7 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _s
 	);
 	__nolibc_entrypoint_epilogue();
 }
+#endif /* NOLIBC_NO_RUNTIME */
 
 #else /* !defined(__x86_64__) */
 
@@ -323,6 +325,7 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _s
 	_ret;                                                                 \
 })
 
+#ifndef NOLIBC_NO_RUNTIME
 /* startup code */
 /*
  * x86-64 System V ABI mandates:
@@ -340,6 +343,7 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _s
 	);
 	__nolibc_entrypoint_epilogue();
 }
+#endif /* NOLIBC_NO_RUNTIME */
 
 #define NOLIBC_ARCH_HAS_MEMMOVE
 void *memmove(void *dst, const void *src, size_t len);
diff --git a/tools/include/nolibc/crt.h b/tools/include/nolibc/crt.h
index 961cfe777c35..d9262998dae9 100644
--- a/tools/include/nolibc/crt.h
+++ b/tools/include/nolibc/crt.h
@@ -7,6 +7,8 @@
 #ifndef _NOLIBC_CRT_H
 #define _NOLIBC_CRT_H
 
+#ifndef NOLIBC_NO_RUNTIME
+
 #include "compiler.h"
 
 char **environ __attribute__((weak));
@@ -88,4 +90,5 @@ void _start_c(long *sp)
 	exit(exitcode);
 }
 
+#endif /* NOLIBC_NO_RUNTIME */
 #endif /* _NOLIBC_CRT_H */
diff --git a/tools/include/nolibc/stackprotector.h b/tools/include/nolibc/stackprotector.h
index c71a2c257177..7123aa056cb0 100644
--- a/tools/include/nolibc/stackprotector.h
+++ b/tools/include/nolibc/stackprotector.h
@@ -9,6 +9,7 @@
 
 #include "compiler.h"
 
+#ifndef NOLIBC_NO_RUNTIME
 #if defined(_NOLIBC_STACKPROTECTOR)
 
 #include "sys.h"
@@ -49,5 +50,6 @@ static __no_stack_protector void __stack_chk_init(void)
 #else /* !defined(_NOLIBC_STACKPROTECTOR) */
 static void __stack_chk_init(void) {}
 #endif /* defined(_NOLIBC_STACKPROTECTOR) */
+#endif /* NOLIBC_NO_RUNTIME */
 
 #endif /* _NOLIBC_STACKPROTECTOR_H */
diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
index 5fd99a480f82..f184e108ed0a 100644
--- a/tools/include/nolibc/stdlib.h
+++ b/tools/include/nolibc/stdlib.h
@@ -100,6 +100,7 @@ void free(void *ptr)
 	munmap(heap, heap->len);
 }
 
+#ifndef NOLIBC_NO_RUNTIME
 /* getenv() tries to find the environment variable named <name> in the
  * environment array pointed to by global variable "environ" which must be
  * declared as a char **, and must be terminated by a NULL (it is recommended
@@ -122,6 +123,7 @@ char *getenv(const char *name)
 	}
 	return NULL;
 }
+#endif /* NOLIBC_NO_RUNTIME */
 
 static __attribute__((unused))
 void *malloc(size_t len)
diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 295e71d34aba..a48f5117bfce 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -509,6 +509,7 @@ pid_t gettid(void)
 	return sys_gettid();
 }
 
+#ifndef NOLIBC_NO_RUNTIME
 static unsigned long getauxval(unsigned long key);
 
 /*
@@ -520,7 +521,7 @@ int getpagesize(void)
 {
 	return __sysret((int)getauxval(AT_PAGESZ) ?: -ENOENT);
 }
-
+#endif /* NOLIBC_NO_RUNTIME */
 
 /*
  * uid_t getuid(void);
diff --git a/tools/include/nolibc/sys/auxv.h b/tools/include/nolibc/sys/auxv.h
index c52463d6c18d..0e98325e7347 100644
--- a/tools/include/nolibc/sys/auxv.h
+++ b/tools/include/nolibc/sys/auxv.h
@@ -10,6 +10,8 @@
 #ifndef _NOLIBC_SYS_AUXV_H
 #define _NOLIBC_SYS_AUXV_H
 
+#ifndef NOLIBC_NO_RUNTIME
+
 #include "../crt.h"
 
 static __attribute__((unused))
@@ -38,4 +40,5 @@ unsigned long getauxval(unsigned long type)
 	return ret;
 }
 
+#endif /* NOLIBC_NO_RUNTIME */
 #endif /* _NOLIBC_SYS_AUXV_H */
-- 
2.51.0


