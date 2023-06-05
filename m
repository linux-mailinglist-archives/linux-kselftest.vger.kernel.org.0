Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C2A722E31
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 20:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjFESDC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 14:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235195AbjFESCu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 14:02:50 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F83109;
        Mon,  5 Jun 2023 11:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685988161; x=1717524161;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1njCDh4AQc1HNVmmNcrVGlu3E0csxRiOqUiCj2TLy5Q=;
  b=df61BYIFshocEkORMHD/f+U6dveMCZIuaIB4k2w1sxhF8Uzg+JFgB0SO
   dvSoXlk+JngP8gSaRF0lXzUHHUzOpt2VdFwVFU7cMuetXvN4l4oR4CrXr
   IHPYiIsv1umEH2R2fVo3IZr24ULSRqBT7t4/fw2ufo8yoIKhI5AbS7Sjs
   LoiBz4fH8Yc3jK0j4xKKatRxHOkXLa981DF8prhZh1jbaETrYL7NrwDjS
   Bc7n4rqMScvaPuYu3K0qbhQoo0ZLJrLnWWwk4X/XbJICH4PQPKfgh/12t
   oSVqEy/B6gGzWpqbeEP1MbiECUnOLfhLFZUwdNSMdmxgSEdmSJEcZEsJF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="442815046"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="442815046"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 11:02:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="821274083"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="821274083"
Received: from gfittedx-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.47.115])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 11:02:31 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 08/19] selftests/resctrl: Remove mum_resctrlfs from struct resctrl_val_param
Date:   Mon,  5 Jun 2023 21:01:34 +0300
Message-Id: <20230605180145.112924-9-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230605180145.112924-1-ilpo.jarvinen@linux.intel.com>
References: <20230605180145.112924-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Resctrl FS mount/umount are now cleanly paired leaving .mum_resctrlfs
in the struct resctrl_val_param unused.

Remove .mum_resctrlfs from the struct resctrl_val_param that is
leftover from the remount trickery and no longer needed.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
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

