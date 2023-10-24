Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87EE7D4C22
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 11:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbjJXJ1e (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 05:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234149AbjJXJ1V (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 05:27:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984771FE1;
        Tue, 24 Oct 2023 02:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698139618; x=1729675618;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JMN9aahDdQAcKor/PtXdQYhZXLxsC0uS+tKkhuZPS0s=;
  b=i6+7XX4KggrwIiaXnGqRjcB0BrTvLhTJdYbWiWrNMJ0/YRtg95uWHEt2
   0WydlUJFDEyGi6SudwC4h3NvbNd+9VC5qkJbrOyg2UukpT/uVjlrXtnFn
   cTtu11M8Cv98Qt2jiEuLaJ/Ez5qfVTHG7mPemQgN5DOZenhCaZbAEie52
   ieapV7ODL5O/3PRBkovwb17BFic151e/CDB6hJr2UgctjmjklBt+lJtVr
   6WCDtbMWMbZBKRUAg+3m2QXq65YMRu3ZMQUuHRfNc7GkMaogvcmEC+66V
   Bs+nURVqwTXYbV6nmm1FdtGWODMi6nNjcAqNQuERroM8HZ10W9ocIHBwB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="8570095"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="8570095"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:26:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="708223418"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="708223418"
Received: from hprosing-mobl.ger.corp.intel.com (HELO localhost) ([10.249.40.219])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:26:53 -0700
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
Subject: [PATCH 01/24] selftests/resctrl: Split fill_buf to allow tests finer-grained control
Date:   Tue, 24 Oct 2023 12:26:11 +0300
Message-Id: <20231024092634.7122-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

MBM, MBA and CMT test cases use run_fill_buf() to loop indefinitely
around the buffer. CAT test case is different and doesn't want to loop
around the buffer continuously.

Split fill_cache() so that both the use cases are easier to control by
creating separate functions for buffer allocation and looping around
the buffer. Make those functions available for tests. The new interface
is based on returning/passing pointers instead of the startptr global
pointer variable that can now be removed. The deallocation can use
free() directly.

This change is part of preparation for new CAT test which allocates a
buffer and does multiple passes over the same buffer (but not in an
infinite loop).

Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/fill_buf.c | 26 +++++++++++++---------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index 0d425f26583a..f9893edda869 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -135,33 +135,37 @@ static int fill_cache_write(unsigned char *buf, size_t buf_size, bool once)
 	return 0;
 }
 
-static int fill_cache(size_t buf_size, int memflush, int op, bool once)
+static unsigned char *alloc_buffer(size_t buf_size, int memflush)
 {
 	unsigned char *buf;
-	int ret;
 
 	buf = malloc_and_init_memory(buf_size);
 	if (!buf)
-		return -1;
+		return NULL;
 
 	/* Flush the memory before using to avoid "cache hot pages" effect */
 	if (memflush)
 		mem_flush(buf, buf_size);
 
+	return buf;
+}
+
+static int fill_cache(size_t buf_size, int memflush, int op, bool once)
+{
+	unsigned char *buf;
+	int ret;
+
+	buf = alloc_buffer(buf_size, memflush);
+	if (buf == NULL)
+		return -1;
+
 	if (op == 0)
 		ret = fill_cache_read(buf, buf_size, once);
 	else
 		ret = fill_cache_write(buf, buf_size, once);
-
 	free(buf);
 
-	if (ret) {
-		printf("\n Error in fill cache read/write...\n");
-		return -1;
-	}
-
-
-	return 0;
+	return ret;
 }
 
 int run_fill_buf(size_t span, int memflush, int op, bool once)
-- 
2.30.2

