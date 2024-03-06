Return-Path: <linux-kselftest+bounces-5993-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0085387347B
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 11:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24BC21C20A29
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 10:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429FF60887;
	Wed,  6 Mar 2024 10:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VWpRpgmS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CBA605A6;
	Wed,  6 Mar 2024 10:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709721621; cv=none; b=HkMJT1agczzy5cu7xFcipostMxOyY+gO4MfKLnV57zFvPL//tfrSxl7nQLPMUAY+xItogWtYs+oABrQYA7Mf+SZOTlHc3T9OscOCOURBbDF/6j8hjKXfnBkfE2HXXvcNMlZewhw7kJ+w53ZTp0YyvJsdhC0C/bWKp6MX54Z4/rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709721621; c=relaxed/simple;
	bh=OeMpkQvXEIjf/HvoRVZNwJ8BVyXuhxxDqh/xCdOmCks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CE6WNKeVGGmLzwU/xEFrjyFYeX4W+5e0C4fuWNjQ/t3JhdmLsUNoDAhY29J7bWWMlTRF3q8SoQpnG5+QhRO/EdHqDL5ItCExENh5z0fzsdDk5oiBUvUeqp+gCn3ulIzb9Xio22U/pylicMxdpl2/ETI03GdymAHG/oEljuYFJGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VWpRpgmS; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709721618; x=1741257618;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OeMpkQvXEIjf/HvoRVZNwJ8BVyXuhxxDqh/xCdOmCks=;
  b=VWpRpgmSwCsfKxzK9+JJlndVFw7ZWwrnknaBdjAZAon1MbJ3G7HUwLnR
   NcU8BqwvbB6GrCM3tm4dzj8ksOp/YYpl/LxyrsHe5/FeARwoHqa9o/hta
   ubChqfN3/QjADAg6f6wdc0aGBylcEiAxK/GleWkSXRANJ5Pvx6/226V/d
   jHp2SBB+J7XHQhGP+sT1kNj5QKnsjXTThT/jKikgGIu2RlUJSKLN3j0Ey
   W8VKS0LB3AT+cRBYweeNJXyD+TU0auY2uasmn/g9mmUdEJMSFGVYNj8JC
   mGTIToDyeEc9BAJ8GvJlCinG6dytL7gvrHH8x/F5ooABqUguhKqiAFp1V
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4497573"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="4497573"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 02:39:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="9803718"
Received: from ksznyce-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.25.14])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 02:39:52 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>
Cc: ilpo.jarvinen@linux.intel.com,
	tony.luck@intel.com,
	"Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 2/4] selftests/resctrl: SNC support for CMT
Date: Wed,  6 Mar 2024 11:39:19 +0100
Message-ID: <75849cb145429798b21c23b6be4abd7ece9df57b.1709721159.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1709721159.git.maciej.wieczor-retman@intel.com>
References: <cover.1709721159.git.maciej.wieczor-retman@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cache Monitoring Technology (CMT) works by measuring how much data in L3
cache is occupied by a given process identified by its Resource
Monitoring ID (RMID).

On systems with Sub-Numa Clusters (SNC) enabled, a process can occupy
not only the cache that belongs to its own NUMA node but also pieces of
other NUMA nodes' caches that lie on the same socket.

A simple correction to make the CMT selftest NUMA-aware is to sum values
reported by all nodes on the same socket for a given RMID.

Reported-by: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
Closes: https://lore.kernel.org/all/TYAPR01MB6330B9B17686EF426D2C3F308B25A@TYAPR01MB6330.jpnprd01.prod.outlook.com/
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 tools/testing/selftests/resctrl/cache.c       | 17 +++++++++++------
 tools/testing/selftests/resctrl/resctrl.h     |  4 +++-
 tools/testing/selftests/resctrl/resctrl_val.c |  9 ++++++---
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 1b339d6bbff1..dab81920033b 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -161,16 +161,21 @@ int perf_event_measure(int pe_fd, struct perf_event_read *pe_read,
  *
  * Return: =0 on success. <0 on failure.
  */
-int measure_llc_resctrl(const char *filename, int bm_pid)
+int measure_llc_resctrl(const char *filename, int bm_pid, const char *ctrlgrp,
+			const char *mongrp, int res_id)
 {
-	unsigned long llc_occu_resc = 0;
+	unsigned long sum = 0, llc_occu_resc = 0;
 	int ret;
 
-	ret = get_llc_occu_resctrl(&llc_occu_resc);
-	if (ret < 0)
-		return ret;
+	for (int i = 0 ; i < snc_ways() ; i++) {
+		set_cmt_path(ctrlgrp, mongrp, res_id + i);
+		ret = get_llc_occu_resctrl(&llc_occu_resc);
+		if (ret < 0)
+			return ret;
+		sum += llc_occu_resc;
+	}
 
-	return print_results_cache(filename, bm_pid, llc_occu_resc);
+	return print_results_cache(filename, bm_pid, sum);
 }
 
 /*
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 41811e87f81c..178fb2eab13a 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -133,6 +133,7 @@ extern pid_t bm_pid, ppid;
 extern char llc_occup_path[1024];
 
 int snc_ways(void);
+void set_cmt_path(const char *ctrlgrp, const char *mongrp, char sock_num);
 int get_vendor(void);
 bool check_resctrlfs_support(void);
 int filter_dmesg(void);
@@ -182,7 +183,8 @@ int perf_open(struct perf_event_attr *pea, pid_t pid, int cpu_no);
 int perf_event_reset_enable(int pe_fd);
 int perf_event_measure(int pe_fd, struct perf_event_read *pe_read,
 		       const char *filename, int bm_pid);
-int measure_llc_resctrl(const char *filename, int bm_pid);
+int measure_llc_resctrl(const char *filename, int bm_pid, const char *ctrlgrp,
+			const char *mongrp, int res_id);
 void show_cache_info(int no_of_bits, __u64 avg_llc_val, size_t cache_span, bool lines);
 
 /*
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 5a49f07a6c85..e75e3923ebe2 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -557,7 +557,7 @@ static int print_results_bw(char *filename,  int bm_pid, float bw_imc,
 	return 0;
 }
 
-static void set_cmt_path(const char *ctrlgrp, const char *mongrp, char sock_num)
+void set_cmt_path(const char *ctrlgrp, const char *mongrp, char sock_num)
 {
 	if (strlen(ctrlgrp) && strlen(mongrp))
 		sprintf(llc_occup_path,	CON_MON_LCC_OCCUP_PATH,	RESCTRL_PATH,
@@ -698,8 +698,8 @@ int resctrl_val(const struct resctrl_test *test,
 {
 	char *resctrl_val = param->resctrl_val;
 	unsigned long bw_resc_start = 0;
+	int res_id, ret = 0, pipefd[2];
 	struct sigaction sigact;
-	int ret = 0, pipefd[2];
 	char pipe_message = 0;
 	union sigval value;
 
@@ -828,6 +828,8 @@ int resctrl_val(const struct resctrl_test *test,
 	sleep(1);
 
 	/* Test runs until the callback setup() tells the test to stop. */
+	get_domain_id("L3", uparams->cpu, &res_id);
+	res_id *= snc_ways();
 	while (1) {
 		ret = param->setup(test, uparams, param);
 		if (ret == END_OF_TESTS) {
@@ -844,7 +846,8 @@ int resctrl_val(const struct resctrl_test *test,
 				break;
 		} else if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR))) {
 			sleep(1);
-			ret = measure_llc_resctrl(param->filename, bm_pid);
+			ret = measure_llc_resctrl(param->filename, bm_pid, param->ctrlgrp,
+						  param->mongrp, res_id);
 			if (ret)
 				break;
 		}
-- 
2.44.0


