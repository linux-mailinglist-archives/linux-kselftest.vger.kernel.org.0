Return-Path: <linux-kselftest+bounces-6106-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D5E876543
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 14:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD64E286A1E
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 13:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D279E40862;
	Fri,  8 Mar 2024 13:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W7YCD8aV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEC03BBCE;
	Fri,  8 Mar 2024 13:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709904319; cv=none; b=lo2gjW7wU1nOvMvXvVG9XsERBB+7NYUxOKGJXIjINPFNAmEPMbHXRcMnPWM91lqbm+PZEKzjnwjZrqbt79Lq4NTkElE+IPtPMt+0NKePq2RYCxNGNHkjGDDS2zdOx3OfOKo3gNwuLLA7ByC5pophS7MhZQQSxWd6K9++3ZqyMXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709904319; c=relaxed/simple;
	bh=Io7HkA6I9G5lj7F8YQ35r2XQOKOHfRyRrh0aXKyvt4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qo+ghpLvDbQ5EsthRJP+FBpna7hiDQkvoj3x2iTrut8xBLCDp5mRrT4MIYZnRsJCDPKDVLl4Pk8tJTLpmzN1Vqas+ylyeRAs5dJgPZ7awOlCzhLb8aLlwBkJcx5ozIJ+CrbEMyB8NTo3piZ2BuNPINVvJ9f6QhfLhUweWV16QWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W7YCD8aV; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709904318; x=1741440318;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Io7HkA6I9G5lj7F8YQ35r2XQOKOHfRyRrh0aXKyvt4c=;
  b=W7YCD8aVdnbsID+ZCfjT2RQaxa9os+4Uffi+pVZzrH3M1gWSynCybG5B
   1sfHmVjhj8rRnKztSdNDlPm6T86vCYp8HFCs0Myk2PfO9MMVS7R4SvJUe
   j9HtxKvYdIBaW93asd0F5J3MQfD2l8akTNX0CvPi4nUiu0+GJisQ3MuFp
   F0x6tQlUVP6uZjvaCvaSi4JkJbuUQ+kgdshMoGaRlBuYlO57YNDKalYzX
   4T9wBqYsIo5DOFOy/5n/9D0w1ub65KzAJiNFTuKDpphCp/lU1pAqJ2Xxg
   ZbLWTP35BR7VmleL21GTZv6PNU8+hfP1lBwqtfbYYKAi6xo6DIWQ7xMzB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="8375271"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="8375271"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:25:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="41394749"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.186])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:25:14 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 13/13] selftests/resctrl: Remove test name comparing from write_bm_pid_to_resctrl()
Date: Fri,  8 Mar 2024 15:22:55 +0200
Message-Id: <20240308132255.14442-14-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240308132255.14442-1-ilpo.jarvinen@linux.intel.com>
References: <20240308132255.14442-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

write_bm_pid_to_resctrl() uses resctrl_val to check test name which is
not a good interface generic resctrl FS functions should provide.

Only MBM and CMT tests define mongrp so the test name check in
write_bm_pid_to_resctrl() can be changed to depend simply on mongrp
being non-NULL.

With last user of resctrl_val gone, the parameter and member from the
struct resctrl_val_param can removed. Test name constants can also be
removed because they are not used anymore.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cat_test.c    |  5 +--
 tools/testing/selftests/resctrl/cmt_test.c    |  1 -
 tools/testing/selftests/resctrl/mba_test.c    |  1 -
 tools/testing/selftests/resctrl/mbm_test.c    |  1 -
 tools/testing/selftests/resctrl/resctrl.h     | 10 +-----
 tools/testing/selftests/resctrl/resctrl_val.c |  4 +--
 tools/testing/selftests/resctrl/resctrlfs.c   | 33 ++++++++-----------
 7 files changed, 17 insertions(+), 38 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 24af8310288a..e35dffa28173 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -158,7 +158,6 @@ static int cat_test(const struct resctrl_test *test,
 		    struct resctrl_val_param *param,
 		    size_t span, unsigned long current_mask)
 {
-	char *resctrl_val = param->resctrl_val;
 	struct perf_event_read pe_read;
 	struct perf_event_attr pea;
 	cpu_set_t old_affinity;
@@ -178,8 +177,7 @@ static int cat_test(const struct resctrl_test *test,
 		return ret;
 
 	/* Write benchmark to specified con_mon grp, mon_grp in resctrl FS*/
-	ret = write_bm_pid_to_resctrl(bm_pid, param->ctrlgrp, param->mongrp,
-				      resctrl_val);
+	ret = write_bm_pid_to_resctrl(bm_pid, param->ctrlgrp, param->mongrp);
 	if (ret)
 		goto reset_affinity;
 
@@ -272,7 +270,6 @@ static int cat_run_test(const struct resctrl_test *test, const struct user_param
 	start_mask = create_bit_mask(start, n);
 
 	struct resctrl_val_param param = {
-		.resctrl_val	= CAT_STR,
 		.ctrlgrp	= "c1",
 		.filename	= RESULT_FILE_NAME,
 		.num_of_runs	= 0,
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index ae2775ace36e..2109d634d46e 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -144,7 +144,6 @@ static int cmt_run_test(const struct resctrl_test *test, const struct user_param
 	}
 
 	struct resctrl_val_param param = {
-		.resctrl_val	= CMT_STR,
 		.ctrlgrp	= "c1",
 		.mongrp		= "m1",
 		.filename	= RESULT_FILE_NAME,
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index ea024bf8088d..36b4f5303882 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -172,7 +172,6 @@ void mba_test_cleanup(void)
 static int mba_run_test(const struct resctrl_test *test, const struct user_params *uparams)
 {
 	struct resctrl_val_param param = {
-		.resctrl_val	= MBA_STR,
 		.ctrlgrp	= "c1",
 		.filename	= RESULT_FILE_NAME,
 		.init		= set_mba_path,
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 85740177da41..296b0ce6f0f5 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -140,7 +140,6 @@ void mbm_test_cleanup(void)
 static int mbm_run_test(const struct resctrl_test *test, const struct user_params *uparams)
 {
 	struct resctrl_val_param param = {
-		.resctrl_val	= MBM_STR,
 		.ctrlgrp	= "c1",
 		.mongrp		= "m1",
 		.filename	= RESULT_FILE_NAME,
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index f6a77139d1c0..a36182340fb8 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -76,7 +76,6 @@ struct resctrl_test {
 
 /*
  * resctrl_val_param:	resctrl test parameters
- * @resctrl_val:	Resctrl feature (Eg: mbm, mba.. etc)
  * @ctrlgrp:		Name of the control monitor group (con_mon grp)
  * @mongrp:		Name of the monitor group (mon grp)
  * @filename:		Name of file to which the o/p should be written
@@ -85,7 +84,6 @@ struct resctrl_test {
  * @measure:		Callback that performs the measurement (a single test)
  */
 struct resctrl_val_param {
-	char		*resctrl_val;
 	const char	*ctrlgrp;
 	const char	*mongrp;
 	char		filename[64];
@@ -108,11 +106,6 @@ struct perf_event_read {
 	} values[2];
 };
 
-#define MBM_STR			"mbm"
-#define MBA_STR			"mba"
-#define CMT_STR			"cmt"
-#define CAT_STR			"cat"
-
 /*
  * Memory location that consumes values compiler must not optimize away.
  * Volatile ensures writes to this location cannot be optimized away by
@@ -136,8 +129,7 @@ int taskset_benchmark(pid_t bm_pid, int cpu_no, cpu_set_t *old_affinity);
 int taskset_restore(pid_t bm_pid, cpu_set_t *old_affinity);
 int write_schemata(const char *ctrlgrp, char *schemata, int cpu_no,
 		   const char *resource);
-int write_bm_pid_to_resctrl(pid_t bm_pid, const char *ctrlgrp,
-			    const char *mongrp, const char *resctrl_val);
+int write_bm_pid_to_resctrl(pid_t bm_pid, const char *ctrlgrp, const char *mongrp);
 int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
 		    int group_fd, unsigned long flags);
 unsigned char *alloc_buffer(size_t buf_size, int memflush);
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 2f166a5c0c9b..f2101ee665ba 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -632,7 +632,6 @@ int resctrl_val(const struct resctrl_test *test,
 		const char * const *benchmark_cmd,
 		struct resctrl_val_param *param)
 {
-	char *resctrl_val = param->resctrl_val;
 	struct sigaction sigact;
 	int ret = 0, pipefd[2];
 	char pipe_message = 0;
@@ -723,8 +722,7 @@ int resctrl_val(const struct resctrl_test *test,
 		goto out;
 
 	/* Write benchmark to specified control&monitoring grp in resctrl FS */
-	ret = write_bm_pid_to_resctrl(bm_pid, param->ctrlgrp, param->mongrp,
-				      resctrl_val);
+	ret = write_bm_pid_to_resctrl(bm_pid, param->ctrlgrp, param->mongrp);
 	if (ret)
 		goto out;
 
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 597150e4056e..1d363bc8e6f1 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -488,7 +488,6 @@ static int write_pid_to_tasks(char *tasks, pid_t pid)
  * @bm_pid:		PID that should be written
  * @ctrlgrp:		Name of the control monitor group (con_mon grp)
  * @mongrp:		Name of the monitor group (mon grp)
- * @resctrl_val:	Resctrl feature (Eg: mbm, mba.. etc)
  *
  * If a con_mon grp is requested, create it and write pid to it, otherwise
  * write pid to root con_mon grp.
@@ -498,8 +497,7 @@ static int write_pid_to_tasks(char *tasks, pid_t pid)
  *
  * Return: 0 on success, < 0 on error.
  */
-int write_bm_pid_to_resctrl(pid_t bm_pid, const char *ctrlgrp,
-			    const char *mongrp, const char *resctrl_val)
+int write_bm_pid_to_resctrl(pid_t bm_pid, const char *ctrlgrp, const char *mongrp)
 {
 	char controlgroup[128], monitorgroup[512], monitorgroup_p[256];
 	char tasks[1024];
@@ -519,22 +517,19 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, const char *ctrlgrp,
 	if (ret)
 		goto out;
 
-	/* Create mon grp and write pid into it for "mbm" and "cmt" test */
-	if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)) ||
-	    !strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR))) {
-		if (mongrp) {
-			sprintf(monitorgroup_p, "%s/mon_groups", controlgroup);
-			sprintf(monitorgroup, "%s/%s", monitorgroup_p, mongrp);
-			ret = create_grp(mongrp, monitorgroup, monitorgroup_p);
-			if (ret)
-				goto out;
-
-			sprintf(tasks, "%s/mon_groups/%s/tasks",
-				controlgroup, mongrp);
-			ret = write_pid_to_tasks(tasks, bm_pid);
-			if (ret)
-				goto out;
-		}
+	/* Create monitor group and write pid into if it is used */
+	if (mongrp) {
+		sprintf(monitorgroup_p, "%s/mon_groups", controlgroup);
+		sprintf(monitorgroup, "%s/%s", monitorgroup_p, mongrp);
+		ret = create_grp(mongrp, monitorgroup, monitorgroup_p);
+		if (ret)
+			goto out;
+
+		sprintf(tasks, "%s/mon_groups/%s/tasks",
+			controlgroup, mongrp);
+		ret = write_pid_to_tasks(tasks, bm_pid);
+		if (ret)
+			goto out;
 	}
 
 out:
-- 
2.39.2


