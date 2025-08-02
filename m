Return-Path: <linux-kselftest+bounces-38203-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D70AB18B6F
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Aug 2025 10:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EAD97ABA32
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Aug 2025 08:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617851F17EB;
	Sat,  2 Aug 2025 08:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PYhV47+l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9652188CC9;
	Sat,  2 Aug 2025 08:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754124528; cv=none; b=mbwofYcNNgDcsyl7HJpn72X4fQXMyE65iWefl47rL5+LduBuvLCm52jNC6Wva5ABNCt2c4WtsUifjM2bm5Qd+Buw2pbArtuvjiA6dn5/8dB9+GfC90+gSrlbOqMDT5SEgO+tj4QZnAdxWRrQtTPBodcQl1QhFLE7NK+pPBgqjXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754124528; c=relaxed/simple;
	bh=5kxnT9Xzx93uaXYnSAt1yHdetnLLHCQ/S8LS14DVt7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rUvc+pBWSkokDomEMfw+ypybN2K1zEYparaKFFnBMWRrPSq8NUzzPOY9nkrmRSKKztqu/gYZ1dlZxaxBjCZlIYwyF2+PeKVD8XOAJt3aLy63k4iX+bfahsUcbDi+EQGtGiTC41CMzRVYwNQ2VzpS4WNJIcfTji6Hc2/nEjkPu7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PYhV47+l; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=ht
	j7auQ2DJotB/9/cDAg+sQhVrxsQ5LPGiEPy66on4E=; b=PYhV47+l2srGQVZ7af
	ODjv5Ohf+U6IkOH8oMfPIWzAVWYe5xZhKE+AZtU9zA0r0wthjIDZy8V2kO+dnjcq
	HSDL6kjCDpU0LqtGMPGlpHHw9V/ulN32UcRbQHmjljUqDA3RObLa378btRef4oBg
	ZO/thLHaN3HkG6wdBzZmiOqec=
Received: from phoenix.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDX0bXE0I1oWsxLJQ--.56694S4;
	Sat, 02 Aug 2025 16:48:07 +0800 (CST)
From: Jiawei Zhao <phoenix500526@163.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/2] selftests/bpf: Force -O2 for USDT selftests to cover SIB handling logic
Date: Sat,  2 Aug 2025 08:48:03 +0000
Message-ID: <20250802084803.108777-3-phoenix500526@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802084803.108777-1-phoenix500526@163.com>
References: <20250802084803.108777-1-phoenix500526@163.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX0bXE0I1oWsxLJQ--.56694S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw4ktFy5WrWDCF4kGw48JFb_yoW5tw45pa
	95Ww1UtFySq3W7JFs3ZrnrXr45WFs7JFWFyr1UXryFvr4kJF97XFZ7t3yUKFnxW393Xaya
	v392gry7GF45AwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jzUDJUUUUU=
X-CM-SenderInfo: pskrv0dl0viiqvswqiywtou0bp/1tbiFAGdiGiNynRtRQAAsz

When using GCC on x86-64 to compile an usdt prog with -O1 or higher
optimization, the compiler will generate SIB addressing mode for global
array and PC-relative addressing mode for global variable,
e.g. "1@-96(%rbp,%rax,8)" and "-1@4+t1(%rip)".

In this patch:
- force -O2 optimization for usdt.test.o to generate SIB addressing usdt
  argument spec.
- change the global variable t1 to a local variable, to avoid compiler
  generating PC-relative addressing mode for it.

Signed-off-by: Jiawei Zhao <phoenix500526@163.com>
---
 tools/testing/selftests/bpf/Makefile          |  8 ++++++++
 tools/testing/selftests/bpf/prog_tests/usdt.c | 18 ++++++++++++------
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 910d8d6402ef..4b77d06d5c42 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -759,6 +759,14 @@ TRUNNER_BPF_BUILD_RULE := $$(error no BPF objects should be built)
 TRUNNER_BPF_CFLAGS :=
 $(eval $(call DEFINE_TEST_RUNNER,test_maps))
 
+# Force usdt.c to use -O2 optimization to generate SIB addressing
+# Only apply on x86 architecture where SIB addressing is relevant
+ifeq ($(ARCH), x86)
+$(OUTPUT)/usdt.test.o: CFLAGS:=$(subst O0,O2,$(CFLAGS))
+$(OUTPUT)/cpuv4/usdt.test.o: CFLAGS:=$(subst O0,O2,$(CFLAGS))
+$(OUTPUT)/no_alu32/usdt.test.o: CFLAGS:=$(subst O0,O2,$(CFLAGS))
+endif
+
 # Define test_verifier test runner.
 # It is much simpler than test_maps/test_progs and sufficiently different from
 # them (e.g., test.h is using completely pattern), that it's worth just
diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
index 495d66414b57..86f354d25aef 100644
--- a/tools/testing/selftests/bpf/prog_tests/usdt.c
+++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
@@ -14,10 +14,15 @@ static volatile int idx = 2;
 static volatile __u64 bla = 0xFEDCBA9876543210ULL;
 static volatile short nums[] = {-1, -2, -3, -4};
 
-static volatile struct {
-	int x;
-	signed char y;
-} t1 = { 1, -127 };
+/*
+ * TODO:  At O2 optimization level, t1's USDT argument spec becomes -1@4+t1(%rip).
+ * Since libbpf doesn't support RIP addressing mode yet, this causes "unrecognized register" errors.
+ * This test will be re-enabled once libbpf supports RIP addressing mode.
+ */
+// static volatile struct {
+//	int x;
+//	signed char y;
+// } t1 = { 1, -127 };
 
 #define SEC(name) __attribute__((section(name), used))
 
@@ -27,6 +32,7 @@ unsigned short test_usdt12_semaphore SEC(".probes");
 
 static void __always_inline trigger_func(int x) {
 	long y = 42;
+	signed char t1 = -127;
 
 	if (test_usdt0_semaphore)
 		STAP_PROBE(test, usdt0);
@@ -36,7 +42,7 @@ static void __always_inline trigger_func(int x) {
 		STAP_PROBE12(test, usdt12,
 			     x, x + 1, y, x + y, 5,
 			     y / 7, bla, &bla, -9, nums[x],
-			     nums[idx], t1.y);
+			     nums[idx], t1);
 	}
 }
 
@@ -106,7 +112,7 @@ static void subtest_basic_usdt(void)
 	ASSERT_EQ(bss->usdt12_args[8], -9, "usdt12_arg9");
 	ASSERT_EQ(bss->usdt12_args[9], nums[1], "usdt12_arg10");
 	ASSERT_EQ(bss->usdt12_args[10], nums[idx], "usdt12_arg11");
-	ASSERT_EQ(bss->usdt12_args[11], t1.y, "usdt12_arg12");
+	ASSERT_EQ(bss->usdt12_args[11], -127, "usdt12_arg12");
 
 	int usdt12_expected_arg_sizes[12] = { 4, 4, 8, 8, 4, 8, 8, 8, 4, 2, 2, 1 };
 
-- 
2.43.0


