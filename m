Return-Path: <linux-kselftest+bounces-2041-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F910814B2E
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 16:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1763828720E
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 15:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EA737141;
	Fri, 15 Dec 2023 15:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EI7zT3VP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A88339FE2;
	Fri, 15 Dec 2023 15:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702652763; x=1734188763;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=peQ6LxwT/RjKkJOWXyGwETGwb6tSl7bA/Hy4zZU8Ato=;
  b=EI7zT3VPIZNxwZB8yB34rUFmb62QmNz4ffFkWSNwTcU/1vhsUn8X4goN
   PbMriz9fmrk/16mvb8ElwiXQFxmIz7X2n1xg3qofBJpzAwah2NZu2TVez
   4xwJHbBF41Ij/DnCAFOPu4vKS+zpVuutxvaDqgaRP3e8eoeDQ6Rs8H/am
   T3UllxZ4Sg9Iyeb9TYrVIXfXaVvIfUJRwk6sY5DIsSSsNrYiGKoBtZLCs
   C65pylxxFs1RD7+qgiq8rhhAYzyThyuJg4K5BRig0/8lYJXvJCRRDm7Xz
   jnby5VvONcMYSewyAUi7HUnev26U8teiVamB7Kocl9X7fBZ6Hpck+kKBf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="392461469"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="392461469"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:05:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="1106150920"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="1106150920"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.49.116])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:05:42 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 02/29] selftests/resctrl: Return -1 instead of errno on error
Date: Fri, 15 Dec 2023 17:04:48 +0200
Message-Id: <20231215150515.36983-3-ilpo.jarvinen@linux.intel.com>
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

A number of functions in the resctrl selftests return errno. It is
problematic because errno is positive which is often counterintuitive.
Also, every site returning errno prints the error message already with
ksft_perror() so there is not much added value in returning the precise
error code.

Simply convert all places returning errno to return -1 that is typical
userspace error code in case of failures.

While at it, improve resctrl_val() comment to state that 0 means the
test was run (either pass or fail).

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---

v4:
- Typofix changelog

v3:
- New patch
---
 tools/testing/selftests/resctrl/cache.c       |  6 +++---
 tools/testing/selftests/resctrl/cat_test.c    |  4 ++--
 tools/testing/selftests/resctrl/cmt_test.c    |  2 +-
 tools/testing/selftests/resctrl/mba_test.c    |  2 +-
 tools/testing/selftests/resctrl/mbm_test.c    |  2 +-
 tools/testing/selftests/resctrl/resctrl_val.c | 10 +++++-----
 tools/testing/selftests/resctrl/resctrlfs.c   |  2 +-
 7 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 992bac8c352b..1fa4b86e1459 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -126,7 +126,7 @@ static int get_llc_occu_resctrl(unsigned long *llc_occupancy)
 	if (!fp) {
 		ksft_perror("Failed to open results file");
 
-		return errno;
+		return -1;
 	}
 	if (fscanf(fp, "%lu", llc_occupancy) <= 0) {
 		ksft_perror("Could not get llc occupancy");
@@ -146,7 +146,7 @@ static int get_llc_occu_resctrl(unsigned long *llc_occupancy)
  * @llc_value:		perf miss value /
  *			llc occupancy value reported by resctrl FS
  *
- * Return:		0 on success. non-zero on failure.
+ * Return:		0 on success, < 0 on error.
  */
 static int print_results_cache(char *filename, int bm_pid,
 			       unsigned long llc_value)
@@ -161,7 +161,7 @@ static int print_results_cache(char *filename, int bm_pid,
 		if (!fp) {
 			ksft_perror("Cannot open results file");
 
-			return errno;
+			return -1;
 		}
 		fprintf(fp, "Pid: %d \t llc_value: %lu\n", bm_pid, llc_value);
 		fclose(fp);
diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 9bb8ba93f433..fabb56ff68d1 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -53,7 +53,7 @@ static int check_results(struct resctrl_val_param *param, size_t span)
 	if (!fp) {
 		ksft_perror("Cannot open file");
 
-		return errno;
+		return -1;
 	}
 
 	while (fgets(temp, sizeof(temp), fp)) {
@@ -150,7 +150,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 
 	if (pipe(pipefd)) {
 		ksft_perror("Unable to create pipe");
-		return errno;
+		return -1;
 	}
 
 	fflush(stdout);
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index 16fc0488e0a5..ffd302bd5c73 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -39,7 +39,7 @@ static int check_results(struct resctrl_val_param *param, size_t span, int no_of
 	if (!fp) {
 		ksft_perror("Error in opening file");
 
-		return errno;
+		return -1;
 	}
 
 	while (fgets(temp, sizeof(temp), fp)) {
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 4988b93add6a..e907adf7cd25 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -111,7 +111,7 @@ static int check_results(void)
 	if (!fp) {
 		ksft_perror(output);
 
-		return errno;
+		return -1;
 	}
 
 	runs = 0;
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 045cd7818c79..721b3ecbc158 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -61,7 +61,7 @@ static int check_results(size_t span)
 	if (!fp) {
 		ksft_perror(output);
 
-		return errno;
+		return -1;
 	}
 
 	runs = 0;
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 231d2012de2b..7fd9f1010135 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -526,7 +526,7 @@ void signal_handler_unregister(void)
  * @bw_imc:		perf imc counter value
  * @bw_resc:		memory bandwidth value
  *
- * Return:		0 on success. non-zero on failure.
+ * Return:		0 on success, < 0 on error.
  */
 static int print_results_bw(char *filename,  int bm_pid, float bw_imc,
 			    unsigned long bw_resc)
@@ -542,14 +542,14 @@ static int print_results_bw(char *filename,  int bm_pid, float bw_imc,
 		if (!fp) {
 			ksft_perror("Cannot open results file");
 
-			return errno;
+			return -1;
 		}
 		if (fprintf(fp, "Pid: %d \t Mem_BW_iMC: %f \t Mem_BW_resc: %lu \t Difference: %lu\n",
 			    bm_pid, bw_imc, bw_resc, diff) <= 0) {
 			ksft_print_msg("Could not log results\n");
 			fclose(fp);
 
-			return errno;
+			return -1;
 		}
 		fclose(fp);
 	}
@@ -686,7 +686,7 @@ static void run_benchmark(int signum, siginfo_t *info, void *ucontext)
  * @benchmark_cmd:	benchmark command and its arguments
  * @param:		parameters passed to resctrl_val()
  *
- * Return:		0 on success. non-zero on failure.
+ * Return:		0 when the test was run, < 0 on error.
  */
 int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *param)
 {
@@ -814,7 +814,7 @@ int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *par
 	/* Signal child to start benchmark */
 	if (sigqueue(bm_pid, SIGUSR1, value) == -1) {
 		ksft_perror("sigqueue SIGUSR1 to child");
-		ret = errno;
+		ret = -1;
 		goto out;
 	}
 
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 77023d342a12..5fb595ed8843 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -88,7 +88,7 @@ int umount_resctrlfs(void)
 	if (umount(mountpoint)) {
 		ksft_perror("Unable to umount resctrl");
 
-		return errno;
+		return -1;
 	}
 
 	return 0;
-- 
2.30.2


