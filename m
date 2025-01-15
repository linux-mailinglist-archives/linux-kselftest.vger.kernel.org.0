Return-Path: <linux-kselftest+bounces-24547-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCAAA1176D
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 03:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 603AC188AD58
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 02:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4909A22DC30;
	Wed, 15 Jan 2025 02:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="h0Li9A87"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770C922DFA7
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Jan 2025 02:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736908886; cv=none; b=WKzcENKjCjFVGCZKnZ6lY0r7+nITP9qiV3ub22P9v3HLSq/U9bydTm2VoL671UtGg2Hx+Nfk2/fQ59pH/SsSct9irE8I7S0gkmIVi3WOXaTCiKJl17+e5xJEZ2kkMWDy7qVjXR/qeChT0nMkvCC64pR70QOgeaZfXfu4dA7UO9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736908886; c=relaxed/simple;
	bh=NqOUrka99DSUi18FOpq9XilJAxI+Dx6U6EraUGvZnFk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HbQgoNp73Ybk6RdE/aH9wYsDQcupYSdf2WLDIjaJ20BJmUh4oovQM3N52hh9Lb+lo0sbndJ1DGng6or/+MOi4k5T2PJ8Y7Gj8s6dMAKPvyJ2WIWWlpZAMq7uzcajOimKCLsY1nqagykncphNHjUQJ+mpGRjjQvJirUwy9JQY55Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=h0Li9A87; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-216426b0865so109245965ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2025 18:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736908884; x=1737513684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y6H6/Xpe5szI3425MURKDC2kUnYsqHlXT/4n1BN4R7E=;
        b=h0Li9A87gm27wtzSrZ0Ee3L3MmApoSpc+MCThRd7Kpif5KBOO9Xbbf0sMhV890Jlys
         P3IE5Pf4mAyvk4Wjrqqdwv0d4aJZFdv6F0S91rwc92LcpJe8rYJ95W8U28T1YrvVTfzI
         su6nwxTlgm/se7fZSUaPEy1SGNzaL49cLKrp5Olnj9NQkO/fDOEw4PicE78qAnhoIm3s
         p7GOX2qwkY9F9Pi5X2g8Xpp3MtHixkFa4UVJnTfBp/9Sbp/ovi9OPdiM+kToN6RUnTjJ
         g3Xyr03yMz8x4eZzmc+zLD1/LMKULpDRVlvQL9k1d3a6nFcU0yw7S0KU124SUNrw5E5c
         74zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736908884; x=1737513684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y6H6/Xpe5szI3425MURKDC2kUnYsqHlXT/4n1BN4R7E=;
        b=qVXl6VQmW07mpOiLyBAf1BNd6xiqw+go0gCZdkHdxkJbTRLiEUnxDAkhQ2W8mhMwOU
         Rv9fDn1iaGukVh3rZ8vkAW2FDfMeycoUaRV5ZKwlg/VI6bPn7Yq/ZhbQ47vRH47h+UTG
         FhMlt9T2KR0sB1FQbOZ9YQhop4ydNi5wr9fASakiMWDnaNv4iFt6ObLhBIOJ1Ta4W/ul
         We9rGEcudsYg4yBCgq7f2Tb9aClRGE2i9yInqNbnw/forrmkYGpP2Hgy/ER0XkEjIXZH
         eB7dNsPjEgNshuMldZeiaEtHLNcfb7gy7QNIgGoMEwUuPAO8FpFXmmkrbPBU3Loikcbs
         NOCg==
X-Forwarded-Encrypted: i=1; AJvYcCXkNu6xgr54Y4cEDaR1Vu+okvv7KdWyOk3hcbeO4ECDVhkgEhYWrfZHLA+rktQlJgc9kqJRbQMRRxAhJed/Y4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwutM5G7zdggbpt/jP/AIKBmF8aiDMZTpH8KZbNzEH0M0dAxKkX
	pQL3sNubN0jiNVtRXrNGy09B9XwCwQhRwghE7cN4YCA2kLoF7k9RqJ5kEZk7A/8=
X-Gm-Gg: ASbGncs4mYrRRDkVRJ//lt0Sne4D+mvIwzJF3uycYkWUG2kcE6+JXNmS+4BwHyNyqOA
	S5yyjogS2i0VakUMSDokRk949SnuTFyW2mRJudV4wXlK5bkRwXLbzw/CS7d3F9kIYMxhuBGzN1N
	dwtL1+L3aQotmacgfue5Q3AQ0sKRpEU1qzhTXG5yg7nHv2GsMQ47sjagFH/jFUDc20cfBjqy0qj
	eFOO3yRw+3EhPjhfy1FIkfqPVeFVHXl6+gZ+3Dj6Bs2oPBjjjKXExRtQ4rDSULzRLblEJJyTEH9
	gaCvyO78ERgRJKI=
X-Google-Smtp-Source: AGHT+IEvCBxOGHR3ybaItyvONDS8hALHgTqmx4phzF1QLDXR5oLeIKvQn/ktwaSu8a6RAzuXtynCUQ==
X-Received: by 2002:a05:6a00:35c6:b0:725:4109:5b5f with SMTP id d2e1a72fcca58-72d21f3233cmr46085088b3a.8.1736908883633;
        Tue, 14 Jan 2025 18:41:23 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40680e67sm8321841b3a.139.2025.01.14.18.41.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jan 2025 18:41:23 -0800 (PST)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: ajones@ventanamicro.com,
	alexghiti@rivosinc.com,
	andybnac@gmail.com,
	aou@eecs.berkeley.edu,
	charlie@rivosinc.com,
	cleger@rivosinc.com,
	conor.dooley@microchip.com,
	conor@kernel.org,
	corbet@lwn.net,
	cuiyunhui@bytedance.com,
	evan@rivosinc.com,
	jesse@rivosinc.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	samuel.holland@sifive.com,
	shuah@kernel.org
Subject: [PATCH v5 3/3] RISC-V: selftests: Add TEST_ZICBOM into CBO tests
Date: Wed, 15 Jan 2025 10:40:24 +0800
Message-Id: <20250115024024.84365-4-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250115024024.84365-1-cuiyunhui@bytedance.com>
References: <20250115024024.84365-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test for Zicbom and its block size into CBO tests, when
Zicbom is present, test that cbo.clean/flush may be issued and works.
As the software can't verify the clean/flush functions, we just judged
that cbo.clean/flush isn't executed illegally.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 tools/testing/selftests/riscv/hwprobe/cbo.c | 66 +++++++++++++++++----
 1 file changed, 55 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/riscv/hwprobe/cbo.c b/tools/testing/selftests/riscv/hwprobe/cbo.c
index a40541bb7c7d..5e96ef785d0d 100644
--- a/tools/testing/selftests/riscv/hwprobe/cbo.c
+++ b/tools/testing/selftests/riscv/hwprobe/cbo.c
@@ -50,6 +50,14 @@ static void cbo_clean(char *base) { cbo_insn(base, 1); }
 static void cbo_flush(char *base) { cbo_insn(base, 2); }
 static void cbo_zero(char *base)  { cbo_insn(base, 4); }
 
+static void test_no_cbo_inval(void *arg)
+{
+	ksft_print_msg("Testing cbo.inval instruction remain privileged\n");
+	illegal_insn = false;
+	cbo_inval(&mem[0]);
+	ksft_test_result(illegal_insn, "No cbo.inval\n");
+}
+
 static void test_no_zicbom(void *arg)
 {
 	ksft_print_msg("Testing Zicbom instructions remain privileged\n");
@@ -61,10 +69,6 @@ static void test_no_zicbom(void *arg)
 	illegal_insn = false;
 	cbo_flush(&mem[0]);
 	ksft_test_result(illegal_insn, "No cbo.flush\n");
-
-	illegal_insn = false;
-	cbo_inval(&mem[0]);
-	ksft_test_result(illegal_insn, "No cbo.inval\n");
 }
 
 static void test_no_zicboz(void *arg)
@@ -81,6 +85,30 @@ static bool is_power_of_2(__u64 n)
 	return n != 0 && (n & (n - 1)) == 0;
 }
 
+static void test_zicbom(void *arg)
+{
+	struct riscv_hwprobe pair = {
+		.key = RISCV_HWPROBE_KEY_ZICBOM_BLOCK_SIZE,
+	};
+	cpu_set_t *cpus = (cpu_set_t *)arg;
+	__u64 block_size;
+	long rc;
+
+	rc = riscv_hwprobe(&pair, 1, sizeof(cpu_set_t), (unsigned long *)cpus, 0);
+	block_size = pair.value;
+	ksft_test_result(rc == 0 && pair.key == RISCV_HWPROBE_KEY_ZICBOM_BLOCK_SIZE &&
+			 is_power_of_2(block_size), "Zicbom block size\n");
+	ksft_print_msg("Zicbom block size: %llu\n", block_size);
+
+	illegal_insn = false;
+	cbo_clean(&mem[block_size]);
+	ksft_test_result(!illegal_insn, "cbo.clean\n");
+
+	illegal_insn = false;
+	cbo_flush(&mem[block_size]);
+	ksft_test_result(!illegal_insn, "cbo.flush\n");
+}
+
 static void test_zicboz(void *arg)
 {
 	struct riscv_hwprobe pair = {
@@ -129,7 +157,7 @@ static void test_zicboz(void *arg)
 	ksft_test_result_pass("cbo.zero check\n");
 }
 
-static void check_no_zicboz_cpus(cpu_set_t *cpus)
+static void check_no_zicbo_cpus(cpu_set_t *cpus, __u64 cbo)
 {
 	struct riscv_hwprobe pair = {
 		.key = RISCV_HWPROBE_KEY_IMA_EXT_0,
@@ -137,6 +165,7 @@ static void check_no_zicboz_cpus(cpu_set_t *cpus)
 	cpu_set_t one_cpu;
 	int i = 0, c = 0;
 	long rc;
+	char *cbostr;
 
 	while (i++ < CPU_COUNT(cpus)) {
 		while (!CPU_ISSET(c, cpus))
@@ -148,10 +177,13 @@ static void check_no_zicboz_cpus(cpu_set_t *cpus)
 		rc = riscv_hwprobe(&pair, 1, sizeof(cpu_set_t), (unsigned long *)&one_cpu, 0);
 		assert(rc == 0 && pair.key == RISCV_HWPROBE_KEY_IMA_EXT_0);
 
-		if (pair.value & RISCV_HWPROBE_EXT_ZICBOZ)
-			ksft_exit_fail_msg("Zicboz is only present on a subset of harts.\n"
-					   "Use taskset to select a set of harts where Zicboz\n"
-					   "presence (present or not) is consistent for each hart\n");
+		cbostr = cbo == RISCV_HWPROBE_EXT_ZICBOZ ? "Zicboz" : "Zicbom";
+
+		if (pair.value & cbo)
+			ksft_exit_fail_msg("%s is only present on a subset of harts.\n"
+					   "Use taskset to select a set of harts where %s\n"
+					   "presence (present or not) is consistent for each hart\n",
+					   cbostr, cbostr);
 		++c;
 	}
 }
@@ -159,7 +191,9 @@ static void check_no_zicboz_cpus(cpu_set_t *cpus)
 enum {
 	TEST_ZICBOZ,
 	TEST_NO_ZICBOZ,
+	TEST_ZICBOM,
 	TEST_NO_ZICBOM,
+	TEST_NO_CBO_INVAL,
 };
 
 static struct test_info {
@@ -169,7 +203,9 @@ static struct test_info {
 } tests[] = {
 	[TEST_ZICBOZ]		= { .nr_tests = 3, test_zicboz },
 	[TEST_NO_ZICBOZ]	= { .nr_tests = 1, test_no_zicboz },
-	[TEST_NO_ZICBOM]	= { .nr_tests = 3, test_no_zicbom },
+	[TEST_ZICBOM]		= { .nr_tests = 3, test_zicbom },
+	[TEST_NO_ZICBOM]	= { .nr_tests = 2, test_no_zicbom },
+	[TEST_NO_CBO_INVAL]	= { .nr_tests = 1, test_no_cbo_inval },
 };
 
 int main(int argc, char **argv)
@@ -189,6 +225,7 @@ int main(int argc, char **argv)
 		assert(rc == 0);
 		tests[TEST_NO_ZICBOZ].enabled = true;
 		tests[TEST_NO_ZICBOM].enabled = true;
+		tests[TEST_NO_CBO_INVAL].enabled = true;
 	}
 
 	rc = sched_getaffinity(0, sizeof(cpu_set_t), &cpus);
@@ -206,7 +243,14 @@ int main(int argc, char **argv)
 		tests[TEST_ZICBOZ].enabled = true;
 		tests[TEST_NO_ZICBOZ].enabled = false;
 	} else {
-		check_no_zicboz_cpus(&cpus);
+		check_no_zicbo_cpus(&cpus, RISCV_HWPROBE_EXT_ZICBOZ);
+	}
+
+	if (pair.value & RISCV_HWPROBE_EXT_ZICBOM) {
+		tests[TEST_ZICBOM].enabled = true;
+		tests[TEST_NO_ZICBOM].enabled = false;
+	} else {
+		check_no_zicbo_cpus(&cpus, RISCV_HWPROBE_EXT_ZICBOM);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(tests); ++i)
-- 
2.39.2


