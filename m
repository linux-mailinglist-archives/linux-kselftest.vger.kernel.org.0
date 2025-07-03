Return-Path: <linux-kselftest+bounces-36421-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE51AF7339
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 14:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 300904A3920
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 12:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFFD2D2386;
	Thu,  3 Jul 2025 12:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="Le55KwYb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from jpms-ob02-os7.noc.sony.co.jp (jpms-ob02-os7.noc.sony.co.jp [211.125.139.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D95F253939;
	Thu,  3 Jul 2025 12:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.139.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751544365; cv=none; b=RqqV2AJ2PWBsbc28THLdIC1ID0ZJRCNMQj/UF3vNUiUGSdozwZ6qf8shQUTN43l31BPuGsqzBSc5LHFue1VYbag6s2ihbLQXl3x+OU60J8gr03QiQpFdAQUVql6QW0TxxMp0tFLlDILNRGwl0LXZO0U8e9iLkwbJA6t0SkkwcFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751544365; c=relaxed/simple;
	bh=raWexe22dvi7aq1OOnkH/6y7PUeW0mewCeOEWWp1QAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YEvxlOUqPDOJLrgSRq7zaboAvGPdHliqkLCAALkcFLniLNMVjrHVcOSD/zkXloY5BSqndpXQ25nM5nPexd+69KhyQOH4lWyOHQFjHpGdr0rcKExKm+BsjKcxtH7dasfAmYXohtVIkVg36BExFAwtduaMXpWmlg5wuDifk6hBCfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=fail smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=Le55KwYb; arc=none smtp.client-ip=211.125.139.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=sony.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1751544362; x=1783080362;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FA1lUYQuzgJrq3jDPYzI6xXt+JabSa+YCb1SBMISYiA=;
  b=Le55KwYbuM42u4rRTQM7tE+oz0LH42yGpGNTiPvWy7UzNgPERu0Yfk5p
   RufMtkPH1XYCFMXH3fhNdASr5aZylJ4yGUBC9f1/f5V0HNhDG0tiz3Hxw
   gGJskjafDwFJzHi3k4RcnqP/sJsJm+KPGwwYTt0hBcBir8AWdI49PJ6m0
   dbB5f2VHSn9MSLap+j5i9suX6LpXkTkFXdzr1Q5RJCI4K9dQJRtF7FdLv
   IwjHQ+m6JQKc5l+pbNU8swiYtRlh2kON2vek9PcBjom1JlCYyAAQqpDxU
   w1ETVzjhynekKGBxjQhHId5iRX6BWqS7iUWjhJAybzjuz75MX0fklyu/b
   A==;
Received: from unknown (HELO jpmta-ob02-os7.noc.sony.co.jp) ([IPv6:2001:cf8:acf:1104::7])
  by jpms-ob02-os7.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 21:05:59 +0900
X-IronPort-AV: E=Sophos;i="6.16,284,1744038000"; 
   d="scan'208";a="4257026"
Received: from unknown (HELO JPC00244420..) ([IPv6:2001:cf8:1:573:0:dddd:eb3e:119e])
  by jpmta-ob02-os7.noc.sony.co.jp with ESMTP; 03 Jul 2025 21:05:59 +0900
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
Subject: [PATCH v2] selftests/cgroup: improve the accuracy of cpu.max tests
Date: Thu,  3 Jul 2025 21:03:20 +0900
Message-ID: <20250703120325.2905314-1-shashank.mahadasyam@sony.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701-kselftest-cgroup-fix-cpu-max-v1-0-049507ad6832@sony.com>
References: <20250701-kselftest-cgroup-fix-cpu-max-v1-0-049507ad6832@sony.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current cpu.max tests (both the normal one and the nested one) are inaccurate.

They setup cpu.max with 1000 us quota and the default period (100,000 us).
A cpu hog is run for a duration of 1s as per wall clock time. This corresponds
to 10 periods, hence an expected usage of 10,000 us. We want the measured
usage (as per cpu.stat) to be close to 10,000 us.

Previously, this approximate equality test was done by
`!values_close(usage_usec, duration_usec, 95)`: if the absolute
difference between usage_usec and duration_usec is greater than 95% of
their sum, then we pass. This is problematic for two reasons:

1. Semantics: When one sees `values_close` they expect the error
   percentage to be some small number, not 95. The intent behind using
`values_close` is lost by using a high error percent such as 95. The
intent it's actually going for is "values far".

2. Bound too wide: The condition translates to the following expression:

	|usage_usec - duration_usec| > (usage_usec + duration_usec)*0.95

  	0.05*duration_usec > 1.95*usage_usec (usage < duration)

	usage_usec < 0.0257*duration_usec = 25,641 us

   So, this condition passes as long as usage_usec is lower than 25,641
us, while all we want is for it to be close to 10,000 us.

Fix this by explicitly calcuating the expected usage duration based on the
configured quota, default period, and the duration, and compare usage_usec
and expected_usage_usec using values_close() with a 10% error margin.

Also, use snprintf to get the quota string to write to cpu.max instead of
hardcoding the quota, ensuring a single source of truth.

Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>

---

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


