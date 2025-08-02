Return-Path: <linux-kselftest+bounces-38200-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A8EB18A4F
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Aug 2025 03:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6527567065
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Aug 2025 01:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEFE192B75;
	Sat,  2 Aug 2025 01:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="P7gN6f4j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444EE143748;
	Sat,  2 Aug 2025 01:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754099670; cv=none; b=gnBte+T7BN71wOJztrWjy46GVXSLmGjvo2sqjnuHpW5d23z/4zGPbkTqCsZFqw78L5Z9q3PLCBhQfK6tdla6NtUGpIV+VHlrFUmEjBydp7cSgN1NmAEcM/qwdKhJ4cYRo1A+JXJOxj8RwB+VAbZBzDQTmjbOk6xMwovOC4cKbPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754099670; c=relaxed/simple;
	bh=ZzvXMMEd2VKZRyx2UGIotKUKMVqbiSAPuF9PKhhLeL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AvFWfWZYT+j5u4TxNsetD6pAowIQsCaJwgRPLnxQF6i69jD7KboSV6eSb8uurwo1obfqk2GbKDfbjP8sPGHAOdLmxiV+GDfr5RXIIUjOXPNAG+xqt6cGW3lCjbvdu54JEIFcV+rng1qwpN1sEG8pILF2cLmxdEbFz04CgMrWmlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=P7gN6f4j; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=b8
	+eKxxlAXpU1PrZbIB9ESPWyVrT7xYsLsdYc4aRzr8=; b=P7gN6f4jTnBKA1pRbC
	NWJReEgCawaRe+kO4YgEkDxp+/GEHWL25eNGMAyA8+2uqhdbNFH6oqvJDabBMYGL
	JRj5i4hpgtEQUP1vBvEpGRHf08hdriIZtBbO+o6we+GhoCTQM5WWiSG/uB8+gtkz
	w727LOHLWxgMcJWLKo4MobcMw=
Received: from phoenix.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wAn9dGhb41owA7sJQ--.1054S4;
	Sat, 02 Aug 2025 09:53:40 +0800 (CST)
From: Jiawei Zhao <phoenix500526@163.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] selftests/bpf: Force -O2 for USDT selftests to cover SIB handling logic
Date: Sat,  2 Aug 2025 01:53:35 +0000
Message-ID: <20250802015336.823054-3-phoenix500526@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802015336.823054-1-phoenix500526@163.com>
References: <20250802015336.823054-1-phoenix500526@163.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAn9dGhb41owA7sJQ--.1054S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw4ktFy5WrWDCF4kGw48JFb_yoW5tr1kpa
	ykWw1jyFySqa17tan7ZrnrXr45WFs7JFWFyr1UXryFvr4kJF97XFZ7t3yUKFnxW393Xaya
	y392gry3GF4rAwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jzUDJUUUUU=
X-CM-SenderInfo: pskrv0dl0viiqvswqiywtou0bp/xtbBgAydiGiNYdH42AAAss

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
 tools/testing/selftests/bpf/Makefile          |  5 +++++
 tools/testing/selftests/bpf/prog_tests/usdt.c | 18 ++++++++++++------
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 910d8d6402ef..f53c86023334 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -759,6 +759,11 @@ TRUNNER_BPF_BUILD_RULE := $$(error no BPF objects should be built)
 TRUNNER_BPF_CFLAGS :=
 $(eval $(call DEFINE_TEST_RUNNER,test_maps))
 
+# Force usdt.c to use -O2 optimization to generate SIB addressing
+$(OUTPUT)/usdt.test.o: CFLAGS:=$(subst O0,O2,$(CFLAGS))
+$(OUTPUT)/cpuv4/usdt.test.o: CFLAGS:=$(subst O0,O2,$(CFLAGS))
+$(OUTPUT)/no_alu32/usdt.test.o: CFLAGS:=$(subst O0,O2,$(CFLAGS))
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


