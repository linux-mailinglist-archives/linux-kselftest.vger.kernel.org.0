Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD98697CC3
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Feb 2023 14:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbjBONG6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Feb 2023 08:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbjBONGw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Feb 2023 08:06:52 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBA438B66;
        Wed, 15 Feb 2023 05:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676466399; x=1708002399;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TiJbClLs47EPNPKSTZyf82H5dlzHWOIydhuXM2If5tk=;
  b=erLBOpL4ZmQYfwjDYmetqH4ESwiyoA93pkjFsYPAOQ5x8n8dxhZAP4ll
   O8C8V1JbfnImw3YYTn699P6PoC99JV8CBCCdDfueFAEi0/U0JWnMFWBun
   hzEQ84sRlDKsrYV6u8hREL3hJathIyKYdhkJEncCswBQkStPCKs+0eCPE
   JC226xhxeH6DYWY9r6VjjCKHvBqCiw9OJci5fpb+87ouvJv4Y5BQlFG0K
   YLmz24YvFWU8QlQqChlBeLry+F/3HpKhepi1Nptlv5w8hjcbcMooEEvBx
   o/qhAoldJxQ1lYO2P4uB2bpJUSLk/3uwAhYupyRNvh7VlpEsiHUZP6wPd
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="319456292"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="319456292"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 05:06:39 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="812436083"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="812436083"
Received: from hshannan-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.49.120])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 05:06:37 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 6/9] selftests/resctrl: Change initialize_llc_perf() return type to void
Date:   Wed, 15 Feb 2023 15:06:02 +0200
Message-Id: <20230215130605.31583-7-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230215130605.31583-1-ilpo.jarvinen@linux.intel.com>
References: <20230215130605.31583-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

initialize_llc_perf() unconditionally returns 0.

initialize_llc_perf() performs only memory initialization, none of
which can fail.

Change the return type from int to void to accurately reflect that its
return value doesn't need to be checked. Remove the error checking from
the only callsite.

Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cache.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 0485863a169f..585186c874dc 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -48,7 +48,7 @@ static int perf_event_open_llc_miss(pid_t pid, int cpu_no)
 	return 0;
 }
 
-static int initialize_llc_perf(void)
+static void initialize_llc_perf(void)
 {
 	memset(&pea_llc_miss, 0, sizeof(struct perf_event_attr));
 	memset(&rf_cqm, 0, sizeof(struct read_format));
@@ -59,8 +59,6 @@ static int initialize_llc_perf(void)
 	pea_llc_miss.config = PERF_COUNT_HW_CACHE_MISSES;
 
 	rf_cqm.nr = 1;
-
-	return 0;
 }
 
 static int reset_enable_llc_perf(pid_t pid, int cpu_no)
@@ -234,11 +232,8 @@ int cat_val(struct resctrl_val_param *param)
 	if (ret)
 		return ret;
 
-	if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR))) {
-		ret = initialize_llc_perf();
-		if (ret)
-			return ret;
-	}
+	if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)))
+		initialize_llc_perf();
 
 	/* Test runs until the callback setup() tells the test to stop. */
 	while (1) {
-- 
2.30.2

