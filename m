Return-Path: <linux-kselftest+bounces-36189-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 620B6AEFBF8
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 16:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 492C3481C0D
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 14:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E51D27933C;
	Tue,  1 Jul 2025 14:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="amqFuhsp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from jpms-ob01-os7.noc.sony.co.jp (jpms-ob01-os7.noc.sony.co.jp [211.125.139.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689ED278143;
	Tue,  1 Jul 2025 14:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.139.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751379276; cv=none; b=OgSJdDWYe02vxt1KXvfbYoVJeaWjZKayN4+9hnStCfbmUwRJaGu2S6SVKd/qI5S0VALGf3mUfgpVWRC91Kfu2HTrp5c/otOHSqpZ+avY29V6FRyfCNnK/T+YD+4un4d56Mr8LOXj9+s0ho7j9Pvyv4OBnpOO919M6ddLp688Pdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751379276; c=relaxed/simple;
	bh=kqFaZwOq1c8NL2QVuZAFmyI28sb7OjXf6Gf6ByZX1qQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nPOFZbznXpmjp++D3Cn4I/+j6eZsTPApcuW8Qk8YR9s0v0CVyh626sKB0dBGFoywxeK2RBqJH2tYm+D6sVweYC6dIhnpvJR+3pULqJTYkG86WP7PF7V1Iz3M6Ap5xigfue3JgKi+hwHB+G8TEnSU5IIfz8AOjiel0xYz2a7hkgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=fail smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=amqFuhsp; arc=none smtp.client-ip=211.125.139.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=sony.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1751379274; x=1782915274;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=nojilaL/3AL8ig7k4WoYT/DekocQo+4nJIJWkp0Ipms=;
  b=amqFuhspwB1LjlKe99tYBMG1HvYWQI8N7AGYGQQ7GEuJ34DrfVJWUDEP
   T67RcViimZ6TzJmvvW0dQi92wDe+r0LNFvBl+uItLjG4ZC32oSC/jtuFr
   snmSHIQKzYYW6YiVxr8uDpnNfhgLtekYuGkpuidGan5ww1qOUnCSxTWxc
   jBnmn6TSCggWEYxBNey4B6DjHmOc4saTwKb9FTJebIkC5kcEnTGxuukA+
   1eF/TFdSEA63ryQl74+FAhtrKf0Rs+DjrAIqksYGafstoK0XV2GOw3GkV
   E9gQ0iCFSz0diXRajjqEsANj30Gdof+ziDphphV5bxIMOQv22C7jeFUfH
   g==;
Received: from unknown (HELO jpmta-ob02-os7.noc.sony.co.jp) ([IPv6:2001:cf8:acf:1104::7])
  by jpms-ob01-os7.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 23:14:23 +0900
X-IronPort-AV: E=Sophos;i="6.16,279,1744038000"; 
   d="scan'208";a="3310512"
Received: from unknown (HELO [127.0.1.1]) ([IPv6:2001:cf8:1:573:0:dddd:eb3e:119e])
  by jpmta-ob02-os7.noc.sony.co.jp with ESMTP; 01 Jul 2025 23:14:22 +0900
From: Shashank Balaji <shashank.mahadasyam@sony.com>
Date: Tue, 01 Jul 2025 23:13:56 +0900
Subject: [PATCH 2/2] selftests/cgroup: better bound in cpu.max tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-kselftest-cgroup-fix-cpu-max-v1-2-049507ad6832@sony.com>
References: <20250701-kselftest-cgroup-fix-cpu-max-v1-0-049507ad6832@sony.com>
In-Reply-To: <20250701-kselftest-cgroup-fix-cpu-max-v1-0-049507ad6832@sony.com>
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Shinya Takumi <shinya.takumi@sony.com>, 
 Shashank Balaji <shashank.mahadasyam@sony.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4932;
 i=shashank.mahadasyam@sony.com; h=from:subject:message-id;
 bh=kqFaZwOq1c8NL2QVuZAFmyI28sb7OjXf6Gf6ByZX1qQ=;
 b=owGbwMvMwCV2mPH4Ij++H1mMp9WSGDKS39rm/eM+dGCb1oy0Wt3z16LPa9xtbRYvTMq92z8nK
 c+fafnfjlIWBjEuBlkxRZZ3MusuHLSybPp6nOEbzBxWJpAhDFycAjCRJTMY/heKf+6L4P4ewbzp
 Jd8Ph21cn9V1BGw0AnRdWZZYp92tWcLIMMP+8Y8fRVkPjs1acFjbwz/yp1LHHd2XJyILLrsvmLL
 ZhgEA
X-Developer-Key: i=shashank.mahadasyam@sony.com; a=openpgp;
 fpr=EE1CAED0C13A3982F5C700F6C301C7A24E0EF86A

The cpu.max test (both the normal one and the nested one) setup cpu.max
with 1000 us runtime and the default period (100,000 us). A cpu hog is
run for a duration of 1s as per wall clock time. This corresponds to 10
periods, hence an expected usage of 10,000 us. We want the measured
usage (as per cpu.stat) to be close to 10,000 us. Enforce this bound correctly.

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

To address these issues, the condition is changed to `labs(usage_usec -
expected_usage_usec) < 2000` meaning pass. Now the meaning is much
clearer. `labs` is used instead of `values_close` because we don't
expect the error in usage_usec compared to expected_usage_usec to scale
with either of the terms. The error is because of the cpu hog process
running for slightly longer than the duration. So, using a proportional
error estimate, such as `values_close`, does not make sense. The maximum
tolerable error is set to 2000 us because on running this test 10 times,
the maximum `usage_usec` observed was 11,513 us, which corresponds to an
error of 1513 us.

user_usec is removed because it will always be less than usage_usec.
usage_usec is what really represents the throttling.

Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>
---
 tools/testing/selftests/cgroup/test_cpu.c | 34 ++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_cpu.c b/tools/testing/selftests/cgroup/test_cpu.c
index 26b0df338505526cc0c5de8f4179b8ec9bad43d7..fcef90d2948e1344b7741214a0cdd10609069624 100644
--- a/tools/testing/selftests/cgroup/test_cpu.c
+++ b/tools/testing/selftests/cgroup/test_cpu.c
@@ -645,9 +645,8 @@ test_cpucg_nested_weight_underprovisioned(const char *root)
 static int test_cpucg_max(const char *root)
 {
 	int ret = KSFT_FAIL;
-	long usage_usec, user_usec;
+	long usage_usec, expected_usage_usec;
 	long duration_seconds = 1;
-	long duration_usec = duration_seconds * USEC_PER_SEC;
 	char *cpucg;
 
 	cpucg = cg_name(root, "cpucg_test");
@@ -672,14 +671,18 @@ static int test_cpucg_max(const char *root)
 		goto cleanup;
 
 	usage_usec = cg_read_key_long(cpucg, "cpu.stat", "usage_usec");
-	user_usec = cg_read_key_long(cpucg, "cpu.stat", "user_usec");
-	if (user_usec <= 0)
+	if (usage_usec <= 0)
 		goto cleanup;
 
-	if (user_usec >= duration_usec)
-		goto cleanup;
+	/*
+	 * Since the cpu hog is set to run as per wall clock time, it's expected to
+	 * run for 10 periods (duration_usec/default_period_usec), and in each
+	 * period, it's throttled to run for 1000 usec. So its expected usage is
+	 * 1000 * 10 = 10000 usec.
+	 */
+	expected_usage_usec = 10000;
 
-	if (values_close(usage_usec, duration_usec, 95))
+	if (labs(usage_usec - expected_usage_usec) > 2000)
 		goto cleanup;
 
 	ret = KSFT_PASS;
@@ -698,9 +701,8 @@ static int test_cpucg_max(const char *root)
 static int test_cpucg_max_nested(const char *root)
 {
 	int ret = KSFT_FAIL;
-	long usage_usec, user_usec;
+	long usage_usec, expected_usage_usec;
 	long duration_seconds = 1;
-	long duration_usec = duration_seconds * USEC_PER_SEC;
 	char *parent, *child;
 
 	parent = cg_name(root, "cpucg_parent");
@@ -732,14 +734,18 @@ static int test_cpucg_max_nested(const char *root)
 		goto cleanup;
 
 	usage_usec = cg_read_key_long(child, "cpu.stat", "usage_usec");
-	user_usec = cg_read_key_long(child, "cpu.stat", "user_usec");
-	if (user_usec <= 0)
+	if (usage_usec <= 0)
 		goto cleanup;
 
-	if (user_usec >= duration_usec)
-		goto cleanup;
+	/*
+	 * Since the cpu hog is set to run as per wall clock time, it's expected to
+	 * run for 10 periods (duration_usec/default_period_usec), and in each
+	 * period, it's throttled to run for 1000 usec. So its expected usage is
+	 * 1000 * 10 = 10000 usec.
+	 */
+	expected_usage_usec = 10000;
 
-	if (values_close(usage_usec, duration_usec, 95))
+	if (labs(usage_usec - expected_usage_usec) > 2000)
 		goto cleanup;
 
 	ret = KSFT_PASS;

-- 
2.43.0


