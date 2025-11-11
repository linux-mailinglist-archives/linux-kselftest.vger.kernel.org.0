Return-Path: <linux-kselftest+bounces-45305-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 062AFC4D33F
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 11:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9E71188FB8F
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 10:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687EC355800;
	Tue, 11 Nov 2025 10:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LgBxe6yC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DWi326Wa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91F5354AEE;
	Tue, 11 Nov 2025 10:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858208; cv=none; b=dwPj1/YkTVdi81k9h9UYiUbTfNED1YTlDOzgSoztp19+2eytK5+JhkjOGtVALRWsCpfD6Uft+/BtWHuvyD6wmZxTO33mnEzkrKhIx72nGIKMpPZRxKlfXGCAJJmd2B/wY/dvgAQsXXNe0k9LONLj+xsA+HreQGMpf2R/pAvE9fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858208; c=relaxed/simple;
	bh=EWQJQ6D5JmJ0c/Pv8shy9wjpsGBrg9Cm+Eo4OM5oVz8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ECO/muzsvcB/QgR5CCWogw+Ad4Va0b8iWVAz1NsAVHc4uYU56IscLd6S2N+ruWwgGTumNi867dLtjZ7Sk0au3KpBbcr60dQrBiPqDmlIno47JdEL+tSyRmgNHUqY2SSiD4hJHxVtuh/Mm/XgWe70H76zi1kxB4W3JmTCN4bzJ9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LgBxe6yC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DWi326Wa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762858204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Wf3tKTzsmVv2SCafM8ESNg4uW5j8HNf/0LInI7K5hc=;
	b=LgBxe6yCfLAEF5LSihvW/M5EBwoRmVADNCynZcsc/aLbhld6MLEcFQ7RaLKIJeKNFsMVlv
	i20oQ0fkag4gzEaXfTtsJhgOmefrb2Uas5TpjfkTNlWJn424KKA2EQ0gIRC32PRwZraCMw
	GAS9fLnloBgBa/3o0l2GGj9e3rI7cZ7Csn2sNWOrfwtAtRBRHJQIel1VqtuBE09l0lJ2lG
	IJbChuakpRxFqpH/SknlEBtgZRtxvdlcEqG9My3fWjxeL+SA9rCUtkA0X/M0iu6alGkND0
	4q2IO1WCUy1eyScP3Ieqdfftu3a6b1mRH11pDvpUNIy0dbhE/tB/xdz9Hg/FUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762858204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Wf3tKTzsmVv2SCafM8ESNg4uW5j8HNf/0LInI7K5hc=;
	b=DWi326Wari96UnrgAzh5eP3e1ebJBe0iGmMzJZMlmAUjBdv8ZmWfHotK1HVzEEST8CjYLJ
	I4rhFxaJAaQb5MCA==
Date: Tue, 11 Nov 2025 11:49:56 +0100
Subject: [PATCH 10/10] selftests: vDSO: vdso_test_correctness: Use
 facilities from parse_vdso.c
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251111-vdso-test-types-v1-10-03b31f88c659@linutronix.de>
References: <20251111-vdso-test-types-v1-0-03b31f88c659@linutronix.de>
In-Reply-To: <20251111-vdso-test-types-v1-0-03b31f88c659@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762858197; l=4393;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=EWQJQ6D5JmJ0c/Pv8shy9wjpsGBrg9Cm+Eo4OM5oVz8=;
 b=NyMlxBOo0PMMEcOP2Lmv4zVBVOJuOpCnvzWHrx11IZLIffAKvkFa4mlvB+UaNaLlUJRp4eKxr
 e2vRIzbuDT0A9L/P4Ln0WsnKd/00uoidVccI79JiEWVmKCFXfG0jO85
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
index 2de5cef311c8ab695606cf7f408c04910842e377..a61047bdcd576d47d944f442f9e7140fccfe58e0 100644
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
index b27c28cd00a2b974751dffae850f34517ada094d..bda090b8f74632325ba0f15898dbc45656a73090 100644
--- a/tools/testing/selftests/vDSO/vdso_test_correctness.c
+++ b/tools/testing/selftests/vDSO/vdso_test_correctness.c
@@ -10,19 +10,21 @@
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
 #include "vdso_types.h"
 #include "../kselftest.h"
 
+static const char *version;
 static const char **name;
 
 #ifndef __NR_clock_gettime64
@@ -87,39 +89,32 @@ static void *vsyscall_getcpu(void)
 
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
 
@@ -422,6 +417,7 @@ static void test_gettimeofday(void)
 
 int main(int argc, char **argv)
 {
+	version = versions[VDSO_VERSION];
 	name = (const char **)&names[VDSO_NAMES];
 
 	fill_function_pointers();

-- 
2.51.0


