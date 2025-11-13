Return-Path: <linux-kselftest+bounces-45563-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E253C58A12
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 17:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BFB714FE70B
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 15:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656832F49FC;
	Thu, 13 Nov 2025 15:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kIalnQ3H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K1mmvDRf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44453357718;
	Thu, 13 Nov 2025 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047879; cv=none; b=fQr3azNaAzLcjfaqBGRfZ/fI1GHAJC3ao+P0GN8qsGPxZlcfQM+kRCT1/qzosrgV5Vp8cxGYLHLsktZJrqWCWYf2sG7/VhFZrj2yTP85NKC5aAm71BfMsFKi/wwZIZ2JSnUwNknrnvDORMPmOfCLJhWYv5GiwHsL5tkIvGS0vJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047879; c=relaxed/simple;
	bh=LJAX46aHnRmsKlsk759IEhxLTOisIPDMEme8ejGdai4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=peX09pXiLbhMLCfAYsKC9ZI5tDtgA3xPJHpBIjfMbS6A7FRuqHBO7SESu7SC2ZgFzGO8zG72lEr1xmgivy+QwIx0hQnkcVY4U32yk017gOXjNTfuXchpLN1q95kN6s03zAGLxnaMu1S5+ieKq8KhP3xs9CwDxv43CTR4TdciiLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kIalnQ3H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K1mmvDRf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763047875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pKjXgtAOgZVyQ2FoIi7WihbBl5GtnPPYa5CAXSqUp0o=;
	b=kIalnQ3HVEZBUOnoGr99xjt4rHfMNQZ8bpRbJRkXDfEBfnBQUsXWONFUCT7w9/FX/7dA7t
	PGdrXv4X13SVGl6ugzBgznSknS0QfzCnD/5jbOmi4gh2X/ofygpzuhAWBb3dJWvAnhtIbA
	/pBt66mbUN2Bg7G33S/TbiazgvUhMgUPxepu0L4GC0qzdZm7ayhMS2dtARWTFCuCdCRJAM
	Rgo8xsYhkSM3xoEQwmKNEqXBZTcy/qZpopvyj7jGN3bBcmh7KonLzltb3QdpJW1PAk0IEb
	xbQo7pjR10TOpqS9IWWTNIpI3sMD/uGf9kKDzwOXJqOOtwU1Ba6aO+tp6BfVsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763047875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pKjXgtAOgZVyQ2FoIi7WihbBl5GtnPPYa5CAXSqUp0o=;
	b=K1mmvDRfjubh8P/ToZepC/t0hou1voPH81b1lbbEQuEAwhbfv1fqVzq/xX1mDXZuWqm7i3
	4MuAjrAAPjsE4pBw==
Date: Thu, 13 Nov 2025 16:30:29 +0100
Subject: [PATCH v2 13/14] selftests: vDSO: vdso_test_correctness: Use
 facilities from parse_vdso.c
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251113-vdso-test-types-v2-13-0427eff70d08@linutronix.de>
References: <20251113-vdso-test-types-v2-0-0427eff70d08@linutronix.de>
In-Reply-To: <20251113-vdso-test-types-v2-0-0427eff70d08@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763047863; l=4422;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=LJAX46aHnRmsKlsk759IEhxLTOisIPDMEme8ejGdai4=;
 b=/7FiC3tqoDTQbY/cCOz83V/JQhT3c5SEBGUGvv8aP/R4y3VxmYvJMM1+hEiQPvzoIfvDnrxBc
 jlFzhqdy5JbBNLdqFEy4XhBNjEJvxBKPLbfotj/kQ3g7Z/0aWbutfOu
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The soname from the vDSO is not a public API. Furthermore it requires
libc to implement dlsym() and friends.

Use the facilities from parse_vdso.c instead which uses the official
vDSO ABI to find it, aligned with the other vDSO selftests.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/Makefile              |  4 +--
 .../testing/selftests/vDSO/vdso_test_correctness.c | 30 ++++++++++------------
 2 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index 74dfc60e636edce91cc1df9643ca8aa008ecfe65..504b30155ae7c6da3065c4472384f54e5547332a 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -26,13 +26,11 @@ CFLAGS_NOLIBC := -nostdlib -nostdinc -ffreestanding -fno-asynchronous-unwind-tab
 $(OUTPUT)/vdso_test_gettimeofday: parse_vdso.c vdso_test_gettimeofday.c
 $(OUTPUT)/vdso_test_getcpu: parse_vdso.c vdso_test_getcpu.c
 $(OUTPUT)/vdso_test_abi: parse_vdso.c vdso_test_abi.c
+$(OUTPUT)/vdso_test_correctness: parse_vdso.c vdso_test_correctness.c
 
 $(OUTPUT)/vdso_standalone_test_x86: vdso_standalone_test_x86.c parse_vdso.c | headers
 $(OUTPUT)/vdso_standalone_test_x86: CFLAGS:=$(CFLAGS_NOLIBC) $(CFLAGS)
 
-$(OUTPUT)/vdso_test_correctness: vdso_test_correctness.c
-$(OUTPUT)/vdso_test_correctness: LDFLAGS += -ldl
-
 $(OUTPUT)/vdso_test_getrandom: parse_vdso.c
 $(OUTPUT)/vdso_test_getrandom: CFLAGS += -isystem $(top_srcdir)/tools/include \
                                          $(KHDR_INCLUDES) \
diff --git a/tools/testing/selftests/vDSO/vdso_test_correctness.c b/tools/testing/selftests/vDSO/vdso_test_correctness.c
index ac5fa3e906806c28d3238e6f4e767e370932c5d1..310688e1379511e2c564b460c6379cc00b7a5f9a 100644
--- a/tools/testing/selftests/vDSO/vdso_test_correctness.c
+++ b/tools/testing/selftests/vDSO/vdso_test_correctness.c
@@ -10,20 +10,22 @@
 #include <time.h>
 #include <stdlib.h>
 #include <unistd.h>
+#include <sys/auxv.h>
 #include <sys/syscall.h>
-#include <dlfcn.h>
 #include <string.h>
 #include <errno.h>
 #include <sched.h>
 #include <stdbool.h>
 #include <limits.h>
 
+#include "parse_vdso.h"
 #include "vdso_config.h"
 #include "vdso_call.h"
 #include "vdso_syscalls.h"
 #include "vdso_types.h"
 #include "../kselftest.h"
 
+static const char *version;
 static const char **name;
 
 #ifndef __NR_clock_gettime64
@@ -88,39 +90,32 @@ static void *vsyscall_getcpu(void)
 
 static void fill_function_pointers(void)
 {
-	void *vdso = dlopen("linux-vdso.so.1",
-			    RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);
-	if (!vdso)
-		vdso = dlopen("linux-gate.so.1",
-			      RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);
-	if (!vdso)
-		vdso = dlopen("linux-vdso32.so.1",
-			      RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);
-	if (!vdso)
-		vdso = dlopen("linux-vdso64.so.1",
-			      RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);
-	if (!vdso) {
+	unsigned long sysinfo_ehdr = getauxval(AT_SYSINFO_EHDR);
+
+	if (!sysinfo_ehdr) {
 		printf("[WARN]\tfailed to find vDSO\n");
 		return;
 	}
 
-	vdso_getcpu = (getcpu_t)dlsym(vdso, name[4]);
+	vdso_init_from_sysinfo_ehdr(sysinfo_ehdr);
+
+	vdso_getcpu = (getcpu_t)vdso_sym(version, name[4]);
 	if (!vdso_getcpu)
 		printf("Warning: failed to find getcpu in vDSO\n");
 
 	vgetcpu = (getcpu_t) vsyscall_getcpu();
 
-	vdso_clock_gettime = (vdso_clock_gettime_t)dlsym(vdso, name[1]);
+	vdso_clock_gettime = (vdso_clock_gettime_t)vdso_sym(version, name[1]);
 	if (!vdso_clock_gettime)
 		printf("Warning: failed to find clock_gettime in vDSO\n");
 
 #if defined(VDSO_32BIT)
-	vdso_clock_gettime64 = (vdso_clock_gettime64_t)dlsym(vdso, name[5]);
+	vdso_clock_gettime64 = (vdso_clock_gettime64_t)vdso_sym(version, name[5]);
 	if (!vdso_clock_gettime64)
 		printf("Warning: failed to find clock_gettime64 in vDSO\n");
 #endif
 
-	vdso_gettimeofday = (vdso_gettimeofday_t)dlsym(vdso, name[0]);
+	vdso_gettimeofday = (vdso_gettimeofday_t)vdso_sym(version, name[0]);
 	if (!vdso_gettimeofday)
 		printf("Warning: failed to find gettimeofday in vDSO\n");
 
@@ -398,6 +393,7 @@ static void test_gettimeofday(void)
 
 int main(int argc, char **argv)
 {
+	version = versions[VDSO_VERSION];
 	name = (const char **)&names[VDSO_NAMES];
 
 	fill_function_pointers();

-- 
2.51.0


