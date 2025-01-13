Return-Path: <linux-kselftest+bounces-24320-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC9FA0B14C
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 09:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 355091656D7
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 08:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D842343B3;
	Mon, 13 Jan 2025 08:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="K/ceXTjK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3C42343AE
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 08:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736757472; cv=none; b=BySoDhuGM4eutbYvk7CuK1JOoNgUnhCfiwkr9PqL4Xx2zAuEmTgMRp2qi6flEf5Z5t7VC5UYZ6EUllCMdLQwXhMb1TE3h1T4hKtkwxyfXxR1aa0s+1hA2N+zgQSNugCOLi4HkJw7PTnUNtZPDCo4rd52PbY0wqy/wPr7nQDwVuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736757472; c=relaxed/simple;
	bh=kpZZDmzk+pA7qUikHydnQ184ytU7CciUWTlCG7kR63U=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e09ybS9W/nBc3hIJZE16BgbVjtKKlRRpiClA/ODu9P2G+jUKidArOfBgJrmnfoJQX4XUqPjh2m9IV6z+7qGUkhrImqSVySMi7Yn9ejXUByVJsaFRDXTwFqo2+RdOiq0gz/1vuBCB9wP1rmo0SylaQ4MsL2yhwcsRXj9AEC0n7iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=K/ceXTjK; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-216634dd574so44241625ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 00:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736757471; x=1737362271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qMJOsZFUuGMCCNl6Ap7/zKUJmvdFBz7dQyyFwX4yhfU=;
        b=K/ceXTjKYjf0qJWYIfPnAiPfXSoWgYOfJKCRhVPUTO52v5Xu12ipEfGfbrwByqoSdh
         VKTG4IaHw1xKfIKU5yuJKYUnQ1vAx7ZFOARRsxPu8Q8DTA61YxUa50VVH5XzE5tUAtjX
         ekzMdJ2UVCNGiEtZjn9JJ+3pHJsmSJewdArni+GX762ExGT56AWjOr9WY9yf+6mT4mz2
         n8glp6EzruBvCUHK7g+hhi25enN0ccuVkLtI5uE7fYI2STZGz+U5dZIKZHUjYchx0FJ2
         avqGJDizFlY95vb/0Rlxav3qxEfZr6CumxRYWkCaQ9Nk2J9UcZZR2elh3fYu6dOYind4
         11kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736757471; x=1737362271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qMJOsZFUuGMCCNl6Ap7/zKUJmvdFBz7dQyyFwX4yhfU=;
        b=QL9MzL6EJ4VZ4tu8tjjxky4yE+xzllG0XZIf4EW8gwyrwxo5WLEJJul4t/QBY72mK0
         v2w5WM70QH8GzcSMFYgHA0USyEHYQ3tRzRvjqVVFjpRFc5u/peGAUGiFy2QOLiVey3IO
         g1tNytIQ/rS2qLwqGO87mtnLP4Mffw+v6yHROMVP5cKFxAfB0grRkLdeVK9HACqnXET1
         1lgIQmxYtC9tMg3HpFFbTOqbNPs+B+IVXLGS/O4kxBml51hH1M8egBGHAS/sDWdAjIMe
         NkElpdwa4A1EdT59+w2PnWyVJdzpx+GmcWeTBwQsDiTmyKG09bq1XyaLlzbfsw14BmYE
         UPFA==
X-Forwarded-Encrypted: i=1; AJvYcCUnJMKQ04XgHDizf03NShoUigHAYdCjC1acP83WcL4JUyaKbp91NRe8mZzqujREnNvrqujnnZ5T+7F5UcY1RpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzDMOH+cUjpGbt7/TJkEH+tIq3TphXNhoyInPANjHez7Fmr/Ki
	s5yl+3OB1X4LkAGxe9IlCecX/yYG8DwNWWSbAzl5Ry7kAiWeHHNacF0cdg/LU+A=
X-Gm-Gg: ASbGncsNzgVenGwM0GuErtjv8Cl6TvNcR+dDH0l1xLLGfbrPtymH51h9h3izJVG/wKu
	HYinsJ2WdpONcc98CxdRyip2eRB+FbU5UxjNAZzBnomisHklepqT3ZV/B2HVGP2UaC6wU2Vs5wr
	jf+88n50GYJgnONMXdZL81wiSVDIRmWy9f3Y5vSH5Jy3bNDWY47f3w4dNTwrqL1yP4Oa5fqY9H2
	8pEcy1s0U7mWeIsbJjk1jK4egcdrPxbLhrqQDNChFXA1Cy3qxgbePdG9THGqlQHsE1AzlRTyILU
	LGUSCLfwzPfhc+s=
X-Google-Smtp-Source: AGHT+IFLYk6bgrJ0SOLLV8CBQcEe8+QaPJ84+VNsdagEBMamy215GoqGCmwUbo8FjSJ9Sz2cJj2tMw==
X-Received: by 2002:a05:6a20:7344:b0:1e6:8f10:8ba2 with SMTP id adf61e73a8af0-1e88cf7f796mr31344708637.9.1736757470676;
        Mon, 13 Jan 2025 00:37:50 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a317a07ceedsm6427433a12.6.2025.01.13.00.37.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jan 2025 00:37:50 -0800 (PST)
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
Subject: [PATCH v3 3/3] RISC-V: selftests: Add TEST_ZICBOM into CBO tests
Date: Mon, 13 Jan 2025 16:36:35 +0800
Message-Id: <20250113083635.73826-3-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250113083635.73826-1-cuiyunhui@bytedance.com>
References: <20250113083635.73826-1-cuiyunhui@bytedance.com>
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

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 tools/testing/selftests/riscv/hwprobe/cbo.c | 49 ++++++++++++++++++---
 1 file changed, 43 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/riscv/hwprobe/cbo.c b/tools/testing/selftests/riscv/hwprobe/cbo.c
index a40541bb7c7d..b63e23f95e08 100644
--- a/tools/testing/selftests/riscv/hwprobe/cbo.c
+++ b/tools/testing/selftests/riscv/hwprobe/cbo.c
@@ -81,6 +81,30 @@ static bool is_power_of_2(__u64 n)
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
@@ -129,7 +153,7 @@ static void test_zicboz(void *arg)
 	ksft_test_result_pass("cbo.zero check\n");
 }
 
-static void check_no_zicboz_cpus(cpu_set_t *cpus)
+static void check_no_zicbo_cpus(cpu_set_t *cpus, __u64 cbo)
 {
 	struct riscv_hwprobe pair = {
 		.key = RISCV_HWPROBE_KEY_IMA_EXT_0,
@@ -137,6 +161,7 @@ static void check_no_zicboz_cpus(cpu_set_t *cpus)
 	cpu_set_t one_cpu;
 	int i = 0, c = 0;
 	long rc;
+	char *cbostr;
 
 	while (i++ < CPU_COUNT(cpus)) {
 		while (!CPU_ISSET(c, cpus))
@@ -148,10 +173,13 @@ static void check_no_zicboz_cpus(cpu_set_t *cpus)
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
@@ -159,6 +187,7 @@ static void check_no_zicboz_cpus(cpu_set_t *cpus)
 enum {
 	TEST_ZICBOZ,
 	TEST_NO_ZICBOZ,
+	TEST_ZICBOM,
 	TEST_NO_ZICBOM,
 };
 
@@ -169,6 +198,7 @@ static struct test_info {
 } tests[] = {
 	[TEST_ZICBOZ]		= { .nr_tests = 3, test_zicboz },
 	[TEST_NO_ZICBOZ]	= { .nr_tests = 1, test_no_zicboz },
+	[TEST_ZICBOM]		= { .nr_tests = 3, test_zicbom },
 	[TEST_NO_ZICBOM]	= { .nr_tests = 3, test_no_zicbom },
 };
 
@@ -206,7 +236,14 @@ int main(int argc, char **argv)
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


