Return-Path: <linux-kselftest+bounces-7427-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B303589C9C5
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 18:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D99F5B223EA
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 16:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6800514388A;
	Mon,  8 Apr 2024 16:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P7nkEvgr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82163143C56;
	Mon,  8 Apr 2024 16:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712594132; cv=none; b=e+GoFfIMRAbsiOl0Vyi+sT73HgYU8qwhJEGLDWRoAau8Hrwi2irmKlYQDY8AuXROWT+Aer0nYaNkaZU967vxIh/FM8JzBjageGheO0Pl1/e8t9pb6h9+0pjjQvPALZQzDhpS9p/tj+WMOzzgN69ZDeSkRSd+mMvHQbACAypY7P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712594132; c=relaxed/simple;
	bh=Pi8iFK7pv9gVSy4zoMZi823T9m60lWJMkW/RGNBSPt4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BlNwzvYoGV5YlDTa+VJ7Tye0xf4HmYpfvqphFTpHHkETxfzCMaJDibOWSuhQzP/iaVyFl3q67QvhjMcX2YEuULy1ark0epYb8b4xKxsyXMBenlu3wxqUZ5+sH6Qy+VHwQlayKEoFp9ybvrRc3jB9fB+y18GrLnL0qHVRS5K/lKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P7nkEvgr; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712594130; x=1744130130;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Pi8iFK7pv9gVSy4zoMZi823T9m60lWJMkW/RGNBSPt4=;
  b=P7nkEvgr+4+oj9fWOeCFnBb/Fz985GiVB6Qh4fvZXiHrkmvww1bKeLrF
   N9niTH7h/sdgSsQbr1qCgS9FW1t+ls4kxREMSwDunP31WVCVlMEYQBwjH
   T53uEXSMQiKks8N8ZgYxaqs2BvUacCmt6KYoc/vA59omE2o2lSOh8maZo
   eEUQrpRqmHKEt8vOxCUbf9I6fkDBGj158UonzqHgkqqVvrryeFOuQxSut
   G28gXmgZNpC/hIYUbyjg+knEeZYmijgc47dRcfGdl8ju98dRiUPiMsCwk
   GFSQ8gPZUZn9FgGOh8iWZkGiK5/xtG/DdrG3aNG3U7CbCHhdE2pcjBzjq
   A==;
X-CSE-ConnectionGUID: u6/IEKL/QJ+fPhuLLyt6OA==
X-CSE-MsgGUID: oGxkhFJrTnO6jtgW3twb2g==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7739013"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="7739013"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 09:35:30 -0700
X-CSE-ConnectionGUID: d3Vm6xtjSLekTdGc28CwmA==
X-CSE-MsgGUID: QzRKYmE9RQSZG364hhtU4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="20503591"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.28])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 09:35:27 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 16/16] selftests/resctrl: Remove test name comparing from write_bm_pid_to_resctrl()
Date: Mon,  8 Apr 2024 19:32:47 +0300
Message-Id: <20240408163247.3224-17-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240408163247.3224-1-ilpo.jarvinen@linux.intel.com>
References: <20240408163247.3224-1-ilpo.jarvinen@linux.intel.com>
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
index c7686fb6641a..d4dffc934bc3 100644
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
index 238f514ba7e6..e1fadc1bfa37 100644
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
index 5e0b1e794295..1f2a7dc73b62 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -164,7 +164,6 @@ static void mba_test_cleanup(void)
 static int mba_run_test(const struct resctrl_test *test, const struct user_params *uparams)
 {
 	struct resctrl_val_param param = {
-		.resctrl_val	= MBA_STR,
 		.ctrlgrp	= "c1",
 		.filename	= RESULT_FILE_NAME,
 		.init		= mba_init,
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 0a3ab99b31ab..b027d17b57c5 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -132,7 +132,6 @@ static void mbm_test_cleanup(void)
 static int mbm_run_test(const struct resctrl_test *test, const struct user_params *uparams)
 {
 	struct resctrl_val_param param = {
-		.resctrl_val	= MBM_STR,
 		.ctrlgrp	= "c1",
 		.mongrp		= "m1",
 		.filename	= RESULT_FILE_NAME,
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index a999fbc13fd3..2dda56084588 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -81,7 +81,6 @@ struct resctrl_test {
 
 /*
  * resctrl_val_param:	resctrl test parameters
- * @resctrl_val:	Resctrl feature (Eg: mbm, mba.. etc)
  * @ctrlgrp:		Name of the control monitor group (con_mon grp)
  * @mongrp:		Name of the monitor group (mon grp)
  * @filename:		Name of file to which the o/p should be written
@@ -90,7 +89,6 @@ struct resctrl_test {
  * @measure:		Callback that performs the measurement (a single test)
  */
 struct resctrl_val_param {
-	char		*resctrl_val;
 	const char	*ctrlgrp;
 	const char	*mongrp;
 	char		filename[64];
@@ -113,11 +111,6 @@ struct perf_event_read {
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
@@ -143,8 +136,7 @@ int taskset_benchmark(pid_t bm_pid, int cpu_no, cpu_set_t *old_affinity);
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
index a9e0bb35a4ab..17b93b44b013 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -664,7 +664,6 @@ int resctrl_val(const struct resctrl_test *test,
 		const char * const *benchmark_cmd,
 		struct resctrl_val_param *param)
 {
-	char *resctrl_val = param->resctrl_val;
 	struct sigaction sigact;
 	int ret = 0, pipefd[2];
 	char pipe_message = 0;
@@ -755,8 +754,7 @@ int resctrl_val(const struct resctrl_test *test,
 		goto out;
 
 	/* Write benchmark to specified control&monitoring grp in resctrl FS */
-	ret = write_bm_pid_to_resctrl(bm_pid, param->ctrlgrp, param->mongrp,
-				      resctrl_val);
+	ret = write_bm_pid_to_resctrl(bm_pid, param->ctrlgrp, param->mongrp);
 	if (ret)
 		goto out;
 
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 6b4448588666..4bf1fe6dc308 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -519,7 +519,6 @@ static int write_pid_to_tasks(char *tasks, pid_t pid)
  * @bm_pid:		PID that should be written
  * @ctrlgrp:		Name of the control monitor group (con_mon grp)
  * @mongrp:		Name of the monitor group (mon grp)
- * @resctrl_val:	Resctrl feature (Eg: mbm, mba.. etc)
  *
  * If a con_mon grp is requested, create it and write pid to it, otherwise
  * write pid to root con_mon grp.
@@ -529,8 +528,7 @@ static int write_pid_to_tasks(char *tasks, pid_t pid)
  *
  * Return: 0 on success, < 0 on error.
  */
-int write_bm_pid_to_resctrl(pid_t bm_pid, const char *ctrlgrp,
-			    const char *mongrp, const char *resctrl_val)
+int write_bm_pid_to_resctrl(pid_t bm_pid, const char *ctrlgrp, const char *mongrp)
 {
 	char controlgroup[128], monitorgroup[512], monitorgroup_p[256];
 	char tasks[1024];
@@ -550,22 +548,19 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, const char *ctrlgrp,
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


