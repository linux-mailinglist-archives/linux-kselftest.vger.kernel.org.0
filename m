Return-Path: <linux-kselftest+bounces-36188-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E45B0AEFBDD
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 16:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 866384E1E50
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 14:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65D727816E;
	Tue,  1 Jul 2025 14:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="B07RFzmW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from jpms-ob01-os7.noc.sony.co.jp (jpms-ob01-os7.noc.sony.co.jp [211.125.139.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48623277C9F;
	Tue,  1 Jul 2025 14:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.139.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751379274; cv=none; b=YeZ2O/D2OmPzVFYRxdqVaUo/sgMautan6dba6Y0z/R0K2+C6BvBsV5PO4k45aUYQ9PCRZX6Ddnsv/vaYBmFZ15KTRqkO0uSBd046vmmWev4j8GZKuCWYZYznmJieTjJNjNlQqEv/4vthty07fL5e/DqKfAzqwJN5/vwUh3KDP8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751379274; c=relaxed/simple;
	bh=bXuJLPTLDbbHnYV4dbJjzAbMiGO8yl0jOjOXRDCZff0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RA2QcOwQB2ugsAoa6+LBJY2uGgPcgzy1+Jas2CC/LWYCUdXGKNPIqhh1Rbl7HF9KGbevz89D00ht/bqrykYBnhVqSd9O/C+x6wvGAqxQw+EckB8GJBR44PvwtOFYFbqH/jGf2WdOXk9zDmQQ8aShqUx2ngV8AexVFoQvjlPMPUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=fail smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=B07RFzmW; arc=none smtp.client-ip=211.125.139.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=sony.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1751379273; x=1782915273;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=qEn21RhlS91E/y3X/SxTP2la2eNKogK7MDafYiol9Kk=;
  b=B07RFzmW6f1dk0h7mjpCtx5il9z1cOv1EpN9g84tgrc+WjsT7bMstQZw
   Gj6aA8EUxZA/pqbqtAE6D82DaemhVvzI+4w7NDdMIbJLyVD/Q/LCa3Jr8
   e7HrIr10PQZurWfRS4BImTp6a8OYtu/qrdxinKbv23N3x/ws1446hbnj1
   mH+uobHlqlTc1ZZzWe+kiOb5+Q28cwE2Sh7rL+sgYxhU6Qm9vHlDqzqlf
   Chc7bpDOO3WJh4yZ+2dU2KrI/9YiKebI4rAZ/ogzjxVDB+inC/uTF6heq
   v6JXUEJlG4y3dpRG2kk11M/8vJzkVFswcy3UoqOuyFNlWANdN2g9GK7eB
   A==;
Received: from unknown (HELO jpmta-ob02-os7.noc.sony.co.jp) ([IPv6:2001:cf8:acf:1104::7])
  by jpms-ob01-os7.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 23:14:22 +0900
X-IronPort-AV: E=Sophos;i="6.16,279,1744038000"; 
   d="scan'208";a="3310508"
Received: from unknown (HELO [127.0.1.1]) ([IPv6:2001:cf8:1:573:0:dddd:eb3e:119e])
  by jpmta-ob02-os7.noc.sony.co.jp with ESMTP; 01 Jul 2025 23:14:22 +0900
From: Shashank Balaji <shashank.mahadasyam@sony.com>
Date: Tue, 01 Jul 2025 23:13:55 +0900
Subject: [PATCH 1/2] selftests/cgroup: rename `expected` to `duration` in
 cpu.max tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-kselftest-cgroup-fix-cpu-max-v1-1-049507ad6832@sony.com>
References: <20250701-kselftest-cgroup-fix-cpu-max-v1-0-049507ad6832@sony.com>
In-Reply-To: <20250701-kselftest-cgroup-fix-cpu-max-v1-0-049507ad6832@sony.com>
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Shinya Takumi <shinya.takumi@sony.com>, 
 Shashank Balaji <shashank.mahadasyam@sony.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3346;
 i=shashank.mahadasyam@sony.com; h=from:subject:message-id;
 bh=bXuJLPTLDbbHnYV4dbJjzAbMiGO8yl0jOjOXRDCZff0=;
 b=owGbwMvMwCV2mPH4Ij++H1mMp9WSGDKS39oya86oOMUa0vW2eIKzwfX6rTaPvX3kea6uF7/3T
 tj1klZ4RykLgxgXg6yYIss7mXUXDlpZNn09zvANZg4rE8gQBi5OAZhIw2SG/4kLRU9v4/x2dflk
 OfWXohssODYlr3/y+MeisBXMJ5PnXrzKyLB753vBaAVuxkunvyg3LTkaV16ct+Np9sWInkuzJ3J
 dO8YLAA==
X-Developer-Key: i=shashank.mahadasyam@sony.com; a=openpgp;
 fpr=EE1CAED0C13A3982F5C700F6C301C7A24E0EF86A

usage_seconds is renamed to duration_seconds and expected_usage_usec is
renamed to duration_usec to better reflect the meaning of those
variables: they're the duration for which the cpu hog runs for as per
wall clock time.

Using `usage` for this purpose conflicts with the meaning of `usage` as
per cpu.stat. In the cpu.stat case, `usage` is the duration for which
the cgroup processes get to run for. Since in the cpu.max tests (both the
normal one and the nested test), the cpu hog is set to use the wall
clock time, because of throttling, the usage as per cpu.stat will be
lower than the duration for which the cpu hog was set to run for.

Now it should ring an alarm to see `values_close` being called on
usage_usec and duration_usec, because they are not supposed to be close!
This is fixed in the next patch.

No functional changes.

Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>
---
 tools/testing/selftests/cgroup/test_cpu.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_cpu.c b/tools/testing/selftests/cgroup/test_cpu.c
index a2b50af8e9eeede0cf61d8394300cac02ccaf005..26b0df338505526cc0c5de8f4179b8ec9bad43d7 100644
--- a/tools/testing/selftests/cgroup/test_cpu.c
+++ b/tools/testing/selftests/cgroup/test_cpu.c
@@ -646,8 +646,8 @@ static int test_cpucg_max(const char *root)
 {
 	int ret = KSFT_FAIL;
 	long usage_usec, user_usec;
-	long usage_seconds = 1;
-	long expected_usage_usec = usage_seconds * USEC_PER_SEC;
+	long duration_seconds = 1;
+	long duration_usec = duration_seconds * USEC_PER_SEC;
 	char *cpucg;
 
 	cpucg = cg_name(root, "cpucg_test");
@@ -663,7 +663,7 @@ static int test_cpucg_max(const char *root)
 	struct cpu_hog_func_param param = {
 		.nprocs = 1,
 		.ts = {
-			.tv_sec = usage_seconds,
+			.tv_sec = duration_seconds,
 			.tv_nsec = 0,
 		},
 		.clock_type = CPU_HOG_CLOCK_WALL,
@@ -676,10 +676,10 @@ static int test_cpucg_max(const char *root)
 	if (user_usec <= 0)
 		goto cleanup;
 
-	if (user_usec >= expected_usage_usec)
+	if (user_usec >= duration_usec)
 		goto cleanup;
 
-	if (values_close(usage_usec, expected_usage_usec, 95))
+	if (values_close(usage_usec, duration_usec, 95))
 		goto cleanup;
 
 	ret = KSFT_PASS;
@@ -699,8 +699,8 @@ static int test_cpucg_max_nested(const char *root)
 {
 	int ret = KSFT_FAIL;
 	long usage_usec, user_usec;
-	long usage_seconds = 1;
-	long expected_usage_usec = usage_seconds * USEC_PER_SEC;
+	long duration_seconds = 1;
+	long duration_usec = duration_seconds * USEC_PER_SEC;
 	char *parent, *child;
 
 	parent = cg_name(root, "cpucg_parent");
@@ -723,7 +723,7 @@ static int test_cpucg_max_nested(const char *root)
 	struct cpu_hog_func_param param = {
 		.nprocs = 1,
 		.ts = {
-			.tv_sec = usage_seconds,
+			.tv_sec = duration_seconds,
 			.tv_nsec = 0,
 		},
 		.clock_type = CPU_HOG_CLOCK_WALL,
@@ -736,10 +736,10 @@ static int test_cpucg_max_nested(const char *root)
 	if (user_usec <= 0)
 		goto cleanup;
 
-	if (user_usec >= expected_usage_usec)
+	if (user_usec >= duration_usec)
 		goto cleanup;
 
-	if (values_close(usage_usec, expected_usage_usec, 95))
+	if (values_close(usage_usec, duration_usec, 95))
 		goto cleanup;
 
 	ret = KSFT_PASS;

-- 
2.43.0


