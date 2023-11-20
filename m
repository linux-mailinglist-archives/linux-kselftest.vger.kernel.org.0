Return-Path: <linux-kselftest+bounces-312-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9408A7F1197
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 12:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5BC91C2119B
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 11:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F18C79F4;
	Mon, 20 Nov 2023 11:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LBboshSc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C108170F;
	Mon, 20 Nov 2023 03:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700478984; x=1732014984;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xPmGr7tpOJkUFCgjC5RUy87oirL30OKjxVb4BLpr69M=;
  b=LBboshScG0hI3ZXgHmNWeYpb+wGGc+koxiljQv8VYZ12o0mFVCW64BZE
   NFJC92xaYhFc2DQHjRXav5rqEafC8Rxyot1BXwqaxhj0EpiOclYdfmv0a
   rsAaDvIeRXVai+CMBfSB+qlSihkJA0wS+yfyJlciPaU9fb1OJuCVJCZa1
   KfUY/fAozAXgylpmctLFh2KDyGtoyfqCkjfmKRQOoGYQNTI+5b6ShSRqh
   3yNikpzZM6o4YVUYCOwQQmduqpou2ZzY49QBiBoAIHJsS5LHM7k5oVbs6
   Y6ihuRNwF8yNAjiT28orDbz5/KOoW7z9FcFs8mJkHAW9dZ6ArATtFLt6k
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="388737175"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="388737175"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:16:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="759761378"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="759761378"
Received: from sc9itsct4906.amr.corp.intel.com (HELO localhost) ([10.249.46.107])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:16:06 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 16/26] selftests/resctrl: Open perf fd before start & add error handling
Date: Mon, 20 Nov 2023 13:13:30 +0200
Message-Id: <20231120111340.7805-17-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
References: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
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
---
 tools/testing/selftests/resctrl/cache.c    | 19 +++++++++++++++----
 tools/testing/selftests/resctrl/cat_test.c | 14 +++++++-------
 tools/testing/selftests/resctrl/resctrl.h  |  1 +
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 29d70fc11f4e..012da5952cd6 100644
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
index 7e1c383f9119..cfda87667b46 100644
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
index 5626482b41cf..fe07b732cbd9 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -124,6 +124,7 @@ int get_core_sibling(int cpu_no);
 void perf_event_attr_initialize(struct perf_event_attr *pea, __u64 config);
 void perf_event_initialize_read_format(struct perf_event_read *pe_read);
 int perf_open(struct perf_event_attr *pea, pid_t pid, int cpu_no);
+int perf_event_reset_enable(int pe_fd);
 int perf_event_measure(int pe_fd, struct perf_event_read *pe_read,
 		       const char *filename, int bm_pid);
 int measure_llc_resctrl(const char *filename, int bm_pid);
-- 
2.30.2


