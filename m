Return-Path: <linux-kselftest+bounces-11005-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E811D8D6290
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 15:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 141061C25537
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 13:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C87158A2E;
	Fri, 31 May 2024 13:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="APaK9CVO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4EC158A26;
	Fri, 31 May 2024 13:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717161162; cv=none; b=pFtvCJCtqolz12YZu/ZUCT2U33QrIbFKKPdaUBFo6io2NhpVGaQDDKh/cVme5qV/nx6bGNu9XBaARFOrQn4qVIKrQn57au3mXaWQRJx1s0ltEUs1ZIQgp9b/sEpvIXKO9J5K8ni8HXK0gBHJeT1fFlGPReH3FhzIuhAq56OVO0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717161162; c=relaxed/simple;
	bh=LmE4FlciLL+cu5fhNjsY1HfGtrfdQq1IaG3rCXtdeTE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h82MvzI49OXCI99Xp1NzuyFARN2zcNRLMSngKliLs0mYP+x3u0DTfh7BYx+64eeNEstYuUn13WenNprXoNmn01OfSWoA76CG4W8I5tF5LfipS7s4uMbLqvCy3stT3Ars/wPljQiQ8RQAOx9AkWg8wquHa9iL8l7d0Hq13RszmMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=APaK9CVO; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717161161; x=1748697161;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LmE4FlciLL+cu5fhNjsY1HfGtrfdQq1IaG3rCXtdeTE=;
  b=APaK9CVOly4kp6x66hL1TQpLKZAL0EHwT8zDMNXAQisujVIV5NBzPwD3
   x/5AbEU3tHHaFgfDejElSzA3vphJ/qXncjBrh0xGJhS0N/7k7h/50eiRv
   XXiilIDxntH9HV/mW2TBODFtVysr7XCNWqyANDJ9i7Ge/rR+bagsJC9yp
   0QVUMA+HdYdTn4f0EqjBJacCc9WiECaEOq8He41KGqVF9L2eY4froqxFr
   zERgLlA9ZK34WwEPtea8GMIoXLc9of+s3zk8Y5SIUYezhR2dqI+G23vkh
   XTcDz/33xjGdl3etu9FAueTSN0j+W5I433ElyKuYfVmFxQqZ+vZYGTycS
   A==;
X-CSE-ConnectionGUID: azLxBRKqTIOCUkH6rj23FQ==
X-CSE-MsgGUID: MFW1aUh8RkaS/oI6+Sl10g==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="17532563"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="17532563"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 06:12:40 -0700
X-CSE-ConnectionGUID: K4yOc981RrWEMy0toPsoQw==
X-CSE-MsgGUID: l5fNEYQVQFSYLaVZ/ax+xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="36106903"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.152])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 06:12:36 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
Cc: linux-kernel@vger.kernel.org,
	Fenghua Yu <fenghua.yu@intel.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v5 05/16] selftests/resctrl: Use correct type for pids
Date: Fri, 31 May 2024 16:11:31 +0300
Message-Id: <20240531131142.1716-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240531131142.1716-1-ilpo.jarvinen@linux.intel.com>
References: <20240531131142.1716-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A few functions receive PIDs through int arguments. PIDs variables
should be of type pid_t, not int.

Convert pid arguments from int to pid_t.

Before printing PID, match the type to %d by casting to int which is
enough for Linux (standard would allow using a longer integer type but
generalizing for that would complicate the code unnecessarily, the
selftest code does not need to be portable).

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

v5:
- Cast to int before printing to match with %d.
---
 tools/testing/selftests/resctrl/cache.c       | 10 +++++-----
 tools/testing/selftests/resctrl/resctrl.h     |  4 ++--
 tools/testing/selftests/resctrl/resctrl_val.c |  8 ++++----
 tools/testing/selftests/resctrl/resctrlfs.c   |  2 +-
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 1b339d6bbff1..1ff1104e6575 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -101,12 +101,12 @@ static int get_llc_occu_resctrl(unsigned long *llc_occupancy)
  *
  * Return:		0 on success, < 0 on error.
  */
-static int print_results_cache(const char *filename, int bm_pid, __u64 llc_value)
+static int print_results_cache(const char *filename, pid_t bm_pid, __u64 llc_value)
 {
 	FILE *fp;
 
 	if (strcmp(filename, "stdio") == 0 || strcmp(filename, "stderr") == 0) {
-		printf("Pid: %d \t LLC_value: %llu\n", bm_pid, llc_value);
+		printf("Pid: %d \t LLC_value: %llu\n", (int)bm_pid, llc_value);
 	} else {
 		fp = fopen(filename, "a");
 		if (!fp) {
@@ -114,7 +114,7 @@ static int print_results_cache(const char *filename, int bm_pid, __u64 llc_value
 
 			return -1;
 		}
-		fprintf(fp, "Pid: %d \t llc_value: %llu\n", bm_pid, llc_value);
+		fprintf(fp, "Pid: %d \t llc_value: %llu\n", (int)bm_pid, llc_value);
 		fclose(fp);
 	}
 
@@ -133,7 +133,7 @@ static int print_results_cache(const char *filename, int bm_pid, __u64 llc_value
  * Return: =0 on success. <0 on failure.
  */
 int perf_event_measure(int pe_fd, struct perf_event_read *pe_read,
-		       const char *filename, int bm_pid)
+		       const char *filename, pid_t bm_pid)
 {
 	int ret;
 
@@ -161,7 +161,7 @@ int perf_event_measure(int pe_fd, struct perf_event_read *pe_read,
  *
  * Return: =0 on success. <0 on failure.
  */
-int measure_llc_resctrl(const char *filename, int bm_pid)
+int measure_llc_resctrl(const char *filename, pid_t bm_pid)
 {
 	unsigned long llc_occu_resc = 0;
 	int ret;
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 00d51fa7531c..e6f221236c79 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -174,8 +174,8 @@ void perf_event_initialize_read_format(struct perf_event_read *pe_read);
 int perf_open(struct perf_event_attr *pea, pid_t pid, int cpu_no);
 int perf_event_reset_enable(int pe_fd);
 int perf_event_measure(int pe_fd, struct perf_event_read *pe_read,
-		       const char *filename, int bm_pid);
-int measure_llc_resctrl(const char *filename, int bm_pid);
+		       const char *filename, pid_t bm_pid);
+int measure_llc_resctrl(const char *filename, pid_t bm_pid);
 void show_cache_info(int no_of_bits, __u64 avg_llc_val, size_t cache_span, bool lines);
 
 /*
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index e1ae59063c51..d6f6db77d480 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -572,14 +572,14 @@ void signal_handler_unregister(void)
  *
  * Return:		0 on success, < 0 on error.
  */
-static int print_results_bw(char *filename,  int bm_pid, float bw_imc,
+static int print_results_bw(char *filename, pid_t bm_pid, float bw_imc,
 			    unsigned long bw_resc)
 {
 	unsigned long diff = fabs(bw_imc - bw_resc);
 	FILE *fp;
 
 	if (strcmp(filename, "stdio") == 0 || strcmp(filename, "stderr") == 0) {
-		printf("Pid: %d \t Mem_BW_iMC: %f \t ", bm_pid, bw_imc);
+		printf("Pid: %d \t Mem_BW_iMC: %f \t ", (int)bm_pid, bw_imc);
 		printf("Mem_BW_resc: %lu \t Difference: %lu\n", bw_resc, diff);
 	} else {
 		fp = fopen(filename, "a");
@@ -589,7 +589,7 @@ static int print_results_bw(char *filename,  int bm_pid, float bw_imc,
 			return -1;
 		}
 		if (fprintf(fp, "Pid: %d \t Mem_BW_iMC: %f \t Mem_BW_resc: %lu \t Difference: %lu\n",
-			    bm_pid, bw_imc, bw_resc, diff) <= 0) {
+			    (int)bm_pid, bw_imc, bw_resc, diff) <= 0) {
 			ksft_print_msg("Could not log results\n");
 			fclose(fp);
 
@@ -832,7 +832,7 @@ int resctrl_val(const struct resctrl_test *test,
 		PARENT_EXIT();
 	}
 
-	ksft_print_msg("Benchmark PID: %d\n", bm_pid);
+	ksft_print_msg("Benchmark PID: %d\n", (int)bm_pid);
 
 	/*
 	 * The cast removes constness but nothing mutates benchmark_cmd within
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 9b86f826a40c..917d677adbba 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -508,7 +508,7 @@ static int write_pid_to_tasks(char *tasks, pid_t pid)
 
 		return -1;
 	}
-	if (fprintf(fp, "%d\n", pid) < 0) {
+	if (fprintf(fp, "%d\n", (int)pid) < 0) {
 		ksft_print_msg("Failed to write pid to tasks file\n");
 		fclose(fp);
 
-- 
2.39.2


