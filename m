Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E546E603D
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Apr 2023 13:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjDRLqu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Apr 2023 07:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbjDRLqk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Apr 2023 07:46:40 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F45E78;
        Tue, 18 Apr 2023 04:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681818369; x=1713354369;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UXzBCe+HMFj+CW/PyVKY25ygKi4rEwQRoqZga+3wvGs=;
  b=FYhv2eg1X7PqtkCadNzc5jdInvhS6rCVmuTzBVq6Q9Smh8gbdK0BzHEH
   YOsY1hKeyoOGAYi3B8LqWLEsVX2PXU13ZUOchVqlgYVSsibSa+XhQjDfa
   6BTK0t8cgDfNgqftqbubh2jJps02X7MJ1IKuhqtnPGK2afqX1x1yRCHy1
   7fYjpXtl8KVzkTo5uoC6ORjgbDZHzvbbRNv2SR34bv3tu6lzR4oftbZK+
   2qNcKdMhYBjMsHLrvoUqRB5GHwGcn9Obq2jhE8GbWOqqhpxvGuva0HXAu
   Lx+SeFOff7XGdPJGL9MO+DUoU4OBRdO8/49jEGCp1qpLq/0TAMoK1Goxc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="346994352"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="346994352"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 04:45:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="723601648"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="723601648"
Received: from yvolokit-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.213.103])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 04:45:55 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 10/24] selftests/resctrl: Split run_fill_buf() to alloc, work, and dealloc helpers
Date:   Tue, 18 Apr 2023 14:44:52 +0300
Message-Id: <20230418114506.46788-11-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
 tools/testing/selftests/resctrl/fill_buf.c | 46 ++++++++++++++++------
 tools/testing/selftests/resctrl/resctrl.h  |  3 ++
 2 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index 5cdb421a2f6c..6f0438aa71a6 100644
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
@@ -138,36 +143,53 @@ static int fill_cache_write(unsigned char *start_ptr, unsigned char *end_ptr,
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
index 574adac8932d..75bfa2b2746d 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -95,6 +95,9 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
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

