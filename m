Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03EC697CC7
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Feb 2023 14:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234098AbjBONHN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Feb 2023 08:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbjBONHD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Feb 2023 08:07:03 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D2B392A0;
        Wed, 15 Feb 2023 05:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676466406; x=1708002406;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rbo6pbyWbXZwebkS7BOf6e5/MHJ+u2ASUXfLqvQcmlA=;
  b=kEjPQe4iPiSiRMDjdgTjNDOG6OZZqPXGYSc1bl14ISwicuSd+2f8/Ck1
   KtH8/QNL0p6OqIB4AUayWoIK92kWEHgrTiVoU6qefOwox622hOVbD7V9s
   eyJ3AEN6BQVc/3mJz6Sw4zTP+4JNjdsrPM+/nZPb0CoFYMzp1tpL9lgOt
   urVI3av/oY3pqvWQSH20wiDNIl1/St/AywNYba6bTXA6CpDcmIYLBBcHu
   pz9SL21v+SRH34NgOT8hSCZhy/eha19oohtBfPH6dCL84zkMNcCraICx6
   EfZxT8BC6M3UMoHs74gHj8tDmUc+MyIOoBEwGrF8t1TrqKeaQf1Bk6s5q
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="319456342"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="319456342"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 05:06:45 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="812436105"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="812436105"
Received: from hshannan-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.49.120])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 05:06:43 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 8/9] selftests/resctrl: Use remount_resctrlfs() consistently with boolean
Date:   Wed, 15 Feb 2023 15:06:04 +0200
Message-Id: <20230215130605.31583-9-ilpo.jarvinen@linux.intel.com>
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

remount_resctrlfs() accepts a boolean value as an argument. Some tests
pass 0/1 and some tests pass true/false.

Make all the callers of remount_resctrlfs() use true/false so that the
parameter usage is consistent across tests.

Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cat_test.c | 2 +-
 tools/testing/selftests/resctrl/cmt_test.c | 7 +++----
 tools/testing/selftests/resctrl/mba_test.c | 2 +-
 tools/testing/selftests/resctrl/mbm_test.c | 2 +-
 tools/testing/selftests/resctrl/resctrl.h  | 2 +-
 5 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 2d3c7c77ab6c..08070d4fa735 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -145,7 +145,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 	struct resctrl_val_param param = {
 		.resctrl_val	= CAT_STR,
 		.cpu_no		= cpu_no,
-		.mum_resctrlfs	= 0,
+		.mum_resctrlfs	= false,
 		.setup		= cat_setup,
 	};
 
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index 3b0454e7fc82..47cde5c02b7f 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -82,12 +82,11 @@ void cmt_test_cleanup(void)
 
 int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
 {
-	int ret, mum_resctrlfs;
+	int ret;
 
 	cache_size = 0;
-	mum_resctrlfs = 1;
 
-	ret = remount_resctrlfs(mum_resctrlfs);
+	ret = remount_resctrlfs(true);
 	if (ret)
 		return ret;
 
@@ -118,7 +117,7 @@ int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
 		.ctrlgrp	= "c1",
 		.mongrp		= "m1",
 		.cpu_no		= cpu_no,
-		.mum_resctrlfs	= 0,
+		.mum_resctrlfs	= false,
 		.filename	= RESULT_FILE_NAME,
 		.mask		= ~(long_mask << n) & long_mask,
 		.span		= cache_size * n / count_of_bits,
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 97dc98c0c949..7defb32ad0de 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -154,7 +154,7 @@ int mba_schemata_change(int cpu_no, char *bw_report, char **benchmark_cmd)
 		.ctrlgrp	= "c1",
 		.mongrp		= "m1",
 		.cpu_no		= cpu_no,
-		.mum_resctrlfs	= 1,
+		.mum_resctrlfs	= true,
 		.filename	= RESULT_FILE_NAME,
 		.bw_report	= bw_report,
 		.setup		= mba_setup
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 280187628054..c9dfa54af42f 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -122,7 +122,7 @@ int mbm_bw_change(int span, int cpu_no, char *bw_report, char **benchmark_cmd)
 		.mongrp		= "m1",
 		.span		= span,
 		.cpu_no		= cpu_no,
-		.mum_resctrlfs	= 1,
+		.mum_resctrlfs	= true,
 		.filename	= RESULT_FILE_NAME,
 		.bw_report	=  bw_report,
 		.setup		= mbm_setup
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 20aaa7c0e784..9555a6f683f7 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -64,7 +64,7 @@ struct resctrl_val_param {
 	char		mongrp[64];
 	int		cpu_no;
 	unsigned long	span;
-	int		mum_resctrlfs;
+	bool		mum_resctrlfs;
 	char		filename[64];
 	char		*bw_report;
 	unsigned long	mask;
-- 
2.30.2

