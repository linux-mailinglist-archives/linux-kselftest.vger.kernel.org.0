Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2659F7D4C25
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 11:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbjJXJ1q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 05:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234165AbjJXJ1e (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 05:27:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D4C170E;
        Tue, 24 Oct 2023 02:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698139626; x=1729675626;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R45F98fHakdxYxWQJb3bOvle17ofixaT3HcQ0/a68KM=;
  b=S9b8biNV/tOwtYAbvBxr5jYezvIhlnTKLWGBq0zXn7qGueQmixuIcuVS
   tHPOiNYHDomZljermy5heL7eJUSZUno6kxnd/0J4yRS1RO7tmVehRaLYA
   imjWOPWotFzmajowkAUDGYmqA7U/rOd4Gb/7bHEvYz9fe2UegS/uiMZ+X
   86ER0gmmsR4F9PIG4WOvmpFeYK8azY7oOa/mdEdpMhTcqvSyA8w2D0bSm
   tocM30nmBPjm8T48w5cyPa5SlvoF1nxs/n2RRRLoIopKjN/GZFBsOXCJL
   +JBYBm5yut2oXCY5Ympjhp0DWEIYdT+9o6NaLwx8tF33CQNSQE68r6cYu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="366363883"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="366363883"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:27:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="882061125"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="882061125"
Received: from hprosing-mobl.ger.corp.intel.com (HELO localhost) ([10.249.40.219])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:27:02 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 02/24] selftests/resctrl: Refactor fill_buf functions
Date:   Tue, 24 Oct 2023 12:26:12 +0300
Message-Id: <20231024092634.7122-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There are unnecessary nested calls in fill_buf.c:
  - run_fill_buf() calls fill_cache()
  - alloc_buffer() calls malloc_and_init_memory()

Simplify the code flow and remove those unnecessary call levels by
moving the called code inside the calling function.

Resolve the difference in run_fill_buf() and fill_cache() parameter
name into 'buf_size' which is more descriptive than 'span'.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/fill_buf.c | 58 +++++++---------------
 tools/testing/selftests/resctrl/resctrl.h  |  2 +-
 2 files changed, 20 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index f9893edda869..9d0b0bf4b85a 100644
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
@@ -137,20 +114,33 @@ static int fill_cache_write(unsigned char *buf, size_t buf_size, bool once)
 
 static unsigned char *alloc_buffer(size_t buf_size, int memflush)
 {
-	unsigned char *buf;
+	void *p = NULL;
+	uint64_t *p64;
+	size_t s64;
+	int ret;
 
-	buf = malloc_and_init_memory(buf_size);
-	if (!buf)
+	ret = posix_memalign(&p, PAGE_SIZE, buf_size);
+	if (ret < 0)
 		return NULL;
 
+	/* Initialize the buffer */
+	p64 = (uint64_t *)p;
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
-		mem_flush(buf, buf_size);
+		mem_flush(p, buf_size);
 
-	return buf;
+	return p;
 }
 
-static int fill_cache(size_t buf_size, int memflush, int op, bool once)
+int run_fill_buf(size_t buf_size, int memflush, int op, bool once)
 {
 	unsigned char *buf;
 	int ret;
@@ -164,16 +154,6 @@ static int fill_cache(size_t buf_size, int memflush, int op, bool once)
 	else
 		ret = fill_cache_write(buf, buf_size, once);
 	free(buf);
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
index a33f414f6019..08b95b5a4949 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -92,7 +92,7 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
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

