Return-Path: <linux-kselftest+bounces-2047-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A0E814B3A
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 16:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2BB4288A2B
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 15:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C30358B3;
	Fri, 15 Dec 2023 15:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D1z5LzIG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119803DB88;
	Fri, 15 Dec 2023 15:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702652859; x=1734188859;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aQ7Uzjld6F7vOGPv885RCteUq5DHQavMT2G0u/Do9Zc=;
  b=D1z5LzIGLISZpCiON+KQ1vC6c+HXhcD3gssnPiuMh3o5iBjBbGUbj9ll
   RaoGBRnaaLVTMhVgjjrvQMer/8P9Okc9eTtwn5xblIdGc2Irx8VdTzqcR
   z40N4u1wobbTYcFq27dQYxga1AMvGzFbs6kmIKEXF1KgB+Z2VxYGMleI6
   nes2DHXLXgIWFmex6Hxi0Npx3Qa4Cz7PolskLVDsIcluSqnKDy04M08J5
   HlVRSmcbiZ8mSbeK3a0V0W1+C8xXXOphL2AN+Q/RycaLrSQRoOkh9EKVc
   F9yHkOb1lSz+QbXCgvQUFh6hPUrm6kKWdixKy1uXukC6HBSK/uflsoHb4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="2453690"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="2453690"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:07:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="809001167"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="809001167"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.49.116])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:07:35 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 14/29] selftests/resctrl: Remove nested calls in perf event handling
Date: Fri, 15 Dec 2023 17:05:00 +0200
Message-Id: <20231215150515.36983-15-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231215150515.36983-1-ilpo.jarvinen@linux.intel.com>
References: <20231215150515.36983-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Perf event handling has functions that are the sole caller of another
perf event handling related function:
  - reset_enable_llc_perf() calls perf_event_open_llc_miss()
  - perf_event_measure() calls get_llc_perf()

Remove the extra layer of calls to make the code easier to follow by
moving the code into the calling function.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/resctrl/cache.c | 64 ++++++-------------------
 1 file changed, 14 insertions(+), 50 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 11d1a6ce14c2..4f846a2e5e26 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -29,24 +29,13 @@ static void initialize_perf_event_attr(void)
 	pea_llc_miss.disabled = 1;
 }
 
+/* Start counters to log values */
 static void ioctl_perf_event_ioc_reset_enable(void)
 {
 	ioctl(fd_lm, PERF_EVENT_IOC_RESET, 0);
 	ioctl(fd_lm, PERF_EVENT_IOC_ENABLE, 0);
 }
 
-static int perf_event_open_llc_miss(pid_t pid, int cpu_no)
-{
-	fd_lm = perf_event_open(&pea_llc_miss, pid, cpu_no, -1,
-				PERF_FLAG_FD_CLOEXEC);
-	if (fd_lm == -1) {
-		ksft_perror("Error opening leader");
-		return -1;
-	}
-
-	return 0;
-}
-
 static void initialize_llc_perf(void)
 {
 	memset(&pea_llc_miss, 0, sizeof(struct perf_event_attr));
@@ -62,42 +51,13 @@ static void initialize_llc_perf(void)
 
 static int reset_enable_llc_perf(pid_t pid, int cpu_no)
 {
-	int ret = 0;
-
-	ret = perf_event_open_llc_miss(pid, cpu_no);
-	if (ret < 0)
-		return ret;
-
-	/* Start counters to log values */
-	ioctl_perf_event_ioc_reset_enable();
-
-	return 0;
-}
-
-/*
- * get_llc_perf:	llc cache miss through perf events
- * @llc_perf_miss:	LLC miss counter that is filled on success
- *
- * Perf events like HW_CACHE_MISSES could be used to validate number of
- * cache lines allocated.
- *
- * Return: =0 on success.  <0 on failure.
- */
-static int get_llc_perf(__u64 *llc_perf_miss)
-{
-	int ret;
-
-	/* Stop counters after one span to get miss rate */
-
-	ioctl(fd_lm, PERF_EVENT_IOC_DISABLE, 0);
-
-	ret = read(fd_lm, &rf_cqm, sizeof(struct read_format));
-	if (ret == -1) {
-		ksft_perror("Could not get llc misses through perf");
+	fd_lm = perf_event_open(&pea_llc_miss, pid, cpu_no, -1, PERF_FLAG_FD_CLOEXEC);
+	if (fd_lm == -1) {
+		ksft_perror("Error opening leader");
 		return -1;
 	}
 
-	*llc_perf_miss = rf_cqm.values[0].value;
+	ioctl_perf_event_ioc_reset_enable();
 
 	return 0;
 }
@@ -178,14 +138,18 @@ static int print_results_cache(const char *filename, int bm_pid, __u64 llc_value
  */
 static int perf_event_measure(const char *filename, int bm_pid)
 {
-	__u64 llc_perf_miss = 0;
 	int ret;
 
-	ret = get_llc_perf(&llc_perf_miss);
-	if (ret < 0)
-		return ret;
+	/* Stop counters after one span to get miss rate */
+	ioctl(fd_lm, PERF_EVENT_IOC_DISABLE, 0);
+
+	ret = read(fd_lm, &rf_cqm, sizeof(struct read_format));
+	if (ret == -1) {
+		ksft_perror("Could not get perf value");
+		return -1;
+	}
 
-	return print_results_cache(filename, bm_pid, llc_perf_miss);
+	return print_results_cache(filename, bm_pid, rf_cqm.values[0].value);
 }
 
 /*
-- 
2.30.2


