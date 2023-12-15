Return-Path: <linux-kselftest+bounces-2054-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B364E814B49
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 16:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29FFD1F24D54
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 15:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E6E36AF9;
	Fri, 15 Dec 2023 15:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VJTemh7+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258F33EA71;
	Fri, 15 Dec 2023 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702652889; x=1734188889;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BVJW4TewmYtpzgu+yfSzCRjXdC+iNiGDpz9GYSqkwkI=;
  b=VJTemh7+gpYTA4kpy12X3WE5od+1db1xgyAqrxQS20x8FB2mw/Q6BVVo
   NqcXiKjR3Mmv5my1V/5MTDBgB7Rv+pgVst5uPDba71VuCQuNVROQqChFh
   Do+PlD+KgMaHj4ubtBjA0rD8hhu+1rP/Js047hw/fE9R8ZGIYCieChPop
   cAz827MPPHDGEtj9wjyLnxfus6FVPL8oW8eaV++5cEo/Rk8FE744tFT/Q
   2REVPhQeKlfNUQYvVHVFN3J0Kn88kJooJa/6VfiwO8iRl82mOKmh0ibkc
   7e5Q/hhKkXFphtu+UcRQ5OQxcaZaL5hoaMSBeAfvb0rYMqQ8AcMY99Azx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="2453759"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="2453759"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:08:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="809001326"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="809001326"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.49.116])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:08:05 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 17/29] selftests/resctrl: Convert perf related globals to locals
Date: Fri, 15 Dec 2023 17:05:03 +0200
Message-Id: <20231215150515.36983-18-ilpo.jarvinen@linux.intel.com>
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

Perf related variables pea_llc_miss, pe_read, and pe_fd are globals in
cache.c.

Convert them to locals for better scoping and make pea_llc_miss simpler
by renaming it to pea. Make close(pe_fd) handling easier to understand
by doing it inside cat_val().

Make also sizeof()s use safer way to determine the right struct.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/resctrl/cache.c | 72 ++++++++++++++-----------
 1 file changed, 40 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 58ee6f6b0edf..335415eaa406 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -10,51 +10,50 @@ struct perf_event_read {
 	} values[2];
 };
 
-static struct perf_event_attr pea_llc_miss;
-static struct perf_event_read pe_read;
-static int pe_fd;
 char llc_occup_path[1024];
 
-static void perf_event_attr_initialize(__u64 config)
+static void perf_event_attr_initialize(struct perf_event_attr *pea, __u64 config)
 {
-	memset(&pea_llc_miss, 0, sizeof(struct perf_event_attr));
-	pea_llc_miss.type = PERF_TYPE_HARDWARE;
-	pea_llc_miss.size = sizeof(struct perf_event_attr);
-	pea_llc_miss.read_format = PERF_FORMAT_GROUP;
-	pea_llc_miss.exclude_kernel = 1;
-	pea_llc_miss.exclude_hv = 1;
-	pea_llc_miss.exclude_idle = 1;
-	pea_llc_miss.exclude_callchain_kernel = 1;
-	pea_llc_miss.inherit = 1;
-	pea_llc_miss.exclude_guest = 1;
-	pea_llc_miss.disabled = 1;
-	pea_llc_miss.config = config;
+	memset(pea, 0, sizeof(*pea));
+	pea->type = PERF_TYPE_HARDWARE;
+	pea->size = sizeof(*pea);
+	pea->read_format = PERF_FORMAT_GROUP;
+	pea->exclude_kernel = 1;
+	pea->exclude_hv = 1;
+	pea->exclude_idle = 1;
+	pea->exclude_callchain_kernel = 1;
+	pea->inherit = 1;
+	pea->exclude_guest = 1;
+	pea->disabled = 1;
+	pea->config = config;
 }
 
 /* Start counters to log values */
-static void perf_event_reset_enable(void)
+static void perf_event_reset_enable(int pe_fd)
 {
 	ioctl(pe_fd, PERF_EVENT_IOC_RESET, 0);
 	ioctl(pe_fd, PERF_EVENT_IOC_ENABLE, 0);
 }
 
-static void perf_event_initialize_read_format(void)
+static void perf_event_initialize_read_format(struct perf_event_read *pe_read)
 {
-	memset(&pe_read, 0, sizeof(struct perf_event_read));
-	pe_read.nr = 1;
+	memset(pe_read, 0, sizeof(*pe_read));
+	pe_read->nr = 1;
 }
 
-static int perf_open(pid_t pid, int cpu_no)
+static int perf_open(struct perf_event_attr *pea, pid_t pid, int cpu_no)
 {
-	pe_fd = perf_event_open(&pea_llc_miss, pid, cpu_no, -1, PERF_FLAG_FD_CLOEXEC);
+	int pe_fd;
+
+	pe_fd = perf_event_open(pea, pid, cpu_no, -1, PERF_FLAG_FD_CLOEXEC);
 	if (pe_fd == -1) {
 		ksft_perror("Error opening leader");
 		return -1;
 	}
 
-	perf_event_reset_enable();
+	perf_event_reset_enable(pe_fd);
 
-	return 0;
+	return pe_fd;
 }
 
 /*
@@ -131,20 +130,21 @@ static int print_results_cache(const char *filename, int bm_pid, __u64 llc_value
  *
  * Return: =0 on success. <0 on failure.
  */
-static int perf_event_measure(const char *filename, int bm_pid)
+static int perf_event_measure(int pe_fd, struct perf_event_read *pe_read,
+			      const char *filename, int bm_pid)
 {
 	int ret;
 
 	/* Stop counters after one span to get miss rate */
 	ioctl(pe_fd, PERF_EVENT_IOC_DISABLE, 0);
 
-	ret = read(pe_fd, &pe_read, sizeof(struct perf_event_read));
+	ret = read(pe_fd, pe_read, sizeof(*pe_read));
 	if (ret == -1) {
 		ksft_perror("Could not get perf value");
 		return -1;
 	}
 
-	return print_results_cache(filename, bm_pid, pe_read.values[0].value);
+	return print_results_cache(filename, bm_pid, pe_read->values[0].value);
 }
 
 /*
@@ -181,7 +181,10 @@ int cat_val(struct resctrl_val_param *param, size_t span)
 {
 	int memflush = 1, operation = 0, ret = 0;
 	char *resctrl_val = param->resctrl_val;
+	struct perf_event_read pe_read;
+	struct perf_event_attr pea;
 	pid_t bm_pid;
+	int pe_fd;
 
 	if (strcmp(param->filename, "") == 0)
 		sprintf(param->filename, "stdio");
@@ -199,8 +202,8 @@ int cat_val(struct resctrl_val_param *param, size_t span)
 	if (ret)
 		return ret;
 
-	perf_event_attr_initialize(PERF_COUNT_HW_CACHE_MISSES);
-	perf_event_initialize_read_format();
+	perf_event_attr_initialize(&pea, PERF_COUNT_HW_CACHE_MISSES);
+	perf_event_initialize_read_format(&pe_read);
 
 	/* Test runs until the callback setup() tells the test to stop. */
 	while (1) {
@@ -211,9 +214,12 @@ int cat_val(struct resctrl_val_param *param, size_t span)
 		}
 		if (ret < 0)
 			break;
-		ret = perf_open(bm_pid, param->cpu_no);
-		if (ret)
+
+		pe_fd = perf_open(&pea, bm_pid, param->cpu_no);
+		if (pe_fd < 0) {
+			ret = -1;
 			break;
+		}
 
 		if (run_fill_buf(span, memflush, operation, true)) {
 			fprintf(stderr, "Error-running fill buffer\n");
@@ -222,9 +228,11 @@ int cat_val(struct resctrl_val_param *param, size_t span)
 		}
 
 		sleep(1);
-		ret = perf_event_measure(param->filename, bm_pid);
+		ret = perf_event_measure(pe_fd, &pe_read, param->filename, bm_pid);
 		if (ret)
 			goto pe_close;
+
+		close(pe_fd);
 	}
 
 	return ret;
-- 
2.30.2


