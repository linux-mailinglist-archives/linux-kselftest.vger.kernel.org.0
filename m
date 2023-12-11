Return-Path: <linux-kselftest+bounces-1540-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2054980C980
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 13:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8087BB20C52
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 12:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8195B3B1AB;
	Mon, 11 Dec 2023 12:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HtsK4smc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC29186;
	Mon, 11 Dec 2023 04:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702297248; x=1733833248;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aQ7Uzjld6F7vOGPv885RCteUq5DHQavMT2G0u/Do9Zc=;
  b=HtsK4smcewQL/IvFoFAlHJ9nl51+DrIqy5PJAzryRVZQJR3Eo8Ae1+n3
   THBsP8t8Vu1slA/oadw+r6xTWR6Rg2qFer4zfVS8tLDVp+vMCfACZWJbM
   /lnCe36oELlDe0NSrCaOGOz5pkS3MQOaRck9Ok7aiLh6E7Ho2JST9yhVK
   Sqa8c9QwwhzYlBp6UCpdQXziMO5Ykp+55VNJ2n3ubI2sm9RCU/YIhw6jB
   kK35n3xyZJZqs83lvk8dIss3mFGZxAtUoWfaknF1c+JfluWoO9N+9EZ1L
   dMKJIbQ6ciwfjRuJMPdqcv6RzB9jqWcyaY5EpRauB2OKb4uSrpvNuiOYa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="1758033"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="1758033"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 04:20:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="1104461401"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="1104461401"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.50.188])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 04:20:43 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 14/29] selftests/resctrl: Remove nested calls in perf event handling
Date: Mon, 11 Dec 2023 14:18:11 +0200
Message-Id: <20231211121826.14392-15-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231211121826.14392-1-ilpo.jarvinen@linux.intel.com>
References: <20231211121826.14392-1-ilpo.jarvinen@linux.intel.com>
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


