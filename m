Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7276DF6FB
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 15:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjDLNXR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 09:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjDLNW6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 09:22:58 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925F4A27C;
        Wed, 12 Apr 2023 06:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681305754; x=1712841754;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EbSGLRJK87o+0OkinnBsanXlo8hsPcUrCfMxIYbjd7o=;
  b=eL+Qq7c9ZhWJf06lSDbUQphP9ApNXDcpRV1QfPdnD8JX6knzLoESXpJ6
   X8YWBrhqbVTOMgjzuDs6aJJ1uirzx9xxV4zkiG1J9N1KsNnaqOyAa8zQA
   LPxBSiBUbt7QTtrTLgq0BShfm9714+KLP+8/15rARpEemXW4ulverVAsI
   F60A3KZHrZP9GppQLmeBbGRRIMqQuO3kdKmKKqGCVGqTc7fN+oRKwuDoo
   k1NTQHP82AtRymWxAa5F3N832mp1oIb1AZsAwQnaGHuS0KExGZG7DwuxI
   QfqmVVouf2d2ymeco0J3scnj1qS5k7WZfs3Zpqu1x1PZTd4WcVpnUeL8x
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="332590116"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="332590116"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:22:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="639230066"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="639230066"
Received: from chanse1-mobl2.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.213.80])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:22:03 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 08/22] selftests/resctrl: Split run_fill_buf() to alloc, work, and dealloc helpers
Date:   Wed, 12 Apr 2023 16:21:08 +0300
Message-Id: <20230412132122.29452-9-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230412132122.29452-1-ilpo.jarvinen@linux.intel.com>
References: <20230412132122.29452-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

MBM, MBA and CMT test cases use run_fill_buf() to loop indefinitely
loop around the buffer. CAT test case is different and doesn't want to
loop around the buffer continuously.

Split run_fill_buf() into helpers so that both the use cases are easier
to control by creating separate functions for buffer allocation,
looping around the buffer and the deallocation. Make those functions
available for tests.

Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/fill_buf.c | 48 ++++++++++++++++------
 tools/testing/selftests/resctrl/resctrl.h  |  3 ++
 2 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index b1e883ecbd60..7f1688405320 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -24,6 +24,11 @@
 
 static unsigned char *startptr;
 
+void free_buffer(void)
+{
+	free(startptr);
+}
+
 static void sb(void)
 {
 #if defined(__i386) || defined(__x86_64)
@@ -34,7 +39,7 @@ static void sb(void)
 
 static void ctrl_handler(int signo)
 {
-	free(startptr);
+	free_buffer();
 	printf("\nEnding\n");
 	sb();
 	exit(EXIT_SUCCESS);
@@ -146,36 +151,53 @@ static int fill_cache_write(unsigned char *start_ptr, unsigned char *end_ptr,
 	return 0;
 }
 
-static int
-fill_cache(unsigned long long buf_size, int memflush, int op, char *resctrl_val)
+int alloc_buffer(unsigned long long buf_size, int memflush)
 {
-	unsigned char *start_ptr, *end_ptr;
-	int ret;
+	unsigned char *start_ptr;
 
 	start_ptr = malloc_and_init_memory(buf_size);
 	if (!start_ptr)
 		return -1;
 
 	startptr = start_ptr;
-	end_ptr = start_ptr + buf_size;
 
 	/* Flush the memory before using to avoid "cache hot pages" effect */
 	if (memflush)
 		mem_flush(start_ptr, buf_size);
 
+	return 0;
+}
+
+int use_buffer(unsigned long long buf_size, int op, char *resctrl_val)
+{
+	unsigned char *end_ptr;
+	int ret;
+
+	end_ptr = startptr + buf_size;
 	if (op == 0)
-		ret = fill_cache_read(start_ptr, end_ptr, resctrl_val);
+		ret = fill_cache_read(startptr, end_ptr, resctrl_val);
 	else
-		ret = fill_cache_write(start_ptr, end_ptr, resctrl_val);
+		ret = fill_cache_write(startptr, end_ptr, resctrl_val);
 
-	if (ret) {
+	if (ret)
 		printf("\n Error in fill cache read/write...\n");
-		return -1;
-	}
 
-	free(startptr);
+	return ret;
+}
 
-	return 0;
+static int
+fill_cache(unsigned long long buf_size, int memflush, int op, char *resctrl_val)
+{
+	int ret;
+
+	ret = alloc_buffer(buf_size, memflush);
+	if (ret)
+		return ret;
+
+	ret = use_buffer(buf_size, op, resctrl_val);
+	free_buffer();
+
+	return ret;
 }
 
 int run_fill_buf(unsigned long span, int memflush, int op, char *resctrl_val)
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 037c6914d27a..16876ac00bf1 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -97,6 +97,9 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
 			    char *resctrl_val);
 int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
 		    int group_fd, unsigned long flags);
+void free_buffer(void);
+int alloc_buffer(unsigned long long buf_size, int memflush);
+int use_buffer(unsigned long long buf_size, int op, char *resctrl_val);
 int run_fill_buf(unsigned long span, int memflush, int op, char *resctrl_val);
 int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param);
 int mbm_bw_change(unsigned long span, int cpu_no, char *bw_report, char **benchmark_cmd);
-- 
2.30.2

