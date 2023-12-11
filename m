Return-Path: <linux-kselftest+bounces-1532-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0509880C96A
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 13:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B8DC1F210E7
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 12:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD4A3AC16;
	Mon, 11 Dec 2023 12:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KTdidk60"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F168E;
	Mon, 11 Dec 2023 04:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702297175; x=1733833175;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dok/Lw/7dpBtXhITf9AUg3ARipomFxoKv6i7dvfhq6g=;
  b=KTdidk60Y2hNyr6WqH5fEuaU5yXVZiAJwd+P0AkyUQQbd2F/7JotCF67
   snGDSWMrLzn1ctVIE2pqy9j6N5s6TaDk2BVBZaSuAUCxRYba7UcVQD0kn
   4NTaWEt+p6cQylbY3ha2e9EfmyPdgW3CNVw1IhPBRmKFXNG3G0xroBWF/
   mzRA4DN7nauF7dH/+nOpb0J2R2RVbmraWtjxUEKjBOu3drHHwUXVltxsw
   0eUu8e8B9GaCqKzzowYNWDNCHwCBAWPDwy63kYyBdUAwU+dklQppTP+o7
   dI8v0QQqWUmzF7NcdfwueZjI6FqmJmB3QcM3jz1PyoePsnBUhhqWMR22m
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="1757894"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="1757894"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 04:19:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="1104461143"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="1104461143"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.50.188])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 04:19:30 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 06/29] selftests/resctrl: Refactor fill_buf functions
Date: Mon, 11 Dec 2023 14:18:03 +0200
Message-Id: <20231211121826.14392-7-ilpo.jarvinen@linux.intel.com>
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

There are unnecessary nested calls in fill_buf.c:
  - run_fill_buf() calls fill_cache()
  - alloc_buffer() calls malloc_and_init_memory()

Simplify the code flow and remove those unnecessary call levels by
moving the called code inside the calling function and remove the
duplicated error print.

Resolve the difference in run_fill_buf() and fill_cache() parameter
name into 'buf_size' which is more descriptive than 'span'. Also, while
moving the allocation related code, rename 'p' into 'buf' to be
consistent in naming the variables.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---

v3:
- Moved error printout remove to this patch
---
 tools/testing/selftests/resctrl/fill_buf.c | 59 +++++++---------------
 tools/testing/selftests/resctrl/resctrl.h  |  2 +-
 2 files changed, 18 insertions(+), 43 deletions(-)

diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index 6d1d5eed595c..635f938b11f0 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -51,29 +51,6 @@ static void mem_flush(unsigned char *buf, size_t buf_size)
 	sb();
 }
 
-static void *malloc_and_init_memory(size_t buf_size)
-{
-	void *p = NULL;
-	uint64_t *p64;
-	size_t s64;
-	int ret;
-
-	ret = posix_memalign(&p, PAGE_SIZE, buf_size);
-	if (ret < 0)
-		return NULL;
-
-	p64 = (uint64_t *)p;
-	s64 = buf_size / sizeof(uint64_t);
-
-	while (s64 > 0) {
-		*p64 = (uint64_t)rand();
-		p64 += (CL_SIZE / sizeof(uint64_t));
-		s64 -= (CL_SIZE / sizeof(uint64_t));
-	}
-
-	return p;
-}
-
 static int fill_one_span_read(unsigned char *buf, size_t buf_size)
 {
 	unsigned char *end_ptr = buf + buf_size;
@@ -137,12 +114,25 @@ static int fill_cache_write(unsigned char *buf, size_t buf_size, bool once)
 
 static unsigned char *alloc_buffer(size_t buf_size, int memflush)
 {
-	unsigned char *buf;
+	void *buf = NULL;
+	uint64_t *p64;
+	size_t s64;
+	int ret;
 
-	buf = malloc_and_init_memory(buf_size);
-	if (!buf)
+	ret = posix_memalign(&buf, PAGE_SIZE, buf_size);
+	if (ret < 0)
 		return NULL;
 
+	/* Initialize the buffer */
+	p64 = buf;
+	s64 = buf_size / sizeof(uint64_t);
+
+	while (s64 > 0) {
+		*p64 = (uint64_t)rand();
+		p64 += (CL_SIZE / sizeof(uint64_t));
+		s64 -= (CL_SIZE / sizeof(uint64_t));
+	}
+
 	/* Flush the memory before using to avoid "cache hot pages" effect */
 	if (memflush)
 		mem_flush(buf, buf_size);
@@ -150,7 +140,7 @@ static unsigned char *alloc_buffer(size_t buf_size, int memflush)
 	return buf;
 }
 
-static int fill_cache(size_t buf_size, int memflush, int op, bool once)
+int run_fill_buf(size_t buf_size, int memflush, int op, bool once)
 {
 	unsigned char *buf;
 	int ret;
@@ -164,21 +154,6 @@ static int fill_cache(size_t buf_size, int memflush, int op, bool once)
 	else
 		ret = fill_cache_write(buf, buf_size, once);
 	free(buf);
-
-	if (ret) {
-		printf("\n Error in fill cache read/write...\n");
-		return -1;
-	}
-
-	return ret;
-}
-
-int run_fill_buf(size_t span, int memflush, int op, bool once)
-{
-	size_t cache_size = span;
-	int ret;
-
-	ret = fill_cache(cache_size, memflush, op, once);
 	if (ret) {
 		printf("\n Error in fill cache\n");
 		return -1;
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index dd3546655657..a848e9c75578 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -91,7 +91,7 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
 			    char *resctrl_val);
 int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
 		    int group_fd, unsigned long flags);
-int run_fill_buf(size_t span, int memflush, int op, bool once);
+int run_fill_buf(size_t buf_size, int memflush, int op, bool once);
 int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *param);
 int mbm_bw_change(int cpu_no, const char * const *benchmark_cmd);
 void tests_cleanup(void);
-- 
2.30.2


