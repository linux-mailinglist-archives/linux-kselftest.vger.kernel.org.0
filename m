Return-Path: <linux-kselftest+bounces-36543-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7ADAF910B
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 13:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14F085647DC
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 11:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B036C2C08CD;
	Fri,  4 Jul 2025 11:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="w9HYPVjy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from jpms-ob01-os7.noc.sony.co.jp (jpms-ob01-os7.noc.sony.co.jp [211.125.139.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC98285CBC;
	Fri,  4 Jul 2025 11:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.139.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751627357; cv=none; b=hR072ajEM+9h6MbMX9FGJtKzKePbUEO7nRKiMc6h8DCE25aAZdGkbCIFvrpmlmcL6Ug1Kh6Ol2nEDUNO5+Mm3fLXbMlOMLwXu8L6hLx9vm79KUnouj7eJb22N/GxCAwOQNBq4TmrVTlga2Zq5meMs89R0JMYnO4wpjFD/EYwo0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751627357; c=relaxed/simple;
	bh=TV/7w58bjfLB6WXsgckFzwAaVso0lFgSwbVf0M/jOrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eau8uuoTLArGqpvVhDXvvfl0H5tOAl6UhCoTYRZjjMsAE3OyH+001J52ZIXfLIJzkUWMv07aK/sopQHTG2YyyI3LWTVfDQPOw2HLzAYAT33xjECDFsIZpjf+g3KfOlJzZ0E1xNLLMb/7l9fp+0n0NQrtK+NY+vL2ClWbFW4AfIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=fail smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=w9HYPVjy; arc=none smtp.client-ip=211.125.139.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=sony.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1751627355; x=1783163355;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ovcOttaXl9UWHiQRmJlTkj3Gz0h6p0BU5i0IVTunyR8=;
  b=w9HYPVjypiAOmi3zcOY8y+R3V9IsQIxoknuI9il4Yi6BQUsH8gbABW28
   4u+sLjvrHUPLUbfN+gdseo2mKthtPas4cEjkp/oueD07UXywUJWKK6INP
   9Sureo8dLJ/Us049uATG8ZqCF8ijiUiaMgbgBYHZkelw8+bLmaus4Car5
   jgrtzzDTn0xvwHOx1V2bk963WuzyMl3zF7Hy9wMpPOGhYV7qCo3b8OigV
   Hjo/H0oFXor7Pt/JYn1Ai/fP5ODuYhDYMOuL+OpiTsE9I9pIazW+Xod6G
   YgRJ8z2bQCCO2CLcs/3glrNGLLsTU/2MQ3PLDjQLhzeUH9MYVnOE+7DtR
   A==;
Received: from unknown (HELO jpmta-ob02-os7.noc.sony.co.jp) ([IPv6:2001:cf8:acf:1104::7])
  by jpms-ob01-os7.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 20:09:13 +0900
X-IronPort-AV: E=Sophos;i="6.16,287,1744038000"; 
   d="scan'208";a="4728064"
Received: from unknown (HELO JPC00244420..) ([IPv6:2001:cf8:1:573:0:dddd:eb3e:119e])
  by jpmta-ob02-os7.noc.sony.co.jp with ESMTP; 04 Jul 2025 20:09:13 +0900
From: Shashank Balaji <shashank.mahadasyam@sony.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Shashank Balaji <shashank.mahadasyam@sony.com>,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shinya Takumi <shinya.takumi@sony.com>
Subject: [PATCH v3] selftests/cgroup: fix cpu.max tests
Date: Fri,  4 Jul 2025 20:08:41 +0900
Message-ID: <20250704110843.1022518-1-shashank.mahadasyam@sony.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250703120325.2905314-1-shashank.mahadasyam@sony.com>
References: <20250703120325.2905314-1-shashank.mahadasyam@sony.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Current cpu.max tests (both the normal one and the nested one) are broken.

They setup cpu.max with 1000 us quota and the default period (100,000 us).
A cpu hog is run for a duration of 1s as per wall clock time. This corresponds
to 10 periods, hence an expected usage of 10,000 us. We want the measured
usage (as per cpu.stat) to be close to 10,000 us.

Previously, this approximate equality test was done by
`!values_close(usage_usec, expected_usage_usec, 95)`: if the absolute
difference between usage_usec and expected_usage_usec is greater than 95% of
their sum, then we pass. And expected_usage_usec was set to 1,000,000 us.
Mathematically, this translates to the following being true for pass:

	|usage - expected_usage| > (usage + expected_usage)*0.95

	If usage > expected_usage:
		usage - expected_usage > (usage + expected_usage)*0.95
		0.05*usage > 1.95*expected_usage
		usage > 39*expected_usage = 39s

	If usage < expected_usage:
		expected_usage - usage > (usage + expected_usage)*0.95
		0.05*expected_usage > 1.95*usage
		usage < 0.0256*expected_usage = 25,600 us

Combined,

	Pass if usage < 25,600 us or > 39 s,

which makes no sense given that all we need is for usage_usec to be close to
10,000 us.

Fix this by explicitly calcuating the expected usage duration based on the
configured quota, default period, and the duration, and compare usage_usec
and expected_usage_usec using values_close() with a 10% error margin.

Also, use snprintf to get the quota string to write to cpu.max instead of
hardcoding the quota, ensuring a single source of truth.

Remove the check comparing user_usec and expected_usage_usec, since on running
this test modified with printfs, it's seen that user_usec and usage_usec can
regularly exceed the theoretical expected_usage_usec:

	$ sudo ./test_cpu
	user: 10485, usage: 10485, expected: 10000
	ok 1 test_cpucg_max
	user: 11127, usage: 11127, expected: 10000
	ok 2 test_cpucg_max_nested
	$ sudo ./test_cpu
	user: 10286, usage: 10286, expected: 10000
	ok 1 test_cpucg_max
	user: 10404, usage: 11271, expected: 10000
	ok 2 test_cpucg_max_nested

Hence, a values_close() check of usage_usec and expected_usage_usec is
sufficient.

Fixes: a79906570f9646ae17 ("cgroup: Add test_cpucg_max_nested() testcase")
Fixes: 889ab8113ef1386c57 ("cgroup: Add test_cpucg_max() testcase")
Acked-by: Michal Koutný <mkoutny@suse.com>
Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>

---

Changes in v3:
- Simplified commit message
- Explained why the "user_usec >= expected_usage_usec" check is removed
- Added fixes tags and Michal's Acked-by
- No code changes
- v2: https://lore.kernel.org/all/20250703120325.2905314-1-shashank.mahadasyam@sony.com/

Changes in v2:
- Incorporate Michal's suggestions:
	- Merge two patches into one
	- Generate the quota string from the variable instead of hardcoding it
	- Use values_close() instead of labs()
	- Explicitly calculate expected_usage_usec
- v1: https://lore.kernel.org/all/20250701-kselftest-cgroup-fix-cpu-max-v1-0-049507ad6832@sony.com/
---
 tools/testing/selftests/cgroup/test_cpu.c | 63 ++++++++++++++++-------
 1 file changed, 43 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_cpu.c b/tools/testing/selftests/cgroup/test_cpu.c
index a2b50af8e9ee..2a60e6c41940 100644
--- a/tools/testing/selftests/cgroup/test_cpu.c
+++ b/tools/testing/selftests/cgroup/test_cpu.c
@@ -2,6 +2,7 @@
 
 #define _GNU_SOURCE
 #include <linux/limits.h>
+#include <sys/param.h>
 #include <sys/sysinfo.h>
 #include <sys/wait.h>
 #include <errno.h>
@@ -645,10 +646,16 @@ test_cpucg_nested_weight_underprovisioned(const char *root)
 static int test_cpucg_max(const char *root)
 {
 	int ret = KSFT_FAIL;
-	long usage_usec, user_usec;
-	long usage_seconds = 1;
-	long expected_usage_usec = usage_seconds * USEC_PER_SEC;
+	long quota_usec = 1000;
+	long default_period_usec = 100000; /* cpu.max's default period */
+	long duration_seconds = 1;
+
+	long duration_usec = duration_seconds * USEC_PER_SEC;
+	long usage_usec, n_periods, remainder_usec, expected_usage_usec;
 	char *cpucg;
+	char quota_buf[32];
+
+	snprintf(quota_buf, sizeof(quota_buf), "%ld", quota_usec);
 
 	cpucg = cg_name(root, "cpucg_test");
 	if (!cpucg)
@@ -657,13 +664,13 @@ static int test_cpucg_max(const char *root)
 	if (cg_create(cpucg))
 		goto cleanup;
 
-	if (cg_write(cpucg, "cpu.max", "1000"))
+	if (cg_write(cpucg, "cpu.max", quota_buf))
 		goto cleanup;
 
 	struct cpu_hog_func_param param = {
 		.nprocs = 1,
 		.ts = {
-			.tv_sec = usage_seconds,
+			.tv_sec = duration_seconds,
 			.tv_nsec = 0,
 		},
 		.clock_type = CPU_HOG_CLOCK_WALL,
@@ -672,14 +679,19 @@ static int test_cpucg_max(const char *root)
 		goto cleanup;
 
 	usage_usec = cg_read_key_long(cpucg, "cpu.stat", "usage_usec");
-	user_usec = cg_read_key_long(cpucg, "cpu.stat", "user_usec");
-	if (user_usec <= 0)
+	if (usage_usec <= 0)
 		goto cleanup;
 
-	if (user_usec >= expected_usage_usec)
-		goto cleanup;
+	/*
+	 * The following calculation applies only since
+	 * the cpu hog is set to run as per wall-clock time
+	 */
+	n_periods = duration_usec / default_period_usec;
+	remainder_usec = duration_usec - n_periods * default_period_usec;
+	expected_usage_usec
+		= n_periods * quota_usec + MIN(remainder_usec, quota_usec);
 
-	if (values_close(usage_usec, expected_usage_usec, 95))
+	if (!values_close(usage_usec, expected_usage_usec, 10))
 		goto cleanup;
 
 	ret = KSFT_PASS;
@@ -698,10 +710,16 @@ static int test_cpucg_max(const char *root)
 static int test_cpucg_max_nested(const char *root)
 {
 	int ret = KSFT_FAIL;
-	long usage_usec, user_usec;
-	long usage_seconds = 1;
-	long expected_usage_usec = usage_seconds * USEC_PER_SEC;
+	long quota_usec = 1000;
+	long default_period_usec = 100000; /* cpu.max's default period */
+	long duration_seconds = 1;
+
+	long duration_usec = duration_seconds * USEC_PER_SEC;
+	long usage_usec, n_periods, remainder_usec, expected_usage_usec;
 	char *parent, *child;
+	char quota_buf[32];
+
+	snprintf(quota_buf, sizeof(quota_buf), "%ld", quota_usec);
 
 	parent = cg_name(root, "cpucg_parent");
 	child = cg_name(parent, "cpucg_child");
@@ -717,13 +735,13 @@ static int test_cpucg_max_nested(const char *root)
 	if (cg_create(child))
 		goto cleanup;
 
-	if (cg_write(parent, "cpu.max", "1000"))
+	if (cg_write(parent, "cpu.max", quota_buf))
 		goto cleanup;
 
 	struct cpu_hog_func_param param = {
 		.nprocs = 1,
 		.ts = {
-			.tv_sec = usage_seconds,
+			.tv_sec = duration_seconds,
 			.tv_nsec = 0,
 		},
 		.clock_type = CPU_HOG_CLOCK_WALL,
@@ -732,14 +750,19 @@ static int test_cpucg_max_nested(const char *root)
 		goto cleanup;
 
 	usage_usec = cg_read_key_long(child, "cpu.stat", "usage_usec");
-	user_usec = cg_read_key_long(child, "cpu.stat", "user_usec");
-	if (user_usec <= 0)
+	if (usage_usec <= 0)
 		goto cleanup;
 
-	if (user_usec >= expected_usage_usec)
-		goto cleanup;
+	/*
+	 * The following calculation applies only since
+	 * the cpu hog is set to run as per wall-clock time
+	 */
+	n_periods = duration_usec / default_period_usec;
+	remainder_usec = duration_usec - n_periods * default_period_usec;
+	expected_usage_usec
+		= n_periods * quota_usec + MIN(remainder_usec, quota_usec);
 
-	if (values_close(usage_usec, expected_usage_usec, 95))
+	if (!values_close(usage_usec, expected_usage_usec, 10))
 		goto cleanup;
 
 	ret = KSFT_PASS;
-- 
2.43.0


