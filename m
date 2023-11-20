Return-Path: <linux-kselftest+bounces-310-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A09717F1194
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 12:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 512FF28242B
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 11:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718797473;
	Mon, 20 Nov 2023 11:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fPxMa+9p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484371993;
	Mon, 20 Nov 2023 03:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700478979; x=1732014979;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DktzD/iLAjshXQ2RGQH6sZM3sLDUA4PpyDcphlSqMLI=;
  b=fPxMa+9psON1urpLzV7gia2YP0sDucc0d4OYzj6ij1r9SaVsB0MUhi5W
   AbS/kb16z9Cna/NIUu6AIiA/MyZZIsBTdWAjK43UTwZm1RP4GkeYuOzOh
   rAmm+jCpV96BEn1ku1Wbw2DneW00Kr3bSxN4rqSH+ourMhEVcjCth8vQu
   FUCu/80JPMBZ941UkMTudA+QmVRJ+N5iDx98vDByDt8TvUscjl/vOEZaK
   KPmTd2dxQsYTiJlqgrlV5Vn1yQdGR0ZL3FLLg8y3yzQouO4WmmColl+j8
   O48QWsQmqXCF2l9senBChjQM+MKWdNkp3k75hzz9UfhzAm5vkXVRIqnJt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="394447253"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="394447253"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:16:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="7681615"
Received: from sc9itsct4906.amr.corp.intel.com (HELO localhost) ([10.249.46.107])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:16:15 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 17/26] selftests/resctrl: Replace file write with volatile variable
Date: Mon, 20 Nov 2023 13:13:31 +0200
Message-Id: <20231120111340.7805-18-ilpo.jarvinen@linux.intel.com>
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

The fill_buf code prevents compiler optimizating the entire read loop
away by writing the final value of the variable into a file. While it
achieves the goal, writing into a file requires significant amount of
work within the innermost test loop and also error handling.

A simpler approach is to take advantage of volatile. Writing to a
variable through a volatile pointer is enough to prevent compiler from
optimizing the write away, and therefore compiler cannot remove the
read loop either.

Add a volatile 'value_sink' into resctrl_tests.c and make fill_buf to
write into it. As a result, the error handling in fill_buf.c can be
simplified.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/fill_buf.c    | 26 ++++---------------
 tools/testing/selftests/resctrl/resctrl.h     |  7 +++++
 .../testing/selftests/resctrl/resctrl_tests.c |  4 +++
 3 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index b9303a9d819b..8fe9574db9d8 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -78,10 +78,9 @@ static void fill_one_span_write(unsigned char *buf, size_t buf_size)
 	}
 }
 
-static int fill_cache_read(unsigned char *buf, size_t buf_size, bool once)
+static void fill_cache_read(unsigned char *buf, size_t buf_size, bool once)
 {
 	int ret = 0;
-	FILE *fp;
 
 	while (1) {
 		ret = fill_one_span_read(buf, buf_size);
@@ -90,26 +89,16 @@ static int fill_cache_read(unsigned char *buf, size_t buf_size, bool once)
 	}
 
 	/* Consume read result so that reading memory is not optimized out. */
-	fp = fopen("/dev/null", "w");
-	if (!fp) {
-		perror("Unable to write to /dev/null");
-		return -1;
-	}
-	fprintf(fp, "Sum: %d ", ret);
-	fclose(fp);
-
-	return 0;
+	*value_sink = ret;
 }
 
-static int fill_cache_write(unsigned char *buf, size_t buf_size, bool once)
+static void fill_cache_write(unsigned char *buf, size_t buf_size, bool once)
 {
 	while (1) {
 		fill_one_span_write(buf, buf_size);
 		if (once)
 			break;
 	}
-
-	return 0;
 }
 
 static unsigned char *alloc_buffer(size_t buf_size, int memflush)
@@ -143,21 +132,16 @@ static unsigned char *alloc_buffer(size_t buf_size, int memflush)
 int run_fill_buf(size_t buf_size, int memflush, int op, bool once)
 {
 	unsigned char *buf;
-	int ret;
 
 	buf = alloc_buffer(buf_size, memflush);
 	if (!buf)
 		return -1;
 
 	if (op == 0)
-		ret = fill_cache_read(buf, buf_size, once);
+		fill_cache_read(buf, buf_size, once);
 	else
-		ret = fill_cache_write(buf, buf_size, once);
+		fill_cache_write(buf, buf_size, once);
 	free(buf);
-	if (ret) {
-		printf("\n Error in fill cache\n");
-		return -1;
-	}
 
 	return 0;
 }
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index fe07b732cbd9..68eb1f1bac3a 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -79,6 +79,13 @@ struct perf_event_read {
 #define CMT_STR			"cmt"
 #define CAT_STR			"cat"
 
+/*
+ * Memory location that consumes values compiler must not optimize away.
+ * Volatile ensures writes to this location cannot be optimized away by
+ * compiler.
+ */
+extern volatile int *value_sink;
+
 extern pid_t bm_pid, ppid;
 
 extern char llc_occup_path[1024];
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 2bbe3045a018..f0d573aa363b 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -10,6 +10,10 @@
  */
 #include "resctrl.h"
 
+/* Volatile memory sink to prevent compiler optimizations */
+static volatile int sink_target;
+volatile int *value_sink = &sink_target;
+
 static int detect_vendor(void)
 {
 	FILE *inf = fopen("/proc/cpuinfo", "r");
-- 
2.30.2


