Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4796DF6FD
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 15:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjDLNX3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 09:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjDLNXG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 09:23:06 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB00B7EF4;
        Wed, 12 Apr 2023 06:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681305763; x=1712841763;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SCy97YJMhkM/QX3EC3qkg3/ealaFQbVkHIo9u4z4FPU=;
  b=jqqr23ZQdY7DlZFFgFdhUzwBrqI9f0Yr2K+Bc9kddOkjFsEBa/SNMIeH
   ABqCkyD/ZcHmhfUYWYv1OYEASP9+jr0CYMPgJIxD+S6NVDilWMXIcGBOY
   Z7QexHLRqmuymSbGSvJPKPxIEpTNy7utXEezukQMx81lbfhCjsVvq+ft0
   p++SOQsgUA9792arkaCbSUsqfE0bKHeRh/S+hP7QVKcK7P9qaqfd5/N14
   V9Fq2ARqRnHMSdbO38BmMo1ldw0RCWDJGLz65+qkuENX0c2ee85sWDKKd
   BbrLZGwtSYquX/AX2LmfKttxLmdumHtt9gWkJQs41/H+BhEauqtOan6fg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="332590139"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="332590139"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:22:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="639230069"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="639230069"
Received: from chanse1-mobl2.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.213.80])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:22:10 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 09/22] selftests/resctrl: Remove start_buf local variable from buffer alloc func
Date:   Wed, 12 Apr 2023 16:21:09 +0300
Message-Id: <20230412132122.29452-10-ilpo.jarvinen@linux.intel.com>
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

alloc_buffer() has local start_ptr variable which is unnecessary.

Assign the pointer of the allocated buffer directly to startptr that is
a global variable in fill_buf to simplify the code in alloc_buffer().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/fill_buf.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index 7f1688405320..c815c80f7a0c 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -153,17 +153,13 @@ static int fill_cache_write(unsigned char *start_ptr, unsigned char *end_ptr,
 
 int alloc_buffer(unsigned long long buf_size, int memflush)
 {
-	unsigned char *start_ptr;
-
-	start_ptr = malloc_and_init_memory(buf_size);
-	if (!start_ptr)
+	startptr = malloc_and_init_memory(buf_size);
+	if (!startptr)
 		return -1;
 
-	startptr = start_ptr;
-
 	/* Flush the memory before using to avoid "cache hot pages" effect */
 	if (memflush)
-		mem_flush(start_ptr, buf_size);
+		mem_flush(startptr, buf_size);
 
 	return 0;
 }
-- 
2.30.2

