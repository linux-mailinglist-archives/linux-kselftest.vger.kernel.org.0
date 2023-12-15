Return-Path: <linux-kselftest+bounces-2067-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00877814B6B
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 16:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 609BA1F24B62
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 15:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804FA364DA;
	Fri, 15 Dec 2023 15:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JNUTklaw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963B93C062;
	Fri, 15 Dec 2023 15:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702653086; x=1734189086;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NzpN2F2SPY9x7Z5I0FOJbY9bMUojN49k0tmelZobAyA=;
  b=JNUTklawL9xsMtS9w9PYj8z0dvIGRFfcLEaVfPTxhJEcd+BLJgalSmWt
   ZABDQNC9KAB6rb+Upwvb9ND/jeWULIE7pwITFN/ZnHEMgZTST/WvFzdwy
   HZ3ZbG4lzH7dQOm7Xwz46SAVLBW7UnpctZY8b09oZQZ31nO+yCoNj0/DB
   7/XoiAkNjgRkg0XtJFk/jpnCE0cK4u6ca+m4MPBHH63RP585yMRnH/51A
   0rcMQgfWmdXgam2U2eIqIQrdt8rZg0mTMPGAL92nq2up5ddgeJrTIo0Ms
   mwLx9Q5zsaprsBqh6FZR4eCKTkBcbhxEOqI018Kq5XRjJBV69ejFwrlVq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="394161487"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="394161487"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:09:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="803736338"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="803736338"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.49.116])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:09:01 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 23/29] selftests/resctrl: Restore the CPU affinity after CAT test
Date: Fri, 15 Dec 2023 17:05:09 +0200
Message-Id: <20231215150515.36983-24-ilpo.jarvinen@linux.intel.com>
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

CAT test does not reset the CPU affinity after the benchmark.
This is relatively harmless as is because CAT test is the last
benchmark to run, however, more tests may be added later.

Store the CPU affinity the first time taskset_benchmark() is run and
add taskset_restore() which the test can call to reset the CPU mask to
its original value.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---

v4:
- Reworded error prints

v3:
- New patch
---
 tools/testing/selftests/resctrl/cat_test.c    | 13 +++++---
 tools/testing/selftests/resctrl/resctrl.h     |  3 +-
 tools/testing/selftests/resctrl/resctrl_val.c |  2 +-
 tools/testing/selftests/resctrl/resctrlfs.c   | 33 +++++++++++++++++--
 4 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index b79916069788..fa95433297c9 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -156,6 +156,7 @@ static int cat_test(struct resctrl_val_param *param, size_t span, unsigned long
 	char *resctrl_val = param->resctrl_val;
 	struct perf_event_read pe_read;
 	struct perf_event_attr pea;
+	cpu_set_t old_affinity;
 	unsigned char *buf;
 	char schemata[64];
 	int ret, i, pe_fd;
@@ -167,7 +168,7 @@ static int cat_test(struct resctrl_val_param *param, size_t span, unsigned long
 	bm_pid = getpid();
 
 	/* Taskset benchmark to specified cpu */
-	ret = taskset_benchmark(bm_pid, param->cpu_no);
+	ret = taskset_benchmark(bm_pid, param->cpu_no, &old_affinity);
 	if (ret)
 		return ret;
 
@@ -175,13 +176,15 @@ static int cat_test(struct resctrl_val_param *param, size_t span, unsigned long
 	ret = write_bm_pid_to_resctrl(bm_pid, param->ctrlgrp, param->mongrp,
 				      resctrl_val);
 	if (ret)
-		return ret;
+		goto reset_affinity;
 
 	perf_event_attr_initialize(&pea, PERF_COUNT_HW_CACHE_MISSES);
 	perf_event_initialize_read_format(&pe_read);
 	pe_fd = perf_open(&pea, bm_pid, param->cpu_no);
-	if (pe_fd < 0)
-		return pe_fd;
+	if (pe_fd < 0) {
+		ret = -1;
+		goto reset_affinity;
+	}
 
 	buf = alloc_buffer(span, 1);
 	if (!buf) {
@@ -220,6 +223,8 @@ static int cat_test(struct resctrl_val_param *param, size_t span, unsigned long
 	free(buf);
 pe_close:
 	close(pe_fd);
+reset_affinity:
+	taskset_restore(bm_pid, &old_affinity);
 
 	return ret;
 }
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 4f040e999eea..94347acafe55 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -98,7 +98,8 @@ int umount_resctrlfs(void);
 int validate_bw_report_request(char *bw_report);
 bool validate_resctrl_feature_request(const char *resource, const char *feature);
 char *fgrep(FILE *inf, const char *str);
-int taskset_benchmark(pid_t bm_pid, int cpu_no);
+int taskset_benchmark(pid_t bm_pid, int cpu_no, cpu_set_t *old_affinity);
+int taskset_restore(pid_t bm_pid, cpu_set_t *old_affinity);
 int write_schemata(char *ctrlgrp, char *schemata, int cpu_no,
 		   char *resctrl_val);
 int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index f6859fe433d9..6574a13f3919 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -777,7 +777,7 @@ int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *par
 	value.sival_ptr = (void *)benchmark_cmd;
 
 	/* Taskset benchmark to specified cpu */
-	ret = taskset_benchmark(bm_pid, param->cpu_no);
+	ret = taskset_benchmark(bm_pid, param->cpu_no, NULL);
 	if (ret)
 		goto out;
 
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 846281e429ca..1bcb9aa96cc2 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -345,15 +345,25 @@ int get_mask_no_shareable(const char *cache_type, unsigned long *mask)
 
 /*
  * taskset_benchmark - Taskset PID (i.e. benchmark) to a specified cpu
- * @bm_pid:	PID that should be binded
- * @cpu_no:	CPU number at which the PID would be binded
+ * @bm_pid:		PID that should be binded
+ * @cpu_no:		CPU number at which the PID would be binded
+ * @old_affinity:	When not NULL, set to old CPU affinity
  *
  * Return: 0 on success, < 0 on error.
  */
-int taskset_benchmark(pid_t bm_pid, int cpu_no)
+int taskset_benchmark(pid_t bm_pid, int cpu_no, cpu_set_t *old_affinity)
 {
 	cpu_set_t my_set;
 
+	if (old_affinity) {
+		CPU_ZERO(old_affinity);
+		if (sched_getaffinity(bm_pid, sizeof(*old_affinity),
+				      old_affinity)) {
+			ksft_perror("Unable to read CPU affinity");
+			return -1;
+		}
+	}
+
 	CPU_ZERO(&my_set);
 	CPU_SET(cpu_no, &my_set);
 
@@ -366,6 +376,23 @@ int taskset_benchmark(pid_t bm_pid, int cpu_no)
 	return 0;
 }
 
+/*
+ * taskset_restore - Taskset PID to the earlier CPU affinity
+ * @bm_pid:		PID that should be reset
+ * @old_affinity:	The old CPU affinity to restore
+ *
+ * Return: 0 on success, < 0 on error.
+ */
+int taskset_restore(pid_t bm_pid, cpu_set_t *old_affinity)
+{
+	if (sched_setaffinity(bm_pid, sizeof(*old_affinity), old_affinity)) {
+		ksft_perror("Unable to restore CPU affinity");
+		return -1;
+	}
+
+	return 0;
+}
+
 /*
  * create_grp - Create a group only if one doesn't exist
  * @grp_name:	Name of the group
-- 
2.30.2


