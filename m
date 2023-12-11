Return-Path: <linux-kselftest+bounces-1545-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 292DA80C98B
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 13:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD3C8B20C02
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 12:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E69D3B1B9;
	Mon, 11 Dec 2023 12:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BVbrTqLt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC861B1;
	Mon, 11 Dec 2023 04:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702297291; x=1733833291;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VSvjnPLu7Fih72ExaXTPlbEBBkfKQMvNugkoOWLF/vw=;
  b=BVbrTqLttjxtOEcrneEFMSlyP5zHAOwk8ih/HKnAtFbu8irc9SmBJmWX
   UpsuGOBVsl+ss2m5Yp41hOJ9PiqKCUPwYkEKACjOVl6MP6wCqIWCTtWG+
   F6v0/7B+1HvF4o7WcoMi3FgC8i73G8G7wkEF1XswHUiaSTxH5IV+qF192
   /ikAN9VP0FiihY9qeS3U4rGWoEukQ3evrYWR9VqOeI3LJ2DofIIsKRpSl
   euGQuCv/qDST6GNn388WNGcK8LZ28Vmk6WFtctUTma23N/kX4Egn1ewqS
   EAGYux5yZkPa6NZklxV9EBgqQmJ+H3c7t5Wnwj+urSPV0g8cht2j1NS2V
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="393509728"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="393509728"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 04:21:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="863755924"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="863755924"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.50.188])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 04:21:27 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 19/29] selftests/resctrl: Open perf fd before start & add error handling
Date: Mon, 11 Dec 2023 14:18:16 +0200
Message-Id: <20231211121826.14392-20-ilpo.jarvinen@linux.intel.com>
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
index 6635d5c1908a..419669502959 100644
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


