Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD31F756428
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 15:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjGQNQi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 09:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjGQNQJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 09:16:09 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7793E2120;
        Mon, 17 Jul 2023 06:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689599749; x=1721135749;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OFDth0hC1lh6InjhSEs+Bp/5dwcILo8hw2+/N9uGIKo=;
  b=bgpiXDP08dEeFuzCoZTptLxnlmADK40JidgbHRHC/0gIv9HM5QVf2rRE
   1xJ9tRa1HfBOTOj+4SiuH2IBI33Teywdq7d17Fc8cwCywxN1cYciXAPPD
   8r60HGAp2DRtd09txcrdoHCCmhEOwX42L/qATFJmYBEnEX31YXzlnrUk7
   j6/pWm97MBQI2iNSZjqE6RNX8hCADjRQqwbZVTvsrTjbw4jmYFH45ewF2
   H4gKt9t4+duMNkUuTtqQMIFtJKJBIVfqXjl+aAZUrI41Mn7H74Nrv163l
   qbElLO0LsopF8LZ5vQXbtT+IxZlC8F347ytvDCgxd1oWax92h10KQhq16
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="368568923"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="368568923"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 06:15:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="793246813"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="793246813"
Received: from dkravtso-mobl1.ccr.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.45.233])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 06:15:45 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v5 08/19] selftests/resctrl: Remove mum_resctrlfs from struct resctrl_val_param
Date:   Mon, 17 Jul 2023 16:14:56 +0300
Message-Id: <20230717131507.32420-9-ilpo.jarvinen@linux.intel.com>
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

Resctrl FS mount/umount are now cleanly paired leaving .mum_resctrlfs
in the struct resctrl_val_param unused.

Remove .mum_resctrlfs from struct resctrl_val_param.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/resctrl/cat_test.c | 1 -
 tools/testing/selftests/resctrl/cmt_test.c | 1 -
 tools/testing/selftests/resctrl/mba_test.c | 1 -
 tools/testing/selftests/resctrl/mbm_test.c | 1 -
 tools/testing/selftests/resctrl/resctrl.h  | 2 --
 5 files changed, 6 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index e1c071dec1b0..480db0dc4e0e 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -140,7 +140,6 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 	struct resctrl_val_param param = {
 		.resctrl_val	= CAT_STR,
 		.cpu_no		= cpu_no,
-		.mum_resctrlfs	= false,
 		.setup		= cat_setup,
 	};
 
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index 426d11189a99..d31e28416bb7 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -113,7 +113,6 @@ int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
 		.ctrlgrp	= "c1",
 		.mongrp		= "m1",
 		.cpu_no		= cpu_no,
-		.mum_resctrlfs	= false,
 		.filename	= RESULT_FILE_NAME,
 		.mask		= ~(long_mask << n) & long_mask,
 		.span		= cache_size * n / count_of_bits,
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index cde3781a9ab0..3d53c6c9b9ce 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -154,7 +154,6 @@ int mba_schemata_change(int cpu_no, char *bw_report, char **benchmark_cmd)
 		.ctrlgrp	= "c1",
 		.mongrp		= "m1",
 		.cpu_no		= cpu_no,
-		.mum_resctrlfs	= true,
 		.filename	= RESULT_FILE_NAME,
 		.bw_report	= bw_report,
 		.setup		= mba_setup
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 538d35a6485a..24326cb7bc21 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -123,7 +123,6 @@ int mbm_bw_change(int span, int cpu_no, char *bw_report, char **benchmark_cmd)
 		.mongrp		= "m1",
 		.span		= span,
 		.cpu_no		= cpu_no,
-		.mum_resctrlfs	= true,
 		.filename	= RESULT_FILE_NAME,
 		.bw_report	=  bw_report,
 		.setup		= mbm_setup
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 23af3fb73cb4..99678d688a80 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -54,7 +54,6 @@
  * @mongrp:		Name of the monitor group (mon grp)
  * @cpu_no:		CPU number to which the benchmark would be binded
  * @span:		Memory bytes accessed in each benchmark iteration
- * @mum_resctrlfs:	Should the resctrl FS be remounted?
  * @filename:		Name of file to which the o/p should be written
  * @bw_report:		Bandwidth report type (reads vs writes)
  * @setup:		Call back function to setup test environment
@@ -65,7 +64,6 @@ struct resctrl_val_param {
 	char		mongrp[64];
 	int		cpu_no;
 	unsigned long	span;
-	bool		mum_resctrlfs;
 	char		filename[64];
 	char		*bw_report;
 	unsigned long	mask;
-- 
2.30.2

