Return-Path: <linux-kselftest+bounces-2056-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F79B814B4D
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 16:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 835551F21536
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 15:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C066364A7;
	Fri, 15 Dec 2023 15:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c6dCLA8G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876553EA8E;
	Fri, 15 Dec 2023 15:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702652910; x=1734188910;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uiI1Txb8SQ4sjg4oSkuae8MT0lekNNhJgNqmPnqkOjQ=;
  b=c6dCLA8GxkTgn0ORzyyRaFM81hXDv1FJ7kGA1VzfmkiP8hbzjMQc+Doh
   p73N7NftW0yWc/yHdNXl+ELn4hFlBlpZ6ORs1CaYlENkk+0tvQiCsvQxl
   fyBR9YRJ6GU3mvoOsUYKW1XNGxE1Qo+GxJ7YldIF4H/LsU9opCinQBGIH
   bxM34g+a5lEAvTakxEdhz4djjNrjVCaUaMQgKw3m2JyGHABJZLDSoOcQQ
   kop50TcULDkpkFBf2en7pJ/yIWSnTi9vcoEP4qa1sRb7K58aha6z0Nq7W
   tG5krXilU2oTEtESlZkx+0Mys8j+5bEuMeSWvMjP/EwCiya5MU+kqD/bP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="375433494"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="375433494"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:08:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="778289188"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="778289188"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.49.116])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:08:26 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 19/29] selftests/resctrl: Open perf fd before start & add error handling
Date: Fri, 15 Dec 2023 17:05:05 +0200
Message-Id: <20231215150515.36983-20-ilpo.jarvinen@linux.intel.com>
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

Perf fd (pe_fd) is opened, reset, and enabled during every test the CAT
selftest runs. Also, ioctl(pe_fd, ...) calls are not error checked even
if ioctl() could return an error.

Open perf fd only once before the tests and only reset and enable the
counter within the test loop. Add error checking to pe_fd ioctl()
calls.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/resctrl/cache.c    | 19 +++++++++++++++----
 tools/testing/selftests/resctrl/cat_test.c | 14 +++++++-------
 tools/testing/selftests/resctrl/resctrl.h  |  1 +
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 319d0cdd7225..1b339d6bbff1 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -22,10 +22,19 @@ void perf_event_attr_initialize(struct perf_event_attr *pea, __u64 config)
 }
 
 /* Start counters to log values */
-static void perf_event_reset_enable(int pe_fd)
+int perf_event_reset_enable(int pe_fd)
 {
-	ioctl(pe_fd, PERF_EVENT_IOC_RESET, 0);
-	ioctl(pe_fd, PERF_EVENT_IOC_ENABLE, 0);
+	int ret;
+
+	ret = ioctl(pe_fd, PERF_EVENT_IOC_RESET, 0);
+	if (ret < 0)
+		return ret;
+
+	ret = ioctl(pe_fd, PERF_EVENT_IOC_ENABLE, 0);
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 void perf_event_initialize_read_format(struct perf_event_read *pe_read)
@@ -129,7 +138,9 @@ int perf_event_measure(int pe_fd, struct perf_event_read *pe_read,
 	int ret;
 
 	/* Stop counters after one span to get miss rate */
-	ioctl(pe_fd, PERF_EVENT_IOC_DISABLE, 0);
+	ret = ioctl(pe_fd, PERF_EVENT_IOC_DISABLE, 0);
+	if (ret < 0)
+		return ret;
 
 	ret = read(pe_fd, pe_read, sizeof(*pe_read));
 	if (ret == -1) {
diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index bfb607b13491..36e62baebf4f 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -145,6 +145,9 @@ static int cat_test(struct resctrl_val_param *param, size_t span)
 
 	perf_event_attr_initialize(&pea, PERF_COUNT_HW_CACHE_MISSES);
 	perf_event_initialize_read_format(&pe_read);
+	pe_fd = perf_open(&pea, bm_pid, param->cpu_no);
+	if (pe_fd < 0)
+		return pe_fd;
 
 	/* Test runs until the callback setup() tells the test to stop. */
 	while (1) {
@@ -155,11 +158,10 @@ static int cat_test(struct resctrl_val_param *param, size_t span)
 		}
 		if (ret < 0)
 			break;
-		pe_fd = perf_open(&pea, bm_pid, param->cpu_no);
-		if (pe_fd < 0) {
-			ret = -1;
-			break;
-		}
+
+		ret = perf_event_reset_enable(pe_fd);
+		if (ret)
+			goto pe_close;
 
 		if (run_fill_buf(span, memflush, operation, true)) {
 			fprintf(stderr, "Error-running fill buffer\n");
@@ -171,8 +173,6 @@ static int cat_test(struct resctrl_val_param *param, size_t span)
 		ret = perf_event_measure(pe_fd, &pe_read, param->filename, bm_pid);
 		if (ret)
 			goto pe_close;
-
-		close(pe_fd);
 	}
 
 	return ret;
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 4aabf7ac0ab9..f22b7897251e 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -122,6 +122,7 @@ int get_core_sibling(int cpu_no);
 void perf_event_attr_initialize(struct perf_event_attr *pea, __u64 config);
 void perf_event_initialize_read_format(struct perf_event_read *pe_read);
 int perf_open(struct perf_event_attr *pea, pid_t pid, int cpu_no);
+int perf_event_reset_enable(int pe_fd);
 int perf_event_measure(int pe_fd, struct perf_event_read *pe_read,
 		       const char *filename, int bm_pid);
 int measure_llc_resctrl(const char *filename, int bm_pid);
-- 
2.30.2


