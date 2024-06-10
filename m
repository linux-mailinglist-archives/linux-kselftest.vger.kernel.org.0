Return-Path: <linux-kselftest+bounces-11562-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE1E90253E
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 17:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44E1428273C
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 15:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85ED13DB9B;
	Mon, 10 Jun 2024 15:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M3CxDOK0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D68A81754;
	Mon, 10 Jun 2024 15:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718032561; cv=none; b=u7uHCNYkX1ozX95EUJEZ0tlg0ILn8HUl3cWDGq+nrnV6PVdqSac9gMdWlwV+AXLw1Vp5EiYwpETTsjTcLGKpbvJNzgxJjMfxoXYpSf40V2rRHXHW949MxnQ+YN/GvNjh25EKji3X7BTSSJfcANhQ8T8M+ilP1xXsVtCwIojft00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718032561; c=relaxed/simple;
	bh=J8MXk2+opYTa7xZQ/Gh3p+vp6i8luDzj3u3KMCcjByM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kJQ7em0E9is4PR7upoJWOChgXnEXd/8L4Oy6JO2IZeGz20UVYrjFXAFCil0Za1LSOSVZpRQi/+TEdemDZt7GNS7gw2tLCFaO2YW0zqp0j8zHk8ARvemCnKWGO4MYb0ZJdTd9PnRt+qnojZnUHUfRxPN6NmXnG2izo71FZwdxfhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M3CxDOK0; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718032560; x=1749568560;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J8MXk2+opYTa7xZQ/Gh3p+vp6i8luDzj3u3KMCcjByM=;
  b=M3CxDOK0ss7EAJuV9BL7cYnYiyZCFixr2FFgepsRQSRtNviP40f0TaCp
   cc7b/KNlsoCxBA48MMpGXFGtumlB4IYC3wKP4FAPbfTEbKARG44QP+9mT
   LoJ9h4wVkwmB/Kv4LWSieXQdjLdp9/SsUfJGPqxQJEZZnbaOTk5YoyMJB
   sVAqWtKWX2mC480jHiosVgDUskbzH8FhZWJbL39itBIOM6mv/WViGWY06
   5DPURsgkh5LSPRUiWKtrR+mt2Fg+B05G9uraaNRJ/g/4Q4pn1c7tprJd6
   rc9+jObwTINQv8qwx+kTt5Dpz1a4KfZTKmBmariS8ErSpl/aebSeGAzy4
   g==;
X-CSE-ConnectionGUID: 92IfzP8bSmmx4sUr1neZRw==
X-CSE-MsgGUID: ovGRmyjAQj6+n0/lq9si4A==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="18530836"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="18530836"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 08:16:00 -0700
X-CSE-ConnectionGUID: HoBNmIP0SxijAJWn9TI8rg==
X-CSE-MsgGUID: vK+sG1WuQImm4pGnpP4DcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="39650727"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.194])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 08:15:49 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v7 05/16] selftests/resctrl: Use correct type for pids
Date: Mon, 10 Jun 2024 18:14:46 +0300
Message-Id: <20240610151457.7305-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240610151457.7305-1-ilpo.jarvinen@linux.intel.com>
References: <20240610151457.7305-1-ilpo.jarvinen@linux.intel.com>
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
Tested-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
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
index cccf6b80f3f3..5704fa3ba202 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -566,14 +566,14 @@ void signal_handler_unregister(void)
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
@@ -583,7 +583,7 @@ static int print_results_bw(char *filename,  int bm_pid, float bw_imc,
 			return -1;
 		}
 		if (fprintf(fp, "Pid: %d \t Mem_BW_iMC: %f \t Mem_BW_resc: %lu \t Difference: %lu\n",
-			    bm_pid, bw_imc, bw_resc, diff) <= 0) {
+			    (int)bm_pid, bw_imc, bw_resc, diff) <= 0) {
 			ksft_print_msg("Could not log results\n");
 			fclose(fp);
 
@@ -828,7 +828,7 @@ int resctrl_val(const struct resctrl_test *test,
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


