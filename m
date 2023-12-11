Return-Path: <linux-kselftest+bounces-1546-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF2480C98D
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 13:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 637A51F21659
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 12:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D2F3B1BA;
	Mon, 11 Dec 2023 12:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bR+7FYjs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BDB1729;
	Mon, 11 Dec 2023 04:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702297300; x=1733833300;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8lZx/e7i1mLL+bjJrmN6XniLHqbBvmT5Tn6jv0M2TqM=;
  b=bR+7FYjsWSlXejP+tYQtRcY8tLzJ8GXWKsZ297oEdsPU/T6AHEtGwenU
   jUB+BHv/jjcxMUG7uok7bG0mqXFA2KfQlkVczmihf5XRJB9dd5rYS0LYJ
   ehU5Mc3cMnAd1pUD3szwByOiqCoeaUqyAif3g6DrZ8PtizCe5OOMPe76b
   n8ulr8V2Y7VtkI/d4Ha6Uza1Do3Z1cCmpvkYxMSxoE8EpDgS/5R5In7sf
   Y8PDTizI96NMOvNqsr9I46wA+wviP0dqhG8bAQXgptZUzwj90IPN6qqPJ
   5blK36ItJ1WpCMml3+hH+0crmJeOAIsYd+oNm1ePwx5I+o7WH8S5Ib5/s
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="393509741"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="393509741"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 04:21:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="863755957"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="863755957"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.50.188])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 04:21:36 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 20/29] selftests/resctrl: Replace file write with volatile variable
Date: Mon, 11 Dec 2023 14:18:17 +0200
Message-Id: <20231211121826.14392-21-ilpo.jarvinen@linux.intel.com>
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

The fill_buf code prevents compiler optimizating the entire read loop
away by writing the final value of the variable into a file. While it
achieves the goal, writing into a file requires significant amount of
work within the innermost test loop and also error handling.

A simpler approach is to take advantage of volatile. Writing through
a pointer to a volatile variable is enough to prevent compiler from
optimizing the write away, and therefore compiler cannot remove the
read loop either.

Add a volatile 'value_sink' into resctrl_tests.c and make fill_buf to
write into it. As a result, the error handling in fill_buf.c can be
simplified.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

v3:
- Altered changelog's wording to not say "a volatile pointer"
---
 tools/testing/selftests/resctrl/fill_buf.c    | 26 ++++---------------
 tools/testing/selftests/resctrl/resctrl.h     |  7 +++++
 .../testing/selftests/resctrl/resctrl_tests.c |  4 +++
 3 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index 635f938b11f0..8fe9574db9d8 100644
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
-		ksft_perror("Unable to write to /dev/null");
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
index 419669502959..4e1f7a4bbaf5 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -78,6 +78,13 @@ struct perf_event_read {
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


