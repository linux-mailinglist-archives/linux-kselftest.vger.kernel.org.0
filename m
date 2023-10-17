Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1157CC2D4
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 14:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbjJQMSG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 08:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234143AbjJQMSE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 08:18:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E330186;
        Tue, 17 Oct 2023 05:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697545083; x=1729081083;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6E7Vvr30AXJewe66Dzx3EIvZeCNC2ARaF2V37Rds5vw=;
  b=agfXW4894t/WXv48CYorgOp9T3lJW3KfvLLqm6e8bmtQ4tpM6RmhUcaw
   XkKSWMiA6BQ42cq2STz84Wk5jDPLxEaqfhHqBF44MBCsarXYgkuCGIRuH
   ph/4nm0r6hkTrfStj0So9FUz5VZ0U2KpoAm1u7VV1n+wdLpvPOSLoOnuG
   jUPD568nhNi5bFMFuRaPD9ZbGJyRSrn2FkYwolCwuyRAvYwWqENsbcMwN
   5icVkE7PALPdbZh3E26gKTarqCBaNNZNmHaRLulaPIEj/vWVc9CpQlW5T
   vOE3G13QiurGkMeyznHdfSgdS6NKl/1eBVfNV5D+rN9ZYzQ+jpNUhc37I
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="416852632"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="416852632"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 05:18:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="846801368"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="846801368"
Received: from thaimovx-mobl2.ger.corp.intel.com (HELO localhost) ([10.251.208.112])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 05:18:00 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 1/1] selftests/resctrl: Don't fail MBM test when schemata doesn't support MB:x=x line
Date:   Tue, 17 Oct 2023 15:17:50 +0300
Message-Id: <20231017121750.15433-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Commit 20d96b25cc4c ("selftests/resctrl: Fix schemata write error
check") exposed a problem in feature detection logic in MBM selftest.
If schemata does not support MB:x=x entries, the schemata write to
initialize 100% memory bandwidth allocation in mbm_setup() will now
fail with -EINVAL due to the error handling corrected by 20d96b25cc4c.
Commit 20d96b25cc4c just uncovers the failed write, it is not wrong
itself.

If MB:x=x is not supported by schemata, it is safe to assume 100%
memory bandwidth is always set. Therefore, the previously ignored error
does not make the MBM test itself wrong.

Restore the previous behavior of MBM test by checking MB support before
attempting to write it into schemata which results in behavior
equivalent to ignoring the write error.

Fixes: 20d96b25cc4c ("selftests/resctrl: Fix schemata write error check")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/mbm_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index d3c0d30c676a..85987957e7f5 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -95,7 +95,7 @@ static int mbm_setup(struct resctrl_val_param *p)
 		return END_OF_TESTS;
 
 	/* Set up shemata with 100% allocation on the first run. */
-	if (p->num_of_runs == 0)
+	if ((p->num_of_runs == 0) && validate_resctrl_feature_request("MB", NULL))
 		ret = write_schemata(p->ctrlgrp, "100", p->cpu_no,
 				     p->resctrl_val);
 
-- 
2.30.2

