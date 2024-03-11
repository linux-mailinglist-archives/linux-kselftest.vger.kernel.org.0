Return-Path: <linux-kselftest+bounces-6201-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB4287810F
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 14:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1E471C2271A
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 13:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E55A3FB30;
	Mon, 11 Mar 2024 13:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PLfgWJJq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40F6446C8;
	Mon, 11 Mar 2024 13:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710165287; cv=none; b=USd83i4XgPBeJNPsxCtvMh8HdFDpx3SXOohjQAES7PfFaRf0raI7p+GKRItb3tcD6QHg3xjsrURNpG9Ry5bVubH7jJwHa+Yg+8QUUEgEIkINPUOtmlHSZkNp+wW88xwz6DFheEqVearqkyjCjRNq2jgrXxCRVqhqJwKnRD1oZSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710165287; c=relaxed/simple;
	bh=VPYe+KPk8aOURavBcr5qgfEgzrTuYjayKHJkJ4aZNR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c5PBj5oq5t8TI4GZooDtfbR25p2Qup8ITWZyLhhvt7ZYBGI4g8saMTgT9FE2bw/DWmdDwpg8I5lnIj8pR29bzCuTM4QEwHG/MEtQ3FI75EJgvnI/Pl2P6XIEbCD/hZaIzIgfWmYxN07gWqnU/7Y2/+ZkxN6AHoH5ppgy10dShTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PLfgWJJq; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710165285; x=1741701285;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VPYe+KPk8aOURavBcr5qgfEgzrTuYjayKHJkJ4aZNR0=;
  b=PLfgWJJqD422tEw3CNl7XMmOxVfL078+Fqmkoyi9C8sk0b3n3aZZvhAv
   BkGRW0vHG5B1oJ+QSjl1c422tf9AZXCMi3JjeMoWJFjpWSUsDlSwpkukT
   l5M1bwNWQt7D1jof2qmKqZUHhH+CDYR+e0UAG8GfggwOK+EiHTQoIUxVV
   SmED4KwBcXnYin+p6FY8L92UwCm/ko3HOZ7whnj1ztdz9ka6zynSqHp1l
   oNIhuZDJgliyMSJEzfT3E3QqNblR9uaUlF7HmYbTK2Wp0o/GRtwc9m/Qk
   LATryHKv2cXLooR5s97EHAfnPL5y4Olyj6RMcnyMUoC3bj5ok6jj/iUJd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="4963959"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="4963959"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 06:54:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="11065436"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.201])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 06:54:41 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 13/13] selftests/resctrl: Remove test name comparing from write_bm_pid_to_resctrl()
Date: Mon, 11 Mar 2024 15:52:30 +0200
Message-Id: <20240311135230.7007-14-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240311135230.7007-1-ilpo.jarvinen@linux.intel.com>
References: <20240311135230.7007-1-ilpo.jarvinen@linux.intel.com>
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
index 4cb991be8e31..c0291ecf1d1c 100644
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
index e79eca9346f3..ab96411d1015 100644
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
index 5bb73e6cabc3..c44af1f62f55 100644
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
index c8c9aba81db8..120c356a069e 100644
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
index 54e5bce4c698..4cd7997b39e6 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -79,7 +79,6 @@ struct resctrl_test {
 
 /*
  * resctrl_val_param:	resctrl test parameters
- * @resctrl_val:	Resctrl feature (Eg: mbm, mba.. etc)
  * @ctrlgrp:		Name of the control monitor group (con_mon grp)
  * @mongrp:		Name of the monitor group (mon grp)
  * @filename:		Name of file to which the o/p should be written
@@ -88,7 +87,6 @@ struct resctrl_test {
  * @measure:		Callback that performs the measurement (a single test)
  */
 struct resctrl_val_param {
-	char		*resctrl_val;
 	const char	*ctrlgrp;
 	const char	*mongrp;
 	char		filename[64];
@@ -111,11 +109,6 @@ struct perf_event_read {
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
@@ -141,8 +134,7 @@ int taskset_benchmark(pid_t bm_pid, int cpu_no, cpu_set_t *old_affinity);
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
index dbe0cc6d74fa..1bd70ac73ae2 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -524,7 +524,6 @@ static int write_pid_to_tasks(char *tasks, pid_t pid)
  * @bm_pid:		PID that should be written
  * @ctrlgrp:		Name of the control monitor group (con_mon grp)
  * @mongrp:		Name of the monitor group (mon grp)
- * @resctrl_val:	Resctrl feature (Eg: mbm, mba.. etc)
  *
  * If a con_mon grp is requested, create it and write pid to it, otherwise
  * write pid to root con_mon grp.
@@ -534,8 +533,7 @@ static int write_pid_to_tasks(char *tasks, pid_t pid)
  *
  * Return: 0 on success, < 0 on error.
  */
-int write_bm_pid_to_resctrl(pid_t bm_pid, const char *ctrlgrp,
-			    const char *mongrp, const char *resctrl_val)
+int write_bm_pid_to_resctrl(pid_t bm_pid, const char *ctrlgrp, const char *mongrp)
 {
 	char controlgroup[128], monitorgroup[512], monitorgroup_p[256];
 	char tasks[1024];
@@ -555,22 +553,19 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, const char *ctrlgrp,
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


