Return-Path: <linux-kselftest+bounces-1549-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C599F80C991
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 13:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80F1B281DF6
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 12:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FA43B286;
	Mon, 11 Dec 2023 12:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A85W4/wN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0D41FEB;
	Mon, 11 Dec 2023 04:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702297326; x=1733833326;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cJnQHdeT9Iw1CbiGh/KWIUxLQ31U3SIhpmH46T/Q2yY=;
  b=A85W4/wNdlHYIOq0NFR953OJf+mUIzikrUePr+xlsxZ0h6RCzPpf/OYO
   NwXhq/0vevMdtkHYVN5GrAkh1+a9+zpMQwNaCn6VwoQjxg3WExCumVJQC
   CS2INm0oGtvI72b0uv75K2cYkiT44Z+WGgPfoP3OYkN1MKsb3LP9AdDlM
   nje7dtKshHBYg7DbBcZu/Bp9Uemnd/Rz8w651Kod8Nkf8sHi6dNegX6pX
   5/uUt/O+5fl+WVpNKSvqJp988+aogSKljwwMFfk8HgJQuvC7iRhRkI8UB
   7ZIo1iDm98OoaTSdMzOazi8+SAEcRE41TZUfQhd5zUnFe9EczYGIVQUZj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="7992642"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="7992642"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 04:22:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="843494612"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="843494612"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.50.188])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 04:22:02 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 23/29] selftests/resctrl: Restore the CPU affinity after CAT test
Date: Mon, 11 Dec 2023 14:18:20 +0200
Message-Id: <20231211121826.14392-24-ilpo.jarvinen@linux.intel.com>
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

CAT test does not reset the CPU affinity after the benchmark.
This is relatively harmless as is because CAT test is the last
benchmark to run, however, more tests may be added later.

Store the CPU affinity the first time taskset_benchmark() is run and
add taskset_restore() which the test can call to reset the CPU mask to
its original value.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

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
index da1f1b508aee..da62f4cd5add 100644
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
index d515850cc174..4aed974efa0f 100644
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
index dffe42e11c6c..97760fadcddf 100644
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
+			ksft_perror("Unable to read previous CPU affinity");
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
+		ksft_perror("Unable to restore taskset");
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


