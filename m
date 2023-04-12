Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC87C6DF714
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 15:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjDLNZE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 09:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbjDLNYr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 09:24:47 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8934EA5E3;
        Wed, 12 Apr 2023 06:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681305856; x=1712841856;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+HlcceL/6KXHLxqSA6FbbPQQoUxeUZhePHT3Dn2jNao=;
  b=JzxOLO4Hcc+ccn+k/zendtJ61yHRZPNSO+EpGTbWyttPk6zML5sGTCTc
   4e58Q8xkNnyhLeKJ5KfqEoD2TmLXp7LpPylHTMHuhiefNYOytWyK4orOM
   6fPrQ8WBOP5xf3Zd0kDHvKc4R9k5CTmqaU8KdRQR+oUJG/vcpQxmoPQCN
   SToQhZLMvNRtRLiaZeVwaBIMiDulyw7a3hsjHw8VUR/mxuAc2ntKeXH4p
   /Q/8MThxOmuWWZbcqOzZimB4brV8WV0urTQa9BSybPKMX8hxF22wO6QmK
   YqQ6eBzP3Dbs+ihioKhSfvNdtSOfjXgn0gjXychPZUOhvzIXcRxrOZevC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="332590297"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="332590297"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:22:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="639230129"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="639230129"
Received: from chanse1-mobl2.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.213.80])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:22:50 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 19/22] selftests/resctrl: Read in less obvious order to defeat prefetch optimizations
Date:   Wed, 12 Apr 2023 16:21:19 +0300
Message-Id: <20230412132122.29452-20-ilpo.jarvinen@linux.intel.com>
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

When reading memory in order, HW prefetching optimizations will
interfere with measuring how caches and memory are being accessed. This
adds noise into the results.

Change the fill_buf reading loop to not use an obvious in-order
access.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/fill_buf.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index 316800715386..742b3878ac2f 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -96,14 +96,17 @@ static void *malloc_and_init_memory(size_t s)
 
 static int fill_one_span_read(unsigned char *start_ptr, unsigned char *end_ptr)
 {
-	unsigned char sum, *p;
-
+	unsigned int size = (end_ptr - start_ptr) / (CL_SIZE / 2);
+	unsigned int count = size;
+	unsigned char sum;
+
+	/*
+	 * Read the buffer in an order that is unexpected by HW prefetching
+	 * optimizations to prevent them interfering with the caching pattern.
+	 */
 	sum = 0;
-	p = start_ptr;
-	while (p < end_ptr) {
-		sum += *p;
-		p += (CL_SIZE / 2);
-	}
+	while (count--)
+		sum += start_ptr[((count * 59) % size) * CL_SIZE / 2];
 
 	return sum;
 }
-- 
2.30.2

