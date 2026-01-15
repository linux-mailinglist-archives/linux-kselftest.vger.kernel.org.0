Return-Path: <linux-kselftest+bounces-49000-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 776C0D2331C
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 09:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5BF48302CA83
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 08:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A07339B43;
	Thu, 15 Jan 2026 08:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cGOq1rq1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i9G9/5j1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841D83385BE;
	Thu, 15 Jan 2026 08:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768465818; cv=none; b=UpvZSjhJx/sKW1l457B184MjcC+lHUlySaArFvD5p2vClSP7iec5Nh2NKQJpBW2xb9v4scF5xMlhMEgyddYeMj699qUDyXhrW+pylbslpbtPDPcDYfxizc+DCB6GUuwL+URN/L/43DP8saOCJS2XC18eG71eOcDlICULfvi7rhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768465818; c=relaxed/simple;
	bh=AER4fGi0z+KKvpkEQeIEQIFzt+vVP2SRhEq8AMYffes=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PyDrndyzjE5b0VhvZnBA4wZcOYkYPBPbIehPty9TSOmvpS9BY/aYq4PMcw44pvTbN56KE0W0oUUaG183fltHi5tvsS8asqFX3O8tbzD9G0fa+qx1POq+ShBESBt3NtKUTpffqDPpKBwyjtD841JAf3admrXfhuB9tbmAmmGS9d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cGOq1rq1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i9G9/5j1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768465802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ua/mSNRnV7lHdf3pKqR1IcGHRDXxLTzSpocRza2tj2Q=;
	b=cGOq1rq1s7Jm9vnEoQodFFXodJNOz0PfIgRePJvsuHTFFK6deLmTxNUy/UnnzL5BR91hIi
	41ruo6QtMeuC47urIrhYoFukTPIWlxL2uBZGqsUB1BvLfuKUwQ+E09M9j79DP/WPINW6sn
	Sqzw+h6XcN2fff6vbgP0iB/kZREc0TdyOLDYFflBkAE9ntAZT1bB7JkBznDgEyX1kOCxcF
	CQppVxIonUq+/Ek8XK6+c59SiWz78R4feF5GZq9I5mu9r4uO0GSiV036UzDOFilT8V82lN
	PkGiIrRAbw4NOCPcR+5L3MRYIv4RkBj34RGX6mk/DYAfrb+x556zlC/wjgenfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768465802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ua/mSNRnV7lHdf3pKqR1IcGHRDXxLTzSpocRza2tj2Q=;
	b=i9G9/5j1N3pwlH9SXkxmss8AljardXnKazXxZPQ9bq2HHv2vLguUCOwRySBUwYwTOLsgAL
	ZkOf5soDI8s60qDg==
Date: Thu, 15 Jan 2026 09:29:57 +0100
Subject: [PATCH 5/6] selftests: vDSO: vdso_test_correctness: Use facilities
 from parse_vdso.c
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260115-vdso-selftest-cleanups-v1-5-103e1ccbfdc3@linutronix.de>
References: <20260115-vdso-selftest-cleanups-v1-0-103e1ccbfdc3@linutronix.de>
In-Reply-To: <20260115-vdso-selftest-cleanups-v1-0-103e1ccbfdc3@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768465799; l=4190;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=AER4fGi0z+KKvpkEQeIEQIFzt+vVP2SRhEq8AMYffes=;
 b=9yDNDYIY4OkaIeFrVnaFiSgGPXV5n8XjEJRdG/IhYcLhE5NVh2mNM0GGK/lWNFhCFtxmWLhE8
 GV2nfqdXr8NB6KwV2g4225RSWoTfzi/jFqRaO/yG+NcdQy57VSgr+eq
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
index 2de5cef311c8..a61047bdcd57 100644
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
index 9b564888e74d..a94ab4d597b1 100644
--- a/tools/testing/selftests/vDSO/vdso_test_correctness.c
+++ b/tools/testing/selftests/vDSO/vdso_test_correctness.c
@@ -11,18 +11,20 @@
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
 #include "kselftest.h"
 
+static const char *version;
 static const char **name;
 
 #ifndef __NR_clock_gettime64
@@ -102,39 +104,32 @@ static void *vsyscall_getcpu(void)
 
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
 
-	vdso_clock_gettime = (vgettime_t)dlsym(vdso, name[1]);
+	vdso_clock_gettime = (vgettime_t)vdso_sym(version, name[1]);
 	if (!vdso_clock_gettime)
 		printf("Warning: failed to find clock_gettime in vDSO\n");
 
 #if defined(VDSO_32BIT)
-	vdso_clock_gettime64 = (vgettime64_t)dlsym(vdso, name[5]);
+	vdso_clock_gettime64 = (vgettime64_t)vdso_sym(version, name[5]);
 	if (!vdso_clock_gettime64)
 		printf("Warning: failed to find clock_gettime64 in vDSO\n");
 #endif
 
-	vdso_gettimeofday = (vgtod_t)dlsym(vdso, name[0]);
+	vdso_gettimeofday = (vgtod_t)vdso_sym(version, name[0]);
 	if (!vdso_gettimeofday)
 		printf("Warning: failed to find gettimeofday in vDSO\n");
 
@@ -429,6 +424,7 @@ static void test_gettimeofday(void)
 
 int main(int argc, char **argv)
 {
+	version = versions[VDSO_VERSION];
 	name = (const char **)&names[VDSO_NAMES];
 
 	fill_function_pointers();

-- 
2.52.0


