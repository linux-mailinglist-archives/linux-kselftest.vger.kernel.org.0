Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D79B75643D
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 15:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjGQNRt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 09:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbjGQNR2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 09:17:28 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4700A10D9;
        Mon, 17 Jul 2023 06:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689599803; x=1721135803;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H8TUYXGj7h3o11itnFQ9jQLYJahO2RBWpVOXlg1CxfQ=;
  b=JMc+xAZmvERWqouugCOIAu4h0nrQpww/i5hqdUiKAR1LY3ST96VsrbOs
   VNwl+aX/S4RLZxg4U+XTagtB1hzmBMcGzcHJYnL/GF3HeEGJHZWXkZv3e
   J9aJjx8dHOKSTwJTGIixSZgo0CyhpaIN5UoHbZzWIM7ax4kVnAOQtqvgJ
   gfI49zW7QonjnMRvK9odp8v2x6p49O6HOoHuLcjQ9bp3IdFLvzxG1oauo
   21e+xyKJ1HGv1EXdUReJxbrWOge7ZFI2yuv3QTW2GzkiIt9bDAXtLD1a/
   Z0t+3G1Ow1iHgXdzycAxKDs9u2PAPLZAe5pA9QAfF6PFG+iKYUNAbQnB4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="368569138"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="368569138"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 06:16:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="793247127"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="793247127"
Received: from dkravtso-mobl1.ccr.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.45.233])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 06:16:32 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v5 14/19] selftests/resctrl: Improve parameter consistency in fill_buf
Date:   Mon, 17 Jul 2023 16:15:02 +0300
Message-Id: <20230717131507.32420-15-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230717131507.32420-1-ilpo.jarvinen@linux.intel.com>
References: <20230717131507.32420-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

fill_buf's arguments can be improved in multiple ways:

  - Multiple functions in fill_buf have start_ptr as one of their
    argument which is a bit long and the extra "start" is pretty
    obvious when it comes to pointers.

  - Some of the functions take end_ptr and others size_t to indicate
    the end of the buffer.

  - Some arguments meaning buffer size are called just 's'

  - mem_flush() takes void * but immediately converts it to char *

Cleanup the parameters to make things simpler and more consistent:

  - Rename start_ptr to simply buf as it's shorter.

  - Replace end_ptr and s parameters with buf_size and only calculate
    end_ptr in the functions that truly use it.

  - Make mem_flush() parameters to follow the same convention as the
    other functions in fill_buf.

  - convert mem_flush() char * to unsigned char *.

While at it, fix also a typo in a comment.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/resctrl/fill_buf.c | 49 +++++++++++-----------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index a5ec9c82a960..5f16c4f5dfbf 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -38,32 +38,32 @@ static void cl_flush(void *p)
 #endif
 }
 
-static void mem_flush(void *p, size_t s)
+static void mem_flush(unsigned char *buf, size_t buf_size)
 {
-	char *cp = (char *)p;
+	unsigned char *cp = buf;
 	size_t i = 0;
 
-	s = s / CL_SIZE; /* mem size in cache llines */
+	buf_size = buf_size / CL_SIZE; /* mem size in cache lines */
 
-	for (i = 0; i < s; i++)
+	for (i = 0; i < buf_size; i++)
 		cl_flush(&cp[i * CL_SIZE]);
 
 	sb();
 }
 
-static void *malloc_and_init_memory(size_t s)
+static void *malloc_and_init_memory(size_t buf_size)
 {
 	void *p = NULL;
 	uint64_t *p64;
 	size_t s64;
 	int ret;
 
-	ret = posix_memalign(&p, PAGE_SIZE, s);
+	ret = posix_memalign(&p, PAGE_SIZE, buf_size);
 	if (ret < 0)
 		return NULL;
 
 	p64 = (uint64_t *)p;
-	s64 = s / sizeof(uint64_t);
+	s64 = buf_size / sizeof(uint64_t);
 
 	while (s64 > 0) {
 		*p64 = (uint64_t)rand();
@@ -74,12 +74,13 @@ static void *malloc_and_init_memory(size_t s)
 	return p;
 }
 
-static int fill_one_span_read(unsigned char *start_ptr, unsigned char *end_ptr)
+static int fill_one_span_read(unsigned char *buf, size_t buf_size)
 {
+	unsigned char *end_ptr = buf + buf_size;
 	unsigned char sum, *p;
 
 	sum = 0;
-	p = start_ptr;
+	p = buf;
 	while (p < end_ptr) {
 		sum += *p;
 		p += (CL_SIZE / 2);
@@ -88,26 +89,26 @@ static int fill_one_span_read(unsigned char *start_ptr, unsigned char *end_ptr)
 	return sum;
 }
 
-static
-void fill_one_span_write(unsigned char *start_ptr, unsigned char *end_ptr)
+static void fill_one_span_write(unsigned char *buf, size_t buf_size)
 {
+	unsigned char *end_ptr = buf + buf_size;
 	unsigned char *p;
 
-	p = start_ptr;
+	p = buf;
 	while (p < end_ptr) {
 		*p = '1';
 		p += (CL_SIZE / 2);
 	}
 }
 
-static int fill_cache_read(unsigned char *start_ptr, unsigned char *end_ptr,
+static int fill_cache_read(unsigned char *buf, size_t buf_size,
 			   char *resctrl_val)
 {
 	int ret = 0;
 	FILE *fp;
 
 	while (1) {
-		ret = fill_one_span_read(start_ptr, end_ptr);
+		ret = fill_one_span_read(buf, buf_size);
 		if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)))
 			break;
 	}
@@ -124,11 +125,11 @@ static int fill_cache_read(unsigned char *start_ptr, unsigned char *end_ptr,
 	return 0;
 }
 
-static int fill_cache_write(unsigned char *start_ptr, unsigned char *end_ptr,
+static int fill_cache_write(unsigned char *buf, size_t buf_size,
 			    char *resctrl_val)
 {
 	while (1) {
-		fill_one_span_write(start_ptr, end_ptr);
+		fill_one_span_write(buf, buf_size);
 		if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)))
 			break;
 	}
@@ -138,25 +139,23 @@ static int fill_cache_write(unsigned char *start_ptr, unsigned char *end_ptr,
 
 static int fill_cache(size_t buf_size, int memflush, int op, char *resctrl_val)
 {
-	unsigned char *start_ptr, *end_ptr;
+	unsigned char *buf;
 	int ret;
 
-	start_ptr = malloc_and_init_memory(buf_size);
-	if (!start_ptr)
+	buf = malloc_and_init_memory(buf_size);
+	if (!buf)
 		return -1;
 
-	end_ptr = start_ptr + buf_size;
-
 	/* Flush the memory before using to avoid "cache hot pages" effect */
 	if (memflush)
-		mem_flush(start_ptr, buf_size);
+		mem_flush(buf, buf_size);
 
 	if (op == 0)
-		ret = fill_cache_read(start_ptr, end_ptr, resctrl_val);
+		ret = fill_cache_read(buf, buf_size, resctrl_val);
 	else
-		ret = fill_cache_write(start_ptr, end_ptr, resctrl_val);
+		ret = fill_cache_write(buf, buf_size, resctrl_val);
 
-	free(start_ptr);
+	free(buf);
 
 	if (ret) {
 		printf("\n Error in fill cache read/write...\n");
-- 
2.30.2

