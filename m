Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B359F6E603E
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Apr 2023 13:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjDRLqw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Apr 2023 07:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjDRLqq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Apr 2023 07:46:46 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D40468E;
        Tue, 18 Apr 2023 04:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681818376; x=1713354376;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DtsmLDO5mFl9wMfAHngLijzuH7IwO+uKW2gw4UdECuo=;
  b=VxW/m9p+NP/86N3pYXDv0OMFv4/twRcCufFUZo1VbRUU2+HnurFG7NrL
   Oqi2LEsIMvWJJFVZ1ZyG2ktW6at9KBzwoiDrEkcoQWE8qCAKUnlrws6LX
   13KEAPwllDHYYykTe1YhY29YC28qsIU9GmJMsC5FkmmAYIRsuhA5yYXEQ
   ou6LDVzj+7KDiVxnCHRHGJx3tT14TQLb2X/afcGLfMOHmCiJ7n9Yr3P2W
   CaAOEZZEJZCTXoDHmt1TqPeMXyhYF5C25SRV3nr8AKevSxlcgiFGvlJcw
   fDIT4wz7TBu4QW4NbmJkAjnaXWtRoQw/kUUfm4pZi5k/7/PiYEp1NlEfC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="346994361"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="346994361"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 04:46:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="723601661"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="723601661"
Received: from yvolokit-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.213.103])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 04:45:58 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 11/24] selftests/resctrl: Remove start_buf local variable from buffer alloc func
Date:   Tue, 18 Apr 2023 14:44:53 +0300
Message-Id: <20230418114506.46788-12-ilpo.jarvinen@linux.intel.com>
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

alloc_buffer() has local start_ptr variable which is unnecessary.

Assign the pointer of the allocated buffer directly to startptr that is
a global variable in fill_buf to simplify the code in alloc_buffer().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/fill_buf.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index 6f0438aa71a6..3a10b554d778 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -145,17 +145,13 @@ static int fill_cache_write(unsigned char *start_ptr, unsigned char *end_ptr,
 
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

