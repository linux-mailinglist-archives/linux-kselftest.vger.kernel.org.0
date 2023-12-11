Return-Path: <linux-kselftest+bounces-1541-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B41E480C983
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 13:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4B151C209E4
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 12:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440AF3B1AC;
	Mon, 11 Dec 2023 12:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RpuQZiC1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0A3F1;
	Mon, 11 Dec 2023 04:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702297256; x=1733833256;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G69brIMT77l0LXy/mP+PFF5+8Ttay9gu0oXWiXQqBF4=;
  b=RpuQZiC1JM36HTO534SJj4HgqKhS1j8Xmd81Qv2+GhBClI1NerxOLQ4x
   p3oyvYaEtDtS8a3Nqe3sWiASi4lyxwZrQSc+TlxyEZXRphA9cNcXqbApQ
   f4czsl9uPL9jC9aT1yNk2L1wKtcBoaDLx+6wmF8/8sDyVCjecEhCarbtp
   7iEUyFHTM9vdd2SUNgNi77HHrgaOFql+nzq9QNkuumWZ1ikMLwKcShLN6
   eTQ7M9HrCtHJWTCicbXHOe2zPts1j+LyOLSMM7DoP0hrzWJJLsQBPiLzO
   G+MO1VJbxRO8Xn6E6wdP5Yy6YtWmOCntTTmI+3arAEzv1yDdfHf8ruAaa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="425765882"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="425765882"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 04:20:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="14426993"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.50.188])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 04:20:52 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 15/29] selftests/resctrl: Consolidate naming of perf event related things
Date: Mon, 11 Dec 2023 14:18:12 +0200
Message-Id: <20231211121826.14392-16-ilpo.jarvinen@linux.intel.com>
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

Naming for perf event related functions, types, and variables is
inconsistent.

Make struct read_format and all functions related to perf events start
with "perf_". Adjust variable names towards the same direction but use
shorter names for variables where appropriate (pe prefix).

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---

v3:
- removed "currently" from changelog
---
 tools/testing/selftests/resctrl/cache.c | 42 ++++++++++++-------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 4f846a2e5e26..7f45c4957f81 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -3,7 +3,7 @@
 #include <stdint.h>
 #include "resctrl.h"
 
-struct read_format {
+struct perf_event_read {
 	__u64 nr;			/* The number of events */
 	struct {
 		__u64 value;		/* The value of the event */
@@ -11,11 +11,11 @@ struct read_format {
 };
 
 static struct perf_event_attr pea_llc_miss;
-static struct read_format rf_cqm;
-static int fd_lm;
+static struct perf_event_read pe_read;
+static int pe_fd;
 char llc_occup_path[1024];
 
-static void initialize_perf_event_attr(void)
+static void perf_event_attr_initialize(void)
 {
 	pea_llc_miss.type = PERF_TYPE_HARDWARE;
 	pea_llc_miss.size = sizeof(struct perf_event_attr);
@@ -30,34 +30,34 @@ static void initialize_perf_event_attr(void)
 }
 
 /* Start counters to log values */
-static void ioctl_perf_event_ioc_reset_enable(void)
+static void perf_event_reset_enable(void)
 {
-	ioctl(fd_lm, PERF_EVENT_IOC_RESET, 0);
-	ioctl(fd_lm, PERF_EVENT_IOC_ENABLE, 0);
+	ioctl(pe_fd, PERF_EVENT_IOC_RESET, 0);
+	ioctl(pe_fd, PERF_EVENT_IOC_ENABLE, 0);
 }
 
-static void initialize_llc_perf(void)
+static void perf_event_initialize(void)
 {
 	memset(&pea_llc_miss, 0, sizeof(struct perf_event_attr));
-	memset(&rf_cqm, 0, sizeof(struct read_format));
+	memset(&pe_read, 0, sizeof(struct perf_event_read));
 
 	/* Initialize perf_event_attr structures for HW_CACHE_MISSES */
-	initialize_perf_event_attr();
+	perf_event_attr_initialize();
 
 	pea_llc_miss.config = PERF_COUNT_HW_CACHE_MISSES;
 
-	rf_cqm.nr = 1;
+	pe_read.nr = 1;
 }
 
-static int reset_enable_llc_perf(pid_t pid, int cpu_no)
+static int perf_open(pid_t pid, int cpu_no)
 {
-	fd_lm = perf_event_open(&pea_llc_miss, pid, cpu_no, -1, PERF_FLAG_FD_CLOEXEC);
-	if (fd_lm == -1) {
+	pe_fd = perf_event_open(&pea_llc_miss, pid, cpu_no, -1, PERF_FLAG_FD_CLOEXEC);
+	if (pe_fd == -1) {
 		ksft_perror("Error opening leader");
 		return -1;
 	}
 
-	ioctl_perf_event_ioc_reset_enable();
+	perf_event_reset_enable();
 
 	return 0;
 }
@@ -141,15 +141,15 @@ static int perf_event_measure(const char *filename, int bm_pid)
 	int ret;
 
 	/* Stop counters after one span to get miss rate */
-	ioctl(fd_lm, PERF_EVENT_IOC_DISABLE, 0);
+	ioctl(pe_fd, PERF_EVENT_IOC_DISABLE, 0);
 
-	ret = read(fd_lm, &rf_cqm, sizeof(struct read_format));
+	ret = read(pe_fd, &pe_read, sizeof(struct perf_event_read));
 	if (ret == -1) {
 		ksft_perror("Could not get perf value");
 		return -1;
 	}
 
-	return print_results_cache(filename, bm_pid, rf_cqm.values[0].value);
+	return print_results_cache(filename, bm_pid, pe_read.values[0].value);
 }
 
 /*
@@ -204,7 +204,7 @@ int cat_val(struct resctrl_val_param *param, size_t span)
 	if (ret)
 		return ret;
 
-	initialize_llc_perf();
+	perf_event_initialize();
 
 	/* Test runs until the callback setup() tells the test to stop. */
 	while (1) {
@@ -215,7 +215,7 @@ int cat_val(struct resctrl_val_param *param, size_t span)
 		}
 		if (ret < 0)
 			break;
-		ret = reset_enable_llc_perf(bm_pid, param->cpu_no);
+		ret = perf_open(bm_pid, param->cpu_no);
 		if (ret)
 			break;
 
@@ -234,7 +234,7 @@ int cat_val(struct resctrl_val_param *param, size_t span)
 	return ret;
 
 pe_close:
-	close(fd_lm);
+	close(pe_fd);
 	return ret;
 }
 
-- 
2.30.2


